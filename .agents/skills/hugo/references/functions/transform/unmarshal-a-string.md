## Unmarshal a string

```go-html-template
{{ $string := `
title: Les Misérables
author: Victor Hugo
`}}

{{ $book := transform.Unmarshal $string }}
{{ $book.title }} → Les Misérables
{{ $book.author }} → Victor Hugo
```

