# site


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/site/AllPages.md
---


{{< deprecated-in 0.156.0 >}}
See [details](https://discourse.gohugo.io/t/56732).
{{< /deprecated-in >}}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/site/BaseURL.md
---


Project configuration:

{{< code-toggle file=hugo >}}
baseURL = 'https://example.org/docs/'
{{< /code-toggle >}}

Template:

```go-html-template
{{ .Site.BaseURL }} → https://example.org/docs/
```

> [!NOTE]
> There is almost never a good reason to use this method in your templates. Its usage tends to be fragile due to misconfiguration.
>
> Use the [`absURL`][], [`absLangURL`][], [`relURL`][], or [`relLangURL`][] functions instead.

[`absLangURL`]: /functions/urls/absLangURL/
[`absURL`]: /functions/urls/absURL/
[`relLangURL`]: /functions/urls/relLangURL/
[`relURL`]: /functions/urls/relURL/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/site/BuildDrafts.md
---


{{< deprecated-in 0.156.0 >}}
See [details](https://discourse.gohugo.io/t/56732).
{{< /deprecated-in >}}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/site/Config.md
---


The `Config` method on a `Site` object provides access to a subset of your project configuration, specifically the `services` and `privacy` keys.


## Sections

- [`services`](references/methods/site/services.md) — Services
- [`privacy`](references/methods/site/privacy.md) — Privacy
- [`multilingual-projects`](references/methods/site/multilingual-projects.md) — Multilingual Projects
- [`page-bundles`](references/methods/site/page-bundles.md) — Page Bundles
- [`methods`](references/methods/site/methods.md) — Methods
- [`example`](references/methods/site/example.md) — Example
- [`overview`](references/methods/site/overview.md) — Overview
- [`methods`](references/methods/site/methods.md) — Methods
- [`methods`](references/methods/site/methods.md) — Methods
- [`determinate-values`](references/methods/site/determinate-values.md) — Determinate Values
- [`examples`](references/methods/site/examples.md) — Examples
- [`overview`](references/methods/site/overview.md) — Overview
- [`methods`](references/methods/site/methods.md) — Methods

