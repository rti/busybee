
---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/urls/AbsLangURL.md
---


Use this function with both monolingual and multilingual configurations. The URL returned by this function depends on:

- Whether the input begins with a slash (`/`)
- The `baseURL` in your project configuration
- The language prefix, if any

This is the project configuration for the examples that follow:

{{< code-toggle file=hugo >}}
defaultContentLanguage = 'en'
defaultContentLanguageInSubdir = true
[languages.en]
weight = 1
[languages.es]
weight = 2
{{< /code-toggle >}}

## Input does not begin with a slash

If the input does not begin with a slash, the path in the resulting URL will be relative to the `baseURL` in your project configuration.

When rendering the `en` site with `baseURL = https://example.org/`

```go-html-template
{{ absLangURL "" }}           → https://example.org/en/
{{ absLangURL "articles" }}   → https://example.org/en/articles
{{ absLangURL "style.css" }}  → https://example.org/en/style.css
```

When rendering the `en` site with `baseURL = https://example.org/docs/`

```go-html-template
{{ absLangURL "" }}           → https://example.org/docs/en/
{{ absLangURL "articles" }}   → https://example.org/docs/en/articles
{{ absLangURL "style.css" }}  → https://example.org/docs/en/style.css
```

## Input begins with a slash

If the input begins with a slash, the path in the resulting URL will be relative to the protocol+host of the `baseURL` in your project configuration.

When rendering the `en` site with `baseURL = https://example.org/`

```go-html-template
{{ absLangURL "/" }}          → https://example.org/en/
{{ absLangURL "/articles" }}  → https://example.org/en/articles
{{ absLangURL "/style.css" }} → https://example.org/en/style.css
```

When rendering the `en` site with `baseURL = https://example.org/docs/`

```go-html-template
{{ absLangURL "/" }}          → https://example.org/en/
{{ absLangURL "/articles" }}  → https://example.org/en/articles
{{ absLangURL "/style.css" }} → https://example.org/en/style.css
```

> [!NOTE]
> As illustrated by the previous example, using a leading slash is rarely desirable and can lead to unexpected outcomes. In nearly all cases, omit the leading slash.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/urls/AbsURL.md
---


With multilingual configurations, use the [`urls.AbsLangURL`][] function instead. The URL returned by this function depends on:

- Whether the input begins with a slash (`/`)
- The `baseURL` in your project configuration

## Input does not begin with a slash

If the input does not begin with a slash, the path in the resulting URL will be relative to the `baseURL` in your project configuration.

With `baseURL = https://example.org/`

```go-html-template
{{ absURL "" }}          → https://example.org/
{{ absURL "articles" }}  → https://example.org/articles
{{ absURL "style.css" }} → https://example.org/style.css
```

With `baseURL = https://example.org/docs/`

```go-html-template
{{ absURL "" }}          → https://example.org/docs/
{{ absURL "articles" }}  → https://example.org/docs/articles
{{ absURL "style.css" }} → https://example.org/docs/style.css
```

## Input begins with a slash

If the input begins with a slash, the path in the resulting URL will be relative to the protocol+host of the `baseURL` in your project configuration.

With `baseURL = https://example.org/`

```go-html-template
{{ absURL "/" }}          → https://example.org/
{{ absURL "/articles" }}  → https://example.org/articles
{{ absURL "/style.css" }} → https://example.org/style.css
```

With `baseURL = https://example.org/docs/`

```go-html-template
{{ absURL "/" }}          → https://example.org/
{{ absURL "/articles" }}  → https://example.org/articles
{{ absURL "/style.css" }} → https://example.org/style.css
```

> [!NOTE]
> As illustrated by the previous example, using a leading slash is rarely desirable and can lead to unexpected outcomes. In nearly all cases, omit the leading slash.

[`urls.AbsLangURL`]: /functions/urls/abslangurl/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/urls/Anchorize.md
---


{{% include "/_common/functions/urls/anchorize-vs-urlize.md" %}}

The `ursl.Anchorize` function sanitizes the resulting string per the [`autoIDType`][] setting in your project configuration.

[`autoIDType`]: /configuration/markup/#parserautoidtype


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/urls/JoinPath.md
---


```go-html-template
{{ urls.JoinPath }} → "" (empty string)
{{ urls.JoinPath "" }} → /
{{ urls.JoinPath "a" }} → a
{{ urls.JoinPath "a" "b" }} → a/b
{{ urls.JoinPath "/a" "b" }} → /a/b
{{ urls.JoinPath "https://example.org" "b" }} → https://example.org/b

{{ urls.JoinPath (slice "a" "b") }} → a/b
```

Unlike the [`path.Join`][] function, `urls.JoinPath` retains consecutive leading slashes.

[`path.Join`]: /functions/path/join/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/urls/Parse.md
---


The `urls.Parse` function parses a URL into a [URL structure][]. The URL may be relative (a path, without a host) or absolute (starting with a [scheme][]). Hugo throws an error when parsing an invalid URL.

