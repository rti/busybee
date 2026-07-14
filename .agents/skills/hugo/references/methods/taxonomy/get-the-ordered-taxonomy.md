## Get the ordered taxonomy

Now that we have captured the “genres” Taxonomy object, let's get the ordered taxonomy sorted by the number of pages associated with each term:

```go-html-template
{{ $taxonomyObject.ByCount }}
```

To reverse the sort order:

```go-html-template
{{ $taxonomyObject.ByCount.Reverse }}
```

To inspect the data structure:

```go-html-template
<pre>{{ debug.Dump $taxonomyObject.ByCount }}</pre>
```

{{% include "/_common/methods/taxonomy/ordered-taxonomy-element-methods.md" %}}

