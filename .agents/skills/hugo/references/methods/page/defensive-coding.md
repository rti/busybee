## Defensive coding

Some of the pages on a site may not be backed by a file. For example:

- Top-level section pages
- Taxonomy pages
- Term pages

Without a backing file, Hugo will throw an error if you attempt to access a `.File` property. To code defensively, first check for file existence:

```go-html-template
{{ with .File }}
  {{ .ContentBaseName }}
{{ end }}
```

[content adapter]: /content-management/content-adapters/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/FirstSection.md
---


{{% glossary-term section %}}

> [!NOTE]
> When called on the home page, the `FirstSection` method returns the `Page` object of the home page itself.

Consider this content structure:

```tree
content/
├── auctions/
│   ├── 2023-11/
│   │   ├── _index.md     <-- first section: auctions
│   │   ├── auction-1.md
│   │   └── auction-2.md  <-- first section: auctions
│   ├── 2023-12/
│   │   ├── _index.md
│   │   ├── auction-3.md
│   │   └── auction-4.md
│   ├── _index.md         <-- first section: auctions
│   ├── bidding.md
│   └── payment.md        <-- first section: auctions
├── books/
│   ├── _index.md         <-- first section: books
│   ├── book-1.md
│   └── book-2.md         <-- first section: books
├── films/
│   ├── _index.md         <-- first section: films
│   ├── film-1.md
│   └── film-2.md         <-- first section: films
└── _index.md             <-- first section: home
```

To link to the top-level section of which the current page is a descendant:

```go-html-template
<a href="{{ .FirstSection.RelPermalink }}">{{ .FirstSection.LinkTitle }}</a>
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/Fragments.md
---


In a URL, whether absolute or relative, the [fragment](g) links to an `id` attribute of an HTML element on the page.

```text
/articles/article-1#section-2
------------------- ---------
       path         fragment
```

Hugo assigns an `id` attribute to each Markdown [ATX][] and [setext][] heading within the page content. You can override the `id` with a [Markdown attribute](g) as needed. This creates the relationship between an entry in the [table of contents][] (TOC) and a heading on the page.

Use the `Fragments` method on a `Page` object to create a table of contents with the `Fragments.ToHTML` method, or by [walking](g) the `Fragments.Map` data structure. Use the methods below to inspect, validate, and render page fragments.

