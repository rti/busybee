## In a term template

Use these methods on the `Data` object within a _term_ template.

`Singular`
: (`string`) Returns the singular name of the taxonomy.

```go-html-template
{{ .Data.Singular }} → genre
```

`Plural`
: (`string`) Returns the plural name of the taxonomy.

```go-html-template
{{ .Data.Plural }} → genres
```

`Term`
: (`string`) Returns the name of the term.

```go-html-template
{{ .Data.Term }} → suspense
```

Learn more about [term templates][].

[`Pages`]: /methods/page/pages/
[`RegularPagesRecursive`]: /methods/page/regularpagesrecursive/
[`RegularPages`]: /methods/page/regularpages/
[taxonomy methods]: /methods/taxonomy/
[taxonomy templates]: /templates/types/#taxonomy
[term templates]: /templates/types/#term


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/Date.md
---


Set the date in front matter:

{{< code-toggle file=content/news/article-1.md fm=true >}}
title = 'Article 1'
date = 2023-10-19T00:40:04-07:00
{{< /code-toggle >}}

> [!NOTE]
> The date field in front matter is often considered to be the creation date, You can change its meaning, and its effect on your project, in your project configuration. See [details][].

The date is a [time.Time][] value. Format and localize the value with the [`time.Format`][] function, or use it with any of the [time methods][].

```go-html-template
{{ .Date | time.Format ":date_medium" }} → Oct 19, 2023
```

In the example above we explicitly set the date in front matter. With Hugo's default configuration, the `Date` method returns the front matter value. This behavior is configurable, allowing you to set fallback values if the date is not defined in front matter. See [details][].

[`time.Format`]: /functions/time/format/
[details]: /configuration/front-matter/#dates
[time methods]: /methods/time/
[time.Time]: https://pkg.go.dev/time#Time


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/Description.md
---


Conceptually different from a [content summary][], a page description is typically used in metadata about the page.

{{< code-toggle file=content/recipes/sushi.md fm=true >}}
title = 'How to make spicy tuna hand rolls'
description = 'Instructions for making spicy tuna hand rolls.'
{{< /code-toggle >}}

```go-html-template {file="layouts/baseof.html"}
<head>
  ...
  <meta name="description" content="{{ .Description }}">
  ...
</head>
```

[content summary]: /content-management/summaries/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/Draft.md
---


By default, Hugo does not publish draft pages when you build your project. To include draft pages when you build your project, use the `--buildDrafts` command line flag.

{{< code-toggle file=content/posts/post-1.md fm=true >}}
title = 'Post 1'
draft = true
{{< /code-toggle >}}

```go-html-template
{{ .Draft }} → true
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/Eq.md
---


In this contrived example we list all pages in the current section except for the current page.

```go-html-template {file="layouts/page.html"}
{{ $currentPage := . }}
{{ range .CurrentSection.Pages }}
  {{ if not (.Eq $currentPage) }}
    <a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a>
  {{ end }}
{{ end }}
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/ExpiryDate.md
---


By default, Hugo excludes expired pages when building your project. To include expired pages, use the `--buildExpired` command line flag.

Set the expiry date in front matter:

{{< code-toggle file=content/news/article-1.md fm=true >}}
title = 'Article 1'
expiryDate = 2024-10-19T00:32:13-07:00
{{< /code-toggle >}}

The expiry date is a [time.Time][] value. Format and localize the value with the [`time.Format`][] function, or use it with any of the [time methods][].

```go-html-template
{{ .ExpiryDate | time.Format ":date_medium" }} → Oct 19, 2024
```

In the example above we explicitly set the expiry date in front matter. With Hugo's default configuration, the `ExpiryDate` method returns the front matter value. This behavior is configurable, allowing you to set fallback values if the expiry date is not defined in front matter. See [details][].

[`time.Format`]: /functions/time/format/
[details]: /configuration/front-matter/#dates
[time methods]: /methods/time/
[time.Time]: https://pkg.go.dev/time#Time


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/File.md
---


By default, not all pages are backed by a file, including top-level [section pages](g), [taxonomy pages](g), and [term pages](g). By definition, you cannot retrieve file information when the file does not exist.

To back one of the pages above with a file, create an&nbsp;`_index.md`&nbsp;file in the corresponding directory. For example:

```tree
content/
└── books/
    ├── _index.md  <-- the top-slevel section page
    ├── book-1.md
    └── book-2.md
```

> [!NOTE]
> Code defensively by verifying file existence as shown in the examples below.

