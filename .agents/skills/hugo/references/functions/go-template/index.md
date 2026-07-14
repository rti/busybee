# go-template


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/go-template/and.md
---


{{% include "/_common/functions/truthy-falsy.md" %}}

The `and` function evaluates the arguments from left to right, and returns when the result is determined.

```go-html-template
{{ and 1 0 "" }} → 0 (int)
{{ and 1 false 0 }} → false (bool)

{{ and 1 2 3 }} → 3 (int)
{{ and "a" "b" "c" }} → c (string)
{{ and "a" 1 true }} → true (bool)

{{ and false (math.Div 1 0) }} → false (bool)
```

{{% include "/_common/functions/go-template/text-template.md" %}}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/go-template/block.md
---


A block is shorthand for defining a template:

```go-html-template
{{ define "name" }} T1 {{ end }}
```

and then executing it in place:

```go-html-template
{{ template "name" pipeline }}
```

The typical use is to define a set of root templates that are then customized by redefining the block templates within.

```go-html-template {file="layouts/baseof.html"}
<body>
  <main>
    {{ block "main" . }}
      {{ print "default value if 'main' template is empty" }}
    {{ end }}
  </main>
</body>
```

```go-html-template {file="layouts/page.html"}
{{ define "main" }}
  <h1>{{ .Title }}</h1>
  {{ .Content }}
{{ end }}
```

```go-html-template {file="layouts/section.html"}
{{ define "main" }}
  <h1>{{ .Title }}</h1>
  {{ .Content }}
  {{ range .Pages }}
    <h2><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></h2>
  {{ end }}
{{ end }}
```

{{% include "/_common/functions/go-template/text-template.md" %}}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/go-template/break.md
---


This template code:

```go-html-template
{{ $s := slice "foo" "bar" "baz" }}
{{ range $s }}
  {{ if eq . "bar" }}
    {{ break }}
  {{ end }}
  <p>{{ . }}</p>
{{ end }}
```

Is rendered to:

```html
<p>foo</p>
```

{{% include "/_common/functions/go-template/text-template.md" %}}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/go-template/continue.md
---


This template code:

```go-html-template
{{ $s := slice "foo" "bar" "baz" }}
{{ range $s }}
  {{ if eq . "bar" }}
    {{ continue }}
  {{ end }}
  <p>{{ . }}</p>
{{ end }}
```

Is rendered to:

```html
<p>foo</p>
<p>baz</p>
```

{{% include "/_common/functions/go-template/text-template.md" %}}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/go-template/define.md
---


Use with the [`block`][] statement:

```go-html-template
{{ block "main" . }}
  {{ print "default value if 'main' template is empty" }}
{{ end }}

{{ define "main" }}
  <h1>{{ .Title }}</h1>
  {{ .Content }}
{{ end }}
```

Use with the [`partial`][] function:

```go-html-template
{{ partial "inline/foo.html" (dict "answer" 42) }}

{{ define "_partials/inline/foo.html" }}
  {{ printf "The answer is %v." .answer }}
{{ end }}
```

Use with the [`template`][] function:

```go-html-template
{{ template "foo" (dict "answer" 42) }}

{{ define "foo" }}
  {{ printf "The answer is %v." .answer }}
{{ end }}
```

{{% include "/_common/functions/go-template/text-template.md" %}}

[`block`]: /functions/go-template/block/
[`partial`]: /functions/partials/include/
[`template`]: /functions/go-template/block/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/go-template/else.md
---


Use with the [`if`][] statement:

```go-html-template
{{ $var := "foo" }}
{{ if $var }}
  {{ $var }} → foo
{{ else }}
  {{ print "var is falsy" }}
{{ end }}
```

Use with the [`with`][] statement:

```go-html-template
{{ $var := "foo" }}
{{ with $var }}
  {{ . }} → foo
{{ else }}
  {{ print "var is falsy" }}
{{ end }}
```

Use with the [`range`][] statement:

```go-html-template
{{ $var := slice 1 2 3 }}
{{ range $var }}
  {{ . }} → 1 2 3
{{ else }}
  {{ print "var is falsy" }}
{{ end }}
```

Use `else if` to check multiple conditions.

```go-html-template
{{ $var := 12 }}
{{ if eq $var 6 }}
  {{ print "var is 6" }}
{{ else if eq $var 7 }}
  {{ print "var is 7" }}
{{ else if eq $var 42 }}
  {{ print "var is 42" }}
{{ else }}
  {{ print "var is something else" }}
{{ end }}
```

{{% include "/_common/functions/go-template/text-template.md" %}}

[`if`]: /functions/go-template/if/
[`range`]: /functions/go-template/range/
[`with`]: /functions/go-template/with/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/go-template/end.md
---


Use with the [`if`][] statement:

```go-html-template
{{ $var := "foo" }}
{{ if $var }}
  {{ $var }} → foo
{{ end }}
```

