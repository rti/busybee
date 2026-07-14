## Count the weighted pages

Now that we have captured the `genres` `Taxonomy` object, let's count the number of weighted pages to which the `suspense` term has been assigned:

```go-html-template
{{ $taxonomyObject.Count "suspense" }} → 3
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/taxonomy/Get.md
---


The `Get` method on a `Taxonomy` object returns a slice of [weighted pages](g) to which the given [term](g) has been assigned.

{{% include "/_common/methods/taxonomy/get-a-taxonomy-object.md" %}}

