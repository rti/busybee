## Example of `after` with `first`: 2nd&ndash;4th most recent articles

You can use `after` in combination with the [`first`][] function and Hugo's [powerful sorting methods][]. Let's assume you have a `section` page at `example.com/articles`. You have 10 articles, but you want your template to show only two rows:

1. The top row is titled "Featured" and shows only the most recently published article (i.e. by `publishdate` in the content files' front matter).
1. The second row is titled "Recent Articles" and shows only the 2nd- to 4th-most recently published articles.

```go-html-template {file="layouts/section/articles.html"}
{{ define "main" }}
  <section class="row featured-article">
    <h2>Featured Article</h2>
    {{ range first 1 .Pages.ByPublishDate.Reverse }}
    <header>
      <h3><a href="{{ .RelPermalink }}">{{ .Title }}</a></h3>
    </header>
    <p>{{ .Description }}</p>
  {{ end }}
  </section>
  <div class="row recent-articles">
    <h2>Recent Articles</h2>
    {{ range first 3 (after 1 .Pages.ByPublishDate.Reverse) }}
      <section class="recent-article">
        <header>
          <h3><a href="{{ .RelPermalink }}">{{ .Title }}</a></h3>
        </header>
        <p>{{ .Description }}</p>
      </section>
    {{ end }}
  </div>
{{ end }}
```

[`first`]: /functions/collections/first/
[`slice`]: /functions/collections/slice/
[powerful sorting methods]: /quick-reference/page-collections/#sort


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/collections/Append.md
---


This function appends all elements, excluding the last, to the last element. This allows [pipe](g) constructs as shown below.

Append a single element to a slice:

```go-html-template
{{ $s := slice "a" "b" }}
{{ $s }} → [a b]

{{ $s = $s | append "c" }}
{{ $s }} → [a b c]
```

Append two elements to a slice:

```go-html-template
{{ $s := slice "a" "b" }}
{{ $s }} → [a b]

{{ $s = $s | append "c" "d" }}
{{ $s }} → [a b c d]
```

Append two elements, as a slice, to a slice. This produces the same result as the previous example:

```go-html-template
{{ $s := slice "a" "b" }}
{{ $s }} → [a b]

{{ $s = $s | append (slice "c" "d") }}
{{ $s }} → [a b c d]
```

Start with an empty slice:

```go-html-template
{{ $s := slice }}
{{ $s }} → []

{{ $s = $s | append "a" }}
{{ $s }} → [a]

{{ $s = $s | append "b" "c" }}
{{ $s }} → [a b c]

{{ $s = $s | append (slice "d" "e") }}
{{ $s }} → [a b c d e]
```

If you start with a slice of a slice:

```go-html-template
{{ $s := slice (slice "a" "b") }}
{{ $s }} → [[a b]]

{{ $s = $s | append (slice "c" "d") }}
{{ $s }} → [[a b] [c d]]
```

To create a slice of slices, starting with an empty slice:

```go-html-template
{{ $s := slice }}
{{ $s }} → []

{{ $s = $s | append (slice (slice "a" "b")) }}
{{ $s }} → [[a b]]

{{ $s = $s | append (slice "c" "d") }}
{{ $s }} → [[a b] [c d]]
```

Although the elements in the examples above are strings, you can use the `append` function with any data type, including Pages. For example, on the home page of a corporate site, to display links to the two most recent press releases followed by links to the four most recent articles:

```go-html-template
{{ $p := where site.RegularPages "Type" "press-releases" | first 2 }}
{{ $p = $p | append (where site.RegularPages "Type" "articles" | first 4) }}

{{ with $p }}
  <ul>
    {{ range . }}
      <li><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></li>
    {{ end }}
  </ul>
{{ end }}
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/collections/Apply.md
---


The `apply` function takes three or more arguments, depending on the function being applied to the slice elements.

The first argument is the slice itself, the second argument is the function name, and the remaining arguments are passed to the function, with the string `"."` representing the slice element.

```go-html-template
{{ $s := slice "hello" "world" }}

{{ $s = apply $s "strings.FirstUpper" "." }}
{{ $s }} → [Hello World]

{{ $s = apply $s "strings.Replace" "." "l" "_" }}
{{ $s }} →  [He__o Wor_d]
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/collections/Complement.md
---


To find the elements within `$c3` that do not exist in `$c1` or `$c2`:

```go-html-template
{{ $c1 := slice 3 }}
{{ $c2 := slice 4 5 }}
{{ $c3 := slice 1 2 3 4 5 }}

{{ complement $c1 $c2 $c3 }} → [1 2]
```

> [!NOTE]
> Make your code simpler to understand by using a [chained pipeline][]:

```go-html-template
{{ $c3 | complement $c1 $c2 }} → [1 2]
```

You can also use the `complement` function with page collections. Let's say your site has five content types:

```tree
content/
├── blog/
├── books/
├── faqs/
├── films/
└── songs/
```

To list everything except blog articles (`blog`) and frequently asked questions (`faqs`):

```go-html-template
{{ $blog := where site.RegularPages "Type" "blog" }}
{{ $faqs := where site.RegularPages "Type" "faqs" }}
{{ range site.RegularPages | complement $blog $faqs }}
  <a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a>
{{ end }}
```

> [!NOTE]
> Although the example above demonstrates the `complement` function, you could use the [`where`][] function as well:

```go-html-template
{{ range where site.RegularPages "Type" "not in" (slice "blog" "faqs") }}
  <a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a>
{{ end }}
```

In this example we use the `complement` function to remove [stop words][] from a sentence:

```go-html-template
{{ $text := "The quick brown fox jumps over the lazy dog" }}
{{ $stopWords := slice "a" "an" "in" "over" "the" "under" }}
{{ $filtered := split $text " " | complement $stopWords }}

{{ delimit $filtered " " }} → The quick brown fox jumps lazy dog
```

[`where`]: /functions/collections/where/
[chained pipeline]: https://pkg.go.dev/text/template#hdr-Pipelines
[stop words]: https://en.wikipedia.org/wiki/Stop_word


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/collections/D.md
---


{{< new-in 0.149.0 />}}

The `collections.D` function returns a sorted slice of unique random integers in the half-open [interval](g) `[0, HIGH)` using the provided [`SEED`](g) value. The number of elements in the resulting slice is `N` or `HIGH`, whichever is less.

- `N` and `H` must be integers in the closed interval `[0, 1000000]`
- `SEED` must be an integer in the closed interval `[0, 2^64 - 1]`

