## Limitations

The primary use case for `.RenderShortcodes` is inclusion of Markdown content. If you try to use `.RenderShortcodes` inside `HTML` blocks when inside Markdown, you will get a warning similar to this:

```text
WARN .RenderShortcodes detected inside HTML block in "/content/mypost.md"; this may not be what you intended ...
```

The above warning can be turned off is this is what you really want.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/RenderString.md
---


The `RenderString` method on a `Page` object renders markup to HTML.

```go-html-template
{{ $s := "An *emphasized* word" }}
{{ $s | .RenderString }} → An <em>emphasized</em> word
```

