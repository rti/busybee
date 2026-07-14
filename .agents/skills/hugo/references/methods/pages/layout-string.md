## Layout string

{{% include "/_common/time-layout-string.md" %}}

[`time.Format`]: /functions/time/format/
[project configuration]: /configuration/front-matter/#dates


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/pages/Len.md
---


```go-html-template
{{ .Pages.Len }} → 42
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/pages/Limit.md
---


```go-html-template
{{ range .Pages.Limit 3 }}
  <h2><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></h2>
{{ end }}
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/pages/Next.md
---


{{% include "/_common/methods/pages/next-and-prev.md" %}}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/pages/Prev.md
---


{{% include "/_common/methods/pages/next-and-prev.md" %}}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/pages/Related.md
---


Based on front matter, Hugo uses several factors to identify content related to the given page. Use the default [related content configuration][], or tune the results to the desired indices and parameters. See [details][].

The argument passed to the `Related` method may be a `Page` or an options map. For example, to pass the current page:

```go-html-template {file="layouts/page.html"}
{{ with .Site.RegularPages.Related . | first 5 }}
  <p>Related pages:</p>
  <ul>
    {{ range . }}
      <li><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></li>
    {{ end }}
  </ul>
{{ end }}
```

To pass an options map:

```go-html-template {file="layouts/page.html"}
{{ $opts := dict
  "document" .
  "indices" (slice "tags" "keywords")
}}
{{ with .Site.RegularPages.Related $opts | first 5 }}
  <p>Related pages:</p>
  <ul>
    {{ range . }}
      <li><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></li>
    {{ end }}
  </ul>
{{ end }}
```

