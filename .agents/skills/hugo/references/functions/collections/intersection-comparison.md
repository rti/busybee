## Intersection comparison

Compare a `slice` to a `slice`, returning elements with common values. This is frequently used when comparing taxonomy terms.

For example, to return a slice of pages where any of the terms in the `genres` taxonomy are "suspense" or "romance":

```go-html-template
{{ $books := where site.RegularPages "Section" "eq" "books" }}

{{ $genres := slice "suspense" "romance" }}
{{ $pages := where $books "Params.genres" "intersect" $genres }}
```

