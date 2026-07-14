## Nested comparison

These are equivalent:

```go-html-template
{{ $pages := where .Site.RegularPages "Type" "tutorials" }}
{{ $pages = where $pages "Params.level" "eq" "beginner" }}
```

```go-html-template
{{ $pages := where (where .Site.RegularPages "Type" "tutorials") "Params.level" "eq" "beginner" }}
```

