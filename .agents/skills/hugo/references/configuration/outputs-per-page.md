## Outputs per page

Add output formats to a page's rendering using the `outputs` field in its front matter. For example, to include `json` in the output formats rendered for a specific page:

{{< code-toggle file=content/example.md fm=true >}}
title = 'Example'
outputs = ['json']
{{< /code-toggle >}}

In its default configuration, Hugo will render both the `html` and `json` output formats for this page. The `outputs` field appends to, rather than replaces, the project's configured outputs.

[`Permalink`]: /methods/page/permalink/
[`RelPermalink`]: /methods/page/relpermalink/
[configure output formats]: /configuration/output-formats/
[link to output formats]: configuration/output-formats/#link-to-output-formats


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/configuration/page.md
---


{{% glossary-term "default sort order" %}}

Hugo uses the default sort order to determine the _next_ and _previous_ page relative to the current page when calling these methods on a `Page` object:

- [`Next`][] and [`Prev`][]
- [`NextInSection`][] and [`PrevInSection`][]

This is based on this default project configuration:

{{< code-toggle config=page />}}

`nextPrevInSectionSortOrder`
: (`string`) The sort order used to determine the _next_ and _previous_ page within the same section when calling [`NextInSection`][] or [`PrevInSection`][] on a `Page` object. Valid values are `asc` (ascending) or `desc` (descending). Default is `desc`.

`nextPrevSortOrder`
: (`string`) The sort order used to determine the _next_ and _previous_ page when calling [`Next`][] or [`Prev`][] on a `Page` object. Valid values are `asc` (ascending) or `desc` (descending). Default is `desc`.

To reverse the meaning of _next_ and _previous_:

{{< code-toggle file=hugo >}}
[page]
  nextPrevInSectionSortOrder = 'asc'
  nextPrevSortOrder = 'asc'
{{< /code-toggle >}}

> [!NOTE]
> These settings do not apply to the [`Next`][next-pages] or [`Prev`][prev-pages] methods on a `Pages` object.

[`NextInSection`]: /methods/page/nextinsection/
[`Next`]: /methods/page/next/
[`PrevInSection`]: /methods/page/previnsection/
[`Prev`]: /methods/page/prev/
[next-pages]: /methods/pages/next/
[prev-pages]: /methods/pages/prev/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/configuration/pagination.md
---


This is the default configuration:

{{< code-toggle config=pagination />}}

`disableAliases`
: (`bool`) Whether to disable alias generation for the first pager. Default is `false`.

`pagerSize`
: (`int`) The number of pages per pager. Default is `10`.

`path`
: (`string`) The segment of each pager URL indicating that the target page is a pager. Default is `page`.

With multilingual projects you can define the pagination behavior for each language:

{{< code-toggle file=hugo >}}
[languages.en]
contentDir = 'content/en'
direction = 'ltr'
label = 'English'
locale = 'en-US'
weight = 1
[languages.en.pagination]
disableAliases = true
pagerSize = 10
path = 'page'
[languages.de]
contentDir = 'content/de'
direction = 'ltr'
label = 'Deutsch'
locale = 'de-DE'
weight = 2
[languages.de.pagination]
disableAliases = true
pagerSize = 20
path = 'blatt'
{{< /code-toggle >}}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/configuration/params.md
---


Use the `params` key for custom parameters:

{{< code-toggle file=hugo >}}
baseURL = 'https://example.org/'
locale = 'en-US'
title = 'Project Documentation'
[params]
subtitle = 'Reference, Tutorials, and Explanations'
[params.contact]
email = 'info@example.org'
phone = '+1 206-555-1212'
{{< /code-toggle >}}

Access the custom parameters from your templates using the [`Params`][] method on a `Site` object:

```go-html-template
{{ .Site.Params.subtitle }} → Reference, Tutorials, and Explanations
{{ .Site.Params.contact.email }} → info@example.org
```

Key names should use camelCase or snake_case. While TOML, YAML, and JSON allow kebab-case keys, they are not valid [identifiers](g) and cannot be used when [chaining](g) identifiers.

For example, you can do either of these:

```go-html-template
{{ .Site.params.camelCase.foo }}
{{ .Site.params.snake_case.foo }}
```

But you cannot do this:

```go-html-template
{{ .Site.params.kebab-case.foo }}
```

