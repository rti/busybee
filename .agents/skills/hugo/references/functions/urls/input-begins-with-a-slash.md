## Input begins with a slash

If the input begins with a slash, the resulting URL will be relative to the protocol+host of the `baseURL` in your project configuration.

With `baseURL = https://example.org/`

```go-html-template
{{ relURL "/" }}          → /
{{ relURL "/articles" }}  → /articles
{{ relURL "/style.css" }} → /style.css
```

With `baseURL = https://example.org/docs/`

```go-html-template
{{ relURL "/" }}          → /
{{ relURL "/articles" }}  → /articles
{{ relURL "/style.css" }} → /style.css
```

> [!NOTE]
> As illustrated by the previous example, using a leading slash is rarely desirable and can lead to unexpected outcomes. In nearly all cases, omit the leading slash.

[`urls.RelLangURL`]: /functions/urls/rellangurl/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/urls/URLize.md
---


{{% include "/_common/functions/urls/anchorize-vs-urlize.md" %}}

