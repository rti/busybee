## Embedded

Hugo includes an [embedded link render hook][] to resolve Markdown link destinations. You can adjust its behavior in your project configuration. This is the default setting:

{{< code-toggle file=hugo >}}
[markup.goldmark.renderHooks.link]
useEmbedded = 'auto'
{{< /code-toggle >}}

When set to `auto` as shown above, Hugo automatically uses the embedded link render hook for multilingual single-host projects, specifically when the [duplication of shared page resources][] feature is disabled. This is the default behavior for such projects. If custom link render hooks are defined by your project, modules, or themes, these will be used instead.

You can also configure Hugo to `always` use the embedded link render hook, use it only as a `fallback`, or `never` use it. See [details][].

The embedded link render hook resolves internal Markdown destinations by looking for a matching page, falling back to a matching [page resource](g), then falling back to a matching [global resource](g). Remote destinations are passed through, and the render hook will not throw an error or warning if unable to resolve a destination.

You must place global resources in the `assets` directory. If you have placed your resources in the `static` directory, and you are unable or unwilling to move them, you must mount the `static` directory to the `assets` directory by including both of these entries in your project configuration:

{{< code-toggle file=hugo >}}
[[module.mounts]]
source = 'assets'
target = 'assets'

[[module.mounts]]
source = 'static'
target = 'assets'
{{< /code-toggle >}}

{{% include "/_common/render-hooks/pageinner.md" %}}

[CommonMark]: https://spec.commonmark.org/current/
[`RenderShortcodes`]: /methods/page/rendershortcodes/
[details]: /configuration/markup/#renderhookslinkuseembedded
[duplication of shared page resources]: /configuration/markup/#duplicateresourcefiles
[embedded link render hook]: <{{% eturl render-link %}}>


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/render-hooks/passthrough.md
---


