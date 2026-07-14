
---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/shortcode/Get.md
---


Specify the argument by position or by name. When calling a shortcode within Markdown, use either positional or named argument, but not both.

> [!NOTE]
> Some shortcodes support positional arguments, some support named arguments, and others support both. Refer to the shortcode's documentation for usage details.

## Positional arguments

This shortcode call uses positional arguments:

```md {file="content/about.md"}
{{</* myshortcode "Hello" "world" */>}}
```

To retrieve arguments by position:

```go-html-template {file="layouts/_shortcodes/myshortcode.html"}
{{ printf "%s %s." (.Get 0) (.Get 1) }} → Hello world.
```

## Named arguments

This shortcode call uses named arguments:

```md {file="content/about.md"}
{{</* myshortcode greeting="Hello" firstName="world" */>}}
```

To retrieve arguments by name:

```go-html-template {file="layouts/_shortcodes/myshortcode.html"}
{{ printf "%s %s." (.Get "greeting") (.Get "firstName") }} → Hello world.
```

> [!NOTE]
> Argument names are case-sensitive.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/shortcode/Inner.md
---


This content:

```md {file="content/services.md"}
{{</* card title="Product Design" */>}}
We design the **best** widgets in the world.
{{</* /card */>}}
```

With this shortcode:

```go-html-template {file="layouts/_shortcodes/card.html"}
<div class="card">
  {{ with .Get "title" }}
    <div class="card-title">{{ . }}</div>
  {{ end }}
  <div class="card-content">
    {{ .Inner | strings.TrimSpace }}
  </div>
</div>
```

Is rendered to:

```html
<div class="card">
  <div class="card-title">Product Design</div>
  <div class="card-content">
    We design the **best** widgets in the world.
  </div>
</div>
```

> [!NOTE]
> Content between opening and closing shortcode tags may include leading and/or trailing newlines, depending on placement within the Markdown. Use the [`strings.TrimSpace`][] function as shown above to remove carriage returns and newlines.

> [!NOTE]
> In the example above, the value returned by `Inner` is Markdown, but it was rendered as plain text. Use either of the following approaches to render Markdown to HTML.

## Use RenderString

Let's modify the example above to pass the value returned by `Inner` through the [`RenderString`][] method on the `Page` object:

```go-html-template {file="layouts/_shortcodes/card.html"}
<div class="card">
  {{ with .Get "title" }}
    <div class="card-title">{{ . }}</div>
  {{ end }}
  <div class="card-content">
    {{ .Inner | strings.TrimSpace | .Page.RenderString }}
  </div>
</div>
```

Hugo renders this to:

```html
<div class="card">
  <div class="card-title">Product design</div>
  <div class="card-content">
    We produce the <strong>best</strong> widgets in the world.
  </div>
</div>
```

You can use the [`markdownify`][] function instead of the `RenderString` method, but the latter is more flexible. See [details][].

## Alternative notation

Instead of calling the shortcode with the `{{</* */>}}` notation, use the `{{%/* */%}}` notation:

```md {file="content/services.md"}
{{%/* card title="Product Design" */%}}
We design the **best** widgets in the world.
{{%/* /card */%}}
```

When you use the `{{%/* */%}}` notation, Hugo renders the entire shortcode as Markdown, requiring the following changes.

First, configure the renderer to allow raw HTML within Markdown:

{{< code-toggle file=hugo >}}
[markup.goldmark.renderer]
unsafe = true
{{< /code-toggle >}}

This configuration is not unsafe if _you_ control the content. Read more about Hugo's [security model][].

Second, because we are rendering the entire shortcode as Markdown, we must adhere to the rules governing [indentation][] and inclusion of [raw HTML blocks][] as provided in the [CommonMark][] specification.

```go-html-template {file="layouts/_shortcodes/card.html"}
<div class="card">
  {{ with .Get "title" }}
  <div class="card-title">{{ . }}</div>
  {{ end }}
  <div class="card-content">

  {{ .Inner | strings.TrimSpace }}
  </div>
</div>
```

The difference between this and the previous example is subtle but required. Note the change in indentation, the addition of a blank line, and removal of the `RenderString` method.

