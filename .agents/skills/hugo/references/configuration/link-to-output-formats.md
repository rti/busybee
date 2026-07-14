## Link to output formats

By default, a `Page` object's [`Permalink`][] and [`RelPermalink`][] methods return the URL of the [primary output format](g), typically `html`. This behavior remains consistent regardless of the template used.

For example, in `page.json.json`, you'll see:

```go-html-template
{{ .RelPermalink }} → /that-page/
{{ with .OutputFormats.Get "json" }}
  {{ .RelPermalink }} → /that-page/index.json
{{ end }}
```

To make these methods return the URL of the _current_ template's output format, you must set the [`permalinkable`](#permalinkable) setting to `true` for that format.

With `permalinkable` set to true for `json` in the same `page.json.json` template:

```go-html-template
{{ .RelPermalink }} → /that-page/index.json
{{ with .OutputFormats.Get "html" }}
  {{ .RelPermalink }} → /that-page/
{{ end }}
```

