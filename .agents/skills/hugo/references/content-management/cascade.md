## Cascade

> [!NOTE]
  > For multilingual projects, defining cascade values in your project configuration is often more efficient. This avoids repeating the same cascade values for each language. See [details][].

A [branch](g) can cascade front matter values to its descendants. However, this cascading will be prevented if the descendant already defines the field, or if a closer ancestor branch has already cascaded a value for that same field.

For example, to cascade the `color` page parameter from the home page to all its descendants:

{{< code-toggle file=content/_index.md fm=true >}}
title = 'Home'
[cascade.params]
color = 'red'
{{< /code-toggle >}}

### Target

<!-- TODO
We deprecated the `_target` front matter key in favor of `target` in v0.156.0 on 2026-02-17. Remove footnote #1 somewhere after v0.171.0, 15 minor releases
after deprecation.
-->

The `target` key accepts a [page matcher](g) to limit cascaded values to a subset of pages.[^1] If a target is not specified, values cascade to all descendant pages.

{{% include "/_common/configuration/page-matcher.md" %}}

For example, to cascade the `color` page parameter from the home page to the `articles` section and its descendants:

{{< code-toggle file=hugo >}}
[cascade.params]
color = 'red'
[cascade.target]
path = '{/articles,/articles/**}'
{{< /code-toggle >}}

### Array

Define an array of cascade maps to apply different values to different targets. For example:

{{< code-toggle file=content/_index.md fm=true >}}
title = 'Home'
[[cascade]]
[cascade.params]
color = 'red'
[cascade.target]
path = '{/articles,/articles/**}'
[[cascade]]
[cascade.params]
color = 'blue'
[cascade.target]
path = '{/tutorials,/tutorials/**}'
{{< /code-toggle >}}

