#!/usr/bin/env bash
set -euo pipefail

# =============================================================================
# dev-loop.sh — Autonomous development loop driven by GitHub issues/PRs
# Executes exactly one step per invocation; the surrounding environment loops.
# =============================================================================

# --- Git identity -----------------------------------------------------------
git config user.name "busybee-bot"
git config user.email "busybee-bot@users.noreply.github.com"

# --- Required environment ---------------------------------------------------
: "${GH_TOKEN:?Environment variable GH_TOKEN is required}"
: "${REPO:?Environment variable REPO is required}"

# Use token-based HTTPS for git operations (avoids SSH key requirements)
git remote set-url origin "https://x-access-token:${GH_TOKEN}@github.com/${REPO}.git"

DEFAULT_BRANCH="$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's|refs/remotes/origin/||')" || DEFAULT_BRANCH="main"

# --- Helpers ----------------------------------------------------------------

# Derive a branch name: <issue-number>-<short-slug> from the issue title.
make_branch_name() {
    local num="$1" title="$2"
    local slug
    slug="$(echo "$title" | tr '[:upper:]' '[:lower:]' | tr -cs '[:alnum:]' '-' | sed 's/^-//;s/-$//' | cut -c1-40)"
    echo "${num}-${slug}"
}

# Post an error issue and exit with failure.
error_exit() {
    local summary="$1" details="$2"
    gh issue create \
        --repo "$REPO" \
        --title "Dev loop error: ${summary}" \
        --body "<details>${details}</details>" \
        --label "bot" >/dev/null 2>&1 || true
    echo "ERROR: ${summary}" >&2
    exit 1
}

# Ask opencode a structured prompt; capture its output.
# If the output contains lines prefixed with QUESTION:, return them for posting.
run_opencode() {
    local prompt="$1"
    local exit_code=0
    echo "$prompt" | opencode run --agent build --thinking 2>&1 | tee /dev/stderr || exit_code=$?
    return "$exit_code"
}

# Post clarification questions to an issue or PR.
post_questions() {
    local target_type="$1" target_num="$2" questions="$3"
    if [ "$target_type" = "pr" ]; then
        gh pr comment "$target_num" --repo "$REPO" --body "${questions}"
    else
        gh issue comment "$target_num" --repo "$REPO" --body "${questions}"
    fi
}

# --- Step 1: Review open PRs for pending feedback ---------------------------

