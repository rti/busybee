## Example

With this project configuration:

{{< code-toggle file=hugo >}}
[sitemap]
changeFreq = 'monthly'
{{< /code-toggle >}}

And this content:

{{< code-toggle file=content/news.md fm=true >}}
title = 'News'
[sitemap]
changeFreq = 'hourly'
{{< /code-toggle >}}

And this simplistic sitemap template:

```xml {file="layouts/sitemap.xml"}
{{ printf "<?xml version=\"1.0\" encoding=\"utf-8\" standalone=\"yes\"?>" | safeHTML }}
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9"
  xmlns:xhtml="http://www.w3.org/1999/xhtml">
  {{ range .Pages }}
    <url>
      <loc>{{ .Permalink }}</loc>
      {{ if not .Lastmod.IsZero }}
        <lastmod>{{ .Lastmod.Format "2006-01-02T15:04:05-07:00" | safeHTML }}</lastmod>
      {{ end }}
      {{ with .Sitemap.ChangeFreq }}
        <changefreq>{{ . }}</changefreq>
      {{ end }}
    </url>
  {{ end }}
</urlset>
```

The change frequency will be `hourly` for the news page, and `monthly` for other pages.

[changefreqdef]: https://www.sitemaps.org/protocol.html#changefreqdef
[prioritydef]: https://www.sitemaps.org/protocol.html#prioritydef
[sitemap templates]: /templates/sitemap/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/Sites.md
---


{{< deprecated-in 0.156.0 >}}
Use the [`hugo.Sites`](/functions/hugo/sites/) function instead.
{{< /deprecated-in >}}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/Slug.md
---


{{< code-toggle file=content/recipes/spicy-tuna-hand-rolls.md fm=true >}}
title = 'How to make spicy tuna hand rolls'
slug = 'sushi'
{{< /code-toggle >}}

This page will be served from:

    https://example.org/recipes/sushi

To get the slug value within a template:

```go-html-template
{{ .Slug }} → sushi
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/Store.md
---


Use the `Store` method on a `Page` object to create a persistent data structure for storing and manipulating keyed values, scoped to the current page. To create a data structure with a different [scope](g), refer to the [scope](#scope) section below.

{{% include "_common/store-methods.md" %}}

{{% include "_common/store-scope.md" %}}

