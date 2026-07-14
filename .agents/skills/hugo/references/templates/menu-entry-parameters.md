## Menu entry parameters

When you define menu entries in your [project configuration][] or in [front matter][], you can include a `params` key as shown in these examples:

- [Menu entry defined in your project configuration][]
- [Menu entry defined in front matter][]

This simplistic example renders a `class` attribute for each anchor element. Code defensively using `with` or `if` to handle entries where `params.class` is not defined.

```go-html-template {file="layouts/_partials/menu.html"}
{{- range site.Menus.main }}
  <a {{ with .Params.class -}} class="{{ . }}" {{ end -}} href="{{ .URL }}">
    {{ .Name }}
  </a>
{{- end }}
```

