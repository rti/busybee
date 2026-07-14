## Shortcode

Call the `qr` shortcode to insert a QR code into your content.

Use the self-closing syntax to pass the text as an argument:

```md
{{</* qr text="https://gohugo.io" /*/>}}
```

Or insert the text between the opening and closing tags:

```md
{{</* qr */>}}
https://gohugo.io
{{</* /qr */>}}
```

The `qr` shortcode accepts several arguments including `level` and `scale`. See the [related documentation][] for details.

[QR code]: https://en.wikipedia.org/wiki/QR_code
[`publishDir`]: /configuration/all/#publishdir
[related documentation]: /shortcodes/qr/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/images/Saturation.md
---


The percentage must be in the range [-100, 500] where 0 has no effect.

