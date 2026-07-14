## Example -- headless section

Create a unpublished section whose content and resources can be included in other pages.

```tree
content/
├── headless/
│   ├── note-1/
│   │   ├── a.jpg
│   │   ├── b.jpg
│   │   └── index.md  <-- leaf bundle
│   ├── note-2/
│   │   ├── c.jpg
│   │   ├── d.jpg
│   │   └── index.md  <-- leaf bundle
│   └── _index.md     <-- branch bundle
└── _index.md         <-- home page
```

Set the build options in front matter, using the `cascade` keyword to "cascade" the values down to descendant pages.

{{< code-toggle file=content/headless/_index.md fm=true >}}
title = 'Headless section'
[[cascade]]
[cascade.build]
  list = 'local'
  publishResources = false
  render = 'never'
{{< /code-toggle >}}

In the front matter above, note that we have set `list` to `local` to include the descendant pages in local page collections.

To include the content and images on the home page:

```go-html-template {file="layouts/home.html"}
{{ with .Site.GetPage "/headless" }}
  {{ range .Pages }}
    {{ .Content }}
    {{ range .Resources.ByType "image" }}
      <img src="{{ .RelPermalink }}" width="{{ .Width }}" height="{{ .Height }}" alt="">
    {{ end }}
  {{ end }}
{{ end }}
```

The published site will have this structure:

```tree
public/
├── headless/
│   ├── note-1/
│   │   ├── a.jpg
│   │   └── b.jpg
│   └── note-2/
│       ├── c.jpg
│       └── d.jpg
└── index.html
```

In the example above, note that:

1. Hugo did not publish an HTML file for the page.
1. Despite setting `publishResources` to `false` in front matter, Hugo correctly published the [page resources][] because we invoked the [`RelPermalink`][] method on each resource. This is the expected behavior.

