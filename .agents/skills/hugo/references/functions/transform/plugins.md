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