review_prs() {
    echo "[debug] Step 1: reviewing open PRs for pending feedback" >&2

    local pr_list
    pr_list="$(gh pr list --repo "$REPO" --state open --json number,updatedAt,title,headRefName --jq '.[] | "\(.number)|\(.updatedAt)|\(.title)|\(.headRefName)"')" || return 1

    [ -z "$pr_list" ] && { echo "[debug] No open PRs found"; return 1; } >&2

    echo "[debug] Open PRs fetched:" >&2
    echo "$pr_list" | while IFS='|' read -r n u t b; do
        echo "[debug]   PR #$n: \"$t\" (branch: $b, updated: $u)" >&2
    done

    # Sort by most recently updated (descending).
    local pr_sorted
    pr_sorted="$(echo "$pr_list" | sort -t'|' -k2 -r)"

    while IFS='|' read -r pr_num updated_at pr_title branch_name; do
        [ -z "$pr_num" ] && continue

        echo "[debug] Checking PR #${pr_num} (branch: ${branch_name}) for feedback..." >&2

        # Determine the baseline timestamp for detecting new feedback on this PR.
        # We must consider not just pushes but also comments and reviews, since a PR
        # can be updated by reviewers without any new pushes. Using the branch's last
        # push alone is insufficient: another user's push could mask reviewer feedback
        # that arrived between the bot's last run and that user's push.
        local bot_last_push latest_comment_time latest_review_time
        bot_last_push="$(git log --format=%aI --author="busybee-bot" -1 "origin/${branch_name}" 2>/dev/null)" || bot_last_push=""
        latest_comment_time="$(gh pr view "$pr_num" --repo "$REPO" --json comments --jq '[.comments[].updatedAt] | max // empty' 2>/dev/null)" || latest_comment_time=""
        latest_review_time="$(gh pr view "$pr_num" --repo "$REPO" --json reviews --jq '[.reviews[].submittedAt] | max // empty' 2>/dev/null)" || latest_review_time=""

        # Use the bot's own last push as baseline for filtering feedback.
        # Also check comment/review timing to detect if the PR was updated since we last checked.
        local has_new_activity=false
        if [ -n "$bot_last_push" ]; then
            if [ -n "$latest_comment_time" ] && [[ "$latest_comment_time" > "$bot_last_push" ]]; then
                has_new_activity=true
            fi
            if [ -n "$latest_review_time" ] && [[ "$latest_review_time" > "$bot_last_push" ]]; then
                has_new_activity=true
            fi
        fi

        echo "[debug]   Bot last push: ${bot_last_push:-none}; latest comment: ${latest_comment_time:-none}; latest review: ${latest_review_time:-none}; new activity: $has_new_activity" >&2

        # Skip PRs the bot didn't create (no bot commits on the branch).
        if [ -z "$bot_last_push" ]; then
            echo "[debug]   No bot commits on this branch — skipping (not our PR)" >&2
            continue
        fi

        # Skip PRs with no new activity since the bot's last push.
        if [ "$has_new_activity" = false ]; then
            echo "[debug]   No new activity on PR #${pr_num} — skipping" >&2
            continue
        fi

        local comments=""
        echo "[debug]   Bot's last push: ${bot_last_push}; fetching comments after that date" >&2
        comments="$(gh pr view "$pr_num" --repo "$REPO" --json comments --jq --arg date "$bot_last_push" '.comments[] | select(.updatedAt > $date) | "\(.body)\n---\n"' 2>/dev/null)" || comments=""

        # Also check review threads.
        local threads=""
        threads="$(gh pr view "$pr_num" --repo "$REPO" --json reviewThreads --jq --arg date "$bot_last_push" '[.reviewThreads[]?.comments[]? | select(.updatedAt > $date) | .body] | join("\n---\n")' 2>/dev/null)" || threads=""

        # Check for reviews with state CHANGES_REQUESTED after bot's last push.
        local review_feedback=""
        review_feedback="$(gh pr view "$pr_num" --repo "$REPO" --json reviews --jq --arg date "$bot_last_push" '[.reviews[] | select(.submittedAt > $date and .state == "CHANGES_REQUESTED") | (.body // "" ) + if (.body // "" ) == "" then "\nReviewer requested changes." else "" end] | join("\n---\n")' 2>/dev/null)" || review_feedback=""

        # Also check review body text from all reviews (including COMMENTED) for change requests.
        local review_body_feedback=""
        review_body_feedback="$(gh pr view "$pr_num" --repo "$REPO" --json reviews --jq --arg date "$bot_last_push" '[.reviews[] | select(.submittedAt > $date) | .body // "" | select(length > 0)] | join("\n---\n")' 2>/dev/null)" || review_body_feedback=""

        local feedback="${comments}${threads}${review_feedback}${review_body_feedback}"
        # Trim whitespace.
        feedback="$(printf '%s' "$feedback" | sed '/^$/d')"

        if [ -n "$feedback" ]; then
            echo "[debug]   Found feedback on PR #${pr_num} — processing" >&2
            echo "Addressing feedback on PR #${pr_num}..."

            git fetch origin
            git checkout "origin/${branch_name}"
            git checkout -b "bot-fix-${pr_num}"

            local pr_body
            pr_body="$(gh pr view "$pr_num" --repo "$REPO" --json body --jq '.body')" || pr_body=""

            local prompt="You are working on PR #${pr_num} titled \"${pr_title}\".
Original PR description:
${pr_body}

Address the following review comments on this PR:
${feedback}

Read the relevant files from disk. Implement fixes for each comment. Commit when done.
If anything is ambiguous, print your questions to stdout prefixed with \`QUESTION:\` so the wrapper script can post them."

            local result
            result="$(run_opencode "$prompt")" || error_exit "opencode failed on PR #${pr_num}" "$result"

            # Check for clarification questions.
            local questions
            questions="$(echo "$result" | grep '^QUESTION:' || true)"
            if [ -n "$questions" ]; then
                echo "[debug]   Opencode asked for clarification on PR #${pr_num}" >&2
                echo "Asking for clarification on PR #${pr_num}..."
                post_questions "pr" "$pr_num" "I need clarification before proceeding:\n\n${questions}"
                git checkout "$DEFAULT_BRANCH" 2>/dev/null || true
                return 0
            fi

            # Check if opencode made any commits.
            local new_commits
            new_commits="$(git log --oneline "origin/${branch_name}"..HEAD)" || new_commits=""

            if [ -z "$new_commits" ]; then
                echo "[debug]   Opencode did not commit; checking for uncommitted changes on PR #${pr_num}" >&2
                # No commits — check for uncommitted changes as fallback.
                if [ -z "$(git status --porcelain)" ]; then
                    echo "[debug]   No file changes from opencode for PR #${pr_num}" >&2
                    echo "No file changes from opencode; nothing to commit."
                    git checkout "$DEFAULT_BRANCH" 2>/dev/null || true
                    return 1
                fi

                echo "[debug]   Committing uncommitted changes for PR #${pr_num}" >&2
                git add -A
                git commit -m "bot: address review feedback on PR #${pr_num}"
            else
                echo "[debug]   Opencode already committed for PR #${pr_num}:" >&2
                echo "$new_commits" | sed 's/^/    [debug]     /' >&2
                echo "opencode already committed changes for PR #${pr_num}."
            fi

            echo "[debug]   Pushing to branch ${branch_name}" >&2
            git push origin "HEAD:${branch_name}" || {
                echo "[debug]   Push rejected; rebasing onto origin/${DEFAULT_BRANCH}" >&2
                git rebase "origin/${DEFAULT_BRANCH}" || error_exit "rebase failed on PR #${pr_num}" "$(git status)"
                git push --force-with-lease origin "HEAD:${branch_name}" || error_exit "push failed on PR #${pr_num}" "$(git status)"
            }

            git checkout "$DEFAULT_BRANCH" 2>/dev/null || true
            return 0
        else
            echo "[debug]   No pending feedback on PR #${pr_num} — skipping" >&2
        fi
    done <<< "$pr_sorted"

    echo "[debug] No PRs with pending feedback found" >&2
    return 1
}

# --- Step 2: Pick an issue --------------------------------------------------

pick_issue() {
    echo "[debug] Step 2: picking an issue to implement" >&2

    local issues
    # List open issues sorted by oldest created first, excluding bot/wontfix labels.
    issues="$(gh issue list --repo "$REPO" --state open --search "sort:created-asc" \
        --json number,title,body,labels --jq '
            [.[] | select(
                (.labels // [] | map(.name) | all(. != "bot" and . != "wontfix"))
            )] | .[] | "\(.number)|\(.title)|\(.body)"')" || return 1

    [ -z "$issues" ] && { echo "[debug] No open issues found (after filtering bot/wontfix)"; return 1; } >&2

    echo "[debug] Open issues fetched (sorted oldest first):" >&2
    echo "$issues" | while IFS='|' read -r n t b; do
        echo "[debug]   Issue #$n: \"$t\"" >&2
    done

    while IFS='|' read -r issue_num issue_title issue_body; do
        [ -z "$issue_num" ] && continue

        # Check if an open PR already targets this issue.
        local linked_pr
        linked_pr="$(gh pr list --repo "$REPO" --state open --search "#${issue_num}" --json number --jq '.[0].number // empty' 2>/dev/null)" || linked_pr=""

        if [ -n "$linked_pr" ]; then
            echo "[debug]   Issue #${issue_num}: skipping — already has open PR #${linked_pr}" >&2
            continue
        fi

        echo "[debug]   Picked issue #${issue_num}: \"${issue_title}\"" >&2
        echo "${issue_num}|${issue_title}|${issue_body}"
        return 0
    done <<< "$issues"

    echo "[debug] All issues already have open PRs — none available" >&2
    return 1
}

# --- Step 3: Implement the issue --------------------------------------------

implement_issue() {
    local issue_num="$1" issue_title="$2" issue_body="$3"

    echo "[debug] Step 3: implementing issue #${issue_num}: \"${issue_title}\"" >&2

    local branch_name
    branch_name="$(make_branch_name "$issue_num" "$issue_title")"

    echo "[debug]   Branch name: ${branch_name}" >&2
    echo "[debug]   Default branch: ${DEFAULT_BRANCH}" >&2
    echo "Implementing issue #${issue_num}: ${issue_title}"

    echo "[debug]   Fetching origin and checking out ${DEFAULT_BRANCH}" >&2
    git fetch origin
    git checkout "$DEFAULT_BRANCH"
    git pull origin "$DEFAULT_BRANCH"

    # Clean up branch from a previous interrupted run.
    if git show-ref --verify --quiet "refs/heads/${branch_name}"; then
        echo "[debug]   Cleaning up local branch ${branch_name} from previous run" >&2
        git branch -D "$branch_name"
    fi
    if git show-ref --verify --quiet "refs/remotes/origin/${branch_name}"; then
        echo "[debug]   Cleaning up remote branch origin/${branch_name} from previous run" >&2
        git push origin --delete "$branch_name" 2>/dev/null || true
    fi

    git checkout -b "$branch_name"

    local prompt="You are implementing GitHub issue #${issue_num} titled \"${issue_title}\".

Issue body:
${issue_body}

The repository is checked out on disk at the current working directory.
Read the relevant files yourself. Implement this change. Commit when done.
If anything is ambiguous, print your questions to stdout prefixed with \`QUESTION:\` so the wrapper script can post them."

    local result
    result="$(run_opencode "$prompt")" || error_exit "opencode failed on issue #${issue_num}" "$result"

    # Check for clarification questions.
    local questions
    questions="$(echo "$result" | grep '^QUESTION:' || true)"
    if [ -n "$questions" ]; then
        echo "[debug]   Opencode asked for clarification on issue #${issue_num}" >&2
        echo "Asking for clarification on issue #${issue_num}..."
        post_questions "issue" "$issue_num" "I need clarification before proceeding:\n\n${questions}"
        git checkout "$DEFAULT_BRANCH" 2>/dev/null || true
        return 0
    fi

    # Check if opencode made any commits.
    local new_commits
    new_commits="$(git log --oneline "${DEFAULT_BRANCH}"..HEAD)" || new_commits=""

    if [ -z "$new_commits" ]; then
        echo "[debug]   Opencode did not commit; checking for uncommitted changes" >&2
        # No commits — check for uncommitted changes as fallback.
        if [ -z "$(git status --porcelain)" ]; then
            echo "[debug]   No file changes from opencode for issue #${issue_num}" >&2
            echo "No file changes from opencode for issue #${issue_num}."
            git checkout "$DEFAULT_BRANCH" 2>/dev/null || true
            return 1
        fi

        echo "[debug]   Committing uncommitted changes for issue #${issue_num}" >&2
        git add -A
        git commit -m "bot: implement #${issue_num} — ${issue_title}"
    else
        echo "[debug]   Opencode already committed for issue #${issue_num}:" >&2
        echo "$new_commits" | sed 's/^/    [debug]     /' >&2
        echo "opencode already committed changes for issue #${issue_num}."
    fi

    echo "[debug]   Pushing branch ${branch_name} to origin" >&2
    git push origin "$branch_name" || {
        echo "[debug]   Push rejected; rebasing onto origin/${DEFAULT_BRANCH}" >&2
        git rebase "origin/${DEFAULT_BRANCH}" || error_exit "rebase failed on issue #${issue_num}" "$(git status)"
        git push --force-with-lease origin "$branch_name" || error_exit "push failed on issue #${issue_num}" "$(git status)"
    }

    echo "[debug]   Opening PR for issue #${issue_num}" >&2
    # Open a PR.
    local pr_body="Closes #${issue_num}.

---
*Autogenerated by busybee-bot.*"

    gh pr create \
        --repo "$REPO" \
        --title "bot: #${issue_num} — ${issue_title}" \
        --body "$pr_body" \
        --head "$branch_name" \
        --base "$DEFAULT_BRANCH" >/dev/null 2>&1

    git checkout "$DEFAULT_BRANCH" 2>/dev/null || true
    return 0
}

# =============================================================================
# Main loop: one step per invocation
# =============================================================================

# Attempt PR review first.
if review_prs; then
    echo "[debug] Completed PR review step — exiting" >&2
    exit 0
fi

# Fall back to picking and implementing an issue.
issue_data="$(pick_issue)" || {
    echo "[debug] No issues available to pick" >&2
    echo "Nothing to do"
    exit 0
}

IFS='|' read -r issue_num issue_title issue_body <<< "$issue_data"
if implement_issue "$issue_num" "$issue_title" "$issue_body"; then
    echo "[debug] Successfully implemented issue #${issue_num} — exiting" >&2
    exit 0
fi
echo "[debug] Failed to implement issue #${issue_num}" >&2
echo "Failed to implement issue #${issue_num}"
exit 0
