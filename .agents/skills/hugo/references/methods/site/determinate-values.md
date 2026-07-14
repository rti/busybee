## Determinate values

The `Store` method is often used to set values within a _shortcode_ template, a _partial_ template called by a _shortcode_ template, or by a _render hook_ template. In all three cases, the stored values are indeterminate until Hugo renders the page content.

If you need to access a stored value from a parent template, and the parent template has not yet rendered the page content, you can trigger content rendering by assigning the returned value to a [noop](g) variable:

```go-html-template
{{ $noop := .Content }}
{{ site.Store.Get "mykey" }}
```

You can also trigger content rendering with the `ContentWithoutSummary`, `FuzzyWordCount`, `Len`, `Plain`, `PlainWords`, `ReadingTime`, `Summary`, `Truncated`, and `WordCount` methods. For example:

```go-html-template
{{ $noop := .WordCount }}
{{ site.Store.Get "mykey" }}
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/site/Taxonomies.md
---


Conceptually, the `Taxonomies` method on a `Site` object returns a data structure such&nbsp;as:

<!-- markdownlint-disable MD007 MD032 -->
{{< code-toggle file=hugo >}}
taxonomy a:
  - term 1:
    - page 1
    - page 2
  - term 2:
    - page 1
taxonomy b:
  - term 1:
    - page 2
  - term 2:
    - page 1
    - page 2
{{< /code-toggle >}}
<!-- markdownlint-enable MD007 MD032 -->

For example, on a book review site you might create two taxonomies; one for genres and another for authors.

With this project configuration:

{{< code-toggle file=hugo >}}
[taxonomies]
genre = 'genres'
author = 'authors'
{{< /code-toggle >}}

And this content structure:

```tree
content/
├── books/
│   ├── and-then-there-were-none.md --> genres: suspense
│   ├── death-on-the-nile.md        --> genres: suspense
│   └── jamaica-inn.md              --> genres: suspense, romance
│   └── pride-and-prejudice.md      --> genres: romance
└── _index.md
```

Conceptually, the taxonomies data structure looks like:

<!-- markdownlint-disable MD007 MD032 -->
{{< code-toggle file=hugo >}}
genres:
  - suspense:
    - And Then There Were None
    - Death on the Nile
    - Jamaica Inn
  - romance:
    - Jamaica Inn
    - Pride and Prejudice
authors:
  - achristie:
    - And Then There Were None
    - Death on the Nile
  - ddmaurier:
    - Jamaica Inn
  - jausten:
    - Pride and Prejudice
{{< /code-toggle >}}
<!-- markdownlint-enable MD007 MD032 -->

To list the "suspense" books:

```go-html-template
<ul>
  {{ range .Site.Taxonomies.genres.suspense }}
    <li><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></li>
  {{ end }}
</ul>
```

Hugo renders this to:

```html
<ul>
  <li><a href="/books/and-then-there-were-none/">And Then There Were None</a></li>
  <li><a href="/books/death-on-the-nile/">Death on the Nile</a></li>
  <li><a href="/books/jamaica-inn/">Jamaica Inn</a></li>
</ul>
```

> [!NOTE]
> Hugo's taxonomy system is powerful, allowing you to classify content and create relationships between pages.
>
> Please see the [taxonomies][] section for a complete explanation and examples.

