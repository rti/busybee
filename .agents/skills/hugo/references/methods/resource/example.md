## Example

```go-html-template
{{ with resources.Get "images/original.jpg" }}
  {{ with .Resize "300x" }}
    <img src="{{ .RelPermalink }}" width="{{ .Width }}" height="{{ .Height }}" alt="">
  {{ end }}
{{ end }}
```

{{< img
  src="images/examples/zion-national-park.jpg"
  alt="Zion National Park"
  filter="Process"
  filterArgs="resize 300x"
  example=true
>}}

[`reflect.IsImageResourceProcessable`]: /functions/reflect/isimageresourceprocessable/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/resource/ResourceType.md
---


{{% include "/_common/methods/resource/global-page-remote-resources.md" %}}

Common resource types include `audio`, `image`, `text`, and `video`.

```go-html-template
{{ with resources.Get "image/a.jpg" }}
  {{ .ResourceType }} → image
  {{ .MediaType.MainType }} → image
{{ end }}
```

When working with content files, the resource type is `page`.

```tree
content/
├── lessons/
│   ├── lesson-1/
│   │   ├── _objectives.md  <-- resource type = page
│   │   ├── _topics.md      <-- resource type = page
│   │   ├── _example.jpg    <-- resource type = image
│   │   └── index.md
│   └── _index.md
└── _index.md
```

With the structure above, we can range through page resources of type `page` to build content:

```go-html-template {file="layouts/lessons/page.html"}
{{ range .Resources.ByType "page" }}
  {{ .Content }}
{{ end }}
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/resource/Title.md
---


The value returned by the `Title` method on a `Resource` object depends on the resource type.

