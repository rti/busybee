## Include

Use the [`template`][] function to include one or more of Hugo's [embedded templates][]:

```go-html-template
{{ partial "google_analytics.html" . }}
{{ partial "opengraph" . }}
{{ partial "pagination.html" . }}
{{ partial "schema.html" . }}
{{ partial "twitter_cards.html" . }}
```

Use the [`partial`][] or [`partialCached`][] function to include one or more [partial templates][]:

```go-html-template
{{ partial "breadcrumbs.html" . }}
{{ partialCached "css.html" . }}
```

Create your _partial_ templates in the `layouts/_partials` directory.

> [!NOTE]
> In the examples above, note that we are passing the current context (the dot) to each of the templates.

