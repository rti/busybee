## Target

<!-- TODO
We deprecated the `_target` front matter key in favor of `target` in v0.156.0 on 2026-02-17. Remove footnote #1 somewhere after v0.171.0, 15 minor releases
after deprecation.
-->

The `target` key accepts a [page matcher](g) to limit cascaded values to a subset of pages.[^1] If a target is omitted, values cascade to all pages.

{{% include "/_common/configuration/page-matcher.md" %}}

For example, to cascade the `color` page parameter to the `articles` section and its descendants, but only for the English (`en`) and German (`de`) language sites:

{{< code-toggle file=hugo >}}
[cascade.params]
color = 'red'
[cascade.target]
path = '{/articles,/articles/**}'
[cascade.target.sites.matrix]
languages = '{en,de}'
{{< /code-toggle >}}

