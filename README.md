# busybee
Purely agentic development prototype

### run a dev step
You can `gh auth login` with your Github Bot Account (better not use your main), and get the token from `~/.config/gh/config.yml`
```bash
git checkout main; git pull
GH_TOKEN=gho_XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX REPO=rti/busybee \
    wrap -e GH_TOKEN -e REPO -n -r ~/.config/opencode \
        ./dev-loop.sh
```


### bootstrap with opencode and [nixwrap](https://github.com/rti/nixwrap)

```bash
cat bootstrap-prompt.md | \
  wrap -und \
    -r ~/.config/opencode/ \
    -w ~/.local/share/opencode/ \
    nix run nixpkgs-unstable#opencode -- \
      run --agent build --thinking 
```

### build out dev-loop.sh

```bash
cat dev-loop-prompt.md | \
    wrap -und \
        -r ~/.config/opencode/ \
        -w ~/.local/share/opencode/ \
        nix run nixpkgs-unstable#opencode -- \
        run --agent build --thinking 
```

### fixup script

```bash
REPO=rti/busybee \
    wrap -e GH_TOKEN -e REPO -n ./dev-loop.sh 2>&1 | \
    wrap -und \
        -r ~/.config/opencode/ \
        -w ~/.local/share/opencode/ \
        nix run nixpkgs-unstable#opencode -- \
            run --agent build --thinking 
```

### fixup script git ssh access

```bash
echo "REPO=rti/busybee wrap -e GH_TOKEN -e REPO -un ./dev-loop.sh
  The authenticity of host 'github.com (20.205.243.166)' can't be established.
  ED25519 key fingerprint is: SHA256:+DiY3wvvV6TuJJhbpZisF/zLDA0zPMSvHdkr4UvCOqU
  This key is not known by any other names.
  Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
  Warning: Permanently added 'github.com' (ED25519) to the list of known hosts.
  git@github.com: Permission denied (publickey).
  fatal: Could not read from remote repository.

  Please make sure you have the correct access rights
  and the repository exists." | \
    wrap -und \
        -r ~/.config/opencode/ \
        -w ~/.local/share/opencode/ \
        nix run nixpkgs-unstable#opencode -- \
            run --agent build --thinking
```

### fixup opencode run

```bash
echo "
opencode in dev-loop.sh hangs, opencode needs to be called with 'opencode run --agent build --thinking' and get the prompt via stdin
" | wrap -und \
          -r ~/.config/opencode/ \
          -w ~/.local/share/opencode/ \
          nix run nixpkgs-unstable#opencode -- \
            run --agent build --thinking
```

### fixup branch exists
```bash
echo "dev-loop.sh invocation error:
Already on 'main'
Your branch is ahead of 'origin/main' by 3 commits.
  (use 'git push' to publish your local commits)
From https://github.com/rti/busybee
 * branch            main       -> FETCH_HEAD
Already up to date.
fatal: a branch named '1-move-all-session-dumps-into-a-subfolder-' already exists
" | wrap -und \
          -r ~/.config/opencode/ \
          -w ~/.local/share/opencode/ \
          nix run nixpkgs-unstable#opencode -- \
            run --agent build --thinking
```

### fixup nothing to commit
```bash
echo "dev-loop.sh issue fixing error: opencode committed, script failed because found nothing to commit
./dev-loop.sh
Implementing issue #1: move all session dumps into a subfolder and prefix them with an index just like the 003 one
Switched to branch 'main'
Your branch is ahead of 'origin/main' by 4 commits.
  (use "git push" to publish your local commits)
From https://github.com/rti/busybee
 * branch            main       -> FETCH_HEAD
Already up to date.
Deleted branch 1-move-all-session-dumps-into-a-subfolder- (was f979c92).
Switched to a new branch '1-move-all-session-dumps-into-a-subfolder-'
No file changes from opencode for issue #1.
Your branch is ahead of 'origin/main' by 4 commits.
❱ git log 1-move-all-session-dumps-into-a-subfolder- -n1
commit 0d142d4d2d897c1c5fbd639b3383b3338095b9f8 (1-move-all-session-dumps-into-a-subfolder-)
Author: busybee-bot <bot@busybee.dev>
Date:   Sat Jul 11 15:02:31 2026 +0000

    refactor: move all session dumps into sessions/ subfolder with index prefixes
" | wrap -und \
          -r ~/.config/opencode/ \
          -w ~/.local/share/opencode/ \
          nix run nixpkgs-unstable#opencode -- \
            run --agent build --thinking
```

### fixup syntax
```bash
nix run nixpkgs#shellcheck dev-loop.sh | \
        wrap -und \
          -r ~/.config/opencode/ \
          -w ~/.local/share/opencode/ \
          nix run nixpkgs-unstable#opencode -- \
            run --agent build --thinking
```

### export last session

```bash
opencode export (opencode session list | head -n3 | tail -n1 | cut -d' ' -f1) > session-name.json
```
