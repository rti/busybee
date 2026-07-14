## Standalone images

By default, when the [Goldmark][] Markdown renderer encounters a standalone image element (no other elements or text on the same line), it wraps the image element within a paragraph element per the [CommonMark][] specification.

If you were to place an attribute list beneath an image element, Hugo would apply the attributes to the surrounding paragraph, not the image.

To apply attributes to a standalone image element, you must disable the default wrapping behavior:

{{< code-toggle file=hugo >}}
[markup.goldmark.parser]
wrapStandAloneImageWithinParagraph = false # default is true
{{< /code-toggle >}}

