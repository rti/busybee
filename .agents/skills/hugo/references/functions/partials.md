
---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/partials/Include.md
---


Without a [`return`][] statement, the `partial` function returns a string of type `template.HTML`. With a `return` statement, the `partial` function can return any data type.

In this example we have three _partial_ templates:

```tree
layouts/
└── _partials/
    ├── average.html
    ├── breadcrumbs.html
    └── footer.html
```

The "average" partial returns the average of one or more numbers. We pass the numbers in context:

```go-html-template
{{ $numbers := slice 1 6 7 42 }}
{{ $average := partial "average.html" $numbers }}
```

The "breadcrumbs" partial renders [breadcrumb navigation][], and needs to receive the current page in context:

```go-html-template
{{ partial "breadcrumbs.html" . }}
```

The "footer" partial renders the site footer. In this contrived example, the footer does not need access to the current page, so we can omit context:

```go-html-template
{{ partial "footer.html" }}
```

You can pass anything in context: a page, a page collection, a scalar value, a slice, or a map. In this example we pass the current page and three scalar values:

```go-html-template
{{ $ctx := dict
  "page" .
  "name" "John Doe"
  "major" "Finance"
  "gpa" 4.0
}}
{{ partial "render-student-info.html" $ctx }}
```

Then, within the _partial_ template:

```go-html-template
<p>{{ .name }} is majoring in {{ .major }}.</p>
<p>Their grade point average is {{ .gpa }}.</p>
<p>See <a href="{{ .page.RelPermalink }}">details.</a></p>
```

To return a value from a _partial_ template, it must contain only one `return` statement, placed at the end of the template:

```go-html-template
{{ $result := "" }}
{{ if math.ModBool . 2 }}
  {{ $result = "even" }}
{{ else }}
  {{ $result = "odd" }}
{{ end }}
{{ return $result }}
```

[`return`]: /functions/go-template/return/
[breadcrumb navigation]: /content-management/sections/#ancestors-and-descendants


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/partials/IncludeCached.md
---


Without a [`return`][] statement, the `partialCached` function returns a string of type `template.HTML`. With a `return` statement, the `partialCached` function can return any data type.

The `partialCached` function can offer significant performance gains for complex templates that don't need to be re-rendered on every invocation.

> [!NOTE]
> Each site (or language) has its own `partialCached` cache, so each site will execute a partial once.
>
> Hugo renders pages in parallel, and will render the partial more than once with concurrent calls to the `partialCached` function. After Hugo caches the rendered partial, new pages entering the build pipeline will use the cached result.

Here is the simplest usage:

```go-html-template
{{ partialCached "footer.html" . }}
```

Pass additional arguments to `partialCached` to create variants of the cached partial. For example, if you have a complex partial that should be identical when rendered for pages within the same section, use a variant based on section so that the partial is only rendered once per section:

```go-html-template {file="layouts/baseof.html"}
{{ partialCached "footer.html" . .Section }}
```

Pass additional arguments, of any data type, as needed to create unique variants:

```go-html-template
{{ partialCached "footer.html" . .Params.country .Params.province }}
```

The variant arguments are not available to the underlying _partial_ template; they are only used to create unique cache keys.

To return a value from a _partial_ template, it must contain only one `return` statement, placed at the end of the template:

```go-html-template
{{ $result := "" }}
{{ if math.ModBool . 2 }}
  {{ $result = "even" }}
{{ else }}
  {{ $result = "odd" }}
{{ end }}
{{ return $result }}
```

[`return`]: /functions/go-template/return/

