# busybee
Purely agentic development prototype

### bootstrap with opencode and [nixwrap](https://github.com/rti/nixwrap)

```bash
cat bootstrap-prompt.md | \
  wrap -und \
    -r ~/.config/opencode/ \
    -w ~/.local/share/opencode/ \
    nix run nixpkgs-unstable#opencode -- \
      run --agent build
```
