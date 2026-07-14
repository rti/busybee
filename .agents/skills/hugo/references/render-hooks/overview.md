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

