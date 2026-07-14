
---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/transform/CanHighlight.md
---


```go-html-template
{{ transform.CanHighlight "go" }} → true
{{ transform.CanHighlight "klingon" }} → false
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/transform/Emojify.md
---


`emojify` runs a passed string through the Emoji emoticons processor.

See the list of [emoji shortcodes][] for available emoticons.

The `emojify` function can be called in your templates but not directly in your content files by default. For emojis in content files, set [`enableEmoji`][] to `true` in your project configuration. Then you can write emoji shorthand directly into your content files;

```md
I :heart: Hugo!
```

I :heart: Hugo!

[`enableEmoji`]: /configuration/all/#enableemoji
[emoji shortcodes]: /quick-reference/emojis/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/transform/HTMLEscape.md
---


The `transform.HTMLEscape` function escapes five special characters by replacing them with [HTML entities][]:

- `&` → `&amp;`
- `<` → `&lt;`
- `>` → `&gt;`
- `'` → `&#39;`
- `"` → `&#34;`

For example:

```go-html-template
{{ htmlEscape "Lilo & Stitch" }} → Lilo &amp; Stitch
{{ htmlEscape "7 > 6" }} → 7 &gt; 6
```

[HTML entities]: https://developer.mozilla.org/en-US/docs/Glossary/Entity


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/transform/HTMLUnescape.md
---


The `transform.HTMLUnescape` function replaces [HTML entities][] with their corresponding characters.

```go-html-template
{{ htmlUnescape "Lilo &amp; Stitch" }} → Lilo & Stitch
{{ htmlUnescape "7 &gt; 6" }} → 7 > 6
```

In most contexts Go's [`html/template`][] package will escape special characters. To bypass this behavior, pass the unescaped string through the [`safe.HTML`][] function.

```go-html-template
{{ htmlUnescape "Lilo &amp; Stitch" | safeHTML }}
```

[HTML entities]: https://developer.mozilla.org/en-US/docs/Glossary/Entity
[`html/template`]: https://pkg.go.dev/html/template
[`safe.HTML`]: /functions/safe/html/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/transform/HTMLtoMarkdown.md
---


{{< new-in 0.151.0 />}}

> [!NOTE]
> This function is experimental and its API may change in the future.

The `transform.HTMLToMarkdown` function converts HTML to Markdown by utilizing the [`html-to-markdown`][] Go package.

## Usage

```go-html-template
{{ .Content | transform.HTMLToMarkdown | safeHTML }}
```

## Plugins

The conversion process is enabled by the following `html-to-markdown` plugins:

Plugin|Description
:--|:--
Base|Implements basic shared functionality
CommonMark|Implements Markdown according to the [Commonmark][] specification
Table|Implements tables according to the [GitHub Flavored Markdown][] specification

[Commonmark]: https://spec.commonmark.org/current/
[GitHub Flavored Markdown]: https://github.github.com/gfm/
[`html-to-markdown`]: https://github.com/JohannesKaufmann/html-to-markdown?tab=readme-ov-file#readme


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/transform/Highlight.md
---


