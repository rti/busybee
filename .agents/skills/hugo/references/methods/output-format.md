
---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/output-format/MediaType.md
---


{{% include "/_common/methods/output-formats/to-use-this-method.md" %}}

## Example

```go-html-template
{{ with .Site.Home.OutputFormats.Get "rss" }}
  {{ with .MediaType }}
    {{ .Type }} → application/rss+xml
    {{ .MainType }} → application
    {{ .SubType }} → rss
    {{ .Suffixes }} → [rss]
    {{ .FirstSuffix.Suffix }} → rss
  {{ end }}
{{ end }}
```

## Methods

Use these methods on the `MediaType` object.

{{% include "/_common/methods/media-type/core-methods.md" %}}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/output-format/Name.md
---


{{% include "/_common/methods/output-formats/to-use-this-method.md" %}}

```go-html-template
{{ with .Site.Home.OutputFormats.Get "rss" }}
  {{ .Name }} → rss
{{ end }}
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/output-format/Permalink.md
---


{{% include "/_common/methods/output-formats/to-use-this-method.md" %}}

```go-html-template
{{ with .Site.Home.OutputFormats.Get "rss" }}
  {{ .Permalink }} → https://example.org/index.xml
{{ end }}
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/output-format/Rel.md
---


{{% include "/_common/methods/output-formats/to-use-this-method.md" %}}

```go-html-template
{{ with .Site.Home.OutputFormats.Get "rss" }}
  {{ .Rel }} → alternate
{{ end }}
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/output-format/RelPermalink.md
---


{{% include "/_common/methods/output-formats/to-use-this-method.md" %}}

```go-html-template
{{ with .Site.Home.OutputFormats.Get "rss" }}
  {{ .RelPermalink }} → /index.xml
{{ end }}
```

