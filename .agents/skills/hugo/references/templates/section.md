## Section

A _section_ template renders a list of pages within a [section](g).

For example, Hugo applies a _base_ template to the _section_ template below, then renders the page title, page content, and a list of pages in the current section.

```go-html-template {file="layouts/section.html"}
{{ define "main" }}
  <h1>{{ .Title }}</h1>
  {{ .Content }}
  {{ range .Pages }}
    <h2><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></h2>
  {{ end }}
{{ end }}
```

{{% include "/_common/filter-sort-group.md" %}}

