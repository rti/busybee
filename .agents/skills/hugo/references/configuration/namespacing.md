## Namespacing

To prevent naming conflicts, module and theme developers should namespace any custom parameters specific to their module or theme.

{{< code-toggle file=hugo >}}
[params.modules.myModule.colors]
background = '#efefef'
font = '#222222'
{{< /code-toggle >}}

To access the module/theme settings:

```go-html-template
{{ $cfg := .Site.Params.module.mymodule }}

{{ $cfg.colors.background }} → #efefef
{{ $cfg.colors.font }} → #222222
```

[`Params`]: /methods/site/params/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/configuration/permalinks.md
---


Use the `permalinks` configuration to define custom URL patterns for your pages. Hugo supports two forms: a map form for simple section-based patterns, and an array form that supports [page matchers](g) for more precise targeting.

> [!NOTE]
> The [`url`][] front matter field overrides any matching permalink pattern.

