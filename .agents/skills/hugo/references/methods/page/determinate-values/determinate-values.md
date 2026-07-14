## Determinate values

The `Store` method is often used to set values within a _shortcode_ template, a _partial_ template called by a _shortcode_ template, or by a _render hook_ template. In all three cases, the stored values are indeterminate until Hugo renders the page content.

If you need to access a stored value from a parent template, and the parent template has not yet rendered the page content, you can trigger content rendering by assigning the returned value to a [noop](g) variable:

```go-html-template
{{ $noop := .Content }}
{{ .Store.Get "mykey" }}
```

You can also trigger content rendering with the `ContentWithoutSummary`, `FuzzyWordCount`, `Len`, `Plain`, `PlainWords`, `ReadingTime`, `Summary`, `Truncated`, and `WordCount` methods. For example:

```go-html-template
{{ $noop := .WordCount }}
{{ .Store.Get "mykey" }}
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/Summary.md
---


<!-- Do not remove the manual summary divider below. -->
<!-- If you do, you will break its first literal usage on this page. -->

<!--more-->

You can define a [summary][] manually, in front matter, or automatically. A manual summary takes precedence over a front matter summary, and a front matter summary takes precedence over an automatic summary.

To list the pages in a section with a summary beneath each link:

```go-html-template
{{ range .Pages }}
  <h2><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></h2>
  {{ .Summary }}
{{ end }}
```

> [!WARNING]
> Automatic `.Summary` may cut block tags (e.g., `blockquote`) in the middle, causing the browser to recover the end tag. See [automatic summary][] for details and for ways to avoid this.

Depending on content length and how you define the summary, the summary may be equivalent to the content itself. To determine whether the content length exceeds the summary length, use the [`Truncated`][] method on a `Page` object. This is useful for conditionally rendering a “read more” link:

```go-html-template
{{ range .Pages }}
  <h2><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></h2>
  {{ .Summary }}
  {{ if .Truncated }}
    <a href="{{ .RelPermalink }}">Read more...</a>
  {{ end }}
{{ end }}
```

> [!NOTE]
> The `Truncated` method returns `false` if you define the summary in front matter.

[`Truncated`]: /methods/page/truncated/
[automatic summary]: /content-management/summaries/#automatic-summary
[summary]: /content-management/summaries/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/TableOfContents.md
---


The `TableOfContents` method on a `Page` object returns an ordered or unordered list of the Markdown [ATX][] and [setext][] headings within the page content.

This template code:

```go-html-template
{{ .TableOfContents }}
```

Produces this HTML:

```html
<nav id="TableOfContents">
  <ul>
    <li><a href="#section-1">Section 1</a>
      <ul>
        <li><a href="#section-11">Section 1.1</a></li>
        <li><a href="#section-12">Section 1.2</a></li>
      </ul>
    </li>
    <li><a href="#section-2">Section 2</a></li>
  </ul>
</nav>
```

By default, the `TableOfContents` method returns an unordered list of level 2 and level 3 headings. You can adjust this in your project configuration:

{{< code-toggle file=hugo >}}
[markup.tableOfContents]
endLevel = 3
ordered = false
startLevel = 2
{{< /code-toggle >}}

[ATX]: https://spec.commonmark.org/current/#atx-headings
[setext]: https://spec.commonmark.org/current/#setext-headings


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/Title.md
---


With pages backed by a file, the `Title` method returns the `title` field as defined in front matter:

{{< code-toggle file=content/about.md fm=true >}}
title = 'About us'
{{< /code-toggle >}}

```go-html-template
{{ .Title }} → About us
```

When a page is not backed by a file, the value returned by the `Title` method depends on the page [kind](g).

Page kind|Page title when the page is not backed by a file
:--|:--
home|site title
section|section name (capitalized and pluralized)
taxonomy|taxonomy name (capitalized and pluralized)
term|term name (capitalized and pluralized)

You can disable automatic capitalization and pluralization in your project configuration:

{{< code-toggle file=hugo >}}
capitalizeListTitles = false
pluralizeListTitles = false
{{< /code-toggle >}}

You can change the capitalization style in your project configuration to one of `ap`, `chicago`, `go`, `firstupper`, or `none`. For example:

{{< code-toggle file=hugo >}}
titleCaseStyle = "firstupper"
{{< /code-toggle >}}

See [details][].

[details]: /configuration/all/#title-case-style


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/TranslationKey.md
---


The translation key creates a relationship between all translations of a given page. The translation key is derived from the file path, or from the `translationKey` parameter if defined in front matter.

With this project configuration:

{{< code-toggle file=hugo >}}
defaultContentLanguage = 'en'

[languages.en]
contentDir = 'content/en'
label = 'English'
locale = 'en-US'
weight = 1

[languages.de]
contentDir = 'content/de'
label = 'Deutsch'
locale = 'de-DE'
weight = 2
{{< /code-toggle >}}

And this content:

```tree
content/
├── de/
│   ├── books/
│   │   ├── buch-1.md
│   │   └── book-2.md
│   └── _index.md
├── en/
│   ├── books/
│   │   ├── book-1.md
│   │   └── book-2.md
│   └── _index.md
└── _index.md
```

And this front matter:

{{< code-toggle file=content/en/books/book-1.md fm=true >}}
title = 'Book 1'
translationKey = 'foo'
{{< /code-toggle >}}

{{< code-toggle file=content/de/books/buch-1.md fm=true >}}
title = 'Buch 1'
translationKey = 'foo'
{{< /code-toggle >}}

When rendering either either of the pages above:

```go-html-template
{{ .TranslationKey }} → page/foo
```

If the front matter of Book 2, in both languages, does not include a translation key:

```go-html-template
{{ .TranslationKey }} → page/books/book-2
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/Translations.md
---