```diff
--- layouts/_shortcodes/a.html
+++ layouts/_shortcodes/b.html
@@ -1,8 +1,9 @@
 <div class="card">
   {{ with .Get "title" }}
-    <div class="card-title">{{ . }}</div>
+  <div class="card-title">{{ . }}</div>
   {{ end }}
   <div class="card-content">
-    {{ .Inner | strings.TrimSpace | .Page.RenderString }}
+
+  {{ .Inner | strings.TrimSpace }}
   </div>
 </div>
```

> [!NOTE]
> Don't process the `Inner` value with `RenderString` or `markdownify` when using [Markdown notation][] to call the shortcode.

[CommonMark]: https://spec.commonmark.org/current/
[Markdown notation]: /content-management/shortcodes/#notation
[`RenderString`]: /methods/page/renderstring/
[`markdownify`]: /functions/transform/markdownify/
[`strings.TrimSpace`]: /functions/strings/trimspace/
[details]: /methods/page/renderstring/
[indentation]: https://spec.commonmark.org/current/#indented-code-blocks
[raw HTML blocks]: https://spec.commonmark.org/current/#html-blocks
[security model]: /about/security/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/shortcode/InnerDeindent.md
---


Similar to the [`Inner`][] method, `InnerDeindent` returns the content between opening and closing shortcode tags. However, with `InnerDeindent`, indentation before the content is removed.

This allows us to effectively bypass the rules governing indentation as provided in the [CommonMark][] specification.

Consider this Markdown, an unordered list with a small gallery of thumbnail images within each list item:

```md {file="content/about.md"}
- Gallery one

    {{</* gallery */>}}
    ![kitten a](thumbnails/a.jpg)
    ![kitten b](thumbnails/b.jpg)
    {{</* /gallery */>}}

- Gallery two

    {{</* gallery */>}}
    ![kitten c](thumbnails/c.jpg)
    ![kitten d](thumbnails/d.jpg)
    {{</* /gallery */>}}
```

In the example above, notice that the content between the opening and closing shortcode tags is indented by four spaces. Per the CommonMark specification, this is treated as an indented code block.

With this shortcode, calling `Inner` instead of `InnerDeindent`:

```go-html-template {file="layouts/_shortcodes/gallery.html"}
<div class="gallery">
  {{ .Inner | strings.TrimSpace | .Page.RenderString }}
</div>
```

Hugo renders the Markdown to:

```html
<ul>
  <li>
    <p>Gallery one</p>
    <div class="gallery">
      <pre><code>![kitten a](images/a.jpg)
      ![kitten b](images/b.jpg)
      </code></pre>
    </div>
  </li>
  <li>
    <p>Gallery two</p>
    <div class="gallery">
      <pre><code>![kitten c](images/c.jpg)
      ![kitten d](images/d.jpg)
      </code></pre>
    </div>
  </li>
</ul>
```

Although technically correct per the CommonMark specification, this is not what we want. If we remove the indentation using the `InnerDeindent` method:

```go-html-template {file="layouts/_shortcodes/gallery.html"}
<div class="gallery">
  {{ .InnerDeindent | strings.TrimSpace | .Page.RenderString }}
</div>
```

Hugo renders the Markdown to:

```html
<ul>
  <li>
    <p>Gallery one</p>
    <div class="gallery">
      <img src="images/a.jpg" alt="kitten a">
      <img src="images/b.jpg" alt="kitten b">
    </div>
  </li>
  <li>
    <p>Gallery two</p>
    <div class="gallery">
      <img src="images/c.jpg" alt="kitten c">
      <img src="images/d.jpg" alt="kitten d">
    </div>
  </li>
</ul>
```

[CommonMark]: https://spec.commonmark.org/current/#indented-code-blocks
[`Inner`]: /methods/shortcode/inner/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/shortcode/IsNamedParams.md
---


To support both positional and named arguments when calling a shortcode, use the `IsNamedParams` method to determine how the shortcode was called.

With this _shortcode_ template:

```go-html-template {file="layouts/_shortcodes/myshortcode.html"}
{{ if .IsNamedParams }}
  {{ printf "%s %s." (.Get "greeting") (.Get "firstName") }}
{{ else }}
  {{ printf "%s %s." (.Get 0) (.Get 1) }}
{{ end }}
```

Both of these calls return the same value:

