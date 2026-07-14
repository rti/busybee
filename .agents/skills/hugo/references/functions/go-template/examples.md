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

