---
name: github-pr-reviews
description: 'Use the GitHub REST API to read pull request reviews and pull request review comments. Use when the user asks to inspect PR feedback, summarize reviewer decisions, fetch inline review comments, or check for new review activity on a PR.'
license: MIT
source: https://docs.github.com/en/rest/pulls/reviews
allowed-tools: Bash
---

# GitHub PR Reviews

## Overview

Use GitHub REST API endpoints to inspect pull request review state and inline review comments.

## What To Read

### Review history

```bash
gh api repos/{owner}/{repo}/pulls/{pull_number}/reviews
```

Returns an array of pull request review objects in chronological order.

Key fields to inspect:

- `id`
- `user.login`
- `state`
- `body`
- `submitted_at`
- `commit_id`
- `html_url`
- `author_association`

`state` is the review decision:

- `APPROVED`
- `CHANGES_REQUESTED`
- `COMMENTED`
- `DISMISSED`

### Inline review comments on a PR

```bash
gh api repos/{owner}/{repo}/pulls/{pull_number}/comments
```

Returns an array of pull request review comment objects.

Key fields to inspect:

- `id`
- `pull_request_review_id`
- `user.login`
- `body`
- `path`
- `line`
- `original_line`
- `side`
- `start_line`
- `start_side`
- `position`
- `in_reply_to_id`
- `created_at`
- `updated_at`
- `commit_id`
- `original_commit_id`

### Comments for one review only

```bash
gh api repos/{owner}/{repo}/pulls/{pull_number}/reviews/{review_id}/comments
```

Use this when you already know the review id and want only the comments that belong to that review.

### PR conversation comments

```bash
gh api repos/{owner}/{repo}/issues/{pull_number}/comments
```

Use this for general PR discussion comments, not inline review comments.

## Workflow

### 1. Identify the PR

If you only have a branch name, resolve the PR first:

```bash
gh pr list --head <branch> --json number,title,updatedAt
```

### 2. Read the reviews

Fetch the review list and inspect it in chronological order:

```bash
gh api repos/{owner}/{repo}/pulls/{pull_number}/reviews --paginate
```

Look for:

- the latest `CHANGES_REQUESTED`
- the latest `APPROVED`
- reviewer summary text in `body`

### 3. Read the inline comments

Fetch all PR review comments:

```bash
gh api repos/{owner}/{repo}/pulls/{pull_number}/comments --paginate
```

Group comments by:

- reviewer
- file path
- line or line range
- reply chain using `in_reply_to_id`

### 4. Check for updates since last bot push

When tracking new feedback, compare `submitted_at`, `created_at`, or `updated_at` against the last bot push or last bot review state.

## Response Shape Notes

### Review object

Treat each review as a top-level decision plus optional summary text.

Useful fields:

- `state` tells you approval or requested changes
- `body` contains the review summary
- `submitted_at` tells you when it became official
- `commit_id` tells you which commit it applied to

### Review comment object

Treat each comment as inline feedback on a diff line or file.

Useful fields:

- `path` points to the file
- `line` and `side` identify the exact diff location
- `start_line` and `start_side` define multi-line comments
- `subject_type` may be `line` or `file`
- `in_reply_to_id` links threaded replies

## Practical Guidance

- Do not infer approval from the absence of comments. Read reviews directly.
- Do not confuse issue comments with review comments.
- Do not confuse a review summary with a review comment thread.
- For a full feedback picture, read both `/pulls/{pull_number}/reviews` and `/pulls/{pull_number}/comments`.

## Output Guidance

When summarizing feedback, include:

- PR number and title
- each reviewer and review state
- review summary bodies
- inline comments grouped by file
- reply threads and unresolved feedback
- the most recent feedback timestamp

## API Usage Notes

- Prefer `gh api` over manual HTTP calls.
- Use `--paginate` for complete results.
- Use `jq` if you need to filter or group response data.

```bash
gh api repos/{owner}/{repo}/pulls/{pull_number}/reviews --paginate | jq
gh api repos/{owner}/{repo}/pulls/{pull_number}/comments --paginate | jq
```