The `transform.Highlight` function uses the [`alecthomas/chroma`][] package to generate syntax-highlighted HTML from the provided code, [language][], and [options](#options-1).

## Arguments

`CODE`
: (`string`) The code to highlight.

`LANG`
: (`string`) The [language][] of the code to highlight. This value is case-insensitive. Optional; you can also set the language with the `type` key in OPTIONS. {{< new-in 0.162.0 />}}

`OPTIONS`
: (`map or string`) A map or comma-separated key-value pairs wrapped in quotation marks. See the [options](#options-1) below; you can set default values for each option in your [project configuration][]. The key names are case-insensitive.

## Examples

```go-html-template
{{ $input := `fmt.Println("Hello World!")` }}
{{ transform.Highlight $input "go" }}

{{ $input := `console.log('Hello World!');` }}
{{ $lang := "js" }}
{{ transform.Highlight $input $lang "lineNos=table, style=api" }}

{{ $input := `echo "Hello World!"` }}
{{ $lang := "bash" }}
{{ $opts := dict "lineNos" "table" "style" "dracula" }}
{{ transform.Highlight $input $lang $opts }}

{{ $input := `print("Hello World!")` }}
{{ $opts := dict "type" "python" "style" "dracula" }}
{{ transform.Highlight $input $opts }}
```

## Options

The `transform.Highlight` function accepts an options map.

{{% include "_common/syntax-highlighting-options.md" %}}

`code`
: {{< new-in 0.162.0 />}}
: (`string`) Overrides the `CODE` argument.

`type`
: {{< new-in 0.162.0 />}}
: (`string`) Overrides the `LANG` argument.

[`alecthomas/chroma`]: https://github.com/alecthomas/chroma
[language]: /content-management/syntax-highlighting#languages
[project configuration]: /configuration/markup#highlight


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/transform/HighlightCodeBlock.md
---


The `transform.HighlightCodeBlock` function uses the [`alecthomas/chroma`][] package to generate syntax-highlighted HTML from code received in context within a code block render hook. This function is only useful within a code block render hook.

## Arguments

CONTEXT
: The [context][] passed into a code block render hook.

OPTIONS
: (`map`) A map of key-value pairs. See the [options](#options-1) below. The key names are case-insensitive.

## Return value

`transform.HighlightCodeBlock` returns a `HighlightResult` object with two methods.

`Wrapped`
: (`template.HTML`) Returns highlighted code wrapped in `<div>`, `<pre>`, and `<code>` elements. This is identical to the value returned by the `transform.Highlight` function.

`Inner`
: (`template.HTML`) Returns highlighted code without any wrapping elements, allowing you to create your own wrapper.

## Examples

```go-html-template
{{ $result := transform.HighlightCodeBlock . }}
{{ $result.Wrapped }}
```

To override the default options:

```go-html-template
{{ $opts := merge .Options (dict "lineNos" true) }}
{{ $result := transform.HighlightCodeBlock . $opts }}
{{ $result.Wrapped }}
```

To fall back to plain text when the language is not supported by the highlighter:

```go-html-template
{{ $opts := dict }}
{{ if not (transform.CanHighlight .Type) }}
  {{ $opts = dict "type" "text" }}
{{ end }}
{{ $result := transform.HighlightCodeBlock . $opts }}
{{ $result.Wrapped }}
```

## Options

The `transform.HighlightCodeBlock` function accepts an options map.

{{% include "_common/syntax-highlighting-options.md" %}}

`code`
: {{< new-in 0.162.0 />}}
: (`string`) Overrides the code received from the code block context.

`type`
: {{< new-in 0.162.0 />}}
: (`string`) Overrides the language received from the code block context.

[`alecthomas/chroma`]: https://github.com/alecthomas/chroma
[context]: /render-hooks/code-blocks/#context


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/transform/Markdownify.md
---


```go-html-template
<h2>{{ .Title | markdownify }}</h2>
```

If the resulting HTML is a single paragraph, Hugo removes the wrapping `p` tags to produce inline HTML as required per the example above.

To keep the wrapping `p` tags for a single paragraph, use the [`RenderString`][] method on the `Page` object, setting the `display` option to `block`.

> [!NOTE]
> Although the `markdownify` function honors [Markdown render hooks][] when rendering Markdown to HTML, use the `RenderString` method instead of `markdownify` if a render hook accesses `.Page` context. See issue [#9692][] for details.

[#9692]: https://github.com/gohugoio/hugo/issues/9692
[Markdown render hooks]: /render-hooks/
[`RenderString`]: /methods/page/renderstring/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/transform/Plainify.md
---


```go-html-template
{{ "<b>BatMan</b>" | plainify }} → BatMan
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/transform/PortableText.md
---


{{< new-in 0.145.0 />}}

[Portable Text][] is a JSON structure that represents rich text content in the [Sanity][] CMS. In Hugo, this function is typically used in a [content adapter][] that creates pages from Sanity data.

## Types supported

- `block` and `span`
- `image`. Note that the image handling is currently basic; we link to the `asset.url` using `asset.altText` as the image alt text and `asset.title` as the title. For more fine-grained control you may want to process the images in an [image render hook][].
- `code` (see the [code-input][] plugin). Code will be rendered as fenced code blocks with any file name provided passed as a Markdown attribute.

> [!NOTE]
> Since the Portable Text gets converted to Markdown before it gets passed to Hugo, rendering of links, headings, images and code blocks can be controlled with [render hooks][].

## Example

### Content Adapter

```go-html-template {file="content/_content.gotmpl" copy=true}
{{ $projectID := "mysanityprojectid" }}
{{ $useCached := true }}
{{ $api := "api" }}
{{ if $useCached }}
  {{/* See https://www.sanity.io/docs/api-cdn */}}
  {{ $api = "apicdn" }}
{{ end }}
{{ $url := printf "https://%s.%s.sanity.io/v2021-06-07/data/query/production" $projectID $api }}

{{ $q := `*[_type == 'post']{
  title, publishedAt, summary, slug, body[]{
    ...,
    _type == "image" => {
      ...,
      asset->{
        _id,
        path,
        url,
        altText,
        title,
        description,
        metadata {
          dimensions {
            aspectRatio,
            width,
            height
          }
        }
      }
    }
  },
  }`
}}
{{ $body := dict "query" $q | jsonify }}
{{ $opts := dict "method" "post" "body" $body }}
{{ $r := resources.GetRemote $url $opts }}
{{ $m := $r | transform.Unmarshal }}
{{ $result := $m.result }}
{{ range $result }}
  {{ if not .slug }}
    {{ continue }}
  {{ end }}
  {{ $markdown := transform.PortableText .body }}
  {{ $content := dict
    "mediaType" "text/markdown"
    "value" $markdown
  }}
  {{ $params := dict
    "portabletext" (.body | jsonify (dict "indent" " "))
  }}
  {{ $page := dict
    "content" $content
    "kind" "page"
    "path" .slug.current
    "title" .title
    "date" (.publishedAt | time )
    "summary" .summary
    "params" $params
  }}
  {{ $.AddPage $page }}
{{ end }}
```

### Sanity setup

The following outlines a suitable Sanity studio setup for the above example.

```ts {file="sanity.config.ts" copy=true}
import {defineConfig} from 'sanity'
import {structureTool} from 'sanity/structure'
import {visionTool} from '@sanity/vision'
import {schemaTypes} from './schemaTypes'
import {media} from 'sanity-plugin-media'
import {codeInput} from '@sanity/code-input'

export default defineConfig({
  name: 'default',
  title: 'my-sanity-project',

  projectId: 'mysanityprojectid',
  dataset: 'production',

  plugins: [structureTool(), visionTool(), media(),codeInput()],

  schema: {
    types: schemaTypes,
  },
})
```

Type/schema definition:

```ts {file="schemaTypes/postType.ts" copy=true}
import {defineField, defineType} from 'sanity'

export const postType = defineType({
  name: 'post',
  title: 'Post',
  type: 'document',
  fields: [
    defineField({
      name: 'title',
      type: 'string',
      validation: (rule) => rule.required(),
    }),
    defineField({
      name: 'summary',
      type: 'string',
      validation: (rule) => rule.required(),
    }),
    defineField({
      name: 'slug',
      type: 'slug',
      options: {source: 'title'},
      validation: (rule) => rule.required(),
    }),
    defineField({
      name: 'publishedAt',
      type: 'datetime',
      initialValue: () => new Date().toISOString(),
      validation: (rule) => rule.required(),
    }),
    defineField({
      name: 'body',
      type: 'array',
      of: [
        {
          type: 'block',
        },
        {
          type: 'image'
        },
        {
          type: 'code',
          options: {
            language: 'css',
            languageAlternatives: [
              {title: 'HTML', value: 'html'},
              {title: 'CSS', value: 'css'},
            ],
            withFilename: true,
          },
        },
      ],
    }),
  ],
})
```

Note that the above requires some additional plugins to be installed:

```sh
npm i sanity-plugin-media @sanity/code-input
```

```ts {file="schemaTypes/index.ts" copy=true}
import {postType} from './postType'

export const schemaTypes = [postType]
```

## Server setup

Unfortunately, Sanity's API does not support [RFC 7234][] and their output changes even if the data has not. A recommended setup is therefore to use their cached `apicdn` endpoint (see above) and then set up a reasonable polling and file cache strategy in your Hugo configuration, e.g:

<!-- markdownlint-disable MD049 -->
{{< code-toggle file=hugo >}}
[HTTPCache]
  [[HTTPCache.polls]]
    disable = false
    low = '30s'
    high = '3m'
    [HTTPCache.polls.for]
      includes = ['https://*.*.sanity.io/**']

[caches.getresource]
    dir    = ':cacheDir/:project'
    maxAge = "5m"
{{< /code-toggle >}}
<!-- markdownlint-enable MD049 -->

The polling above will be used when running the server/watch mode and rebuilds when you push new content to Sanity.

See [Caching in resources.GetRemote][] for more fine-grained control.

[Caching in resources.GetRemote]: /functions/resources/getremote/#caching
[Portable Text]: https://www.portabletext.org/
[RFC 7234]: https://tools.ietf.org/html/rfc7234
[Sanity]: https://www.sanity.io/
[code-input]: https://www.sanity.io/plugins/code-input
[content adapter]: /content-management/content-adapters/
[image render hook]: /render-hooks/images/
[render hooks]: /render-hooks/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/transform/Remarshal.md
---


The format must be one of `json`, `toml`, `yaml`, or `xml`. If the input is a string of serialized data, it must be valid JSON, TOML, YAML, or XML.

> [!NOTE]
> This function is primarily a helper for Hugo's documentation, used to convert configuration and front matter examples to JSON, TOML, and YAML.
>
> This is not a general purpose converter, and may change without notice if required for Hugo's documentation site.

Example 1
: Convert a string of TOML to JSON.

```go-html-template
{{ $s := `
  baseURL = 'https://example.org/'
  locale = 'en-US'
  title = 'ABC Widgets'
`}}
<pre>{{ transform.Remarshal "json" $s }}</pre>
```

Resulting HTML:

```html
<pre>{
   &#34;baseURL&#34;: &#34;https://example.org/&#34;,
   &#34;locale&#34;: &#34;en-US&#34;,
   &#34;title&#34;: &#34;ABC Widgets&#34;
}
</pre>
```

Rendered in browser:

```text
{
   "baseURL": "https://example.org/",
   "locale": "en-US",
   "title": "ABC Widgets"
}
```

Example 2
: Convert a map to YAML.

```go-html-template
{{ $m := dict
  "a" "Hugo rocks!"
  "b" (dict "question" "What is 6x7?" "answer" 42)
  "c" (slice "foo" "bar")
}}
<pre>{{ transform.Remarshal "yaml" $m }}</pre>
```

Resulting HTML:

```html
<pre>a: Hugo rocks!
b:
  answer: 42
  question: What is 6x7?
c:
- foo
- bar
</pre>
```

Rendered in browser:

```text
a: Hugo rocks!
b:
  answer: 42
  question: What is 6x7?
c:
- foo
- bar
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/transform/ToMath.md
---


Hugo uses an embedded instance of the [KaTeX][] display engine to render mathematical markup to HTML. You do not need to install the KaTeX display engine.

```go-html-template
{{ transform.ToMath "c = \\pm\\sqrt{a^2 + b^2}" }}
```

> [!NOTE]
> By default, Hugo renders mathematical markup to [MathML][], and does not require any CSS to display the result.
>
> To optimize rendering quality and accessibility, use the `htmlAndMathml` output option as described below. This approach requires an external stylesheet.

```go-html-template
{{ $opts := dict "output" "htmlAndMathml" }}
{{ transform.ToMath "c = \\pm\\sqrt{a^2 + b^2}" $opts }}
```

## Options

The `transform.ToMath` function accepts an options map. These options are a subset of the KaTeX [rendering options][].

`displayMode`
: (`bool`) Whether to render in display mode instead of inline mode. Default is `false`.

`errorColor`
: (`string`) The color of the error messages expressed as an RGB [hexadecimal color][]. Default is `#cc0000`.

`fleqn`
: (`bool`) Whether to render flush left with a 2em left margin. Default is `false`.

`macros`
: (`map`) A map of macros to be used in the math expression. Default is `{}`.

  ```go-html-template
  {{ $macros := dict
    "\\addBar" "\\bar{#1}"
    "\\bold" "\\mathbf{#1}"
  }}
  {{ $opts := dict "macros" $macros }}
  {{ transform.ToMath "\\addBar{y} + \\bold{H}" $opts }}
  ```

`minRuleThickness`
: (`float`) The minimum thickness of the fraction lines in `em`. Default is `0.04`.

`output`
: (`string`) Determines the markup language of the output, one of `html`, `mathml`, or `htmlAndMathml`. Default is `mathml`.

  With `html` and `htmlAndMathml` you must include the KaTeX style sheet within the `head` element of your base template.

  ```html
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/katex@0.17.0/dist/katex.min.css" integrity="sha384-vlBdW0r3AcZO/HboRPznQNowvexd3fY8qHOWkBi5q7KGgqJ+F48+DceybYmrVbmB" crossorigin="anonymous">
  ```

`strict`
: {{< new-in 0.147.6 />}}
: (`string`) Controls how KaTeX handles LaTeX features that offer convenience but aren't officially supported, one of `error`, `ignore`, or `warn`. Default is `error`.

  - `error`: Throws an error when convenient, unsupported LaTeX features are encountered.
  - `ignore`: Allows convenient, unsupported LaTeX features without any feedback.
  - `warn`: {{< new-in 0.147.7 />}} Emits a warning when convenient, unsupported LaTeX features are encountered.

  The `newLineInDisplayMode` error code, which flags the use of `\\` or `\newline` in display mode outside an array or tabular environment, is intentionally designed not to throw an error, despite this behavior being questionable.

`throwOnError`
: (`bool`) Whether to throw a `ParseError` when KaTeX encounters an unsupported command or invalid LaTeX. Default is `true`.

## Error handling

There are three ways to handle errors:

1. Let KaTeX throw an error and fail the build. This is the default behavior.
1. Set the `throwOnError` option to `false` to make KaTeX render the expression as an error instead of throwing an error. See [options](#options).
1. Handle the error in your template.

The example below demonstrates error handing within a template.

## Example

Instead of client-side JavaScript rendering of mathematical markup using MathJax or KaTeX, create a passthrough render hook which calls the `transform.ToMath` function.

Step 1
: Enable and configure the Goldmark [passthrough extension][] in your project configuration. The passthrough extension preserves raw Markdown within delimited snippets of text, including the delimiters themselves.

  {{< code-toggle file=hugo copy=true >}}
  [markup.goldmark.extensions.passthrough]
  enable = true
  [markup.goldmark.extensions.passthrough.delimiters]
  block = [['\[', '\]'], ['$$', '$$']]
  inline = [['\(', '\)']]
  {{< /code-toggle >}}

  > [!NOTE]
  > The configuration above precludes the use of the `$...$` delimiter pair for inline equations. Although you can add this delimiter pair to the configuration, you must double-escape the `$` symbol when used outside of math contexts to avoid unintended formatting.

Step 2
: Create a [passthrough render hook][] to capture and render the LaTeX markup.4

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

Step 3
: In your base template, conditionally include the KaTeX CSS within the head element.

  ```go-html-template {file="layouts/baseof.html" copy=true}
  <head>
    {{ $noop := .WordCount }}
    {{ if .Page.Store.Get "hasMath" }}
      <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/katex@0.17.0/dist/katex.min.css" integrity="sha384-vlBdW0r3AcZO/HboRPznQNowvexd3fY8qHOWkBi5q7KGgqJ+F48+DceybYmrVbmB" crossorigin="anonymous">
    {{ end }}
  </head>
  ```

  In the above, note the use of a [noop](g) statement to force content rendering before we check the value of `hasMath` with the `Store.Get` method.

  > [!NOTE]
  > This conditional approach only identifies math on the current page. Mathematical expressions will not display correctly when one page's content is embedded within another. For example, if a [list page](g) calls the [`Content`][] or [`Summary`][] methods while ranging through its page collection, the list page will not load the KaTeX CSS.
  >
  > If this affects your site, use this conditional logic instead:
  >
  > ```go-html-template {file="layouts/baseof.html" copy=true}
  > {{ $noop := .WordCount }}
  > {{ if or (.Page.Store.Get "hasMath") .IsNode }}
  >   <link rel="stylesheet" href="...">
  > {{ end }}
  > ```

Step 4
: Add some mathematical markup to your content, then test.

  ```md {file="content/example.md"}
  This is an inline \(a^*=x-b^*\) equation.

  These are block equations:

  \[a^*=x-b^*\]

  $$a^*=x-b^*$$
  ```

## Chemistry

{{< new-in 0.144.0 />}}

You can also use the `transform.ToMath` function to render chemical equations, leveraging the `\ce` and `\pu` functions from the [`mhchem`][] package.

```md
$$C_p[\ce{H2O(l)}] = \pu{75.3 J // mol K}$$
```

$$C_p[\ce{H2O(l)}] = \pu{75.3 J // mol K}$$

[KaTeX]: https://katex.org/
[MathML]: https://developer.mozilla.org/en-US/docs/Web/MathML
[`Content`]: /methods/page/content/
[`Summary`]: /methods/page/summary/
[`mhchem`]: https://mhchem.github.io/MathJax-mhchem/
[hexadecimal color]: https://developer.mozilla.org/en-US/docs/Web/CSS/hex-color
[passthrough extension]: /configuration/markup/#passthrough
[passthrough render hook]: /render-hooks/passthrough/
[rendering options]: https://katex.org/docs/options.html


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/transform/Unmarshal.md
---


The input can be a string or a [resource](g).

## Options

The `transform.Unmarshal` function accepts an options map.

`delimiter`
: (`string`) Applicable to CSV files. The delimiter used. Default is `,`.

`comment`
: (`string`) Applicable to CSV files. The comment character used in the CSV. If set, lines beginning with the comment character without preceding whitespace are ignored.

`format`
: {{< new-in 0.149.0 />}}
: (`string`) The serialization format of the input, one of `csv`, `json`, `org`, `toml`, `xml`, or `yaml`. If empty or unspecified, Hugo infers the format from the input. For resources, this option is only needed if the file lacks an extension or to override the inferred format. For strings, it's only required when the format is ambiguous.

`lazyQuotes`
: (`bool`) Applicable to CSV files. Whether to allow a quote in an unquoted field, or to allow a non-doubled quote in a quoted field. Default is `false`.

`targetType`
: {{< new-in 0.146.7 />}}
: (`string`) Applicable to CSV files. The target data type, either `slice` or `map`. Default is `slice`.

## Unmarshal a string

```go-html-template
{{ $string := `
title: Les Misérables
author: Victor Hugo
`}}

{{ $book := transform.Unmarshal $string }}
{{ $book.title }} → Les Misérables
{{ $book.author }} → Victor Hugo
```

## Unmarshal a resource

Use the `transform.Unmarshal` function with global, page, and remote resources.

### Global resource

A global resource is a file within the `assets` directory, or within any directory mounted to the `assets` directory.

```tree
assets/
└── data/
    └── books.json
```

```go-html-template
{{ $data := dict }}
{{ $path := "data/books.json" }}
{{ with resources.Get $path }}
  {{ with . | transform.Unmarshal }}
    {{ $data = . }}
  {{ end }}
{{ else }}
  {{ errorf "Unable to get global resource %q" $path }}
{{ end }}

{{ range where $data "author" "Victor Hugo" }}
  {{ .title }} → Les Misérables
{{ end }}
```

### Page resource

A page resource is a file within a [page bundle][].

```tree
content/
├── post/
│   └── book-reviews/
│       ├── books.json
│       └── index.md
└── _index.md
```

```go-html-template
{{ $data := dict }}
{{ $path := "books.json" }}
{{ with .Resources.Get $path }}
  {{ with . | transform.Unmarshal }}
    {{ $data = . }}
  {{ end }}
{{ else }}
  {{ errorf "Unable to get page resource %q" $path }}
{{ end }}

{{ range where $data "author" "Victor Hugo" }}
  {{ .title }} → Les Misérables
{{ end }}
```

### Remote resource

A remote resource is a file on a remote server, accessible via HTTP or HTTPS.

```go-html-template
{{ $data := dict }}
{{ $url := "https://example.org/books.json" }}
{{ with try (resources.GetRemote $url) }}
  {{ with .Err }}
    {{ errorf "%s" . }}
  {{ else with .Value }}
    {{ $data = . | transform.Unmarshal }}
  {{ else }}
    {{ errorf "Unable to get remote resource %q" $url }}
  {{ end }}
{{ end }}

{{ range where $data "author" "Victor Hugo" }}
  {{ .title }} → Les Misérables
{{ end }}
```

> [!NOTE]
> When retrieving remote data, a misconfigured server may send a response header with an incorrect [Content-Type][]. For example, the server may set the Content-Type header to `application/octet-stream` instead of `application/json`.
>
> In these cases, pass the resource `Content` through the `transform.Unmarshal` function instead of passing the resource itself. For example, in the above, do this instead:
>
> `{{ $data = .Content | transform.Unmarshal }}`

## Working with CSV

The examples below use this CSV file:

```csv
"name","type","breed","age"
"Spot","dog","Collie",3
"Rover","dog","Boxer",5
"Felix","cat","Calico",7
```

To render an HTML table from a CSV file:

```go-html-template
{{ $data := slice }}
{{ $file := "pets.csv" }}
{{ with or (.Resources.Get $file) (resources.Get $file) }}
  {{ $opts := dict "targetType" "slice" }}
  {{ $data = transform.Unmarshal $opts . }}
{{ end }}

{{ with $data }}
  <table>
    <thead>
      <tr>
        {{ range index . 0 }}
          <th>{{ . }}</th>
        {{ end }}
      </tr>
    </thead>
    <tbody>
      {{ range . | after 1 }}
        <tr>
          {{ range . }}
            <td>{{ . }}</td>
          {{ end }}
        </tr>
      {{ end }}
    </tbody>
  </table>
{{ end }}
```

To extract a subset of the data, or to sort the data, unmarshal to a map instead of a slice:

```go-html-template
{{ $data := dict }}
{{ $file := "pets.csv" }}
{{ with or (.Resources.Get $file) (resources.Get $file) }}
  {{ $opts := dict "targetType" "map" }}
  {{ $data = transform.Unmarshal $opts . }}
{{ end }}

{{ with sort (where $data "type" "dog") "name" "asc" }}
  <table>
    <thead>
      <tr>
        <th>name</th>
        <th>type</th>
        <th>breed</th>
        <th>age</th>
      </tr>
    </thead>
    <tbody>
      {{ range . }}
        <tr>
          <td>{{ .name }}</td>
          <td>{{ .type }}</td>
          <td>{{ .breed }}</td>
          <td>{{ .age }}</td>
        </tr>
      {{ end }}
    </tbody>
  </table>
{{ end }}
```

## Working with XML

When unmarshaling an XML file, do not include the root node when accessing data. For example, after unmarshaling the RSS feed below, access the feed title with `$data.channel.title`.

```xml
<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">
  <channel>
    <title>Books on Example Site</title>
    <link>https://example.org/books/</link>
    <description>Recent content in Books on Example Site</description>
    <language>en-US</language>
    <atom:link href="https://example.org/books/index.xml" rel="self" type="application/rss+xml" />
    <item>
      <title>The Hunchback of Notre Dame</title>
      <description>Written by Victor Hugo</description>
      <link>https://example.org/books/the-hunchback-of-notre-dame/</link>
      <pubDate>Mon, 09 Oct 2023 09:27:12 -0700</pubDate>
      <guid>https://example.org/books/the-hunchback-of-notre-dame/</guid>
    </item>
    <item>
      <title>Les Misérables</title>
      <description>Written by Victor Hugo</description>
      <link>https://example.org/books/les-miserables/</link>
      <pubDate>Mon, 09 Oct 2023 09:27:11 -0700</pubDate>
      <guid>https://example.org/books/les-miserables/</guid>
    </item>
  </channel>
</rss>
```

Get the remote data:

```go-html-template
{{ $data := dict }}
{{ $url := "https://example.org/books/index.xml" }}
{{ with try (resources.GetRemote $url) }}
  {{ with .Err }}
    {{ errorf "%s" . }}
  {{ else with .Value }}
    {{ $data = . | transform.Unmarshal }}
  {{ else }}
    {{ errorf "Unable to get remote resource %q" $url }}
  {{ end }}
{{ end }}
```

Inspect the data structure:

```go-html-template
<pre>{{ debug.Dump $data }}</pre>
```

List the book titles:

```go-html-template
{{ with $data.channel.item }}
  <ul>
    {{ range . }}
      <li>{{ .title }}</li>
    {{ end }}
  </ul>
{{ end }}
```

Hugo renders this to:

```html
<ul>
  <li>The Hunchback of Notre Dame</li>
  <li>Les Misérables</li>
</ul>
```

### XML attributes and namespaces

Let's add a `lang` attribute to the `title` nodes of our RSS feed, and a namespaced node for the ISBN number:

```xml
<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<rss version="2.0"
  xmlns:atom="http://www.w3.org/2005/Atom"
  xmlns:isbn="http://schemas.isbn.org/ns/1999/basic.dtd"
>
  <channel>
    <title>Books on Example Site</title>
    <link>https://example.org/books/</link>
    <description>Recent content in Books on Example Site</description>
    <language>en-US</language>
    <atom:link href="https://example.org/books/index.xml" rel="self" type="application/rss+xml" />
    <item>
      <title lang="en">The Hunchback of Notre Dame</title>
      <description>Written by Victor Hugo</description>
      <isbn:number>9780140443530</isbn:number>
      <link>https://example.org/books/the-hunchback-of-notre-dame/</link>
      <pubDate>Mon, 09 Oct 2023 09:27:12 -0700</pubDate>
      <guid>https://example.org/books/the-hunchback-of-notre-dame/</guid>
    </item>
    <item>
      <title lang="fr">Les Misérables</title>
      <description>Written by Victor Hugo</description>
      <isbn:number>9780451419439</isbn:number>
      <link>https://example.org/books/les-miserables/</link>
      <pubDate>Mon, 09 Oct 2023 09:27:11 -0700</pubDate>
      <guid>https://example.org/books/les-miserables/</guid>
    </item>
  </channel>
</rss>
```

After retrieving the remote data, inspect the data structure:

```go-html-template
<pre>{{ debug.Dump $data }}</pre>
```

Each item node looks like this:

```json
{
  "description": "Written by Victor Hugo",
  "guid": "https://example.org/books/the-hunchback-of-notre-dame/",
  "link": "https://example.org/books/the-hunchback-of-notre-dame/",
  "number": "9780140443530",
  "pubDate": "Mon, 09 Oct 2023 09:27:12 -0700",
  "title": {
    "#text": "The Hunchback of Notre Dame",
    "-lang": "en"
  }
}
```

The title keys do not begin with an underscore or a letter---they are not valid [identifiers](g). Use the [`index`][] function to access the values:

```go-html-template
{{ with $data.channel.item }}
  <ul>
    {{ range . }}
      {{ $title := index .title "#text" }}
      {{ $lang := index .title "-lang" }}
      {{ $ISBN := .number }}
      <li>{{ $title }} ({{ $lang }}) {{ $ISBN }}</li>
    {{ end }}
  </ul>
{{ end }}
```

Hugo renders this to:

```html
<ul>
  <li>The Hunchback of Notre Dame (en) 9780140443530</li>
  <li>Les Misérables (fr) 9780451419439</li>
</ul>
```

[Content-Type]: https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Type
[`index`]: /functions/collections/indexfunction/
[page bundle]: /content-management/page-bundles/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/transform/XMLEscape.md
---


The `transform.XMLEscape` function removes [disallowed characters][] as defined in the XML specification, then escapes the result by replacing the following characters with [HTML entities][]:

- `"` → `&#34;`
- `'` → `&#39;`
- `&` → `&amp;`
- `<` → `&lt;`
- `>` → `&gt;`
- `\t` → `&#x9;`
- `\n` → `&#xA;`
- `\r` → `&#xD;`

For example:

```go-html-template
{{ transform.XMLEscape "<p>abc</p>" }} → &lt;p&gt;abc&lt;/p&gt;
```

When using `transform.XMLEscape` in a template rendered by Go's [`html/template`][] package, declare the string to be safe HTML to avoid double escaping. For example, in an RSS template:

```xml {file="layouts/rss.xml"}
<description>{{ .Summary | transform.XMLEscape | safeHTML }}</description>
```

[HTML entities]: https://developer.mozilla.org/en-US/docs/Glossary/Entity
[`html/template`]: https://pkg.go.dev/html/template
[disallowed characters]: https://www.w3.org/TR/xml/#charsets

