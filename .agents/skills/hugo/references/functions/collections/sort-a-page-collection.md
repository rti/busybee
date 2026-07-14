## Sort a page collection

> [!NOTE]
> Although you can use the `sort` function to sort a page collection, Hugo provides [sorting and grouping methods][] as well.

In this contrived example, sort the site's regular pages by `.Type` in descending order:

```go-html-template
{{ range sort site.RegularPages "Type" "desc" }}
  <h2><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></h2>
{{ end }}
```

[sorting and grouping methods]: /methods/pages/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/collections/SymDiff.md
---


Example:

```go-html-template
{{ slice 1 2 3 | symdiff (slice 3 4) }} → [1 2 4]
```

Also see <https://en.wikipedia.org/wiki/Symmetric_difference>.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/collections/Union.md
---




```go-html-template
{{ union (slice 1 2 3) (slice 3 4 5) }} → [1 2 3 4 5]
{{ union (slice 1 2 3) nil }}           → [1 2 3]
{{ union nil (slice 1 2 3) }}           → [1 2 3]
{{ union nil nil }}                     → []
```

