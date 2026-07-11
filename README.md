# busybee
Purely agentic development prototype

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

### export last session

```bash
opencode export (opencode session list | head -n3 | tail -n1 | cut -d' ' -f1) > session-name.json
```
