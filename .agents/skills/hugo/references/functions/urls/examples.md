## Examples

The following examples show the rendered output for a page on the English version of the site:

```go-html-template
{{ relref . "/books/book-1" }} → /en/books/book-1/

{{ $opts := dict "path" "/books/book-1" }}
{{ relref . $opts }} → /en/books/book-1/

{{ $opts := dict "path" "/books/book-1" "lang" "de" }}
{{ relref . $opts }} → /de/books/book-1/

{{ $opts := dict "path" "/books/book-1" "lang" "de" "outputFormat" "json" }}
{{ relref . $opts }} → /de/books/book-1/index.json
```

