You are a script architect. Your task is to write a single self-contained bash script called `dev-loop.sh` that implements an autonomous development loop driven by GitHub issues and pull requests, using opencode as its agent harness.

## Script: dev-loop.sh

### Behaviour
- Execute exactly one step per invocation. The surrounding environment will loop the script.
- On each run:
  1. **Review open PRs first** — list all open pull requests on the repo. For each, check if there are new review comments or review threads since the last push by the bot. If any PR has pending feedback, pick the most recently updated one, use opencode to address the feedback, commit the changes to the same branch, and push. Then exit.
  2. **Pick an issue** — if no PR needs iteration, list open issues sorted by most recently updated. Pick the first issue that is not already associated with an open PR (check via `gh pr list --head <branch>` or issue labels/links). Skip issues labelled `bot` or `wontfix`.
  3. **Implement the issue** — create a feature branch from `main` (or default branch), invoke opencode to implement the issue, commit the result, push the branch, and open a pull request linking to the issue. Then exit.
- If opencode determines it needs clarification, post a comment on the issue or PR asking the question and exit without making changes.
- If the script encounters an unexpected error (tool failure, merge conflict, etc.), create a new issue titled "Dev loop error: <summary>" with the error details, then exit with non-zero status.

### Technical requirements
- Language: POSIX-compatible bash (`#!/usr/bin/env bash`, `set -euo pipefail`).
- Forge: GitHub via `gh` CLI only. No REST API calls outside `gh`.
- Environment variables (required at runtime):
  - `GH_TOKEN` — authenticated GitHub token with repo scope.
  - `REPO` — owner/repo in the format `<owner>/<repo>`.
- Agent harness: `opencode` is available on PATH and accepts a prompt string via stdin or a `-p`/`--prompt` flag. The script should pipe a structured prompt to opencode and capture its output or let it edit files in the working directory.
- All dependencies (`gh`, `opencode`, `git`) are expected to be installed in the environment. Do not install anything.
- Git identity: configure `user.name` as "busybee-bot" and `user.email` as "bot@busybee.dev" at the top of the script.
- Branch naming: `<issue-number>-<short-slug>` derived from the issue title (lowercase, spaces to hyphens, max 40 chars).
- PR titles and bodies must reference the originating issue number.
- The script must run from the root of a cloned copy of `$REPO`.
- Keep the script under 300 lines. Favor clarity over cleverness.

### Prompt construction for opencode
The prompt sent to opencode should include:
- The full issue body (or PR feedback comments).
- The current state of relevant files (let opencode read them itself from disk).
- A clear instruction: "Implement this change. Commit when done." or "Address the following review comments on this PR: <comments>. Commit fixes when done."
- For clarification: "If anything is ambiguous, print your questions to stdout prefixed with `QUESTION:` so the wrapper script can post them."

### Edge cases to handle
- No open issues and no PRs with feedback → print "Nothing to do" and exit 0.
- Issue already has an open PR linked → skip it.
- Push rejected (stale branch) → try rebase onto default branch; if that fails, create an error issue and exit 1.

### Output
Write the complete `dev-loop.sh` script. Include inline comments explaining each major section. Do not write any other files.
