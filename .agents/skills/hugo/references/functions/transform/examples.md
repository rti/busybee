## Examples

```go-html-template
{{ $result := transform.HighlightCodeBlock . }}
{{ $result.Wrapped }}
```

To override the default options:

```go-html-template
{{ $opts := merge .Options (dict "lineNos" true) }}
{{ $result := transform.HighlightCodeBlock . $opts }}
{{ $result.Wrapped }}
```

To fall back to plain text when the language is not supported by the highlighter:

```go-html-template
{{ $opts := dict }}
{{ if not (transform.CanHighlight .Type) }}
  {{ $opts = dict "type" "text" }}
{{ end }}
{{ $result := transform.HighlightCodeBlock . $opts }}
{{ $result.Wrapped }}
```

