## Single

A _single_ template is a fallback for a _page_ template. If a _page_ template does not exist, Hugo will look for a _single_ template instead.

For example, Hugo applies a _base_ template to the _single_ template below, then renders the page title and page content.

```go-html-template {file="layouts/single.html"}
{{ define "main" }}
  <h1>{{ .Title }}</h1>
  {{ .Content }}
{{ end }}
```

