## Include feed reference

To include a feed reference in the `head` element of your rendered pages, place this within the `head` element of your templates:

```go-html-template
{{ with .OutputFormats.Get "rss" }}
  {{ printf `<link rel=%q type=%q href=%q title=%q>` .Rel .MediaType.Type .Permalink site.Title | safeHTML }}
{{ end }}
```

Hugo will render this to:

```html
<link rel="alternate" type="application/rss+xml" href="https://example.org/index.xml" title="ABC Widgets">
```

