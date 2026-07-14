## Detection

The [`HasShortcode`][] method allows you to check if a specific shortcode has been called on a page. For example, consider a custom audio shortcode:

```md {file="content/example.md"}
{{</* audio src=/audio/test.mp3 */>}}
```

You can use the `HasShortcode` method in your base template to conditionally load CSS if the audio shortcode was used on the page:

```go-html-template {file="layouts/baseof.html"}
<head>
  ...
  {{ if .HasShortcode "audio" }}
    <link rel="stylesheet" src="/css/audio.css">
  {{ end }}
  ...
</head>
```

[GitHub]: https://github.com/gohugoio/hugo/tree/master/tpl/tplimpl/embedded/templates/_shortcodes
[Markdown notation]: /content-management/shortcodes/#markdown-notation
[`Get`]: /methods/shortcode/get/
[`HasShortcode`]: /methods/page/hasshortcode/
[`Inner`]: /methods/shortcode/inner/
[`IsNamedParams`]: /methods/shortcode/isnamedparams/
[`Name`]: /methods/shortcode/name/
[`Params`]: /methods/shortcode/params/
[`Parent`]: /methods/shortcode/parent/
[`Position`]: /methods/shortcode/position/
[`RenderString`]: /methods/page/renderstring/
[`collections.IsSet`]: /functions/collections/isset/
[`compare.Conditional`]: /functions/compare/conditional/
[`with`]: /functions/go-template/with/
[content management]: /content-management/shortcodes/
[embedded shortcodes]: /shortcodes/
[introduction to templating]: /templates/introduction/
[named or positional]: /content-management/shortcodes/#arguments
[shortcodes]: /content-management/shortcodes/
[standard notation]: /content-management/shortcodes/#standard-notation
[whitespace]: /templates/introduction/#whitespace


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/templates/sitemap.md
---


