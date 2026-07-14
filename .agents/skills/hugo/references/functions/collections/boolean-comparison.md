## Boolean comparison

Compare the value of the given field to a [`bool`](g):

```go-html-template
{{ $books := where site.RegularPages "Section" "eq" "books" }}

{{ $pages := where $books "Params.fiction" "eq" true }}
{{ $pages := where $books "Params.fiction" "eq" false }}
{{ $pages := where $books "Params.fiction" "ne" true }}
{{ $pages := where $books "Params.fiction" "ne" false }}
```

