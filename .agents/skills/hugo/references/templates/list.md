## List

A _list_ template is a fallback for [home](#home), [section](#section), [taxonomy](#taxonomy), and [term](#term) templates. If one of these template types does not exist, Hugo will look for a _list_ template instead.

For example, Hugo applies a _base_ template to the _list_ template below, then renders the page title, page content, and a list of pages.

```go-html-template {file="layouts/list.html"}
{{ define "main" }}
  <h1>{{ .Title }}</h1>
  {{ .Content }}
  {{ range .Pages }}
    <h2><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></h2>
  {{ end }}
{{ end }}
```

