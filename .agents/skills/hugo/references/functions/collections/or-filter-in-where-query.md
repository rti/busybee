## OR filter in where query

This is also useful as `OR` filters when combined with where:

```go-html-template
{{ $pages := where .Site.RegularPages "Type" "not in" (slice "page" "about") }}
{{ $pages = $pages | union (where .Site.RegularPages "Params.pinned" true) }}
{{ $pages = $pages | intersect (where .Site.RegularPages "Params.images" "!=" nil) }}
```

The above fetches regular pages not of `page` or `about` type unless they are pinned. And finally, we exclude all pages with no `images` set in Page parameters.

See [intersect][] for `AND`.

[intersect]: /functions/collections/intersect/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/collections/Uniq.md
---


```go-html-template
{{ slice 1 3 2 1 | uniq }} → [1 3 2]
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/collections/Where.md
---


The `where` function returns the given slice, removing elements that do not satisfy the comparison condition. The comparison condition is composed of the `KEY`, `OPERATOR`, and `VALUE` arguments:

```text
collections.Where SLICE KEY [OPERATOR] VALUE
                        --------------------
                        comparison condition
```

Hugo will test for equality if you do not provide an `OPERATOR` argument. For example:

```go-html-template
{{ $pages := where .Site.RegularPages "Section" "books" }}
{{ $books := where hugo.Data.books "genres" "suspense" }}
```

