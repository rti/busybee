## Examples

To render a list of the current page's language variants, including the current page, while sharing its current version and role:

```go-html-template
{{/* Returns languages sorted by weight ascending, then lexicographically ascending */}}
{{ range .Rotate "language" }}
  <h2><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></h2>
{{ end }}
```

To render a list of the current page's version variants, including the current page, while sharing its current language and role:

```go-html-template
{{/* Returns versions sorted by weight ascending, then semantic version descending */}}
{{ range .Rotate "version" }}
  <h2><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></h2>
{{ end }}
```

To render a list of the current page's role variants, including the current page, while sharing its current language and version:

```go-html-template
{{/* Returns roles sorted by weight ascending, then lexicographically ascending */}}
{{ range .Rotate "role" }}
  <h2><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></h2>
{{ end }}
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/Scratch.md
---


{{< deprecated-in 0.138.0 >}}
Use the [`PAGE.Store`](/methods/page/store/) method instead.

This is a soft deprecation. This method will be removed in a future release, but the removal date has not been established. Although Hugo will not emit a warning if you continue to use this method, you should begin using `PAGE.Store` as soon as possible.

Beginning with v0.138.0 the `PAGE.Scratch` method is aliased to `PAGE.Store`.
{{< /deprecated-in >}}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/Section.md
---


{{% glossary-term section %}}

With this content structure:

```tree
content/
├── lessons/
│   ├── math/
│   │   ├── _index.md
│   │   ├── lesson-1.md
│   │   └── lesson-2.md
│   └── _index.md
└── _index.md
```

When rendering lesson-1.md:

```go-html-template
{{ .Section }} → lessons
```

In the example above "lessons" is the top-level section.

The `Section` method is often used with the [`where`][] function to build a page collection.

```go-html-template
{{ range where .Site.RegularPages "Section" "lessons" }}
  <h2><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></h2>
{{ end }}
```

This is similar to using the [`Type`][] method with the `where` function

```go-html-template
{{ range where .Site.RegularPages "Type" "lessons" }}
  <h2><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></h2>
{{ end }}
```

However, if the `type` field in front matter has been defined on one or more pages, the page collection based on `Type` will be different than the page collection based on `Section`.

[`Type`]: /methods/page/type/
[`where`]: /functions/collections/where/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/Sections.md
---


The `Sections` method on a `Page` object is available to these [page kinds](g): `home`, `section`, and `taxonomy`. The templates for these page kinds receive a page [collection](g) in [context](g), in the [default sort order](g).

With this content structure:

```tree
content/
├── auctions/
│   ├── 2023-11/
│   │   ├── _index.md     <-- front matter: weight = 202311
│   │   ├── auction-1.md
│   │   └── auction-2.md
│   ├── 2023-12/
│   │   ├── _index.md     <-- front matter: weight = 202312
│   │   ├── auction-3.md
│   │   └── auction-4.md
│   ├── _index.md         <-- front matter: weight = 30
│   ├── bidding.md
│   └── payment.md
├── books/
│   ├── _index.md         <-- front matter: weight = 20
│   ├── book-1.md
│   └── book-2.md
├── films/
│   ├── _index.md         <-- front matter: weight = 10
│   ├── film-1.md
│   └── film-2.md
└── _index.md
```

And this template:

```go-html-template
{{ range .Sections.ByWeight }}
  <h2><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></h2>
{{ end }}
```

On the home page, Hugo renders:

```html
<h2><a href="/films/">Films</a></h2>
<h2><a href="/books/">Books</a></h2>
<h2><a href="/auctions/">Auctions</a></h2>
```

On the auctions page, Hugo renders:

```html
<h2><a href="/auctions/2023-11/">Auctions in November 2023</a></h2>
<h2><a href="/auctions/2023-12/">Auctions in December 2023</a></h2>
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/Site.md
---


See [Site methods][].

```go-html-template
{{ .Site.Title }}
```

[Site methods]: /methods/site/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/Sitemap.md
---


Access to the `Sitemap` method on a `Page` object is restricted to [sitemap templates][].

