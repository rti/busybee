## Example -- headless page

Create a unpublished page whose content and resources can be included in other pages.

```tree
content/
├── headless/
│   ├── a.jpg
│   ├── b.jpg
│   └── index.md  <-- leaf bundle
└── _index.md     <-- home page
```

Set the build options in front matter:

{{< code-toggle file=content/headless/index.md fm=true >}}
title = 'Headless page'
[build]
  list = 'never'
  publishResources = false
  render = 'never'
{{< /code-toggle >}}

To include the content and images on the home page:

```go-html-template {file="layouts/home.html"}
{{ with .Site.GetPage "/headless" }}
  {{ .Content }}
  {{ range .Resources.ByType "image" }}
    <img src="{{ .RelPermalink }}" width="{{ .Width }}" height="{{ .Height }}" alt="">
  {{ end }}
{{ end }}
```

The published site will have this structure:

```tree
public/
├── headless/
│   ├── a.jpg
│   └── b.jpg
└── index.html
```

In the example above, note that:

1. Hugo did not publish an HTML file for the page.
1. Despite setting `publishResources` to `false` in front matter, Hugo published the [page resources][] because we invoked the [`RelPermalink`][] method on each resource. This is the expected behavior.

