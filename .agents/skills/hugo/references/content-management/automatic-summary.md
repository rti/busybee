## Automatic summary

If you do not define the summary manually or in front matter, Hugo automatically defines the summary based on the [`summaryLength`][] in your project configuration.

```md {file="content/example.md"}
+++
title: 'Example'
date: 2024-05-26T09:10:33-07:00
+++

This is the first paragraph.

This is the second paragraph.

This is the third paragraph.
```

For example, with a `summaryLength` of 7, the automatic summary will be:

```html
<p>This is the first paragraph.</p>
<p>This is the second paragraph.</p>
```

> [!WARNING]
> Automatic `.Summary` may cut block tags (e.g., `blockquote`) in the middle when `summaryLength` is reached, causing the browser to recover the end tag (the end tag will be inserted before the parent's end tag), resulting in unexpected rendering behavior. To avoid this, wrap `.Summary` in a `<div>`; alternatively, wrap it together with the heading tag using `<section>`. You can avoid this entirely by using a manual summary. See issue [#14044][] for details.

