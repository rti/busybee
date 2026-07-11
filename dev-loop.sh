#!/usr/bin/env bash
set -euo pipefail

# =============================================================================
# dev-loop.sh — Autonomous development loop driven by GitHub issues/PRs
# Executes exactly one step per invocation; the surrounding environment loops.
# =============================================================================

# --- Git identity -----------------------------------------------------------
git config user.name "busybee-bot"
git config user.email "bot@busybee.dev"

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
    local output
    output="$(echo "$prompt" | opencode run --agent build --thinking 2>&1)" || {
        echo "$output" >&2
        return 1
    }
    echo "$output"
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
    local pr_list
    pr_list="$(gh pr list --repo "$REPO" --state open --json number,updatedAt,title,headRefName --jq '.[] | "\(.number)|\(.updatedAt)|\(.title)|\(.headRefName)"')" || return 1

    [ -z "$pr_list" ] && return 1

    # Sort by most recently updated (descending).
    local pr_sorted
    pr_sorted="$(echo "$pr_list" | sort -t'|' -k2 -r)"

    while IFS='|' read -r pr_num updated_at pr_title branch_name; do
        [ -z "$pr_num" ] && continue

        # Fetch review comments that arrived after the bot's last push on this branch.
        local last_push_date
        last_push_date="$(git log --format=%aI -1 "origin/${branch_name}" 2>/dev/null)" || last_push_date=""

        local comments=""
        if [ -n "$last_push_date" ]; then
            comments="$(gh pr view "$pr_num" --repo "$REPO" --json comments --jq --arg date "$last_push_date" '.comments[] | select(.updatedAt > $date) | "\(.body)\n---\n"' 2>/dev/null)" || comments=""
        else
            comments="$(gh pr view "$pr_num" --repo "$REPO" --json comments --jq '.comments[].body' 2>/dev/null)" || comments=""
        fi

        # Also check review threads.
        local threads=""
        threads="$(gh pr view "$pr_num" --repo "$REPO" --json reviewThreads --jq '.reviewThreads[]?.comments[]?.body // ""' 2>/dev/null)" || threads=""

        local feedback="${comments}${threads}"
        # Trim whitespace.
        feedback="$(printf '%s' "$feedback" | sed '/^$/d')"

        if [ -n "$feedback" ]; then
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
                echo "Asking for clarification on PR #${pr_num}..."
                post_questions "pr" "$pr_num" "I need clarification before proceeding:\n\n${questions}"
                git checkout "$DEFAULT_BRANCH" 2>/dev/null || true
                return 0
            fi

            # Check if opencode made any commits.
            local new_commits
            new_commits="$(git log --oneline "origin/${branch_name}"..HEAD)" || new_commits=""

            if [ -z "$new_commits" ]; then
                # No commits — check for uncommitted changes as fallback.
                if [ -z "$(git status --porcelain)" ]; then
                    echo "No file changes from opencode; nothing to commit."
                    git checkout "$DEFAULT_BRANCH" 2>/dev/null || true
                    return 1
                fi

                git add -A
                git commit -m "bot: address review feedback on PR #${pr_num}"
            else
                echo "opencode already committed changes for PR #${pr_num}."
            fi

            git push origin "HEAD:${branch_name}" || {
                git rebase "origin/${DEFAULT_BRANCH}" || error_exit "rebase failed on PR #${pr_num}" "$(git status)"
                git push --force-with-lease origin "HEAD:${branch_name}" || error_exit "push failed on PR #${pr_num}" "$(git status)"
            }

            git checkout "$DEFAULT_BRANCH" 2>/dev/null || true
            return 0
        fi
    done <<< "$pr_sorted"

    return 1
}

# --- Step 2: Pick an issue --------------------------------------------------

pick_issue() {
    local issues
    # List open issues sorted by oldest created first, excluding bot/wontfix labels.
    issues="$(gh issue list --repo "$REPO" --state open --search "sort:created-asc" \
        --json number,title,body,labels --jq '
            [.[] | select(
                (.labels // [] | map(.name) | all(. != "bot" and . != "wontfix"))
            )] | .[] | "\(.number)|\(.title)|\(.body)"')" || return 1

    [ -z "$issues" ] && return 1

    while IFS='|' read -r issue_num issue_title issue_body; do
        [ -z "$issue_num" ] && continue

        # Check if an open PR already targets this issue.
        local linked_pr
        linked_pr="$(gh pr list --repo "$REPO" --state open --search "#${issue_num}" --json number --jq '.[0].number // empty' 2>/dev/null)" || linked_pr=""

        if [ -n "$linked_pr" ]; then
            continue  # Skip — already has an open PR.
        fi

        echo "${issue_num}|${issue_title}|${issue_body}"
        return 0
    done <<< "$issues"

    return 1
}

# --- Step 3: Implement the issue --------------------------------------------

implement_issue() {
    local issue_num="$1" issue_title="$2" issue_body="$3"

    local branch_name
    branch_name="$(make_branch_name "$issue_num" "$issue_title")"

    echo "Implementing issue #${issue_num}: ${issue_title}"

    git fetch origin
    git checkout "$DEFAULT_BRANCH"
    git pull origin "$DEFAULT_BRANCH"

    # Clean up branch from a previous interrupted run.
    if git show-ref --verify --quiet "refs/heads/${branch_name}"; then
        git branch -D "$branch_name"
    fi
    if git show-ref --verify --quiet "refs/remotes/origin/${branch_name}"; then
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
        echo "Asking for clarification on issue #${issue_num}..."
        post_questions "issue" "$issue_num" "I need clarification before proceeding:\n\n${questions}"
        git checkout "$DEFAULT_BRANCH" 2>/dev/null || true
        return 0
    fi

    # Check if opencode made any commits.
    local new_commits
    new_commits="$(git log --oneline "${DEFAULT_BRANCH}"..HEAD)" || new_commits=""

    if [ -z "$new_commits" ]; then
        # No commits — check for uncommitted changes as fallback.
        if [ -z "$(git status --porcelain)" ]; then
            echo "No file changes from opencode for issue #${issue_num}."
            git checkout "$DEFAULT_BRANCH" 2>/dev/null || true
            return 1
        fi

        git add -A
        git commit -m "bot: implement #${issue_num} — ${issue_title}"
    else
        echo "opencode already committed changes for issue #${issue_num}."
    fi

    git push origin "$branch_name" || {
        git rebase "origin/${DEFAULT_BRANCH}" || error_exit "rebase failed on issue #${issue_num}" "$(git status)"
        git push --force-with-lease origin "$branch_name" || error_exit "push failed on issue #${issue_num}" "$(git status)"
    }

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
    exit 0
fi

# Fall back to picking and implementing an issue.
issue_data="$(pick_issue)" || {
    echo "Nothing to do"
    exit 0
}

IFS='|' read -r issue_num issue_title issue_body <<< "$issue_data"
implement_issue "$issue_num" "$issue_title" "$issue_body"
exit 0
