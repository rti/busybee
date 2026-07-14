## Render hook

A _render hook_ template overrides the conversion of Markdown to HTML.

For example, the _render hook_ template below adds an anchor link to the right of each heading.

```go-html-template {file="layouts/_markup/render-heading.html"}
<h{{ .Level }} id="{{ .Anchor }}" {{- with .Attributes.class }} class="{{ . }}" {{- end }}>
  {{ .Text }}
  <a href="#{{ .Anchor }}">#</a>
</h{{ .Level }}>
```

Learn more about [render hook templates][].

