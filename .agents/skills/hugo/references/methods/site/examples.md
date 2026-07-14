## Examples

### List content with the same taxonomy term

If you are using a taxonomy for something like a series of posts, you can list individual pages associated with the same term. For example:

```go-html-template
<ul>
  {{ range .Site.Taxonomies.series.golang }}
    <li><a href="{{ .Page.RelPermalink }}">{{ .Page.Title }}</a></li>
  {{ end }}
</ul>
```

### List all content in a given taxonomy

This is useful in a sidebar as "featured content". You could even have different sections of "featured content" by assigning different terms to the content.

```go-html-template
<section id="menu">
  <ul>
    {{ range $term, $taxonomy := .Site.Taxonomies.featured }}
      <li>{{ $term }}</li>
      <ul>
        {{ range $taxonomy.Pages }}
          <li><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></li>
        {{ end }}
      </ul>
    {{ end }}
  </ul>
</section>
```

### Render a site's taxonomies

The following example displays all terms in a site's tags taxonomy:

```go-html-template
<ul>
  {{ range .Site.Taxonomies.tags }}
    <li><a href="{{ .Page.Permalink }}">{{ .Page.Title }}</a> {{ .Count }}</li>
  {{ end }}
</ul>
```

This example will list all taxonomies and their terms, as well as all the content assigned to each of the terms.

```go-html-template {file="layouts/_partials/all-taxonomies.html"}
{{ with .Site.Taxonomies }}
  {{ $numberOfTerms := 0 }}
  {{ range $taxonomy, $terms := . }}
    {{ $numberOfTerms = len . | add $numberOfTerms }}
  {{ end }}

  {{ if gt $numberOfTerms 0 }}
    <ul>
      {{ range $taxonomy, $terms := . }}
        {{ with $terms }}
          <li>
            <a href="{{ .Page.RelPermalink }}">{{ .Page.LinkTitle }}</a>
            <ul>
              {{ range $term, $weightedPages := . }}
                <li>
                  <a href="{{ .Page.RelPermalink }}">{{ .Page.LinkTitle }}</a>
                  <ul>
                    {{ range $weightedPages }}
                      <li><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></li>
                    {{ end }}
                  </ul>
                </li>
              {{ end }}
            </ul>
          </li>
        {{ end }}
      {{ end }}
    </ul>
  {{ end }}
{{ end }}
```

[taxonomies]: /content-management/taxonomies/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/site/Title.md
---


Project configuration:

{{< code-toggle file=hugo >}}
title = 'My Documentation Site'
{{< /code-toggle >}}

Template:

```go-html-template
{{ .Site.Title }} → My Documentation Site
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/site/Version.md
---


{{< new-in 0.153.0 />}}

