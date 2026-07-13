# busybee — Agentic Development Loop

## Linting & verification

No build system, test suite, or CI.

To lint the script:
```bash
nix run nixpkgs#shellcheck -- dev-loop.sh
```
**NEVER** run `run-loop.sh` or `nix run .#`. You are running inside this context already!

## Git identity

The script sets git identity to `busybee-bot <busybee-bot@users.noreply.github.com>`. Commits are attributed to this bot account.

## Agents skills

`/.agents/skills/` contains opencode skills for git-commit, github-issues, and github-pr-reviews. These are loaded by opencode automatically when relevant.
