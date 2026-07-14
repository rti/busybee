## Home

A _home_ template renders your site's home page.

For example, Hugo applies a _base_ template to the _home_ template below, then renders the page content and a list of the site's regular pages.

```go-html-template {file="layouts/home.html"}
{{ define "main" }}
  {{ .Content }}
  {{ range .Site.RegularPages }}
    <h2><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></h2>
  {{ end }}
{{ end }}
```

{{% include "/_common/filter-sort-group.md" %}}

