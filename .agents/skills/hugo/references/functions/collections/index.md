# collections


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/collections/After.md
---


The following shows `after` being used in conjunction with the [`slice`][] function:

```go-html-template
{{ $data := slice "one" "two" "three" "four" }}
<ul>
  {{ range after 2 $data }}
    <li>{{ . }}</li>
  {{ end }}
</ul>
```

The template above is rendered to:

```html
<ul>
  <li>three</li>
  <li>four</li>
</ul>
```


## Sections

- [`example-of-after-with-first-2ndndash4th-most-recent-articles`](references/functions/collections/example-of-after-with-first-2ndndash4th-most-recent-articles.md) — Example Of `after` With `first`: 2nd&ndash;4th Most Recent Articles
- [`return-values`](references/functions/collections/return-values.md) — Return Values
- [`examples`](references/functions/collections/examples.md) — Examples
- [`seed-value`](references/functions/collections/seed-value.md) — Seed Value
- [`methods`](references/functions/collections/methods.md) — Methods
- [`sort-a-slice`](references/functions/collections/sort-a-slice.md) — Sort A Slice
- [`sort-a-map`](references/functions/collections/sort-a-map.md) — Sort A Map
- [`sort-a-page-collection`](references/functions/collections/sort-a-page-collection.md) — Sort A Page Collection
- [`or-filter-in-where-query`](references/functions/collections/or-filter-in-where-query.md) — OR Filter In Where Query
- [`arguments`](references/functions/collections/arguments.md) — Arguments
- [`operators`](references/functions/collections/operators.md) — Operators
- [`string-comparison`](references/functions/collections/string-comparison.md) — String Comparison
- [`numeric-comparison`](references/functions/collections/numeric-comparison.md) — Numeric Comparison
- [`boolean-comparison`](references/functions/collections/boolean-comparison.md) — Boolean Comparison
- [`member-comparison`](references/functions/collections/member-comparison.md) — Member Comparison
- [`intersection-comparison`](references/functions/collections/intersection-comparison.md) — Intersection Comparison
- [`regular-expression-comparison`](references/functions/collections/regular-expression-comparison.md) — Regular Expression Comparison
- [`date-comparison`](references/functions/collections/date-comparison.md) — Date Comparison
- [`nil-comparison`](references/functions/collections/nil-comparison.md) — Nil Comparison
- [`nested-comparison`](references/functions/collections/nested-comparison.md) — Nested Comparison
- [`portable-section-comparison`](references/functions/collections/portable-section-comparison.md) — Portable Section Comparison
- [`booleanundefined-comparison`](references/functions/collections/booleanundefined-comparison.md) — Boolean/undefined Comparison

