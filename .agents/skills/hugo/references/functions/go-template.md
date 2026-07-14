
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

## Understanding context

See the [context][] section in the introduction to templating.

For example, at the top of a _page_ template, the [context](g) (the dot) is a `Page` object. Within the `range` block, the context is bound to each successive element.

With this contrived example:

```go-html-template
{{ $s := slice "foo" "bar" "baz" }}
{{ range $s }}
  {{ .Title }}
{{ end }}
```

Hugo will throw an error:

```text
can't evaluate field Title in type int
```

The error occurs because we are trying to use the `.Title` method on a string instead of a `Page` object. Within the `range` block, if we want to render the page title, we need to get the context passed into the template.

> [!NOTE]
> Use the `$` to get the context passed into the template.

This template will render the page title three times:

```go-html-template
{{ $s := slice "foo" "bar" "baz" }}
{{ range $s }}
  {{ $.Title }}
{{ end }}
```

> [!NOTE]
> Gaining a thorough understanding of context is critical for anyone writing template code.

## Examples

### Slice of scalars

This template code:

```go-html-template
{{ $s := slice "foo" "bar" "baz" }}
{{ range $s }}
  <p>{{ . }}</p>
{{ end }}
```

Is rendered to:

```html
<p>foo</p>
<p>bar</p>
<p>baz</p>
```

This template code:

```go-html-template
{{ $s := slice "foo" "bar" "baz" }}
{{ range $v := $s }}
  <p>{{ $v }}</p>
{{ end }}
```

Is rendered to:

```html
<p>foo</p>
<p>bar</p>
<p>baz</p>
```

This template code:

```go-html-template
{{ $s := slice "foo" "bar" "baz" }}
{{ range $k, $v := $s }}
  <p>{{ $k }}: {{ $v }}</p>
{{ end }}
```

Is rendered to:

```html
<p>0: foo</p>
<p>1: bar</p>
<p>2: baz</p>
```

### Slice of maps

This template code:

```go-html-template
{{ $m := slice
  (dict "name" "John" "age" 30)
  (dict "name" "Will" "age" 28)
  (dict "name" "Joey" "age" 24)
}}
{{ range $m }}
  <p>{{ .name }} is {{ .age }}</p>
{{ end }}
```

Is rendered to:

```html
<p>John is 30</p>
<p>Will is 28</p>
<p>Joey is 24</p>
```

### Slice of pages

This template code:

```go-html-template
{{ range where site.RegularPages "Type" "articles" }}
  <h2><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></h2>
{{ end }}
```

Is rendered to:

```html
<h2><a href="/articles/article-3/">Article 3</a></h2>
<h2><a href="/articles/article-2/">Article 2</a></h2>
<h2><a href="/articles/article-1/">Article 1</a></h2>
```

### Maps

This template code:

```go-html-template
{{ $m :=  dict "name" "John" "age" 30 }}
{{ range $k, $v := $m }}
  <p>key = {{ $k }} value = {{ $v }}</p>
{{ end }}
```

Is rendered to:

```go-html-template
<p>key = age value = 30</p>
<p>key = name value = John</p>
```

Unlike ranging over an array or slice, Hugo sorts by key when ranging over a map.

### Integers

Ranging over a positive integer `n` executes the block `n` times, with the context starting at zero and incrementing by one in each iteration.

```go-html-template
{{ $s := slice }}
{{ range 1 }}
  {{ $s = $s | append . }}
{{ end }}
{{ $s }} → [0]
```

```go-html-template
{{ $s := slice }}
{{ range 3 }}
  {{ $s = $s | append . }}
{{ end }}
{{ $s }} → [0 1 2]
```

Ranging over a non-positive integer executes the block zero times.

{{% include "/_common/functions/go-template/text-template.md" %}}

[`break`]: /functions/go-template/break/
[`continue`]: /functions/go-template/continue/
[`else`]: /functions/go-template/else/
[context]: /templates/introduction/#context


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/go-template/return.md
---


The `return` statement is a non-standard extension to Go's [`text/template`][] package. Used within _partial_ templates, the `return` statement terminates template execution and returns the given value, if any.

