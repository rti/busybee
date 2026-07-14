## Further explanation

To understand what is returned by the `RenderShortcodes` method, consider this content file

```md {file="content/about.md"}
+++
title = 'About'
date = 2023-10-07T12:28:33-07:00
+++

{{</* ref "privacy" */>}}

An *emphasized* word.
```

With this template code:

```go-html-template
{{ $p := site.GetPage "/about" }}
{{ $p.RenderShortcodes }}
```

Hugo renders this:;

```html
https://example.org/privacy/

An *emphasized* word.
```

Note that the shortcode within the content file was rendered, but the surrounding Markdown was preserved.

