## Notes

> [!NOTE]
> It is safe to use the `Fragments` methods within a render hook, even for the current page.
>
> When using the `Fragments` methods within a shortcode, call the shortcode using [standard notation][]. If you use [Markdown notation][] the rendered shortcode is included in the creation of the fragments map, resulting in a circular loop.

[ATX]: https://spec.commonmark.org/current/#atx-headings
[Markdown notation]: /content-management/shortcodes/#notation
[`TableOfContents`]: /methods/page/tableofcontents/
[configure Markup]: /configuration/markup/#parserautodefinitiontermid
[setext]: https://spec.commonmark.org/current/#setext-headings
[standard notation]: /content-management/shortcodes/#notation
[table of contents]: /methods/page/tableofcontents/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/FuzzyWordCount.md
---


```go-html-template
{{ .FuzzyWordCount }} → 200
```

To get the exact word count, use the [`WordCount`][] method.

[`WordCount`]: /methods/page/wordcount/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/GetPage.md
---


The `GetPage` method is also available on a `Site` object. See [details][].

When using the `GetPage` method on the `Page` object, specify a path relative to the current directory or relative to the `content` directory.

If Hugo cannot resolve the path to a page, the method returns nil. If the path is ambiguous, Hugo throws an error and fails the build.

Consider this content structure:

```tree
content/
├── works/
│   ├── paintings/
│   │   ├── _index.md
│   │   ├── starry-night.md
│   │   └── the-mona-lisa.md
│   ├── sculptures/
│   │   ├── _index.md
│   │   ├── david.md
│   │   └── the-thinker.md
│   └── _index.md
└── _index.md
```

The examples below depict the result of rendering `works/paintings/the-mona-lisa.md`:

```go-html-template {file="layouts/works/page.html"}
{{ with .GetPage "starry-night" }}
  {{ .Title }} → Starry Night
{{ end }}

{{ with .GetPage "./starry-night" }}
  {{ .Title }} → Starry Night
{{ end }}

{{ with .GetPage "../paintings/starry-night" }}
  {{ .Title }} → Starry Night
{{ end }}

{{ with .GetPage "/works/paintings/starry-night" }}
  {{ .Title }} → Starry Night
{{ end }}

{{ with .GetPage "../sculptures/david" }}
  {{ .Title }} → David
{{ end }}

{{ with .GetPage "/works/sculptures/david" }}
  {{ .Title }} → David
{{ end }}
```

[details]: /methods/site/getpage/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/GetTerms.md
---


Given this front matter:

{{< code-toggle file=content/books/les-miserables.md fm=true >}}
title = 'Les Misérables'
tags = ['historical','classic','fiction']
{{< /code-toggle >}}

This template code:

```go-html-template
{{ with .GetTerms "tags" }}
  <p>Tags</p>
  <ul>
    {{ range . }}
      <li><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></li>
    {{ end }}
  </ul>
{{ end }}
```

Is rendered to:

```html
<p>Tags</p>
<ul>
  <li><a href="/tags/historical/">historical</a></li>
  <li><a href="/tags/classic/">classic</a></li>
  <li><a href="/tags/fiction/">fiction</a></li>
</ul>
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/GitInfo.md
---


The `GitInfo` method on a `Page` object provides access to commit metadata from your Git history, such as the author's name, the commit hash, and the commit message.

> [!NOTE]
> Hugo's Git integration is performant, but may increase build times for large projects.

