## Nil comparison

To return a slice of pages where the "color" parameter is present in front matter, compare to `nil`:

```go-html-template
{{ $pages := where .Site.RegularPages "Params.color" "ne" nil }}
```

To return a slice of pages where the "color" parameter is not present in front matter, compare to `nil`:

```go-html-template
{{ $pages := where .Site.RegularPages "Params.color" "eq" nil }}
```

In both examples above, note that `nil` is not quoted.

