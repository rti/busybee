## Positional arguments

This shortcode call uses positional arguments:

```md {file="content/about.md"}
{{</* myshortcode "Hello" "world" */>}}
```

To retrieve arguments by position:

```go-html-template {file="layouts/_shortcodes/myshortcode.html"}
{{ printf "%s %s." (.Get 0) (.Get 1) }} → Hello world.
```