With this project configuration:

{{< code-toggle file=hugo >}}
defaultContentLanguage = 'en'

[languages.en]
contentDir = 'content/en'
label = 'English'
locale = 'en-US'
weight = 1

[languages.de]
contentDir = 'content/de'
label = 'Deutsch'
locale = 'de-DE'
weight = 2

[languages.fr]
contentDir = 'content/fr'
label = 'Français'
locale = 'fr-FR'
weight = 3
{{< /code-toggle >}}

And this content:

```tree
content/
├── de/
│   ├── books/
│   │   ├── book-1.md
│   │   └── book-2.md
│   └── _index.md
├── en/
│   ├── books/
│   │   ├── book-1.md
│   │   └── book-2.md
│   └── _index.md
├── fr/
│   ├── books/
│   │   └── book-1.md
│   └── _index.md
└── _index.md
```

And this template:

```go-html-template
{{ with .Translations }}
  <ul>
    {{ range . }}
      <li>
        <a href="{{ .RelPermalink }}" hreflang="{{ .Language.Locale }}">{{ .LinkTitle }} ({{ or .Language.Label .Language.Name }})</a>
      </li>
    {{ end }}
  </ul>
{{ end }}
```

Hugo will render this list on the `book-1` page of the English site:

```html
<ul>
  <li><a href="/de/books/book-1/" hreflang="de-DE">Book 1 (Deutsch)</a></li>
  <li><a href="/fr/books/book-1/" hreflang="fr-FR">Book 1 (Français)</a></li>
</ul>
```

Hugo will render this list on the `book-2` page of the English site:

```html
<ul>
  <li><a href="/de/books/book-1/" hreflang="de-DE">Book 1 (Deutsch)</a></li>
</ul>
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/Truncated.md
---


You can define a [summary][] manually, in front matter, or automatically. A manual summary takes precedence over a front matter summary, and a front matter summary takes precedence over an automatic summary.

The `Truncated` method returns `true` if the content length exceeds the summary length. This is useful for conditionally rendering a "read more" link:

```go-html-template
{{ range .Pages }}
  <h2><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></h2>
  {{ .Summary }}
  {{ if .Truncated }}
    <a href="{{ .RelPermalink }}">Read more...</a>
  {{ end }}
{{ end }}
```

> [!NOTE]
> The `Truncated` method returns `false` if you define the summary in front matter.

[summary]: /content-management/summaries/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/Type.md
---


The `Type` method on a `Page` object returns the [content type](g) of the given page. The content type is defined by the `type` field in front matter, or inferred from the top-level directory name if the `type` field in front matter is not defined.

With this content structure:

```tree
content/
├── auction/
│   ├── _index.md
│   ├── item-1.md
│   └── item-2.md  <-- front matter: type = books
├── books/
│   ├── _index.md
│   ├── book-1.md
│   └── book-2.md
├── films/
│   ├── _index.md
│   ├── film-1.md
│   └── film-2.md
└── _index.md
```

To list the books, regardless of [section](g):

```go-html-template
{{ range where .Site.RegularPages.ByTitle "Type" "books" }}
  <h2><a href="{{ .RelPermalink }}">{{ .Title }}</a></h2>
{{ end }}
```

Hugo renders this to;

```html
<h2><a href="/books/book-1/">Book 1</a></h2>
<h2><a href="/books/book-2/">Book 2</a></h2>
<h2><a href="/auction/item-2/">Item 2</a></h2>
```

The `type` field in front matter is also useful for targeting a template. See [details][].

[details]: /templates/lookup-order/#target-a-template


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/Weight.md
---


The `Weight` method on a `Page` object returns the [weight](g) of the given page as defined in front matter.

{{< code-toggle file=content/recipes/sushi.md fm=true >}}
title = 'How to make spicy tuna hand rolls'
weight = 42
{{< /code-toggle >}}

Page weight controls the position of a page within a collection that is sorted by weight. Assign weights using non-zero integers. Lighter items float to the top, while heavier items sink to the bottom. Unweighted or zero-weighted elements are placed at the end of the collection.

Although rarely used within a template, you can access the value with:

```go-html-template
{{ .Weight }} → 42
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/WordCount.md
---


```go-html-template
{{ .WordCount }} → 103
```

To round up to nearest multiple of 100, use the [`FuzzyWordCount`][] method.

[`FuzzyWordCount`]: /methods/page/fuzzywordcount/

