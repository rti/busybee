## Taxonomy

A _taxonomy_ template renders a list of terms in a [taxonomy](g).

For example, Hugo applies a _base_ template to the _taxonomy_ template below, then renders the page title, page content, and a list of [terms](g) in the current taxonomy.

```go-html-template {file="layouts/taxonomy.html"}
{{ define "main" }}
  <h1>{{ .Title }}</h1>
  {{ .Content }}
  {{ range .Pages }}
    <h2><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></h2>
  {{ end }}
{{ end }}
```

{{% include "/_common/filter-sort-group.md" %}}

Within a _taxonomy_ template, the [`Data`][] object provides these taxonomy-specific methods:

- [`Singular`][taxonomy-singular]
- [`Plural`][taxonomy-plural]
- [`Terms`][]

The `Terms` method returns a [taxonomy object](g), allowing you to call any of its methods including [`Alphabetical`][] and [`ByCount`][]. For example, use the `ByCount` method to render a list of terms sorted by the number of pages associated with each term:

```go-html-template {file="layouts/taxonomy.html"}
{{ define "main" }}
  <h1>{{ .Title }}</h1>
  {{ .Content }}
  {{ range .Data.Terms.ByCount }}
    <h2><a href="{{ .Page.RelPermalink }}">{{ .Page.LinkTitle }}</a> ({{ .Count }})</h2>
  {{ end }}
{{ end }}
```

