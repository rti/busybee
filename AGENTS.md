# busybee — Agentic Development Loop

## Linting & verification

No build system, test suite, or CI.

To lint the script:
```bash
shellcheck dev-loop.sh
```
**NEVER** run `run-loop.sh` or `nix run .#`. You are running inside this context already!

## Git identity

The script sets git identity to `busybee-bot <busybee-bot@users.noreply.github.com>`.

## Hugo website

This repo contains a Hugo static site using the Ananke theme (managed as a git submodule in `themes/ananke`). The `public/` folder is **not** tracked in git; GitHub Actions builds it.

- **Submodules:** After checking out a branch, run `git submodule update --init --recursive` to ensure the Ananke theme is available.
- **Dev server:** Run `hugo server` to serve at `http://localhost:1313`. If port 1313 is already in use, pick another with `-p <port>` (e.g. `hugo server -p 1314`).
- **Browser inspection:** Use the `playwright` MCP tools (`playwright_browser_navigate`, `playwright_browser_snapshot`, `playwright_browser_take_screenshot`, etc.) to inspect the rendered site in a browser.

## Agents skills

`/.agents/skills/` contains opencode skills for git-commit, github-issues, and github-pr-reviews. These are loaded by opencode automatically when relevant.
