## All

An _all_ template is a fallback for [home](#home), [page](#page), [section](#section), [taxonomy](#taxonomy), [term](#term), [single](#single), and [list](#list) templates. If one of these template types does not exist, Hugo will look for an _all_ template instead.

For example, Hugo applies a _base_ template to the _all_ template below, then conditionally renders a page based on its page kind.

```go-html-template {file="layouts/all.html"}
{{ define "main" }}
  {{ if eq .Kind "home" }}
    {{ .Content }}
    {{ range .Site.RegularPages }}
      <h2><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></h2>
    {{ end }}
  {{ else if eq .Kind "page" }}
    <h1>{{ .Title }}</h1>
    {{ .Content }}
  {{ else if in (slice "section" "taxonomy" "term") .Kind }}
    <h1>{{ .Title }}</h1>
    {{ .Content }}
    {{ range .Pages }}
      <h2><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></h2>
    {{ end }}
  {{ else }}
    {{ errorf "Unsupported page kind: %s" .Kind }}
  {{ end }}
{{ end }}
```

