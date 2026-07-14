## Page references

Regardless of how you [define menu entries][], an entry associated with a page has access to page context.

This simplistic example renders a page parameter named `version` next to each entry's `name`. Code defensively using `with` or `if` to handle entries where (a) the entry points to an external resource, or (b) the `version` parameter is not defined.

```go-html-template {file="layouts/page.html"}
{{- range site.Menus.main }}
  <a href="{{ .URL }}">
    {{ .Name }}
    {{- with .Page }}
      {{- with .Params.version -}}
        ({{ . }})
      {{- end }}
    {{- end }}
  </a>
{{- end }}
```

