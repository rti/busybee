## Nesting

Shortcodes (excluding [inline](#inline) shortcodes) can be nested, creating parent-child relationships. For example, a gallery shortcode might contain several image shortcodes:

```md {file="content/example.md"}
{{</* gallery class="content-gallery" */>}}
  {{</* image src="/images/a.jpg" */>}}
  {{</* image src="/images/b.jpg" */>}}
  {{</* image src="/images/c.jpg" */>}}
{{</* /gallery */>}}
```

The [shortcode templates][nesting] section provides a detailed explanation and examples.

[`TableOfContents`]: /methods/page/tableofcontents/
[`details`]: /shortcodes/details/
[`figure`]: /shortcodes/figure/
[`instagram`]: /shortcodes/instagram/
[`qr`]: /shortcodes/qr/
[configure security]: /configuration/security/
[layout string]: /functions/time/format/#layout-string
[nesting]: /templates/shortcode/#nesting
[shortcode method]: /templates/shortcode/#methods
[shortcode templates]: /templates/shortcode/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/content-management/summaries.md
---


<!-- Do not remove the manual summary divider below. -->
<!-- If you do, you will break its first literal usage on this page. -->

<!--more-->

You can define a summary manually, in front matter, or automatically. A manual summary takes precedence over a front matter summary, and a front matter summary takes precedence over an automatic summary.

Review the [comparison table](#comparison) below to understand the characteristics of each summary type.

