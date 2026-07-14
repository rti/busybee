## Example

With this template:

```go-html-template
{{ $weightedPages := $taxonomyObject.Get "suspense" }}
{{ range $weightedPages }}
  <h2><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></h2>
{{ end }}
```

Hugo renders:

```html
<h2><a href="/books/jamaica-inn/">Jamaica inn</a></h2>
<h2><a href="/books/death-on-the-nile/">Death on the nile</a></h2>
<h2><a href="/books/and-then-there-were-none/">And then there were none</a></h2>
```

[`index`]: /functions/collections/indexfunction/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/taxonomy/Page.md
---


This `TAXONOMY` method returns nil if the taxonomy has no terms, so you must code defensively:

```go-html-template
{{ with .Site.Taxonomies.tags.Page }}
  <a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a>
{{ end }}
```

This is rendered to:

```html
<a href="/tags/">Tags</a>
```