```go-html-template
{{ $url := "https://example.org:123/foo?a=6&b=7#bar" }}
{{ $u := urls.Parse $url }}

{{ $u.String }} → https://example.org:123/foo?a=6&b=7#bar
{{ $u.IsAbs }} → true
{{ $u.Scheme }} → https
{{ $u.Host }} → example.org:123
{{ $u.Hostname }} → example.org
{{ $u.RequestURI }} → /foo?a=6&b=7
{{ $u.Path }} → /foo
{{ $u.RawQuery }} → a=6&b=7
{{ $u.Query }} → map[a:[6] b:[7]]
{{ $u.Query.a }} → [6]
{{ $u.Query.Get "a" }} → 6
{{ $u.Query.Has "b" }} → true
{{ $u.Fragment }} → bar
```

[URL structure]: https://godoc.org/net/url#URL
[scheme]: https://www.iana.org/assignments/uri-schemes/uri-schemes.xhtml#uri-schemes-1


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/urls/PathEscape.md
---


{{< new-in v0.153.0 />}}

The `urls.PathEscape` function does the inverse transformation of [`urls.PathUnescape`][].

```go-html-template
{{ urls.PathEscape "my café" }} → my%20caf%C3%A9
```

Use this function to escape a string so that it can be safely used as an individual segment within a URL path.

[`urls.PathUnescape`]: /functions/urls/PathUnescape/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/urls/PathUnescape.md
---


{{< new-in v0.153.0 />}}

The `urls.PathUnescape` function does the inverse transformation of [`urls.PathEscape`][].

```go-html-template
{{ urls.PathUnescape "A%2Fb%2Fc%3Fd=%C3%A9&f=g+h" }} → A/b/c?d=é&f=g+h
```

Use this function to decode an individual segment within a URL path.

[`urls.PathEscape`]: /functions/urls/PathEscape/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/urls/Ref.md
---


## Usage

The `ref` function takes two arguments:

1. The context for resolving relative paths (typically the current page).
1. Either the target page's path or an options map (see below).

## Options

{{% include "_common/ref-and-relref-options.md" %}}

## Examples

The following examples show the rendered output for a page on the English version of the site:

```go-html-template
{{ ref . "/books/book-1" }} → https://example.org/en/books/book-1/

{{ $opts := dict "path" "/books/book-1" }}
{{ ref . $opts }} → https://example.org/en/books/book-1/

{{ $opts := dict "path" "/books/book-1" "lang" "de" }}
{{ ref . $opts }} → https://example.org/de/books/book-1/

{{ $opts := dict "path" "/books/book-1" "lang" "de" "outputFormat" "json" }}
{{ ref . $opts }} → https://example.org/de/books/book-1/index.json
```

## Error handling

{{% include "_common/ref-and-relref-error-handling.md" %}}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/urls/RelLangURL.md
---


Use this function with both monolingual and multilingual configurations. The URL returned by this function depends on:

- Whether the input begins with a slash (`/`)
- The `baseURL` in your project configuration
- The language prefix, if any

This is the project configuration for the examples that follow:

{{< code-toggle file=hugo >}}
defaultContentLanguage = 'en'
defaultContentLanguageInSubdir = true
[languages.en]
weight = 1
[languages.es]
weight = 2
{{< /code-toggle >}}

## Input does not begin with a slash

If the input does not begin with a slash, the resulting URL will be relative to the `baseURL` in your project configuration.

When rendering the `en` site with `baseURL = https://example.org/`

```go-html-template
{{ relLangURL "" }}                         → /en/
{{ relLangURL "articles" }}                 → /en/articles
{{ relLangURL "style.css" }}                → /en/style.css
{{ relLangURL "https://example.org" }}      → https://example.org
{{ relLangURL "https://example.org/" }}     → /en
{{ relLangURL "https://www.example.org" }}  → https://www.example.org
{{ relLangURL "https://www.example.org/" }} → https://www.example.org/
```

When rendering the `en` site with `baseURL = https://example.org/docs/`

```go-html-template
{{ relLangURL "" }}                           → /docs/en/
{{ relLangURL "articles" }}                   → /docs/en/articles
{{ relLangURL "style.css" }}                  → /docs/en/style.css
{{ relLangURL "https://example.org" }}        → https://example.org
{{ relLangURL "https://example.org/" }}       → https://example.org/
{{ relLangURL "https://example.org/docs" }}   → https://example.org/docs
{{ relLangURL "https://example.org/docs/" }}  → /docs/en
{{ relLangURL "https://www.example.org" }}    → https://www.example.org
{{ relLangURL "https://www.example.org/" }}   → https://www.example.org/
```

## Input begins with a slash

If the input begins with a slash, the resulting URL will be relative to the protocol+host of the `baseURL` in your project configuration.

When rendering the `en` site with `baseURL = https://example.org/`