```md {file="content/about.md"}
{{</* myshortcode greeting="Hello" firstName="world" */>}}
{{</* myshortcode "Hello" "world" */>}}
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/shortcode/Name.md
---


The `Name` method is useful for error reporting. For example, if your shortcode requires a "greeting" argument:

```go-html-template {file="layouts/_shortcodes/myshortcode.html"}
{{ $greeting := "" }}
{{ with .Get "greeting" }}
  {{ $greeting = . }}
{{ else }}
  {{ errorf "The %q shortcode requires a 'greeting' argument. See %s" .Name .Position }}
{{ end }}
```

In the absence of a "greeting" argument, Hugo will throw an error message and fail the build:

```text
ERROR The "myshortcode" shortcode requires a 'greeting' argument. See "/home/user/project/content/about.md:11:1"
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/shortcode/Ordinal.md
---


The `Ordinal` method returns the zero-based ordinal of the shortcode in relation to its parent. If the parent is the page itself, the ordinal represents the position of this shortcode in the page content.

> [!NOTE]
> Hugo increments the ordinal with each shortcode call, regardless of the specific shortcode type. This means that the ordinal value is tracked sequentially across all shortcodes within a given page.

This method is useful for, among other things, assigning unique element IDs when a shortcode is called two or more times from the same page. For example:

```md {file="content/about.md"}
{{</* img src="images/a.jpg" */>}}

{{</* img src="images/b.jpg" */>}}
```

This shortcode performs error checking, then renders an HTML `img` element with a unique `id` attribute:

```go-html-template {file="layouts/_shortcodes/img.html"}
{{ $src := "" }}
{{ with .Get "src" }}
  {{ $src = . }}
  {{ with resources.Get $src }}
    {{ $id := printf "img-%03d" $.Ordinal }}
    <img id="{{ $id }}" src="{{ .RelPermalink }}" width="{{ .Width }}" height="{{ .Height }}" alt="">
  {{ else }}
    {{ errorf "The %q shortcode was unable to find %s. See %s" $.Name $src $.Position }}
  {{ end }}
{{ else }}
  {{ errorf "The %q shortcode requires a 'src' argument. See %s" .Name .Position }}
{{ end }}
```

Hugo renders the page to:

```html
<img id="img-000" src="/images/a.jpg" width="600" height="400" alt="">
<img id="img-001" src="/images/b.jpg" width="600" height="400" alt="">
```

> [!NOTE]
> In the _shortcode_ template above, the [`with`][] statement is used to create conditional blocks. Remember that the `with` statement binds context (the dot) to its expression. Inside of a `with` block, preface shortcode method calls with a `$` to access the top-level context passed into the template.

[`with`]: /functions/go-template/with/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/shortcode/Page.md
---


With this content:

{{< code-toggle file=content/books/les-miserables.md fm=true >}}
title = 'Les Misérables'
author = 'Victor Hugo'
publication_year = 1862
isbn = '978-0451419439'
{{< /code-toggle >}}

Calling this shortcode:

```md
{{</* book-details */>}}
```

We can access the front matter values using the `Page` method:

```go-html-template {file="layouts/_shortcodes/book-details.html"}
<ul>
  <li>Title: {{ .Page.Title }}</li>
  <li>Author: {{ .Page.Params.author }}</li>
  <li>Published: {{ .Page.Params.publication_year }}</li>
  <li>ISBN: {{ .Page.Params.isbn }}</li>
</ul>
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/shortcode/Params.md
---


When you call a shortcode using positional arguments, the `Params` method returns a slice.

```md {file="content/about.md"}
{{</* myshortcode "Hello" "world" */>}}
```

```go-html-template {file="layouts/_shortcodes/myshortcode.html"}
{{ index .Params 0 }} → Hello
{{ index .Params 1 }} → world
```

When you call a shortcode using named arguments, the `Params` method returns a map.

```md {file="content/about.md"}
{{</* myshortcode greeting="Hello" name="world" */>}}
```

```go-html-template {file="layouts/_shortcodes/myshortcode.html"}
{{ .Params.greeting }} → Hello
{{ .Params.name }} → world
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/shortcode/Parent.md
---


This is useful for inheritance of common shortcode arguments from the root.

In this contrived example, the "greeting" shortcode is the parent, and the "now" shortcode is child.

```md {file="content/welcome.md"}
{{</* greeting dateFormat="Jan 2, 2006" */>}}
Welcome. Today is {{</* now */>}}.
{{</* /greeting */>}}
```

```go-html-template {file="layouts/_shortcodes/greeting.html"}
<div class="greeting">
  {{ .Inner | strings.TrimSpace | .Page.RenderString }}
</div>
```

