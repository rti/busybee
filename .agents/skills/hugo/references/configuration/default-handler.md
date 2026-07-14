## Default handler

In its default configuration, Hugo uses [Goldmark][] to render Markdown to HTML.

{{< code-toggle file=hugo >}}
[markup]
defaultMarkdownHandler = 'goldmark'
{{< /code-toggle >}}

Files with ending with `.md`, `.mdown`, or `.markdown` are processed as Markdown, unless you've explicitly set a different format using the `markup` field in your front matter.

To use a different renderer for Markdown files, specify one of `asciidocext`, `org`, `pandoc`, or `rst` in your project configuration.

`defaultMarkdownHandler` | Renderer
:------------------------|:--------------------
`asciidocext`            | [AsciiDoc][]
`goldmark`               | [Goldmark][]
`org`                    | [Emacs Org Mode][]
`pandoc`                 | [Pandoc][]
`rst`                    | [reStructuredText][]

To use AsciiDoc, Pandoc, or reStructuredText you must install the relevant renderer and update your [security policy][].

> [!NOTE]
> Unless you need a unique capability provided by one of the alternative Markdown handlers, we strongly recommend that you use the default setting. Goldmark is fast, well maintained, conforms to the [CommonMark][] specification, and is compatible with [GitHub Flavored Markdown][] (GFM).

