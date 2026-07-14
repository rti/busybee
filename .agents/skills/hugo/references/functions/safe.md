
---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/safe/CSS.md
---


## Introduction

{{% include "/_common/functions/go-html-template-package.md" %}}

## Usage

Use the `safe.CSS` function to encapsulate known safe content that matches any of:

1. The CSS3 stylesheet production, such as `p { color: purple }`.
1. The CSS3 rule production, such as `a[href=~"https:"].foo#bar`.
1. CSS3 declaration productions, such as `color: red; margin: 2px`.
1. The CSS3 value production, such as `rgba(0, 0, 255, 127)`.

Use of this type presents a security risk: the encapsulated content should come from a trusted source, as it will be included verbatim in the template output.

See the [Go documentation][] for details.

## Example

Without a safe declaration:

```go-html-template
{{ $style := "color: red;" }}
<p style="{{ $style }}">foo</p>
```

Hugo renders the above to:

```html
<p style="ZgotmplZ">foo</p>
```

> [!NOTE]
> `ZgotmplZ` is a special value that indicates that unsafe content reached a CSS or URL context at runtime.

To declare the string as safe:

```go-html-template
{{ $style := "color: red;" }}
<p style="{{ $style | safeCSS }}">foo</p>
```

Hugo renders the above to:

```html
<p style="color: red;">foo</p>
```

[Go documentation]: https://pkg.go.dev/html/template#CSS


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/safe/HTML.md
---


## Introduction

{{% include "/_common/functions/go-html-template-package.md" %}}

## Usage

Use the `safe.HTML` function to encapsulate a known safe HTML document fragment. It should not be used for HTML from a third-party, or HTML with unclosed tags or comments.

Use of this type presents a security risk: the encapsulated content should come from a trusted source, as it will be included verbatim in the template output.

See the [Go documentation][] for details.

## Example

Without a safe declaration:

```go-html-template
{{ $html := "<em>emphasized</em>" }}
{{ $html }}
```

Hugo renders the above to:

```html
&lt;em&gt;emphasized&lt;/em&gt;
```

To declare the string as safe:

```go-html-template
{{ $html := "<em>emphasized</em>" }}
{{ $html | safeHTML }}
```

Hugo renders the above to:

```html
<em>emphasized</em>
```

[Go documentation]: https://pkg.go.dev/html/template#HTML


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/safe/HTMLAttr.md
---


## Introduction

{{% include "/_common/functions/go-html-template-package.md" %}}

## Usage

Use the `safe.HTMLAttr` function to encapsulate an HTML attribute from a trusted source.

Use of this type presents a security risk: the encapsulated content should come from a trusted source, as it will be included verbatim in the template output.

See the [Go documentation][] for details.

## Example

Without a safe declaration:

```go-html-template
{{ with .Date }}
  {{ $humanDate := time.Format "2 Jan 2006" . }}
  {{ $machineDate := time.Format "2006-01-02T15:04:05-07:00" . }}
  <time datetime="{{ $machineDate }}">{{ $humanDate }}</time>
{{ end }}
```

Hugo renders the above to:

```html
<time datetime="2024-05-26T07:19:55&#43;02:00">26 May 2024</time>
```

To declare the key-value pair as safe:

```go-html-template
{{ with .Date }}
  {{ $humanDate := time.Format "2 Jan 2006" . }}
  {{ $machineDate := time.Format "2006-01-02T15:04:05-07:00" . }}
  <time {{ printf "datetime=%q" $machineDate | safeHTMLAttr }}>{{ $humanDate }}</time>
{{ end }}
```

Hugo renders the above to:

```html
<time datetime="2024-05-26T07:19:55+02:00">26 May 2024</time>
```

[Go documentation]: https://pkg.go.dev/html/template#HTMLAttr


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/safe/JS.md
---


## Introduction

{{% include "/_common/functions/go-html-template-package.md" %}}

## Usage

Use the `safe.JS` function to encapsulate a known safe EcmaScript5 Expression.

Template authors are responsible for ensuring that typed expressions do not break the intended precedence and that there is no statement/expression ambiguity as when passing an expression like `{ foo: bar() }\n['foo']()`, which is both a valid Expression and a valid Program with an entirely different meaning.

Use of this type presents a security risk: the encapsulated content should come from a trusted source, as it will be included verbatim in the template output.

Using the `safe.JS` function to include valid but untrusted JSON is not safe. A safe alternative is to parse the JSON with the [`transform.Unmarshal`][] function and then pass the resultant object into the template, where it will be converted to sanitized JSON when presented in a JavaScript context.

See the [Go documentation][] for details.

## Example

Without a safe declaration:

```go-html-template
{{ $js := "x + y" }}
<script>const a = {{ $js }}</script>
```

Hugo renders the above to:

```html
<script>const a = "x + y"</script>
```

To declare the string as safe:

```go-html-template
{{ $js := "x + y" }}
<script>const a = {{ $js | safeJS }}</script>
```

Hugo renders the above to:

```html
<script>const a = x + y</script>
```

[Go documentation]: https://pkg.go.dev/html/template#JS
[`transform.Unmarshal`]: /functions/transform/unmarshal/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/safe/JSStr.md
---


## Introduction

{{% include "/_common/functions/go-html-template-package.md" %}}

## Usage

Use the `safe.JSStr` function to encapsulate a sequence of characters meant to be embedded between quotes in a JavaScript expression.

Use of this type presents a security risk: the encapsulated content should come from a trusted source, as it will be included verbatim in the template output.

See the [Go documentation][] for details.

## Example

Without a safe declaration:

```go-html-template
{{ $title := "Lilo & Stitch" }}
<script>
  const a = "Title: " + {{ $title }};
</script>
```

Hugo renders the above to:

```html
<script>
  const a = "Title: " + "Lilo \u0026 Stitch";
</script>
```

To declare the string as safe:

```go-html-template
{{ $title := "Lilo & Stitch" }}
<script>
  const a = "Title: " + {{ $title | safeJSStr }};
</script>
```

Hugo renders the above to:

```html
<script>
  const a = "Title: " + "Lilo & Stitch";
</script>
```

[Go documentation]: https://pkg.go.dev/html/template#JSStr


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/safe/URL.md
---


## Introduction

{{% include "/_common/functions/go-html-template-package.md" %}}

## Usage

Use the `safe.URL` function to encapsulate a known safe URL or URL substring. Schemes other than the following are considered unsafe:

- `http:`
- `https:`
- `mailto:`

Use of this type presents a security risk: the encapsulated content should come from a trusted source, as it will be included verbatim in the template output.

See the [Go documentation][] for details.

## Example

Without a safe declaration:

```go-html-template
{{ $href := "irc://irc.freenode.net/#golang" }}
<a href="{{ $href }}">IRC</a>
```

Hugo renders the above to:

```html
<a href="#ZgotmplZ">IRC</a>
```

> [!NOTE]
> `ZgotmplZ` is a special value that indicates that unsafe content reached a CSS or URL context at runtime.

To declare the string as safe:

```go-html-template
{{ $href := "irc://irc.freenode.net/#golang" }}
<a href="{{ $href | safeURL }}">IRC</a>
```

Hugo renders the above to:

```html
<a href="irc://irc.freenode.net/#golang">IRC</a>
```

[Go documentation]: https://pkg.go.dev/html/template#URL

