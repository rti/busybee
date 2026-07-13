---
name: github-issues
description: 'Use the GitHub REST API to read and manage GitHub issues and issue comments. Use when the user asks to list issues, read issue details, inspect issue discussion, summarize issue activity, or update issue metadata/comments.'
license: MIT
source: https://docs.github.com/en/rest/issues/issues
allowed-tools: Bash
---

# GitHub Issues

## Overview

Use the GitHub REST API to inspect issues, issue comments, and basic issue metadata.

## Important Distinction

- Every pull request is also an issue.
- Not every issue is a pull request.
- Issue endpoints may return PRs too, so check for the `pull_request` key when you need to exclude PRs.

## Core Endpoints

### List repository issues

```bash
gh api repos/{owner}/{repo}/issues
```

Useful fields on each issue:

- `number`
- `title`
- `state`
- `body`
- `user.login`
- `labels`
- `assignees`
- `comments`
- `created_at`
- `updated_at`
- `html_url`
- `pull_request` if it is actually a PR

Common filters:

- `state=open|closed|all`
- `sort=created|updated|comments`
- `direction=asc|desc`
- `since=<ISO-8601 timestamp>`
- `labels=<comma-separated labels>`

### Get a single issue

```bash
gh api repos/{owner}/{repo}/issues/{issue_number}
```

Use this for the full issue record.

### Update an issue

```bash
gh api -X PATCH repos/{owner}/{repo}/issues/{issue_number} -f title='...' -f body='...'
```

Useful update fields:

- `title`
- `body`
- `state`
- `state_reason`
- `labels`
- `assignees`
- `milestone`
- `type`

### Create an issue

```bash
gh api -X POST repos/{owner}/{repo}/issues -f title='...' -f body='...'
```

Optional create fields:

- `labels`
- `assignees`
- `milestone`
- `type`
- `issue_field_values`

## Issue Comments

### List comments on an issue

```bash
gh api repos/{owner}/{repo}/issues/{issue_number}/comments
```

Returns issue comment objects ordered by ascending ID.

Key fields:

- `id`
- `user.login`
- `body`
- `created_at`
- `updated_at`
- `issue_url`
- `html_url`

### List comments for the repository

```bash
gh api repos/{owner}/{repo}/issues/comments
```

Use this when you need all issue and PR conversation comments in the repository.

### Get an issue comment

```bash
gh api repos/{owner}/{repo}/issues/comments/{comment_id}
```

### Update an issue comment

```bash
gh api -X PATCH repos/{owner}/{repo}/issues/comments/{comment_id} -f body='...'
```

### Delete an issue comment

```bash
gh api -X DELETE repos/{owner}/{repo}/issues/comments/{comment_id}
```

## Workflow

### 1. Find issues

Use repository, organization, or global issue listings depending on scope:

```bash
gh api repos/{owner}/{repo}/issues --paginate
gh api orgs/{org}/issues --paginate
gh api issues --paginate
```

### 2. Filter carefully

If you only want real issues, skip entries that include `pull_request`.

### 3. Read discussion

For an issue, read:

```bash
gh api repos/{owner}/{repo}/issues/{issue_number}
gh api repos/{owner}/{repo}/issues/{issue_number}/comments --paginate
```

### 4. Summarize activity

When summarizing, include:

- issue number and title
- current state
- labels and assignees
- last update time
- comment count
- recent comments or blockers

## Practical Notes

- Use `since` when you only want recently changed issues.
- Use `sort=updated` when triaging issue queues.
- Use `sort=comments` when looking for active discussion.
- The `body` fields can be rendered as markdown; use `jq` if you need structured output.

```bash
gh api repos/{owner}/{repo}/issues --paginate | jq
gh api repos/{owner}/{repo}/issues/{issue_number}/comments --paginate | jq
```

## Safety Notes

- Do not confuse issue comments with PR review comments.
- Do not assume a returned issue is not a PR unless you verify the absence of `pull_request`.
- Be careful when updating labels, assignees, or state on issue endpoints because they apply to PRs too.
