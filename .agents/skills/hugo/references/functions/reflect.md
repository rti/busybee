
---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/reflect/IsImageResource.md
---


{{< new-in 0.154.0 />}}

## Usage

This example iterates through all project resources and uses `reflect.IsImageResource` to decide whether to render an image tag or provide a download link for non-image files.

```go-html-template
{{ range resources.Match "**" }}
  {{ if reflect.IsImageResource . }}
    <img src="{{ .RelPermalink }}" alt="Image">
  {{ else }}
    <a href="{{ .RelPermalink }}">Download</a>
  {{ end }}
{{ end }}
```

{{% include "/_common/functions/reflect/image-reflection-functions.md" %}}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/reflect/IsImageResourceProcessable.md
---


{{< new-in 0.157.0 />}}

{{% glossary-term "processable image" %}}

## Usage

This example iterates through all project resources and uses `reflect.IsImageResourceProcessable` to ensure the image pipeline can perform transformations like resizing before processing begins.

```go-html-template
{{ range resources.Match "**" }}
  {{ if reflect.IsImageResourceProcessable . }}
    {{ with .Process "resize 300x webp" }}
      <img src="{{ .RelPermalink }}" width="{{ .Width }}" height="{{ .Height }}" alt="Processed Image">
    {{ end }}
  {{ end }}
{{ end }}
```

{{% include "/_common/functions/reflect/image-reflection-functions.md" %}}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/reflect/IsImageResourceWithMeta.md
---


{{< new-in 0.157.0 />}}

## Usage

This example iterates through all project resources and uses `reflect.IsImageResourceWithMeta` to safely display image dimensions and metadata only for supported formats.

```go-html-template
{{ range resources.Match "**" }}
  {{ if reflect.IsImageResourceWithMeta . }}
    <img src="{{ .RelPermalink }}" width="{{ .Width }}" height="{{ .Height }}" alt="Image with Meta">
    {{ with .Meta }}
      <p>Taken on: {{ .Date }}</p>
    {{ end }}
  {{ end }}
{{ end }}
```

{{% include "/_common/functions/reflect/image-reflection-functions.md" %}}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/reflect/IsMap.md
---


```go-html-template
{{ reflect.IsMap (dict "key" "value") }} → true
{{ reflect.IsMap "yo" }} → false
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/reflect/IsPage.md
---


{{< new-in 0.154.0 />}}

```go-html-template {file="layouts/page.html"}
{{ with site.GetPage "/examples" }}
  {{ reflect.IsPage . }} → true
{{ end }}

{{ with .Site  }}
  {{ reflect.IsPage . }} → false
{{ end }}
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/reflect/IsResource.md
---


{{< new-in 0.154.0 />}}

With this project structure:

```tree
project/
├── assets/
│   ├── a.json
│   ├── b.avif
│   └── c.jpg
└── content/
    └── example/
        ├── index.md
        ├── d.json
        ├── e.avif
        └── f.jpg
```

These are the values returned by the `reflect.IsResource` function:

```go-html-template {file="layouts/page.html"}
{{ with resources.Get "a.json" }}
  {{ reflect.IsResource . }} → true
{{ end }}

{{ with resources.Get "b.avif" }}
  {{ reflect.IsResource . }} → true
{{ end }}

{{ with resources.Get "c.jpg" }}
  {{ reflect.IsResource . }} → true
{{ end }}
```

```go-html-template {file="layouts/page.html"}
{{ with .Resources.Get "d.json" }}
  {{ reflect.IsResource . }} → true
{{ end }}

{{ with .Resources.Get "e.avif" }}
  {{ reflect.IsResource . }} → true
{{ end }}

{{ with .Resources.Get "f.jpg" }}
  {{ reflect.IsResource . }} → true
{{ end }}
```

```go-html-template {file="layouts/page.html"}
{{ with site.GetPage "/example" }}
  {{ reflect.IsResource . }} → true
{{ end }}
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/reflect/IsSite.md
---


{{< new-in 0.154.0 />}}

```go-html-template {file="layouts/page.html"}
{{ with .Site  }}
  {{ reflect.IsSite . }} → true
{{ end }}

{{ with site.GetPage "/examples" }}
  {{ reflect.IsSite . }} → false
{{ end }}
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/reflect/IsSlice.md
---


```go-html-template
{{ reflect.IsSlice (slice 1 2 3) }} → true
{{ reflect.IsSlice "yo" }} → false
```

