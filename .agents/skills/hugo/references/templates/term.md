## Term

A _term_ template renders a list of pages associated with a [term](g).

For example, Hugo applies a _base_ template to the _term_ template below, then renders the page title, page content, and a list of pages associated with the current term.

```go-html-template {file="layouts/term.html"}
{{ define "main" }}
  <h1>{{ .Title }}</h1>
  {{ .Content }}
  {{ range .Pages }}
    <h2><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></h2>
  {{ end }}
{{ end }}
```

{{% include "/_common/filter-sort-group.md" %}}

Within a _term_ template, the [`Data`][] object provides these term-specific methods:

- [`Singular`][term-singular]
- [`Plural`][term-plural]
- [`Term`][]

