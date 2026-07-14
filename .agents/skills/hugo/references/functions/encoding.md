
---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/encoding/Base64Decode.md
---


```go-html-template
{{ "SHVnbw==" | base64Decode }} → Hugo
```

Use the `base64Decode` function to decode responses from APIs. For example, the result of this call to GitHub's API contains the base64-encoded representation of the repository's README file:

```text
https://api.github.com/repos/gohugoio/hugo/readme
```

To retrieve and render the content:

```go-html-template
{{ $url := "https://api.github.com/repos/gohugoio/hugo/readme" }}
{{ with try (resources.GetRemote $url) }}
  {{ with .Err }}
    {{ errorf "%s" . }}
  {{ else with .Value }}
    {{ with . | transform.Unmarshal }}
      {{ .content | base64Decode | markdownify }}
    {{ end }}
  {{ else }}
    {{ errorf "Unable to get remote resource %q" $url }}
  {{ end }}
{{ end }}
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/encoding/Base64Encode.md
---


```go-html-template
{{ "Hugo" | base64Encode }} → SHVnbw==
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/encoding/HexDecode.md
---


```go-html-template
{{ "48656c6c6f20776f726c64" | encoding.HexDecode }} → Hello world
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/encoding/HexEncode.md
---


```go-html-template
{{ "Hello world" | encoding.HexEncode }} → 48656c6c6f20776f726c64
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/encoding/Jsonify.md
---


To customize the printing of the JSON, pass an options map as the first
argument. Supported options are "prefix" and "indent". Each JSON element in
the output will begin on a new line beginning with _prefix_ followed by one or
more copies of _indent_ according to the indentation nesting.

```go-html-template
{{ dict "title" .Title "content" .Plain | jsonify }}
{{ dict "title" .Title "content" .Plain | jsonify (dict "indent" "  ") }}
{{ dict "title" .Title "content" .Plain | jsonify (dict "prefix" " " "indent" "  ") }}
```

## Options

The `encoding.Jsonify` function accepts an options map.

`indent`
: (`string`) Indentation to use. Default is "".

`prefix`
: (`string`) Indentation prefix. Default is "".

`noHTMLEscape`
: (`bool`) Whether to disable escaping of problematic HTML characters inside JSON quoted strings. The default behavior is to escape `&`, `<`, and `>` to `\u0026`, `\u003c`, and `\u003e` to avoid certain safety problems that can arise when embedding JSON in HTML. Default is `false`.