```go-html-template {file="layouts/_shortcodes/now.html"}
{{- $dateFormat := "January 2, 2006 15:04:05" }}

{{- with .Params }}
  {{- with .dateFormat }}
    {{- $dateFormat = . }}
  {{- end }}
{{- else }}
  {{- with .Parent.Params }}
    {{- with .dateFormat }}
      {{- $dateFormat = . }}
    {{- end }}
  {{- end }}
{{- end }}

{{- now | time.Format $dateFormat -}}
```

The "now" shortcode formats the current time using:

1. The `dateFormat` argument passed to the "now" shortcode, if present
1. The `dateFormat` argument passed to the "greeting" shortcode, if present
1. The default layout string defined at the top of the shortcode


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/shortcode/Position.md
---


The `Position` method is useful for error reporting. For example, if your shortcode requires a "greeting" argument:

```go-html-template {file="layouts/_shortcodes/myshortcode.html"}
{{ $greeting := "" }}
{{ with .Get "greeting" }}
  {{ $greeting = . }}
{{ else }}
  {{ errorf "The %q shortcode requires a 'greeting' argument. See %s" .Name .Position }}
{{ end }}
```

In the absence of a "greeting" argument, Hugo will throw an error message and fail the build:

```text
ERROR The "myshortcode" shortcode requires a 'greeting' argument. See "/home/user/project/content/about.md:11:1"
```

> [!NOTE]
> The position can be expensive to calculate. Limit its use to error reporting.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/shortcode/Ref.md
---


## Usage

The `Ref` method requires a single argument: an options map.

## Options

{{% include "_common/ref-and-relref-options.md" %}}

## Examples

The following examples show the rendered output for a page on the English version of the site:

```go-html-template
{{ $opts := dict "path" "/books/book-1" }}
{{ .Ref $opts }} → https://example.org/en/books/book-1/

{{ $opts := dict "path" "/books/book-1" "lang" "de" }}
{{ .Ref $opts }} → https://example.org/de/books/book-1/

{{ $opts := dict "path" "/books/book-1" "lang" "de" "outputFormat" "json" }}
{{ .Ref $opts }} → https://example.org/de/books/book-1/index.json
```

## Error handling

{{% include "_common/ref-and-relref-error-handling.md" %}}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/shortcode/RelRef.md
---


## Usage

The `RelRef` method requires a single argument: an options map.

## Options

{{% include "_common/ref-and-relref-options.md" %}}

## Examples

The following examples show the rendered output for a page on the English version of the site:

```go-html-template
{{ $opts := dict "path" "/books/book-1" }}
{{ .RelRef $opts }} → /en/books/book-1/

{{ $opts := dict "path" "/books/book-1" "lang" "de" }}
{{ .RelRef $opts }} → /de/books/book-1/

{{ $opts := dict "path" "/books/book-1" "lang" "de" "outputFormat" "json" }}
{{ .RelRef $opts }} → /de/books/book-1/index.json
```

## Error handling

{{% include "_common/ref-and-relref-error-handling.md" %}}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/shortcode/Scratch.md
---


{{< deprecated-in 0.139.0 >}}
Use the [`SHORTCODE.Store`](/methods/shortcode/store/) method instead.

This is a soft deprecation. This method will be removed in a future release, but the removal date has not been established. Although Hugo will not emit a warning if you continue to use this method, you should begin using `SHORTCODE.Store` as soon as possible.

Beginning with v0.139.0 the `SHORTCODE.Scratch` method is aliased to `SHORTCODE.Store`.
{{< /deprecated-in >}}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/shortcode/Site.md
---


See [Site methods][].

```go-html-template
{{ .Site.Title }}
```

[Site methods]: /methods/site/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/shortcode/Store.md
---


{{< new-in 0.139.0 />}}

Use the `Store` method to create a persistent data structure for storing and manipulating keyed values, scoped to the current shortcode. To create a data structure with a different [scope](g), refer to the [scope](#scope) section below.

> [!NOTE]
> With the introduction of the [`newScratch`][] function, and the ability to [assign values to template variables][] after initialization, the `Store` method within a shortcode is mostly obsolete.

{{% include "_common/store-methods.md" %}}

{{% include "_common/store-scope.md" %}}

[`newScratch`]: /functions/collections/newScratch/
[assign values to template variables]: https://go.dev/doc/go1.11#texttemplatepkgtexttemplate

