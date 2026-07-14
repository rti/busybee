## Error handling

{{% include "_common/ref-and-relref-error-handling.md" %}}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/urls/RelURL.md
---


With multilingual configurations, use the [`urls.RelLangURL`][] function instead. The URL returned by this function depends on:

- Whether the input begins with a slash (`/`)
- The `baseURL` in your project configuration

