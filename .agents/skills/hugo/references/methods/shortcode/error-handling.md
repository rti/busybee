## Error handling

{{% include "_common/ref-and-relref-error-handling.md" %}}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/shortcode/Scratch.md
---


{{< deprecated-in 0.139.0 >}}
Use the [`SHORTCODE.Store`](/methods/shortcode/store/) method instead.

This is a soft deprecation. This method will be removed in a future release, but the removal date has not been established. Although Hugo will not emit a warning if you continue to use this method, you should begin using `SHORTCODE.Store` as soon as possible.

Beginning with v0.139.0 the `SHORTCODE.Scratch` method is aliased to `SHORTCODE.Store`.
{{< /deprecated-in >}}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/shortcode/Site.md
---


See [Site methods][].

```go-html-template
{{ .Site.Title }}
```

[Site methods]: /methods/site/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/shortcode/Store.md
---


{{< new-in 0.139.0 />}}

Use the `Store` method to create a persistent data structure for storing and manipulating keyed values, scoped to the current shortcode. To create a data structure with a different [scope](g), refer to the [scope](#scope) section below.

> [!NOTE]
> With the introduction of the [`newScratch`][] function, and the ability to [assign values to template variables][] after initialization, the `Store` method within a shortcode is mostly obsolete.

{{% include "_common/store-methods.md" %}}

{{% include "_common/store-scope.md" %}}

[`newScratch`]: /functions/collections/newScratch/
[assign values to template variables]: https://go.dev/doc/go1.11#texttemplatepkgtexttemplate

