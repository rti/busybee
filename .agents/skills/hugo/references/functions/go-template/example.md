## Example

Error handling is essential when using the [`resources.GetRemote`][] function to capture remote resources such as data or images. When calling this function, if the HTTP request fails, Hugo will fail the build.

Instead of failing the build, we can catch the error and emit a warning:

```go-html-template
{{ $url := "https://broken-example.org/images/a.jpg" }}
{{ with try (resources.GetRemote $url) }}
  {{ with .Err }}
    {{ warnf "%s" . }}
  {{ else with .Value }}
    <img src="{{ .RelPermalink }}" width="{{ .Width }}" height="{{ .Height }}" alt="">
  {{ else }}
    {{ warnf "Unable to get remote resource %q" $url }}
  {{ end }}
{{ end }}
```

In the above, note that the [context](g) within the last conditional block is the `TryValue` object returned by the `try` statement. At this point neither the `Err` nor `Value` methods returned anything, so the current context is not useful. Use the `$` to access the [template context][] if needed.

> [!NOTE]
> Hugo does not classify an HTTP response with status code 404 as an error. In this case `resources.GetRemote` returns nil.

[`resources.GetRemote`]: /functions/resources/getremote/
[`text/template`]: https://pkg.go.dev/text/template
[template context]: /templates/introduction/#template-context


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/go-template/urlquery.md
---


This template code:

```go-html-template
{{ $u := urlquery "https://" "example.com" | safeURL }}
<a href="https://example.org?url={{ $u }}">Link</a>
```

Is rendered to:

```html
<a href="https://example.org?url=https%3A%2F%2Fexample.com">Link</a>
```

{{% include "/_common/functions/go-template/text-template.md" %}}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/go-template/with.md
---


{{% include "/_common/functions/truthy-falsy.md" %}}

```go-html-template
{{ $var := "foo" }}
{{ with $var }}
  {{ . }} → foo
{{ end }}
```

Use with the [`else`][] statement:

```go-html-template
{{ $var := "foo" }}
{{ with $var }}
  {{ . }} → foo
{{ else }}
  {{ print "var is falsy" }}
{{ end }}
```

Use `else with` to check multiple conditions:

```go-html-template
{{ $v1 := 0 }}
{{ $v2 := 42 }}
{{ with $v1 }}
  {{ . }}
{{ else with $v2 }}
  {{ . }} → 42
{{ else }}
  {{ print "v1 and v2 are falsy" }}
{{ end }}
```

Initialize a variable, scoped to the current block:

```go-html-template
{{ with $var := 42 }}
  {{ . }} → 42
  {{ $var }} → 42
{{ end }}
{{ $var }} → undefined
```

