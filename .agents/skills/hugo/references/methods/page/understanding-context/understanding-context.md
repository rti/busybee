## Understanding context

Inside of the `with` block, the [context](g) (the dot) is the section `Page` object, not the `Page` object passed into the template. If we were to use this syntax:

```go-html-template
{{ with .Site.GetPage "/auctions" }}
  {{ .IsDescendant . }} → true
{{ end }}
```

The result would be wrong when rendering the `auction-1` page because we are comparing the section page to itself.

> [!NOTE]
> Use the `$` to get the context passed into the template.

```go-html-template
{{ with .Site.GetPage "/auctions" }}
  {{ $.IsDescendant . }} → true
{{ end }}
```

> [!NOTE]
> Gaining a thorough understanding of context is critical for anyone writing template code.

[`else`]: /functions/go-template/else/
[`with`]: /functions/go-template/with/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/IsHome.md
---


The `IsHome` method on a `Page` object returns `true` if the [page kind](g) is `home`.

```tree
content/
├── books/
│   ├── book-1/
│   │   └── index.md  <-- kind = page
│   ├── book-2.md     <-- kind = page
│   └── _index.md     <-- kind = section
└── _index.md         <-- kind = home
```

```go-html-template
{{ .IsHome }}
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/IsMenuCurrent.md
---


```go-html-template
{{ $currentPage := . }}
{{ range site.Menus.main }}
  {{ if $currentPage.IsMenuCurrent .Menu . }}
    <a class="active" aria-current="page" href="{{ .URL }}">{{ .Name }}</a>
  {{ else if $currentPage.HasMenuCurrent .Menu . }}
    <a class="ancestor" aria-current="true" href="{{ .URL }}">{{ .Name }}</a>
  {{ else }}
    <a href="{{ .URL }}">{{ .Name }}</a>
  {{ end }}
{{ end }}
```

See [menu templates][] for a complete example.

> [!NOTE]
> When using this method you must either define the menu entry in front matter, or specify a `pageRef` property when defining the menu entry in your project configuration.

[menu templates]: /templates/menu/#example


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/IsNode.md
---


{{< deprecated-in 0.163.0 >}}
Use the [`IsBranch`](/methods/page/isbranch/) method instead.
{{< /deprecated-in >}}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/IsPage.md
---


The `IsPage` method on a `Page` object returns `true` if the [page kind](g) is `page`.

```tree
content/
├── books/
│   ├── book-1/
│   │   └── index.md  <-- kind = page
│   ├── book-2.md     <-- kind = page
│   └── _index.md     <-- kind = section
└── _index.md         <-- kind = home
```

```go-html-template
{{ .IsPage }}
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/IsSection.md
---


The `IsSection` method on a `Page` object returns `true` if the [page kind](g) is `section`.

```tree
content/
├── books/
│   ├── book-1/
│   │   └── index.md  <-- kind = page
│   ├── book-2.md     <-- kind = page
│   └── _index.md     <-- kind = section
└── _index.md         <-- kind = home
```

```go-html-template
{{ .IsSection }}
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/IsTranslated.md
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
{{< /code-toggle >}}

And this content:

```tree
content/
├── de/
│   ├── books/
│   │   └── book-1.md
│   └── _index.md
├── en/
│   ├── books/
│   │   ├── book-1.md
│   │   └── book-2.md
│   └── _index.md
└── _index.md
```

When rendering `content/en/books/book-1.md`:

```go-html-template
{{ .IsTranslated }} → true
```

When rendering `content/en/books/book-2.md`:

```go-html-template
{{ .IsTranslated }} → false
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/Keywords.md
---


By default, Hugo evaluates the keywords when creating collections of [related content][].

{{< code-toggle file=content/recipes/sushi.md fm=true >}}
title = 'How to make spicy tuna hand rolls'
keywords = ['tuna','sriracha','nori','rice']
{{< /code-toggle >}}

To list the keywords within a template:

```go-html-template
{{ range .Keywords }}
  {{ . }}
{{ end }}
```

Or use the [`delimit`][] function:

```go-html-template
{{ delimit .Keywords ", " ", and " }} → tuna, sriracha, nori, and rice
```

Keywords are also a useful [taxonomy][]:

{{< code-toggle file=hugo >}}
[taxonomies]
tag = 'tags'
keyword = 'keywords'
category = 'categories'
{{< /code-toggle >}}

[`delimit`]: /functions/collections/delimit/
[related content]: /content-management/related-content/
[taxonomy]: /content-management/taxonomies/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/Kind.md
---


The [page kind](g) is one of `home`, `page`, `section`, `taxonomy`, or `term`.

```tree
content/
├── books/
│   ├── book-1/
│   │   └── index.md    <-- kind = page
│   ├── book-2.md       <-- kind = page
│   └── _index.md       <-- kind = section
├── tags/
│   ├── fiction/
│   │   └── _index.md   <-- kind = term
│   └── _index.md       <-- kind = taxonomy
└── _index.md           <-- kind = home
```

To get the value within a template:

```go-html-template
{{ .Kind }}
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/Language.md
---


The `Language` method on a `Page` object returns the `Language` object for the given page, derived from the language definition in your project configuration.

You can also use the `Language` method on a `Site` object. See [details][].

