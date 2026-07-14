# pages


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/pages/ByDate.md
---


When sorting by date, the value is determined by your [project configuration][], defaulting to the `date` field in front matter.

```go-html-template
{{ range .Pages.ByDate }}
  <h2><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></h2>
{{ end }}
```

To sort in descending order:

```go-html-template
{{ range .Pages.ByDate.Reverse }}
  <h2><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></h2>
{{ end }}
```

[project configuration]: /configuration/front-matter/#dates


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/pages/ByExpiryDate.md
---


When sorting by expiration date, the value is determined by your [project configuration][], defaulting to the `expiryDate` field in front matter.

```go-html-template
{{ range .Pages.ByExpiryDate }}
  <h2><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></h2>
{{ end }}
```

To sort in descending order:

```go-html-template
{{ range .Pages.ByExpiryDate.Reverse }}
  <h2><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></h2>
{{ end }}
```

[project configuration]: /configuration/front-matter/#dates


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/pages/ByLanguage.md
---


When sorting by language, Hugo orders the page collection using the following priority:

1. Language weight (ascending)
1. Date (descending)
1. LinkTitle (ascending)

This method is rarely, if ever, needed. Page collections that already contain multiple languages, such as those returned by the [`Rotate`][], [`Translations`][], or [`AllTranslations`][] methods on a `Page` object, are already sorted by language weight.

This contrived example aggregates pages from all sites and then sorts them by language:

```go-html-template
{{ $p := slice }}
{{ range hugo.Sites }}
  {{ range .Pages }}
    {{ $p = $p | append . }}
  {{ end }}
{{ end }}

{{ range $p.ByLanguage }}
  <h2><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></h2>
{{ end }}
```

To sort in descending order:

```go-html-template
{{ range $p.ByLanguage.Reverse }}
  <h2><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></h2>
{{ end }}
```

[`AllTranslations`]: /methods/page/alltranslations/
[`Rotate`]: /methods/page/rotate/
[`Translations`]: /methods/page/translations/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/pages/ByLastmod.md
---


When sorting by last modification date, the value is determined by your [project configuration][], defaulting to the `lastmod` field in front matter.

```go-html-template
{{ range .Pages.ByLastmod }}
  <h2><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></h2>
{{ end }}
```

To sort in descending order:

```go-html-template
{{ range .Pages.ByLastmod.Reverse }}
  <h2><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></h2>
{{ end }}
```

[project configuration]: /configuration/front-matter/#dates


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/pages/ByLength.md
---


```go-html-template
{{ range .Pages.ByLength }}
  <h2><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></h2>
{{ end }}
```

To sort in descending order:

```go-html-template
{{ range .Pages.ByLength.Reverse }}
  <h2><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></h2>
{{ end }}
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/pages/ByLinkTitle.md
---


```go-html-template
{{ range .Pages.ByLinkTitle }}
  <h2><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></h2>
{{ end }}
```

To sort in descending order:

```go-html-template
{{ range .Pages.ByLinkTitle.Reverse }}
  <h2><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></h2>
{{ end }}
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/pages/ByParam.md
---


If the given parameter is not present in front matter, Hugo will use the matching parameter in your project configuration if present.

```go-html-template
{{ range .Pages.ByParam "author" }}
  <h2><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></h2>
{{ end }}
```

To sort in descending order:

```go-html-template
{{ range (.Pages.ByParam "author").Reverse }}
  <h2><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></h2>
{{ end }}
```

If the targeted parameter is nested, access the field using dot notation:

```go-html-template
{{ range .Pages.ByParam "author.last_name" }}
  <h2><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></h2>
{{ end }}
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/pages/ByPublishDate.md
---


When sorting by publish date, the value is determined by your [project configuration][], defaulting to the `publishDate` field in front matter.

```go-html-template
{{ range .Pages.ByPublishDate }}
  <h2><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></h2>
{{ end }}
```

To sort in descending order:

```go-html-template
{{ range .Pages.ByPublishDate.Reverse }}
  <h2><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></h2>
{{ end }}
```

[project configuration]: /configuration/front-matter/#dates


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/pages/ByTitle.md
---


```go-html-template
{{ range .Pages.ByTitle }}
  <h2><a href="{{ .RelPermalink }}">{{ .Title }}</a></h2>
{{ end }}
```

To sort in descending order:

```go-html-template
{{ range .Pages.ByTitle.Reverse }}
  <h2><a href="{{ .RelPermalink }}">{{ .Title }}</a></h2>
{{ end }}
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/pages/ByWeight.md
---


Assign a [weight](g) to a page using the `weight` field in front matter. The weight must be a non-zero integer. Lighter items float to the top, while heavier items sink to the bottom. Unweighted or zero-weighted pages are placed at the end of the collection.

```go-html-template
{{ range .Pages.ByWeight }}
  <h2><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></h2>
{{ end }}
```

To sort in descending order:

```go-html-template
{{ range .Pages.ByWeight.Reverse }}
  <h2><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></h2>
{{ end }}
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/pages/GroupBy.md
---


{{% include "/_common/methods/pages/group-sort-order.md" %}}

```go-html-template
{{ range .Pages.GroupBy "Section" }}
  <p>{{ .Key }}</p>
  <ul>
    {{ range .Pages }}
      <li><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></li>
    {{ end }}
  </ul>
{{ end }}
```

To sort the groups in descending order:

```go-html-template
{{ range .Pages.GroupBy "Section" "desc" }}
  <p>{{ .Key }}</p>
  <ul>
    {{ range .Pages }}
      <li><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></li>
    {{ end }}
  </ul>
{{ end }}
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/pages/GroupByDate.md
---


When grouping by date, the value is determined by your [project configuration][], defaulting to the `date` field in front matter.

The [layout string](#layout-string) has the same format as the layout string for the [`time.Format`][] function. The resulting group key is [localized](g) for language and region.

{{% include "/_common/methods/pages/group-sort-order.md" %}}

To group content by year and month:

```go-html-template
{{ range .Pages.GroupByDate "January 2006" }}
  <p>{{ .Key }}</p>
  <ul>
    {{ range .Pages }}
      <li><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></li>
    {{ end }}
  </ul>
{{ end }}
```

To sort the groups in ascending order:

```go-html-template
{{ range .Pages.GroupByDate "January 2006" "asc" }}
  <p>{{ .Key }}</p>
  <ul>
    {{ range .Pages }}
      <li><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></li>
    {{ end }}
  </ul>
{{ end }}
```

The pages within each group will also be sorted by date, either ascending or descending depending on the grouping option. To sort the pages within each group, use one of the sorting methods. For example, to sort the pages within each group by title:

```go-html-template
{{ range .Pages.GroupByDate "January 2006" }}
  <p>{{ .Key }}</p>
  <ul>
    {{ range .Pages.ByTitle }}
      <li><a href="{{ .RelPermalink }}">{{ .Title }}</a></li>
    {{ end }}
  </ul>
{{ end }}
```


## Sections

- [`layout-string`](references/methods/pages/layout-string.md) — Layout String
- [`layout-string`](references/methods/pages/layout-string.md) — Layout String
- [`layout-string`](references/methods/pages/layout-string.md) — Layout String
- [`layout-string`](references/methods/pages/layout-string.md) — Layout String
- [`layout-string`](references/methods/pages/layout-string.md) — Layout String
- [`options`](references/methods/pages/options.md) — Options

