## Replace

For local module development, use a `replace` directive in `go.mod` pointing to your local directory:

```text
replace github.com/user/module => /home/user/projects/module
```

With `hugo serve`r running, this change will trigger a configuration reload and add the local directory to the watch list. Alternatively, configure replacements by setting the [`replacements`][] parameter in your project configuration.

