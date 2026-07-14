## List output formats

To access output formats, each `Page` object provides two methods: [`OutputFormats`][] (for all formats, including the current one) and [`AlternativeOutputFormats`][]. Use `AlternativeOutputFormats` to create a link `rel` list within a `head` element, as shown below:

```go-html-template
{{ range .AlternativeOutputFormats }}
  <link rel="{{ .Rel }}" type="{{ .MediaType.Type }}" href="{{ .Permalink | safeURL }}">
{{ end }}
```

