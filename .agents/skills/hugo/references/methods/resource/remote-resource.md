## Remote resource

With a [remote resource](g), the `Title` method returns a hashed file name.

```go-html-template
{{ with resources.GetRemote "https://example.org/images/a.jpg" }}
  {{ .Title }} → /a_18432433023265451104.jpg
{{ end }}
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/resource/Width.md
---


{{% include "/_common/methods/resource/global-page-remote-resources.md" %}}

Use the [`reflect.IsImageResourceWithMeta`][] function to verify that Hugo can determine the dimensions before calling the `Width` method.

```go-html-template
{{ with resources.GetMatch "images/featured.*" }}
  {{ if reflect.IsImageResourceWithMeta . }}
    <img src="{{ .RelPermalink }}" width="{{ .Width }}" height="{{ .Height }}" alt="">
  {{ else }}
    <img src="{{ .RelPermalink }}" alt="">
  {{ end }}
{{ end }}
```

[`reflect.IsImageResourceWithMeta`]: /functions/reflect/isimageresourcewithmeta/

