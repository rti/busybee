## Boolean/undefined comparison

Consider this project structure:

```tree
content/
├── posts/
│   ├── _index.md
│   ├── post-1.md  <-- front matter: exclude = false
│   ├── post-2.md  <-- front matter: exclude = true
│   └── post-3.md  <-- front matter: exclude not defined
└── _index.md
```

The first two pages have an "exclude" field in front matter, but the last page does not. When testing for _equality_, the third page is _excluded_ from the result. When testing for _inequality_, the third page is _included_ in the result.

### Equality test

This template:

```go-html-template
<ul>
  {{ range where .Site.RegularPages "Params.exclude" "eq" false }}
    <li><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></li>
  {{ end }}
</ul>
```

Is rendered to:

```html
<ul>
  <li><a href="/posts/post-1/">Post 1</a></li>
</ul>
```

This template:

```go-html-template
<ul>
  {{ range where .Site.RegularPages "Params.exclude" "eq" true }}
    <li><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></li>
  {{ end }}
</ul>
```

Is rendered to:

```html
<ul>
  <li><a href="/posts/post-2/">Post 2</a></li>
</ul>
```

### Inequality test

This template:

```go-html-template
<ul>
  {{ range where .Site.RegularPages "Params.exclude" "ne" false }}
    <li><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></li>
  {{ end }}
</ul>
```

Is rendered to:

```html
<ul>
  <li><a href="/posts/post-2/">Post 2</a></li>
  <li><a href="/posts/post-3/">Post 3</a></li>
</ul>
```

This template:

```go-html-template
<ul>
  {{ range where .Site.RegularPages "Params.exclude" "ne" true }}
    <li><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></li>
  {{ end }}
</ul>
```

Is rendered to:

```html
<ul>
  <li><a href="/posts/post-1/">Post 1</a></li>
  <li><a href="/posts/post-3/">Post 3</a></li>
</ul>
```

To exclude a page with an undefined field from a boolean _inequality_ test:

1. Create a slice using a boolean comparison
1. Create a slice using a nil comparison
1. Subtract the second slice from the first slice using the [`collections.Complement`][] function.

This template:

```go-html-template
{{ $p1 := where .Site.RegularPages "Params.exclude" "ne" true }}
{{ $p2 := where .Site.RegularPages "Params.exclude" "eq" nil }}
<ul>
  {{ range $p1 | complement $p2 }}
    <li><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></li>
  {{ end }}
</ul>
```

Is rendered to:

```html
<ul>
  <li><a href="/posts/post-1/">Post 1</a></li>
</ul>
```

This template:

```go-html-template
{{ $p1 := where .Site.RegularPages "Params.exclude" "ne" false }}
{{ $p2 := where .Site.RegularPages "Params.exclude" "eq" nil }}
<ul>
  {{ range $p1 | complement $p2 }}
    <li><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></li>
  {{ end }}
</ul>
```

Is rendered to:

```html
<ul>
  <li><a href="/posts/post-1/">Post 2</a></li>
</ul>
```

[`MainSections`]: /methods/site/mainsections/
[`collections.Complement`]: /functions/collections/complement/
[`date`]: /methods/page/date/
[`lastmod`]: /methods/page/lastmod/
[`time.Time`]: https://pkg.go.dev/time#Time

