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


### bootstrap

See `bootstrap/README.md` for the full bootstrap process, fixup notes, and session dump index.

Quick start with opencode and [nixwrap](https://github.com/rti/nixwrap):

```bash
cat bootstrap/bootstrap-prompt.md | \
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