Use with the [`with`][] statement:

```go-html-template
{{ $var := "foo" }}
{{ with $var }}
  {{ . }} → foo
{{ end }}
```

Use with the [`range`][] statement:

```go-html-template
{{ $var := slice 1 2 3 }}
{{ range $var }}
  {{ . }} → 1 2 3
{{ end }}
```

Use with the [`block`][] statement:

```go-html-template
{{ block "main" . }}{{ end }}
```

Use with the [`define`][] statement:

```go-html-template
{{ define "main" }}
  {{ print "this is the main section" }}
{{ end }}
```

{{% include "/_common/functions/go-template/text-template.md" %}}

[`block`]: /functions/go-template/block/
[`define`]: /functions/go-template/define/
[`if`]: /functions/go-template/if/
[`range`]: /functions/go-template/range/
[`with`]: /functions/go-template/with/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/go-template/if.md
---


{{% include "/_common/functions/truthy-falsy.md" %}}

```go-html-template
{{ $var := "foo" }}
{{ if $var }}
  {{ $var }} → foo
{{ end }}
```

Use with the [`else`][] statement:

```go-html-template
{{ $var := "foo" }}
{{ if $var }}
  {{ $var }} → foo
{{ else }}
  {{ print "var is falsy" }}
{{ end }}
```

Use `else if` to check multiple conditions:

```go-html-template
{{ $var := 12 }}
{{ if eq $var 6 }}
  {{ print "var is 6" }}
{{ else if eq $var 7 }}
  {{ print "var is 7" }}
{{ else if eq $var 42 }}
  {{ print "var is 42" }}
{{ else }}
  {{ print "var is something else" }}
{{ end }}
```

{{% include "/_common/functions/go-template/text-template.md" %}}

[`else`]: /functions/go-template/else/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/go-template/len.md
---


With a string:

```go-html-template
{{ "ab" | len }} → 2
{{ "" | len }} → 0
```

With a slice:

```go-html-template
{{ slice "a" "b" | len }} → 2
{{ slice | len }} → 0
```

With a map:

```go-html-template
{{ dict "a" 1 "b" 2  | len }} → 2
{{ dict | len }} → 0
```

With a collection:

```go-html-template
{{ site.RegularPages | len }} → 42
```

You may also determine the number of pages in a collection with:

```go-html-template
{{ site.RegularPages.Len }} → 42
```

{{% include "/_common/functions/go-template/text-template.md" %}}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/go-template/not.md
---


Unlike the `and` and `or` operators, the `not` operator always returns a boolean value.

```go-html-template
{{ not true }} → false
{{ not false }} → true

{{ not 1 }} → false
{{ not 0 }} → true

{{ not "x" }} → false
{{ not "" }} → true
```

Use the `not` operator, twice in succession, to cast any value to a boolean value. For example:

```go-html-template
{{ 42 | not | not }} → true
{{ "" | not | not }} → false
```

{{% include "/_common/functions/go-template/text-template.md" %}}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/go-template/or.md
---


{{% include "/_common/functions/truthy-falsy.md" %}}

The `or` function evaluates the arguments from left to right, and returns when the result is determined.

```go-html-template
{{ or 0 1 2 }} → 1 (int)
{{ or false "a" 1 }} → a (string)
{{ or 0 true "a" }} → true (bool)

{{ or false "" 0 }} → 0 (int)
{{ or 0 "" false }} → false (bool)

{{ or true (math.Div 1 0) }} → true (bool)
```

{{% include "/_common/functions/go-template/text-template.md" %}}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/go-template/range.md
---


The collection may be a slice, a map, or an integer.

```go-html-template
{{ $s := slice "foo" "bar" "baz" }}
{{ range $s }}
  {{ . }} → foo bar baz
{{ end }}
```

Use with the [`else`][] statement:

```go-html-template
{{ $s := slice "foo" "bar" "baz" }}
{{ range $s }}
  <p>{{ . }}</p>
{{ else }}
  <p>The collection is empty</p>
{{ end }}
```

Within a range block:

- Use the [`continue`][] statement to stop the innermost iteration and continue to the next iteration
- Use the [`break`][] statement to stop the innermost iteration and bypass all remaining iterations


## Sections

- [`understanding-context`](references/functions/go-template/understanding-context.md) — Understanding Context
- [`examples`](references/functions/go-template/examples.md) — Examples
- [`example`](references/functions/go-template/example.md) — Example
- [`usage`](references/functions/go-template/usage.md) — Usage
- [`methods`](references/functions/go-template/methods.md) — Methods
- [`explanation`](references/functions/go-template/explanation.md) — Explanation
- [`example`](references/functions/go-template/example.md) — Example
- [`understanding-context`](references/functions/go-template/understanding-context.md) — Understanding Context

