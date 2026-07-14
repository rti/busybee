## Template lookup order

Each output format requires a template conforming to the [template lookup order][].

For the highest specificity in the template lookup order, include the page kind, output format, and suffix in the file name:

```text
[page kind].[output format].[suffix]
```

For example, for section pages:

Output format|Template path
:--|:--
`html`|`layouts/section.html.html`
`json`|`layouts/section.json.json`
`rss`|`layouts/section.rss.xml`

[`AlternativeOutputFormats`]: /methods/page/alternativeoutputformats/
[`OutputFormats`]: /methods/page/outputformats/
[`Permalink`]: /methods/page/permalink/
[`RelPermalink`]: /methods/page/relpermalink/
[`baseURL`]: /configuration/all/#baseurl
[`html/template`]: https://pkg.go.dev/html/template
[`publishDir`]: /configuration/all/#publishdir
[`text/template`]: https://pkg.go.dev/text/template
[`uglyURLs`]: /configuration/ugly-urls/
[alias redirects]: /content-management/urls/#aliases
[configure media types]: /configuration/media-types/
[configure outputs]: /configuration/outputs/
[configured media types]: /configuration/media-types/
[default media types]: /configuration/media-types/
[embedded RSS template]: <{{% eturl rss %}}>
[template lookup order]: /templates/lookup-order/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/configuration/outputs.md
---


{{% glossary-term "output format" %}}

Learn more about creating and configuring output formats in the [configure output formats][] section.

