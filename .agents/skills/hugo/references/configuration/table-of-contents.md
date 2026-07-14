## Table of contents

This is the default configuration for the table of contents, applicable to Goldmark and Asciidoctor:

{{< code-toggle config=markup.tableOfContents />}}

`startLevel`
: (`int`) Heading levels less than this value will be excluded from the table of contents. For example, to exclude `h1` elements from the table of contents, set this value to `2`. Default is `2`.

`endLevel`
: (`int`) Heading levels greater than this value will be excluded from the table of contents. For example, to exclude `h4`, `h5`, and `h6` elements from the table of contents, set this value to `3`. Default is `3`.

`ordered`
: (`bool`) Whether to generates an ordered list instead of an unordered list. Default is `false`.

[^1]: See [details](https://github.com/gohugoio/hugo-goldmark-extensions/commit/4d4fcd022fe45a9b51483df001c9e5f4e632d5a9).

[AsciiDoc]: https://asciidoc.org/
[CommonMark]: https://spec.commonmark.org/current/
[Emacs Org Mode]: https://orgmode.org/
[GitHub Flavored Markdown: Autolinks]: https://github.github.com/gfm/#autolinks-extension-
[GitHub Flavored Markdown: Strikethrough]: https://github.github.com/gfm/#strikethrough-extension-
[GitHub Flavored Markdown: Tables]: https://github.github.com/gfm/#tables-extension-
[GitHub Flavored Markdown: Task list items]: https://github.github.com/gfm/#task-list-items-extension-
[GitHub Flavored Markdown]: https://github.github.com/gfm/
[Goldmark Extensions: CJK]: https://github.com/yuin/goldmark?tab=readme-ov-file#cjk-extension
[Goldmark Extensions: Typographer]: https://github.com/yuin/goldmark?tab=readme-ov-file#typographer-extension
[Goldmark]: https://github.com/yuin/goldmark/
[Hugo Goldmark Extensions: Extras]: https://github.com/gohugoio/hugo-goldmark-extensions?tab=readme-ov-file#extras-extension
[Hugo Goldmark Extensions: Passthrough]: https://github.com/gohugoio/hugo-goldmark-extensions?tab=readme-ov-file#passthrough-extension
[Markdown attributes]: /content-management/markdown-attributes/
[PHP Markdown Extra: Definition lists]: https://michelf.ca/projects/php-markdown/extra/#def-list
[PHP Markdown Extra: Footnotes]: https://michelf.ca/projects/php-markdown/extra/#footnotes
[Pandoc]: https://pandoc.org/
[`Fragments.Identifiers`]: /methods/page/fragments/#identifiers
[`TableOfContents`]: /methods/page/tableofcontents/
[`urls.Anchorize`]: /functions/urls/anchorize/
[asciidoctor-diagram]: https://asciidoctor.org/docs/asciidoctor-diagram/
[attributes]: https://asciidoctor.org/docs/asciidoc-syntax-quick-reference/#attributes-and-substitutions
[deleted text]: https://developer.mozilla.org/en-US/docs/Web/HTML/Element/del
[duplication of shared page resources]: /configuration/markup/#duplicateresourcefiles
[embedded image render hook]: /render-hooks/images/#embedded
[embedded link render hook]: /render-hooks/links/#embedded
[image render hook]: /render-hooks/images/
[includes]: https://docs.asciidoctor.org/asciidoc/latest/syntax-quick-reference/#includes
[inserted text]: https://developer.mozilla.org/en-US/docs/Web/HTML/Element/ins
[mark text]: https://developer.mozilla.org/en-US/docs/Web/HTML/Element/mark
[mathematics in Markdown]: /content-management/mathematics/
[multilingual page resources]: /content-management/page-resources/#multilingual
[reStructuredText]: https://docutils.sourceforge.io/rst.html
[security policy]: /configuration/security/
[subscript]: https://developer.mozilla.org/en-US/docs/Web/HTML/Element/sub
[superscript]: https://developer.mozilla.org/en-US/docs/Web/HTML/Element/sup


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/configuration/media-types.md
---


{{% glossary-term "media type" %}}

Configured media types serve multiple purposes in Hugo, including the definition of [output formats](g). This is the default media type configuration in tabular form:

{{< datatable "config" "mediaTypes" "_key" "suffixes" >}}

The `suffixes` column in the table above shows the suffixes associated with each media type. For example, Hugo associates `.html` and `.htm` files with the `text/html` media type.

> [!NOTE]
> The first suffix is the primary suffix. Use the primary suffix when naming template files. For example, when creating a template for an RSS feed, use the `xml` suffix.