```go-html-template
{{ relLangURL "/" }}          → /en/
{{ relLangURL "/articles" }}  → /en/articles
{{ relLangURL "/style.css" }} → /en/style.css
```

When rendering the `en` site with `baseURL = https://example.org/docs/`

```go-html-template
{{ relLangURL "/" }}          → /en/
{{ relLangURL "/articles" }}  → /en/articles
{{ relLangURL "/style.css" }} → /en/style.css
```

> [!NOTE]
> As illustrated by the previous example, using a leading slash is rarely desirable and can lead to unexpected outcomes. In nearly all cases, omit the leading slash.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/urls/RelRef.md
---


## Usage

The `relref` function takes two arguments:

1. The context for resolving relative paths (typically the current page).
1. Either the target page's path or an options map (see below).

## Options

{{% include "_common/ref-and-relref-options.md" %}}

## Examples

The following examples show the rendered output for a page on the English version of the site:

```go-html-template
{{ relref . "/books/book-1" }} → /en/books/book-1/

{{ $opts := dict "path" "/books/book-1" }}
{{ relref . $opts }} → /en/books/book-1/

{{ $opts := dict "path" "/books/book-1" "lang" "de" }}
{{ relref . $opts }} → /de/books/book-1/

{{ $opts := dict "path" "/books/book-1" "lang" "de" "outputFormat" "json" }}
{{ relref . $opts }} → /de/books/book-1/index.json
```

## Error handling

{{% include "_common/ref-and-relref-error-handling.md" %}}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/urls/RelURL.md
---


With multilingual configurations, use the [`urls.RelLangURL`][] function instead. The URL returned by this function depends on:

- Whether the input begins with a slash (`/`)
- The `baseURL` in your project configuration

## Input does not begin with a slash

If the input does not begin with a slash, the resulting URL will be relative to the `baseURL` in your project configuration.

With `baseURL = https://example.org/`

```go-html-template
{{ relURL "" }}                         → /
{{ relURL "articles" }}                 → /articles
{{ relURL "style.css" }}                → /style.css
{{ relURL "https://example.org" }}      → https://example.org
{{ relURL "https://example.org/" }}     → /
{{ relURL "https://www.example.org" }}  → https://www.example.org
{{ relURL "https://www.example.org/" }} → https://www.example.org/
```

With `baseURL = https://example.org/docs/`

```go-html-template
{{ relURL "" }}                           → /docs/
{{ relURL "articles" }}                   → /docs/articles
{{ relURL "style.css" }}                  → /docs/style.css
{{ relURL "https://example.org" }}        → https://example.org
{{ relURL "https://example.org/" }}       → https://example.org/
{{ relURL "https://example.org/docs" }}   → https://example.org/docs
{{ relURL "https://example.org/docs/" }}  → /docs
{{ relURL "https://www.example.org" }}    → https://www.example.org
{{ relURL "https://www.example.org/" }}   → https://www.example.org/
```

## Input begins with a slash

If the input begins with a slash, the resulting URL will be relative to the protocol+host of the `baseURL` in your project configuration.

With `baseURL = https://example.org/`

```go-html-template
{{ relURL "/" }}          → /
{{ relURL "/articles" }}  → /articles
{{ relURL "/style.css" }} → /style.css
```

With `baseURL = https://example.org/docs/`

```go-html-template
{{ relURL "/" }}          → /
{{ relURL "/articles" }}  → /articles
{{ relURL "/style.css" }} → /style.css
```

> [!NOTE]
> As illustrated by the previous example, using a leading slash is rarely desirable and can lead to unexpected outcomes. In nearly all cases, omit the leading slash.

[`urls.RelLangURL`]: /functions/urls/rellangurl/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/urls/URLize.md
---


{{% include "/_common/functions/urls/anchorize-vs-urlize.md" %}}

## Example

Use the `urlize` function to create a link to a [term page](g).

Consider this project configuration:

{{< code-toggle file=hugo >}}
[taxonomies]
author = 'authors'
{{< /code-toggle >}}

And this front matter:

{{< code-toggle file=content/books/les-miserables.md fm=true >}}
title = 'Les Misérables'
authors = ['Victor Hugo']
{{< /code-toggle >}}

The published site will have this structure:

```tree
public/
├── authors/
│   ├── victor-hugo/
│   │   └── index.html
│   └── index.html
├── books/
│   ├── les-miserables/
│   │   └── index.html
│   └── index.html
└── index.html
```

To create a link to the term page:

```go-html-template
{{ $taxonomy := "authors" }}
{{ $term := "Victor Hugo" }}
{{ with index .Site.Taxonomies $taxonomy (urlize $term) }}
  <a href="{{ .Page.RelPermalink }}">{{ .Page.LinkTitle }}</a>
{{ end }}
```

To generate a list of term pages associated with a given content page, use the [`GetTerms`][] method on a `Page` object.

[`GetTerms`]: /methods/page/getterms/

