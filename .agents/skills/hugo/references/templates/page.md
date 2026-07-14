## Page

A _page_ template renders a regular page.

For example, Hugo applies a _base_ template to the _page_ template below, then renders the page title and page content.

```go-html-template {file="layouts/page.html"}
{{ define "main" }}
  <h1>{{ .Title }}</h1>
  {{ .Content }}
{{ end }}
```

