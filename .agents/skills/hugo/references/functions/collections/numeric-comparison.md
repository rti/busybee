## Numeric comparison

Compare the value of the given field to an [`int`](g) or [`float`](g):

```go-html-template
{{ $books := where site.RegularPages "Section" "eq" "books" }}

{{ $pages := where $books "Params.price" "eq" 42 }}
{{ $pages := where $books "Params.price" "ne" 42.67 }}
{{ $pages := where $books "Params.price" "ge" 42 }}
{{ $pages := where $books "Params.price" "gt" 42.67 }}
{{ $pages := where $books "Params.price" "le" 42 }}
{{ $pages := where $books "Params.price" "lt" 42.67 }}
```

