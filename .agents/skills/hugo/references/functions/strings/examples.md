## Examples

Observe that replacements are not applied recursively because the function scans the string only once.

```go-html-template
{{ $pairs := slice
  "a" "b"
  "b" "c"
}}
{{ "a" | strings.ReplacePairs $pairs }} → b
```

Apply the first match when multiple old strings could match at the same position.

```go-html-template
{{ $pairs := slice
  "app" "pear"
  "apple" "orange"
}}
{{ "apple" | strings.ReplacePairs $pairs }} → pearle
```

Delete specific strings by providing an empty string as the second value in a pair.

```go-html-template
{{ $pairs := slice "b" "" }}
{{ "abc" | strings.ReplacePairs $pairs }} → ac
```

