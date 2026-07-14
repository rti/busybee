## Partial

A _partial_ template is typically used to render a component of your site, though you may also create _partial_ templates that return values.

For example, the _partial_ template below renders copyright information:

```go-html-template {file="layouts/_partials/footer.html"}
<p>Copyright {{ now.Year }}. All rights reserved.</p>
```

Execute the _partial_ template by calling the [`partial`][] or [`partialCached`][] function, optionally passing context as the second argument:

```go-html-template {file="layouts/baseof.html"}
{{ partial "footer.html" . }}
```

<!-- https://github.com/gohugoio/hugo/pull/13614#issuecomment-2805977008 -->
Unlike other template types, Hugo does not consider the current page kind, content type, logical path, language, or output format when searching for a matching _partial_ template. However, it _does_ apply the same _name_ matching logic it uses for other template types. This means it tries to find the most specific match first, then progressively looks for more general versions if the specific one isn't found.

For example, with this call:

```go-html-template {file="layouts/baseof.html"}
{{ partial "footer.section.de.html" . }}
```

Hugo uses this lookup order to find a matching template:

1. `layouts/_partials/footer.section.de.html`
1. `layouts/_partials/footer.section.html`
1. `layouts/_partials/footer.de.html`
1. `layouts/_partials/footer.html`

A _partial_ template can also be defined inline within another template. However, it's important to note that the template namespace is global; ensuring unique names for these _partial_ templates is necessary to prevent conflicts.

```go-html-template
Value: {{ partial "my-inline-partial.html" . }}

{{ define "_partials/my-inline-partial.html" }}
  {{ $value := 32 }}
  {{ return $value }}
{{ end }}
```

