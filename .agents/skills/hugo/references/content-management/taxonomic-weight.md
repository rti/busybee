## Taxonomic weight

{{% glossary-term "taxonomic weight" %}}

Assign a taxonomic weight using a front matter key named `[taxonomy_name]_weight`.

{{< code-toggle file="content/courses/organic-chemistry.md" fm=true >}}
title = 'Organic Chemistry'
weight = 10
tags_weight = 1000
tags = ['chemistry','science']
{{</ code-toggle >}}

With the front matter above, the `organic-chemistry` page will float towards the top of the list on section and home pages, and it will sink towards the bottom of the list on the `chemistry` and `science` term pages.

