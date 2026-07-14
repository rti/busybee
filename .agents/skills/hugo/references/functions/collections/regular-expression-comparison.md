## Regular expression comparison

To return a slice of pages where the `author` page parameter begins with either "victor" or "Victor":

```go-html-template
{{ $pages := where .Site.RegularPages "Params.author" "like" `(?i)^victor` }}
```

{{% include "/_common/functions/regular-expressions.md" %}}

> [!NOTE]
> Use the `like` operator to compare string values. Comparing other data types will result in an empty slice.

