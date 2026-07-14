## Logical tree

Just as file paths form a file tree, logical paths form a logical tree.

A file tree:

```tree
content/
└── s1/
    ├── p1/
    │   └── index.md
    └── p2.md
```

The same content represented as a logical tree:

```tree
content/
└── s1/
    ├── p1
    └── p2
```

A key difference between these trees is the relative path from p1 to p2:

- In the file tree, the relative path from p1 to p2 is `../p2.md`
- In the logical tree, the relative path is `p2`

> [!NOTE]
> Remember to use the logical path when using any of the methods, functions, or shortcodes listed in the previous section. If you include a file extension or language identifier, Hugo will strip these values before finding the page in the logical tree.

[`Page.GetPage`]: /methods/page/getpage/
[`Page.Ref`]: /methods/page/ref/
[`Page.RelRef`]: /methods/page/relref/
[`Shortcode.Ref`]: /methods/shortcode/ref/
[`Shortcode.RelRef`]: /methods/shortcode/relref/
[`Site.GetPage`]: /methods/site/getpage/
[`ref`]: /shortcodes/ref/
[`relref`]: /shortcodes/relref/
[`urls.Ref`]: /functions/urls/ref/
[`urls.RelRef`]: /functions/urls/relref/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/Permalink.md
---


Project configuration:

{{< code-toggle file=hugo >}}
title = 'Documentation'
baseURL = 'https://example.org/docs/'
{{< /code-toggle >}}

Template:

```go-html-template
{{ $page := .Site.GetPage "/about" }}
{{ $page.Permalink }} → https://example.org/docs/about/
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/Plain.md
---


The `Plain` method on a `Page` object renders Markdown and [shortcodes](g) to HTML, then strips the HTML [tags][]. It does not strip HTML [entities][].

To prevent Go's [`html/template`][] package from escaping HTML entities, pass the result through the [`htmlUnescape`][] function.

```go-html-template
{{ .Plain | htmlUnescape }}
```

[`html/template`]: https://pkg.go.dev/html/template
[`htmlUnescape`]: /functions/transform/htmlunescape/
[entities]: https://developer.mozilla.org/en-US/docs/Glossary/Entity
[tags]: https://developer.mozilla.org/en-US/docs/Glossary/Tag


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/PlainWords.md
---


The `PlainWords` method on a `Page` object calls the [`Plain`][] method, then uses Go's [`strings.Fields`][] function to split the result into words.

> [!NOTE]
> `Fields` splits the string `s` around each instance of one or more consecutive whitespace characters, as defined by [`unicode.IsSpace`][], returning a slice of substrings of `s` or an empty slice if `s` contains only whitespace.

As a result, elements within the slice may contain leading or trailing punctuation.

```go-html-template
{{ .PlainWords }}
```

To determine the approximate number of unique words on a page:

```go-html-template
{{ .PlainWords | uniq }} → 42
```

[`Plain`]: /methods/page/plain/
[`strings.Fields`]: https://pkg.go.dev/strings#Fields
[`unicode.IsSpace`]: https://pkg.go.dev/unicode#IsSpace


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/Prev.md
---


{{% include "/_common/methods/page/next-and-prev.md" %}}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/PrevInSection.md
---


{{% include "/_common/methods/page/nextinsection-and-previnsection.md" %}}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/PublishDate.md
---


By default, Hugo excludes pages with future publish dates when building your project. To include future pages, use the `--buildFuture` command line flag.

Set the publish date in front matter:

{{< code-toggle file=content/news/article-1.md fm=true >}}
title = 'Article 1'
publishDate = 2023-10-19T00:40:04-07:00
{{< /code-toggle >}}

The publish date is a [time.Time][] value. Format and localize the value with the [`time.Format`][] function, or use it with any of the [time methods][].

```go-html-template
{{ .PublishDate | time.Format ":date_medium" }} → Oct 19, 2023
```

In the example above we explicitly set the publish date in front matter. With Hugo's default configuration, the `PublishDate` method returns the front matter value. This behavior is configurable, allowing you to set fallback values if the publish date is not defined in front matter. See [details][].

[`time.Format`]: /functions/time/format/
[details]: /configuration/front-matter/#dates
[time methods]: /methods/time/
[time.Time]: https://pkg.go.dev/time#Time


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/RawContent.md
---


The `RawContent` method on a `Page` object returns the raw content. The raw content does not include front matter.

```go-html-template
{{ .RawContent }}
```

This is useful when rendering a page in a plain text [output format](g).

> [!NOTE]
> [Shortcodes](g) within the content are not rendered. To get the raw content with shortcodes rendered, use the [`RenderShortcodes`][] method on a `Page` object.

[`RenderShortcodes`]: /methods/page/rendershortcodes/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/ReadingTime.md
---


The estimated reading time is calculated by dividing the number of words in the content by the reading speed.

By default, Hugo assumes a reading speed of 212 words per minute. For CJK languages, it assumes 500 words per minute.

```go-html-template
{{ printf "Estimated reading time: %d minutes" .ReadingTime }}
```

Reading speed varies by language. Create language-specific estimated reading times on your multilingual project using site parameters.

{{< code-toggle file=hugo >}}
[languages]
  [languages.de]
    contentDir = 'content/de'
    label = 'Deutsch'
    locale = 'de-DE'
    weight = 2
    [languages.de.params]
    reading_speed = 179
  [languages.en]
    contentDir = 'content/en'
    label = 'English'
    locale = 'en-US'
    weight = 1
    [languages.en.params]
      reading_speed = 228
{{< /code-toggle >}}

Then in your template:

```go-html-template
{{ $readingTime := div (float .WordCount) .Site.Params.reading_speed }}
{{ $readingTime = math.Ceil $readingTime }}
```

We cast the `.WordCount` to a float to obtain a float when we divide by the reading speed. Then round up to the nearest integer.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/Ref.md
---


