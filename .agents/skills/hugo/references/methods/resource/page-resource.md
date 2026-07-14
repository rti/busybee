## Page resource

With a [page resource](g), if you create an element in the `resources` array in front matter, the `Title` method returns the value of the `title` parameter.

```tree
content/
├── example/
│   ├── images/
│   │   └── a.jpg
│   └── index.md
└── _index.md
```

{{< code-toggle file=content/example/index.md fm=true >}}
title = 'Example'
[[resources]]
src = 'images/a.jpg'
title = 'A beautiful sunrise in Bryce Canyon'
{{< /code-toggle >}}

```go-html-template
{{ with .Resources.Get "images/a.jpg" }}
  {{ .Title }} → A beautiful sunrise in Bryce Canyon
{{ end }}
```

If you do not create an element in the `resources` array in front matter, the `Title` method returns the file path, relative to the page bundle.

```tree
content/
├── example/
│   ├── images/
│   │   └── Sunrise in Bryce Canyon.jpg
│   └── index.md
└── _index.md
```

```go-html-template
{{ with .Resources.Get "Sunrise in Bryce Canyon.jpg" }}
  {{ .Title }} → images/Sunrise in Bryce Canyon.jpg
{{ end }}
```

