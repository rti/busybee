
---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/render-hooks/blockquotes.md
---


## Context

Blockquote _render hook_ templates receive the following [context](g):

`AlertType`
: (`string`) Applicable when [`Type`](#type) is `alert`, this is the alert type converted to lowercase. See the [alerts](#alerts) section below.

`AlertTitle`
: {{< new-in 0.134.0 />}}
: (`template.HTML`) Applicable when [`Type`](#type) is `alert`, this is the alert title. See the [alerts](#alerts) section below.

`AlertSign`
: {{< new-in 0.134.0 />}}
: (`string`) Applicable when [`Type`](#type) is `alert`, this is the alert sign. Typically used to indicate whether an alert is graphically foldable, this is one of&nbsp;`+`,&nbsp;`-`,&nbsp;or an empty string. See the [alerts](#alerts) section below.

`Attributes`
: (`map`) The [Markdown attributes][], available if you configure your site as follows:

  {{< code-toggle file=hugo >}}
  [markup.goldmark.parser.attribute]
  block = true
  {{< /code-toggle >}}

`Ordinal`
: (`int`) The zero-based ordinal of the blockquote on the page.

`Page`
: (`page`) A reference to the current page.

`PageInner`
: (`page`) A reference to a page nested via the [`RenderShortcodes`][] method. [See details](#pageinner-details).

`Position`
: (`string`) The position of the blockquote within the page content.

`Text`
: (`template.HTML`) The blockquote text, excluding the first line if [`Type`](#type) is `alert`. See the [alerts](#alerts) section below.

`Type`
: (`string`) The blockquote type. Returns `alert` if the blockquote has an alert designator, else `regular`. See the [alerts](#alerts) section below.

## Examples

In its default configuration, Hugo renders Markdown blockquotes according to the [CommonMark][] specification. To create a render hook that does the same thing:

```go-html-template {file="layouts/_markup/render-blockquote.html" copy=true}
<blockquote>
  {{ .Text }}
</blockquote>
```

To render a blockquote as an HTML `figure` element with an optional citation and caption:

```go-html-template {file="layouts/_markup/render-blockquote.html" copy=true}
<figure>
  <blockquote {{ with .Attributes.cite }}cite="{{ . }}"{{ end }}>
    {{ .Text }}
  </blockquote>
  {{ with .Attributes.caption }}
    <figcaption class="blockquote-caption">
      {{ . | safeHTML }}
    </figcaption>
  {{ end }}
</figure>
```

Then in your markdown:

```md
> Some text
{cite="https://gohugo.io" caption="Some caption"}
```

## Alerts

Also known as _callouts_ or _admonitions_, alerts are blockquotes used to emphasize critical information.

### Basic syntax

With the basic Markdown syntax, the first line of each alert is an alert designator consisting of an exclamation point followed by the alert type, wrapped within brackets. For example:

```md {file="content/example.md"}
> [!NOTE]
> Useful information that users should know, even when skimming content.

> [!TIP]
> Helpful advice for doing things better or more easily.

> [!IMPORTANT]
> Key information users need to know to achieve their goal.

> [!WARNING]
> Urgent info that needs immediate user attention to avoid problems.

> [!CAUTION]
> Advises about risks or negative outcomes of certain actions.
```

The basic syntax is compatible with [GitHub][], [Obsidian][], and [Typora][].

### Extended syntax

With the extended Markdown syntax, you may optionally include an alert sign and/or an alert title. The alert sign is one of&nbsp;`+`&nbsp;or&nbsp;`-`, typically used to indicate whether an alert is graphically foldable. For example:

```md {file="content/example.md"}
> [!WARNING]+ Radiation hazard
> Do not approach or handle without protective gear.
```

The extended syntax is compatible with [Obsidian][].

> [!NOTE]
> The extended syntax is not compatible with GitHub or Typora. If you include an alert sign or an alert title, these applications render the Markdown as a blockquote.

### Example

This blockquote render hook renders a multilingual alert if an alert designator is present, otherwise it renders a blockquote according to the CommonMark specification.

```go-html-template {file="layouts/_markup/render-blockquote.html" copy=true}
{{ $emojis := dict
  "caution" ":exclamation:"
  "important" ":information_source:"
  "note" ":information_source:"
  "tip" ":bulb:"
  "warning" ":information_source:"
}}

{{ if eq .Type "alert" }}
  <blockquote class="alert alert-{{ .AlertType }}">
    <p class="alert-heading">
      {{ transform.Emojify (index $emojis .AlertType) }}
      {{ with .AlertTitle }}
        {{ . }}
      {{ else }}
        {{ or (i18n .AlertType) (title .AlertType) }}
      {{ end }}
    </p>
    {{ .Text }}
  </blockquote>
{{ else }}
  <blockquote>
    {{ .Text }}
  </blockquote>
{{ end }}
```

To override the label, create these entries in your i18n files:

{{< code-toggle file=i18n/en.toml >}}
caution = 'Caution'
important = 'Important'
note = 'Note'
tip = 'Tip'
warning = 'Warning'
{{< /code-toggle >}}

Although you can use one template with conditional logic as shown above, you can also create separate templates for each [`Type`](#type) of blockquote:

```tree
layouts/
  └── _markup/
      ├── render-blockquote-alert.html
      └── render-blockquote-regular.html
```

{{% include "/_common/render-hooks/pageinner.md" %}}

[CommonMark]: https://spec.commonmark.org/current/
[GitHub]: https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax#alerts
[Markdown attributes]: /content-management/markdown-attributes/
[Obsidian]: https://help.obsidian.md/Editing+and+formatting/Callouts
[Typora]: https://support.typora.io/Markdown-Reference/#callouts--github-style-alerts
[`RenderShortcodes`]: /methods/page/rendershortcodes/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/render-hooks/code-blocks.md
---


## Markdown

This Markdown example contains a fenced code block:

````md {file="content/example.md"}
```sh {class="my-class" id="my-codeblock" lineNos=inline tabWidth=2}
declare a=1
echo "$a"
exit
```
````

A fenced code block consists of:

- A leading [code fence][]
- An optional [info string][]
- A code sample
- A trailing code fence

In the example above, the info string contains:

- The language of the code sample (the first word)
- An optional space-delimited or comma-delimited list of attributes (everything within braces)

The attributes in the info string can be generic attributes or highlighting options.

In the example above, the _generic attributes_ are `class` and `id`. In the absence of special handling within a code block render hook, Hugo adds each generic attribute to the HTML element surrounding the rendered code block. Consistent with its content security model, Hugo removes HTML event attributes such as `onclick` and `onmouseover`. Generic attributes are typically global HTML attributes, but you may include custom attributes as well.

In the example above, the _highlighting options_ are `lineNos` and `tabWidth`. Hugo renders the code sample using its built-in syntax highlighter. You can control the appearance of the rendered code by specifying one or more [highlighting options][].

> [!NOTE]
> Although `style` is a global HTML attribute, when used in an info string it is a highlighting option.

## Context

Code block _render hook_ templates receive the following [context](g):

`Attributes`
: (`map`) The generic attributes from the info string.

`Inner`
: (`string`) The content between the leading and trailing code fences, excluding the info string.

`Options`
: (`map`) The highlighting options from the info string.

`Ordinal`
: (`int`) The zero-based ordinal of the code block on the page.

`Page`
: (`page`) A reference to the current page.

`PageInner`
: (`page`) A reference to a page nested via the [`RenderShortcodes`][] method. [See details](#pageinner-details).

`Position`
: (`text.Position`) The position of the code block within the page content.

`Type`
: (`string`) The first word of the info string, typically the code language.

## Examples

By default, Hugo renders fenced code blocks using its built-in syntax highlighter and wraps the result. To create a render hook that does the same thing:

```go-html-template {file="layouts/_markup/render-codeblock.html" copy=true}
{{ $result := transform.HighlightCodeBlock . }}
{{ $result.Wrapped }}
```

To fall back to plain text when the language is not specified or not supported by the highlighter:

```go-html-template {file="layouts/_markup/render-codeblock.html" copy=true}
{{- $opts := dict }}
{{- if not (transform.CanHighlight .Type) }}
  {{- $opts = dict "type" "text" }}
{{- end }}
{{- $result := transform.HighlightCodeBlock . $opts }}
{{- $result.Wrapped }}
```

Although you can use one template with conditional logic to control the behavior on a per-language basis, you can also create language-specific templates.

```tree
layouts/
  └── _markup/
      ├── render-codeblock-mermaid.html
      ├── render-codeblock-python.html
      └── render-codeblock.html
```

For example, to create a code block render hook to render [Mermaid][] diagrams:

```go-html-template {file="layouts/_markup/render-codeblock-mermaid.html" copy=true}
<pre class="mermaid">
  {{ .Inner | htmlEscape | safeHTML }}
</pre>
{{ .Page.Store.Set "hasMermaid" true }}
```

Then include this snippet at the _bottom_ of your base template, before the closing `body` tag:

```go-html-template {file="layouts/baseof.html" copy=true}
{{ if .Store.Get "hasMermaid" }}
  <script type="module">
    import mermaid from 'https://cdn.jsdelivr.net/npm/mermaid/dist/mermaid.esm.min.mjs';
    mermaid.initialize({ startOnLoad: true });
  </script>
{{ end }}
```

See the [diagrams][] page for details.

## Embedded

Hugo includes an [embedded code block render hook][] to render [GoAT diagrams][].

{{% include "/_common/render-hooks/pageinner.md" %}}

[GoAT diagrams]: /content-management/diagrams/#goat-diagrams-ascii
[Mermaid]: https://mermaid.js.org/
[`RenderShortcodes`]: /methods/page/rendershortcodes/
[code fence]: https://spec.commonmark.org/current/#code-fence
[diagrams]: /content-management/diagrams/#mermaid-diagrams
[embedded code block render hook]: <{{% eturl render-codeblock-goat %}}>
[highlighting options]: /functions/transform/highlight/#options
[info string]: https://spec.commonmark.org/current/#info-string


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/render-hooks/headings.md
---


## Context

Heading _render hook_ templates receive the following [context](g):

`Anchor`
: (`string`) The `id` attribute of the heading element.

`Attributes`
: (`map`) The [Markdown attributes][], available if you configure your site as follows:

  {{< code-toggle file=hugo >}}
  [markup.goldmark.parser.attribute]
  title = true
  {{< /code-toggle >}}

`Level`
: (`int`) The heading level, 1 through 6.

`Ordinal`
: {{< new-in 0.160.0 />}}
: (`int`) The zero-based ordinal of the heading on the page.

`Page`
: (`page`) A reference to the current page.

`PageInner`
: (`page`) A reference to a page nested via the [`RenderShortcodes`][] method. [See details](#pageinner-details).

`PlainText`
: (`string`) The heading text as plain text.

`Position`
: {{< new-in 0.160.0 />}}
: (`string`) The position of the heading within the page content.

`Text`
: (`template.HTML`) The heading text.

## Examples

In its default configuration, Hugo renders Markdown headings according to the [CommonMark][] specification with the addition of automatic `id` attributes. To create a render hook that does the same thing:

```go-html-template {file="layouts/_markup/render-heading.html" copy=true}
<h{{ .Level }} id="{{ .Anchor }}" {{- with .Attributes.class }} class="{{ . }}" {{- end }}>
  {{- .Text -}}
</h{{ .Level }}>
```

To add an anchor link to the right of each heading:

```go-html-template {file="layouts/_markup/render-heading.html" copy=true}
<h{{ .Level }} id="{{ .Anchor }}" {{- with .Attributes.class }} class="{{ . }}" {{- end }}>
  {{ .Text }}
  <a href="#{{ .Anchor }}">#</a>
</h{{ .Level }}>
```

{{% include "/_common/render-hooks/pageinner.md" %}}

[CommonMark]: https://spec.commonmark.org/current/
[Markdown attributes]: /content-management/markdown-attributes/
[`RenderShortcodes`]: /methods/page/rendershortcodes/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/render-hooks/images.md
---


## Markdown

A Markdown image has three components: the image description, the image destination, and optionally the image title.

```text
![white kitten](/images/kitten.jpg "A kitten!")
  ------------  ------------------  ---------
  description      destination        title
```

These components are passed into the render hook [context](g) as shown below.

## Context

Image _render hook_ templates receive the following context:

`Attributes`
: (`map`) The [Markdown attributes][], available if you configure your site as follows:

  {{< code-toggle file=hugo >}}
  [markup.goldmark.parser]
  wrapStandAloneImageWithinParagraph = false
  [markup.goldmark.parser.attribute]
  block = true
  {{< /code-toggle >}}

`Destination`
: (`string`) The image destination.

`IsBlock`
: (`bool`) Reports whether a standalone image is not wrapped within a paragraph element.

`Ordinal`
: {{< new-in v0.160.0 />}}
: (`int`) The zero-based ordinal of the image on the page.

`Page`
: (`page`) A reference to the current page.

`PageInner`
: (`page`) A reference to a page nested via the [`RenderShortcodes`][] method. [See details](#pageinner-details).

`PlainText`
: (`string`) The image description as plain text.

`Position`
: {{< new-in 0.160.0 />}}
: (`string`) The position of the image within the page content.

`Text`
: (`template.HTML`) The image description.

`Title`
: (`string`) The image title.

## Examples

> [!NOTE]
> With inline elements such as images and links, remove leading and trailing whitespace using the `{{‑ ‑}}` delimiter notation to prevent whitespace between adjacent inline elements and text.

In its default configuration, Hugo renders Markdown images according to the [CommonMark][] specification. To create a render hook that does the same thing:

```go-html-template {file="layouts/_markup/render-image.html" copy=true}
<img src="{{ .Destination | safeURL }}"
  {{- with .PlainText }} alt="{{ . }}"{{ end -}}
  {{- with .Title }} title="{{ . }}"{{ end -}}
>
{{- /* chomp trailing newline */ -}}
```

To render standalone images within `figure` elements:

```go-html-template {file="layouts/_markup/render-image.html" copy=true}
{{- if .IsBlock -}}
  <figure>
    <img src="{{ .Destination | safeURL }}"
      {{- with .PlainText }} alt="{{ . }}"{{ end -}}
    >
    {{- with .Title }}<figcaption>{{ . }}</figcaption>{{ end -}}
  </figure>
{{- else -}}
  <img src="{{ .Destination | safeURL }}"
    {{- with .PlainText }} alt="{{ . }}"{{ end -}}
    {{- with .Title }} title="{{ . }}"{{ end -}}
  >
{{- end -}}
```

Note that the above requires the following project configuration:

{{< code-toggle file=hugo >}}
[markup.goldmark.parser]
wrapStandAloneImageWithinParagraph = false
{{< /code-toggle >}}

## Embedded

Hugo includes an [embedded image render hook][] to resolve Markdown image destinations. You can adjust its behavior in your project configuration. This is the default setting:

{{< code-toggle file=hugo >}}
[markup.goldmark.renderHooks.image]
useEmbedded = 'auto'
{{< /code-toggle >}}

When set to `auto` as shown above, Hugo automatically uses the embedded image render hook for multilingual single-host projects, specifically when the [duplication of shared page resources][] feature is disabled. This is the default behavior for such projects. If custom image render hooks are defined by your project, modules, or themes, these will be used instead.

You can also configure Hugo to `always` use the embedded image render hook, use it only as a `fallback`, or `never` use it. See [details][].

The embedded image render hook resolves internal Markdown destinations by looking for a matching [page resource](g), falling back to a matching [global resource](g). Remote destinations are passed through, and the render hook will not throw an error or warning if unable to resolve a destination.

You must place global resources in the `assets` directory. If you have placed your resources in the `static` directory, and you are unable or unwilling to move them, you must mount the `static` directory to the `assets` directory by including both of these entries in your project configuration:

{{< code-toggle file=hugo >}}
[[module.mounts]]
source = 'assets'
target = 'assets'

[[module.mounts]]
source = 'static'
target = 'assets'
{{< /code-toggle >}}

Note that the embedded image render hook does not perform image processing. Its sole purpose is to resolve Markdown image destinations.

{{% include "/_common/render-hooks/pageinner.md" %}}

[CommonMark]: https://spec.commonmark.org/current/
[Markdown attributes]: /content-management/markdown-attributes/
[`RenderShortcodes`]: /methods/page/rendershortcodes/
[details]: /configuration/markup/#renderhooksimageuseembedded
[duplication of shared page resources]: /configuration/markup/#duplicateresourcefiles
[embedded image render hook]: <{{% eturl render-image %}}>


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/render-hooks/introduction.md
---


When rendering Markdown to HTML, render hooks override the conversion. Each render hook is a template, with one template for each supported element type:

- [Blockquotes][]
- [Code blocks][]
- [Headings][]
- [Images][]
- [Links][]
- [Passthrough elements][]
- [Tables][]

> [!NOTE]
> Hugo supports multiple [content formats][] including Markdown, HTML, AsciiDoc, Emacs Org Mode, Pandoc, and reStructuredText.
>
> The render hook capability is limited to Markdown. You cannot create render hooks for the other content formats.

For example, consider this Markdown:

```md
[Hugo](https://gohugo.io)

![kitten](kitten.jpg)
```

Without link or image render hooks, the example above is rendered to:

```html
<p><a href="https://gohugo.io">Hugo</a></p>
<p><img alt="kitten" src="kitten.jpg"></p>
```

By creating link and image render hooks, you can alter the conversion from Markdown to HTML. For example:

```html
<p><a href="https://gohugo.io" rel="external">Hugo</a></p>
<p><img alt="kitten" src="kitten.jpg" width="600" height="400"></p>
```

Each render hook is a template, with one template for each supported element type:

```tree
layouts/
  └── _markup/
      ├── render-blockquote.html
      ├── render-codeblock.html
      ├── render-heading.html
      ├── render-image.html
      ├── render-link.html
      ├── render-passthrough.html
      └── render-table.html
```

The template lookup order allows you to create different render hooks for each page [type](g), [kind](g), language, and [output format](g). For example:

```tree
layouts/
├── _markup/
│   ├── render-link.html
│   └── render-link.rss.xml
├── books/
│   └── _markup/
│       ├── render-link.html
│       └── render-link.rss.xml
└── films/
    └── _markup/
        ├── render-link.html
        └── render-link.rss.xml
```

The remaining pages in this section describe each type of render hook, including examples and the context received by each template.

[Blockquotes]: /render-hooks/blockquotes/
[Code blocks]: /render-hooks/code-blocks/
[Headings]: /render-hooks/headings/
[Images]: /render-hooks/images/
[Links]: /render-hooks/links/
[Passthrough elements]: /render-hooks/passthrough/
[Tables]: /render-hooks/tables/
[content formats]: /content-management/formats/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/render-hooks/links.md
---


## Markdown

A Markdown link has three components: the link text, the link destination, and optionally the link title.

```text
[Post 1](/posts/post-1 "My first post")
 ------  -------------  -------------
  text    destination       title
```

These components are passed into the render hook [context](g) as shown below.

## Context

Link _render hook_ templates receive the following context:

`Destination`
: (`string`) The link destination.

`Ordinal`
: {{< new-in v0.160.0 />}}
: (`int`) The zero-based ordinal of the link on the page.

`Page`
: (`page`) A reference to the current page.

`PageInner`
: (`page`) A reference to a page nested via the [`RenderShortcodes`][] method. [See details](#pageinner-details).

`PlainText`
: (`string`) The link description as plain text.

`Position`
: {{< new-in 0.160.0 />}}
: (`string`) The position of the link within the page content.

`Text`
: (`template.HTML`) The link description.

`Title`
: (`string`) The link title.

## Examples

> [!NOTE]
> With inline elements such as images and links, remove leading and trailing whitespace using the `{{‑ ‑}}` delimiter notation to prevent whitespace between adjacent inline elements and text.

In its default configuration, Hugo renders Markdown links according to the [CommonMark][] specification. To create a render hook that does the same thing:

```go-html-template {file="layouts/_markup/render-link.html" copy=true}
<a href="{{ .Destination | safeURL }}"
  {{- with .Title }} title="{{ . }}"{{ end -}}
>
  {{- with .Text }}{{ . }}{{ end -}}
</a>
{{- /* chomp trailing newline */ -}}
```

To include a `rel` attribute set to `external` for external links:

```go-html-template {file="layouts/_markup/render-link.html" copy=true}
{{- $u := urls.Parse .Destination -}}
<a href="{{ .Destination | safeURL }}"
  {{- with .Title }} title="{{ . }}"{{ end -}}
  {{- if $u.IsAbs }} rel="external"{{ end -}}
>
  {{- with .Text }}{{ . }}{{ end -}}
</a>
{{- /* chomp trailing newline */ -}}
```

## Embedded

Hugo includes an [embedded link render hook][] to resolve Markdown link destinations. You can adjust its behavior in your project configuration. This is the default setting:

{{< code-toggle file=hugo >}}
[markup.goldmark.renderHooks.link]
useEmbedded = 'auto'
{{< /code-toggle >}}

When set to `auto` as shown above, Hugo automatically uses the embedded link render hook for multilingual single-host projects, specifically when the [duplication of shared page resources][] feature is disabled. This is the default behavior for such projects. If custom link render hooks are defined by your project, modules, or themes, these will be used instead.

You can also configure Hugo to `always` use the embedded link render hook, use it only as a `fallback`, or `never` use it. See [details][].

The embedded link render hook resolves internal Markdown destinations by looking for a matching page, falling back to a matching [page resource](g), then falling back to a matching [global resource](g). Remote destinations are passed through, and the render hook will not throw an error or warning if unable to resolve a destination.

You must place global resources in the `assets` directory. If you have placed your resources in the `static` directory, and you are unable or unwilling to move them, you must mount the `static` directory to the `assets` directory by including both of these entries in your project configuration:

{{< code-toggle file=hugo >}}
[[module.mounts]]
source = 'assets'
target = 'assets'

[[module.mounts]]
source = 'static'
target = 'assets'
{{< /code-toggle >}}

{{% include "/_common/render-hooks/pageinner.md" %}}

[CommonMark]: https://spec.commonmark.org/current/
[`RenderShortcodes`]: /methods/page/rendershortcodes/
[details]: /configuration/markup/#renderhookslinkuseembedded
[duplication of shared page resources]: /configuration/markup/#duplicateresourcefiles
[embedded link render hook]: <{{% eturl render-link %}}>


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/render-hooks/passthrough.md
---


## Overview

Hugo uses [Goldmark][] to render Markdown to HTML. Goldmark supports custom extensions to extend its core functionality. The [Passthrough][] extension captures and preserves raw Markdown within delimited snippets of text, including the delimiters themselves. These are known as _passthrough elements_.

Depending on your choice of delimiters, Hugo will classify a passthrough element as either _block_ or _inline_. Consider this contrived example:

```md {file="content/example.md"}
This is a

\[block\]

passthrough element with opening and closing block delimiters.

This is an \(inline\) passthrough element with opening and closing inline delimiters.
```

Update your project configuration to enable the Passthrough extension and define opening and closing delimiters for each passthrough element type, either `block` or `inline`. For example:

{{< code-toggle file=hugo >}}
[markup.goldmark.extensions.passthrough]
enable = true
[markup.goldmark.extensions.passthrough.delimiters]
block = [['\[', '\]'], ['$$', '$$']]
inline = [['\(', '\)']]
{{< /code-toggle >}}

In the example above there are two sets of `block` delimiters. You may use either one in your Markdown.

The Passthrough extension is often used in conjunction with the MathJax or KaTeX display engine to render [mathematical expressions][] written in the LaTeX markup language.

To enable custom rendering of passthrough elements, create a passthrough render hook.

## Context

Passthrough _render hook_ templates receive the following [context](g):

`Attributes`
: (`map`) The [Markdown attributes][], available if you configure your site as follows:

  {{< code-toggle file=hugo >}}
  [markup.goldmark.parser.attribute]
  block = true
  {{< /code-toggle >}}

  Hugo populates the `Attributes` map for _block_ passthrough elements. Markdown attributes are not applicable to _inline_ elements.

`Inner`
: (`string`) The inner content of the passthrough element, excluding the delimiters.

`Ordinal`
: (`int`) The zero-based ordinal of the passthrough element on the page.

`Page`
: (`page`) A reference to the current page.

`PageInner`
: (`page`) A reference to a page nested via the [`RenderShortcodes`][] method. [See details](#pageinner-details).

`Position`
: (`string`) The position of the passthrough element within the page content.

`Type`
: (`string`) The passthrough element type, either `block` or `inline`.

## Example

Instead of client-side JavaScript rendering of mathematical markup using MathJax or KaTeX, create a passthrough render hook which calls the [`transform.ToMath`][] function.

```go-html-template {file="layouts/_markup/render-passthrough.html" copy=true}
{{- $opts := dict "output" "htmlAndMathml" "displayMode" (eq .Type "block") }}
{{- with try (transform.ToMath .Inner $opts) }}
  {{- with .Err }}
    {{- errorf "Unable to render mathematical markup to HTML using the transform.ToMath function. The KaTeX display engine threw the following error: %s: see %s." . $.Position }}
  {{- else }}
    {{- .Value }}
    {{- $.Page.Store.Set "hasMath" true }}
  {{- end }}
{{- end -}}
```

Then, in your base template, conditionally include the KaTeX CSS within the head element:

```go-html-template {file="layouts/baseof.html" copy=true}
<head>
  {{ $noop := .WordCount }}
  {{ if .Page.Store.Get "hasMath" }}
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/katex@0.17.0/dist/katex.min.css" integrity="sha384-vlBdW0r3AcZO/HboRPznQNowvexd3fY8qHOWkBi5q7KGgqJ+F48+DceybYmrVbmB" crossorigin="anonymous">
  {{ end }}
</head>
```

In the above, note the use of a [noop](g) statement to force content rendering before we check the value of `hasMath` with the `Store.Get` method.

Although you can use one template with conditional logic as shown above, you can also create separate templates for each [`Type`](#type) of passthrough element:

```tree
layouts/
  └── _markup/
      ├── render-passthrough-block.html
      └── render-passthrough-inline.html
```

{{% include "/_common/render-hooks/pageinner.md" %}}

[Goldmark]: https://github.com/yuin/goldmark
[Markdown attributes]: /content-management/markdown-attributes/
[Passthrough]: /configuration/markup/#passthrough
[`RenderShortcodes`]: /methods/page/rendershortcodes/
[`transform.ToMath`]: /functions/transform/tomath/
[mathematical expressions]: /content-management/mathematics/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/render-hooks/tables.md
---


{{< new-in 0.134.0 />}}

## Context

Table _render hook_ templates receive the following [context](g):

`Attributes`
: (`map`) The [Markdown attributes][], available if you configure your site as follows:

  {{< code-toggle file=hugo >}}
  [markup.goldmark.parser.attribute]
  block = true
  {{< /code-toggle >}}

`Ordinal`
: (`int`) The zero-based ordinal of the table on the page.

`Page`
: (`page`) A reference to the current page.

`PageInner`
: (`page`) A reference to a page nested via the [`RenderShortcodes`][] method. [See details](#pageinner-details).

`Position`
: (`string`) The position of the table within the page content.

`THead`
: (`slice`) A slice of table header rows, where each element is a slice of table cells.

`TBody`
: (`slice`) A slice of table body rows, where each element is a slice of table cells.

## Table cells

Each table cell within the slice of slices returned by the `THead` and `TBody` methods has the following fields:

`Alignment`
: (`string`) The alignment of the text within the table cell, one of `left`, `center`, or `right`.

`Text`
: (`template.HTML`) The text within the table cell.

## Example

In its default configuration, Hugo renders Markdown tables according to the [GitHub Flavored Markdown specification][]. To create a render hook that does the same thing:

```go-html-template {file="layouts/_markup/render-table.html" copy=true}
<table
  {{- range $k, $v := .Attributes }}
    {{- if $v }}
      {{- printf " %s=%q" $k $v | safeHTMLAttr }}
    {{- end }}
  {{- end }}>
  <thead>
    {{- range .THead }}
      <tr>
        {{- range . }}
          <th
            {{- with .Alignment }}
              {{- printf " style=%q" (printf "text-align: %s" .) | safeHTMLAttr }}
            {{- end -}}
          >
            {{- .Text -}}
          </th>
        {{- end }}
      </tr>
    {{- end }}
  </thead>
  <tbody>
    {{- range .TBody }}
      <tr>
        {{- range . }}
          <td
            {{- with .Alignment }}
              {{- printf " style=%q" (printf "text-align: %s" .) | safeHTMLAttr }}
            {{- end -}}
          >
            {{- .Text -}}
          </td>
        {{- end }}
      </tr>
    {{- end }}
  </tbody>
</table>
```

{{% include "/_common/render-hooks/pageinner.md" %}}

[GitHub Flavored Markdown specification]: https://github.github.com/gfm/#tables-extension-
[Markdown attributes]: /content-management/markdown-attributes/
[`RenderShortcodes`]: /methods/page/rendershortcodes/

