## Example -- list without publishing

Publish a section page without publishing the descendant pages. For example, to create a glossary:

```tree
content/
├── glossary/
│   ├── _index.md
│   ├── bar.md
│   ├── baz.md
│   └── foo.md
└── _index.md
```

Set the build options in front matter, using the `cascade` keyword to "cascade" the values down to descendant pages.

{{< code-toggle file=content/glossary/_index.md fm=true >}}
title = 'Glossary'
[build]
render = 'always'
[[cascade]]
[cascade.build]
  list = 'local'
  publishResources = false
  render = 'never'
{{< /code-toggle >}}

To render the glossary:

```go-html-template {file="layouts/glossary/section.html"}
<dl>
  {{ range .Pages }}
    <dt>{{ .Title }}</dt>
    <dd>{{ .Content }}</dd>
  {{ end }}
</dl>
```

The published site will have this structure:

```tree
public/
├── glossary/
│   └── index.html
└── index.html
```

