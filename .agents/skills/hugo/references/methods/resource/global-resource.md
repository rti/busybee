## Global resource

With a [global resource](g), the `Title` method returns the path to the resource, relative to the `assets` directory.

```tree
assets/
└── images/
    └── Sunrise in Bryce Canyon.jpg
```

```go-html-template
{{ with resources.Get "images/Sunrise in Bryce Canyon.jpg" }}
  {{ .Title }} → /images/Sunrise in Bryce Canyon.jpg
{{ end }}
```

