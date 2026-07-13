# busybee
Purely agentic development prototype

### run a dev step
You can `gh auth login` with your Github Bot Account (better not use your main), and get the token from `~/.config/gh/config.yml`
```bash
GH_TOKEN=gho_XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX \
  REPO=rti/busybee \
  wrap -e GH_TOKEN -e REPO -n -r ~/.config/opencode \
  nix run .
```