The returned value may be of any data type including, but not limited to, [`bool`](g), [`float`](g), [`int`](g), [`map`](g), [`resource`](g), [`slice`](g), or [`string`](g).

A `return` statement without a value returns an empty string of type `template.HTML`.

> [!NOTE]
> Unlike `return` statements in other languages, Hugo executes the first occurrence of the `return` statement regardless of its position within logical blocks. See [usage](#usage) notes below.

## Example

By way of example, let's create a _partial_ template that _renders_ HTML, describing whether the given number is odd or even:

```go-html-template {file="layouts/_partials/odd-or-even.html"}
{{ if math.ModBool . 2 }}
  <p>{{ . }} is even</p>
{{ else }}
  <p>{{ . }} is odd</p>
{{ end }}
```

When called, the partial renders HTML:

```go-html-template
{{ partial "odd-or-even.html" 42 }} → <p>42 is even</p>
```

Instead of rendering HTML, let's create a partial that _returns_ a boolean value, reporting whether the given number is even:

```go-html-template {file="layouts/_partials/is-even.html"}
{{ return math.ModBool . 2 }}
```

With this template:

```go-html-template
{{ $number := 42 }}
{{ if partial "is-even.html" $number }}
  <p>{{ $number }} is even</p>
{{ else }}
  <p>{{ $number }} is odd</p>
{{ end }}
```

Hugo renders:

```html
<p>42 is even</p>
```

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

## Methods

Use these methods on the `TryValue` object.

`Err`
: (`string`) Returns a string representation of the error thrown by the expression, if an error occurred, or returns `nil` if the expression evaluated without errors.

`Value`
: (`any`) Returns the result of the expression if the evaluation was successful, or returns `nil` if an error occurred while evaluating the expression.

## Explanation

By way of example, let's divide a number by zero:

```go-html-template
{{ $x := 1 }}
{{ $y := 0 }}
{{ $result := div $x $y }}
{{ printf "%v divided by %v equals %v" $x $y .Value }}
```

As expected, the example above throws an error and fails the build:

```terminfo
Error: error calling div: can't divide the value by 0
```

Instead of failing the build, we can catch the error and emit a warning:

```go-html-template
{{ $x := 1 }}
{{ $y := 0 }}
{{ with try (div $x $y) }}
  {{ with .Err }}
    {{ warnf "%s" . }}
  {{ else }}
    {{ printf "%v divided by %v equals %v" $x $y .Value }}
  {{ end }}
{{ end }}
```

The error thrown by the expression is logged to the console as a warning:

```terminfo
WARN error calling div: can't divide the value by 0
```

Now let's change the arguments to avoid dividing by zero:

```go-html-template
{{ $x := 42 }}
{{ $y := 6 }}
{{ with try (div $x $y) }}
  {{ with .Err }}
    {{ warnf "%s" . }}
  {{ else }}
    {{ printf "%v divided by %v equals %v" $x $y .Value }}
  {{ end }}
{{ end }}
```

Hugo renders the above to:

```html
42 divided by 6 equals 7
```

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

## Understanding context

See the [context][] section in the introduction to templating.

For example, at the top of a _page_ template, the [context](g) (the dot) is a `Page` object. Inside of the `with` block, the context is bound to the value passed to the `with` statement.

With this contrived example:

```go-html-template
{{ with 42 }}
  {{ .Title }}
{{ end }}
```

Hugo will throw an error:

    can't evaluate field Title in type int

The error occurs because we are trying to use the `.Title` method on an integer instead of a `Page` object. Inside of the `with` block, if we want to render the page title, we need to get the context passed into the template.

> [!NOTE]
> Use the `$` to get the context passed into the template.

This template will render the page title as desired:

```go-html-template
{{ with 42 }}
  {{ $.Title }}
{{ end }}
```

> [!NOTE]
> Gaining a thorough understanding of context is critical for anyone writing template code.

{{% include "/_common/functions/go-template/text-template.md" %}}

[`else`]: /functions/go-template/else/
[context]: /templates/introduction/#context

