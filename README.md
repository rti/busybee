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

### export last session

```bash
opencode export (opencode session list | head -n3 | tail -n1 | cut -d' ' -f1) > session-name.json
```
