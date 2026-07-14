## Usage

> [!NOTE]
> Unlike `return` statements in other languages, Hugo executes the first occurrence of the `return` statement regardless of its position within logical blocks.

A partial that returns a value must contain only one `return` statement, placed at the end of the template.

For example:

```go-html-template {file="layouts/_partials/is-even.html"}
{{ $result := false }}
{{ if math.ModBool . 2 }}
  {{ $result = "even" }}
{{ else }}
  {{ $result = "odd" }}
{{ end }}
{{ return $result }}
```

> [!NOTE]
> The construct below is incorrect; it contains more than one `return` statement.

```go-html-template {file="layouts/_partials/do-not-do-this.html"}
{{ if math.ModBool . 2 }}
  {{ return "even" }}
{{ else }}
  {{ return "odd" }}
{{ end }}
```

[`text/template`]: https://pkg.go.dev/text/template


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/go-template/template.md
---


Use the `template` function to execute a defined template:

```go-html-template
{{ template "foo" (dict "answer" 42) }}

{{ define "foo" }}
  {{ printf "The answer is %v." .answer }}
{{ end }}
```

The example above can be rewritten using an inline _partial_ template:

```go-html-template
{{ partial "inline/foo.html" (dict "answer" 42) }}

{{ define "_partials/inline/foo.html" }}
  {{ printf "The answer is %v." .answer }}
{{ end }}
```

The key distinctions between the preceding two examples are:

1. Inline partials are globally scoped. That means that an inline partial defined in _one_ template may be called from _any_ template.
1. Leveraging the [`partialCached`][] function when calling an inline partial allows for performance optimization through result caching.
1. An inline partial can [`return`][] a value of any data type instead of rendering a string.

{{% include "/_common/functions/go-template/text-template.md" %}}

[`partialCached`]: /functions/partials/includecached/
[`return`]: /functions/go-template/return/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/go-template/try.md
---


{{< new-in 0.141.0 />}}

The `try` statement is a non-standard extension to Go's [`text/template`][] package. It introduces a mechanism for handling errors within templates, mimicking the `try-catch` constructs found in other programming languages.

