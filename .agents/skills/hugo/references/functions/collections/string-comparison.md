## String comparison

Compare the value of the given field to a [`string`](g):

```go-html-template
{{ $pages := where .Site.RegularPages "Section" "eq" "books" }}
{{ $pages := where .Site.RegularPages "Section" "ne" "books" }}
```

