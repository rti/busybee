
---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/collections/After.md
---


The following shows `after` being used in conjunction with the [`slice`][] function:

```go-html-template
{{ $data := slice "one" "two" "three" "four" }}
<ul>
  {{ range after 2 $data }}
    <li>{{ . }}</li>
  {{ end }}
</ul>
```

The template above is rendered to:

```html
<ul>
  <li>three</li>
  <li>four</li>
</ul>
```

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

## Return values

Condition|Return value
:--|:--|:--
`N <= HIGH`|A sorted random sample of size `N` using J. S. Vitter's [Method D][] for sequential random sampling
`N > HIGH`|The full, sorted range `[0, HIGH)` of size `HIGH`
`N == 0`|An empty slice
`N < 0`|Error
`N > 10^6`|Error
`HIGH == 0`|An empty slice
`HIGH < 0`|Error
`HIGH > 10^6`|Error
`SEED < 0`|Error
{.no-wrap-first-col}

## Examples

```go-html-template
{{ collections.D 6 7 42 }} → [4, 9, 10, 20, 22, 24, 41]
```

The example above generates the _same_ random numbers each time it is called. To generate a _different_ set of 7 random numbers in the same range, change the seed value.

```go-html-template
{{ collections.D 2 7 42 }} → [3, 11, 19, 25, 32, 33, 38]
```

When `N` is greater than `HIGH`, this function returns the full, sorted range [0, `HIGH`) of size `HIGH`:

```go-html-template
{{ collections.D 6 42 7 }} → [0 1 2 3 4 5 6]
```

A common use case is the selection of random pages from a page collection. For example, to render a list of 5 random pages using the [day of the year][] as the seed value:

```go-html-template
<ul>
  {{ $p := site.RegularPages }}
  {{ range collections.D time.Now.YearDay 5 ($p | len) }}
    {{ with (index $p .) }}
      <li><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></li>
    {{ end }}
  {{ end }}
</ul>
```

The construct above is significantly faster than using the [`collections.Shuffle`][] function.

## Seed value

Choosing an appropriate seed value depends on your objective.

Objective|Seed example
:--|:--
Consistent result|`42`
Different result on each call|`int time.Now.UnixNano`
Same result per day|`time.Now.YearDay`
Same result per page|`hash.FNV32a .Path`
Different result per page per day|`hash.FNV32a (print .Path time.Now.YearDay)`

[Method D]: https://getkerf.wordpress.com/2016/03/30/the-best-algorithm-no-one-knows-about/
[`collections.Shuffle`]: /functions/collections/shuffle/
[day of the year]: /methods/time/yearday/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/collections/Delimit.md
---


Delimit a slice:

```go-html-template
{{ $s := slice "b" "a" "c" }}
{{ delimit $s ", " }} → b, a, c
{{ delimit $s ", " " and "}} → b, a and c
```

Delimit a map:

> [!NOTE]
> The `delimit` function sorts maps by key, returning the values.

```go-html-template
{{ $m := dict "b" 2 "a" 1 "c" 3 }}
{{ delimit $m ", " }} → 1, 2, 3
{{ delimit $m ", " " and "}} → 1, 2 and 3
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/collections/Dictionary.md
---


Specify the key-value pairs as individual arguments:

```go-html-template
{{ $m := dict "a" 1 "b" 2 }}
```

The above produces this data structure:

```json
{
  "a": 1,
  "b": 2
}
```

Note that the `key` can be either a `string` or a `[]string`. The latter is useful to create a deeply nested structure, e.g.:

```go-html-template
{{ $m := dict (slice "a" "b" "c") "value" }}
```

The above produces this data structure:

```json
{
  "a": {
    "b": {
      "c": "value"
    }
  }
}
```

To create an empty map:

```go-html-template
{{ $m := dict }}
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/collections/First.md
---


```go-html-template
{{ slice "a" "b" "c" | first 1 }} → [a]
{{ slice "a" "b" "c" | first 2 }} → [a b]
```

Given that a string is in effect a read-only slice of bytes, this function can be used to return the specified number of bytes from the beginning of the string:

```go-html-template
{{ "abc" | first 1 }} → a
{{ "abc" | first 2 }} → ab
```

Note that a _character_ may consist of multiple _bytes_:

```go-html-template
{{ "Schön" | first 3 }} → Sch
{{ "Schön" | first 4 }} → Sch\xc3
{{ "Schön" | first 5 }} → Schö
```

To use the `collections.First` function with a page collection:

```go-html-template
{{ range first 5 .Pages }}
  {{ .Render "summary" }}
{{ end }}
```

Set `N` to zero to return an empty slice:

```go-html-template
{{ $emptyPageCollection := first 0 .Pages }}
```

Use `first` and [`where`][] together:

```go-html-template
{{ range where .Pages "Section" "articles" | first 5 }}
  {{ .Render "summary" }}
{{ end }}
```

[`where`]: /functions/collections/where/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/collections/Group.md
---


```go-html-template
{{ $new := .Site.RegularPages | first 10 | group "New" }}
{{ $old := .Site.RegularPages | last 10 | group "Old" }}
{{ $groups := slice $new $old }}
{{ range $groups }}
  <h3>{{ .Key }}{{/* Prints "New", "Old" */}}</h3>
  <ul>
    {{ range .Pages }}
      <li>
        <a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a>
        <div class="meta">{{ .Date.Format "Mon, Jan 2, 2006" }}</div>
      </li>
    {{ end }}
  </ul>
{{ end }}
```

The page group you get from `group` is of the same type you get from the built-in [group methods][] in Hugo. The example above can be [paginated][].

[group methods]: /quick-reference/page-collections/#group
[paginated]: /templates/pagination/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/collections/In.md
---


```go-html-template
{{ $s := slice "a" "b" "c" }}
{{ in $s "b" }} → true
```

```go-html-template
{{ $s := "abc" }}
{{ in $s "b" }} → true
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/collections/IndexFunction.md
---


Each indexed item must be a map or a slice:

```go-html-template
{{ $s := slice "a" "b" "c" }}
{{ index $s 0 }} → a
{{ index $s 1 }} → b

{{ $m := dict "a" 100 "b" 200 }}
{{ index $m "b" }} → 200
```

Use two or more keys to access a nested value:

```go-html-template
{{ $m := dict "a" 100 "b" 200 "c" (slice 10 20 30) }}
{{ index $m "c" 1 }} → 20

{{ $m := dict "a" 100 "b" 200 "c" (dict "d" 10 "e" 20) }}
{{ index $m "c" "e" }} → 20
```

You may also use a slice of keys to access a nested value:

```go-html-template
{{ $m := dict "a" 100 "b" 200 "c" (dict "d" 10 "e" 20) }}
{{ $s := slice "c" "e" }}
{{ index $m $s }} → 20
```

Use the `collections.Index` function to access a nested value when the key is variable. For example, these are equivalent:

```go-html-template
{{ .Site.Params.foo }}

{{ $k := "foo" }}
{{ index .Site.Params $k }}
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/collections/Intersect.md
---


A useful example is to use it as `AND` filters when combined with where:

```go-html-template
{{ $pages := where .Site.RegularPages "Type" "not in" (slice "page" "about") }}
{{ $pages := $pages | union (where .Site.RegularPages "Params.pinned" true) }}
{{ $pages := $pages | intersect (where .Site.RegularPages "Params.images" "!=" nil) }}
```

The above fetches regular pages not of `page` or `about` type unless they are pinned. And finally, we exclude all pages with no `images` set in Page parameters.

See [union][] for `OR`.

[union]: /functions/collections/union/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/collections/IsSet.md
---


For example, consider this project configuration:

{{< code-toggle file=hugo >}}
[params]
showHeroImage = false
{{< /code-toggle >}}

If the value of `showHeroImage` is `true`, we can detect that it exists using either `if` or `with`:

```go-html-template
{{ if site.Params.showHeroImage }}
  {{ site.Params.showHeroImage }} → true
{{ end }}

{{ with site.Params.showHeroImage }}
  {{ . }} → true
{{ end }}
```

However, if the value of `showHeroImage` is `false`, we can't use either `if` or `with` to detect its existence. In this case, you must use the `isset` function:

```go-html-template
{{ if isset site.Params "showheroimage" }}
  <p>The showHeroImage parameter is set to {{ site.Params.showHeroImage }}.<p>
{{ end }}
```

> [!NOTE]
> When using the `isset` function you must reference the key using lower case. See the previous example.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/collections/KeyVals.md
---


The primary application for this function is the definition of the `namedSlices` value in the options map passed to the [`Related`][] method on the `Pages` object.

See [related content][].

```go-html-template
{{ $kv := keyVals "foo" "a" "b" "c" }}
```

The resulting data structure is:

```json
{
  "Key": "foo",
  "Values": [
    "a",
    "b",
    "c"
  ]
}
```

To extract the key and values:

```go-html-template
{{ $kv.Key }} → foo
{{ $kv.Values }} → [a b c]
```

[`Related`]: /methods/pages/related/
[related content]: /content-management/related-content/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/collections/Last.md
---


```go-html-template
{{ slice "a" "b" "c" | last 1 }} → [c]
{{ slice "a" "b" "c" | last 2 }} → [b c]
```

Given that a string is in effect a read-only slice of bytes, this function can be used to return the specified number of bytes from the end of the string:

```go-html-template
{{ "abc" | last 1 }} → c
{{ "abc" | last 2 }} → bc
```

Note that a _character_ may consist of multiple _bytes_:

```go-html-template
{{ "Schön" | last 1 }} → n
{{ "Schön" | last 2 }} → \xb6n
{{ "Schön" | last 3 }} → ön
```

To use the `collections.Last` function with a page collection:

```go-html-template
{{ range last 5 .Pages }}
  {{ .Render "summary" }}
{{ end }}
```

Set `N` to zero to return an empty slice:

```go-html-template
{{ $emptyPageCollection := last 0 .Pages }}
```

Use `last` and [`where`][] together:

```go-html-template
{{ range where .Pages "Section" "articles" | last 5 }}
  {{ .Render "summary" }}
{{ end }}
```

[`where`]: /functions/collections/where/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/collections/Merge.md
---


Returns the result of merging two or more maps from left to right. If a key already exists, `merge` updates its value. If a key is absent, `merge` inserts the value under the new key.

Key handling is case-insensitive.

The following examples use these map definitions:

```go-html-template
{{ $m1 := dict "x" "foo" }}
{{ $m2 := dict "x" "bar" "y" "wibble" }}
{{ $m3 := dict "x" "baz" "y" "wobble" "z" (dict "a" "huey") }}
```

Example 1

```go-html-template
{{ $merged := merge $m1 $m2 $m3 }}

{{ $merged.x }}   → baz
{{ $merged.y }}   → wobble
{{ $merged.z.a }} → huey
```

Example 2

```go-html-template
{{ $merged := merge $m3 $m2 $m1 }}

{{ $merged.x }}   → foo
{{ $merged.y }}   → wibble
{{ $merged.z.a }} → huey
```

Example 3

```go-html-template
{{ $merged := merge $m2 $m3 $m1 }}

{{ $merged.x }}   → foo
{{ $merged.y }}   → wobble
{{ $merged.z.a }} → huey
```

Example 4

```go-html-template
{{ $merged := merge $m1 $m3 $m2 }}

{{ $merged.x }}   → bar
{{ $merged.y }}   → wibble
{{ $merged.z.a }} → huey
```

> [!NOTE]
> Regardless of depth, merging only applies to maps. For slices, use the [`collections.Append`][] function.

[`collections.Append`]: /functions/collections/append/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/collections/NewScratch.md
---


Use the `collections.NewScratch` function to create a locally scoped persistent data structure for storing and manipulating keyed values. To create a data structure with a different [scope](g), refer to the [scope](#scope) section below.

## Methods

Use these methods on the data structure.

`Set`
: Sets the value of the given key.

  ```go-html-template
  {{ $s := newScratch }}
  {{ $s.Set "greeting" "Hello" }}
  ```

`Get`
: (`any`) Gets the value of the given key.

  ```go-html-template
  {{ $s := newScratch }}
  {{ $s.Set "greeting" "Hello" }}
  {{ $s.Get "greeting" }} → Hello
  ```

`Add`
: Adds the given value to existing value(s) of the given key.

  For single values, `Add` accepts values that support Go's `+` operator. If the first `Add` for a key is an array or slice, the following adds will be appended to that list.

  ```go-html-template
  {{ $s := newScratch }}
  {{ $s.Set "greeting" "Hello" }}
  {{ $s.Add "greeting" "Welcome" }}
  {{ $s.Get "greeting" }} → HelloWelcome
  ```

  ```go-html-template
  {{ $s := newScratch }}
  {{ $s.Set "total" 3 }}
  {{ $s.Add "total" 7 }}
  {{ $s.Get "total" }} → 10
  ```

  ```go-html-template
  {{ $s := newScratch }}
  {{ $s.Set "greetings" (slice "Hello") }}
  {{ $s.Add "greetings" (slice "Welcome" "Cheers") }}
  {{ $s.Get "greetings" }} → [Hello Welcome Cheers]
  ```

`SetInMap`
: Takes a `key`, `mapKey` and `value` and adds a map of `mapKey` and `value` to the given `key`.

  ```go-html-template
  {{ $s := newScratch }}
  {{ $s.SetInMap "greetings" "english" "Hello" }}
  {{ $s.SetInMap "greetings" "french" "Bonjour" }}
  {{ $s.Get "greetings" }} → map[english:Hello french:Bonjour]
  ```

`DeleteInMap`
: Takes a `key` and `mapKey` and removes the map of `mapKey` from the given `key`.

  ```go-html-template
  {{ $s := newScratch }}
  {{ $s.SetInMap "greetings" "english" "Hello" }}
  {{ $s.SetInMap "greetings" "french" "Bonjour" }}
  {{ $s.DeleteInMap "greetings" "english" }}
  {{ $s.Get "greetings" }} → map[french:Bonjour]
  ```

`GetSortedMapValues`
: (`[]any`) Returns an array of values from `key` sorted by `mapKey`.

  ```go-html-template
  {{ $s := newScratch }}
  {{ $s.SetInMap "greetings" "english" "Hello" }}
  {{ $s.SetInMap "greetings" "french" "Bonjour" }}
  {{ $s.GetSortedMapValues "greetings" }} → [Hello Bonjour]
  ```

`Delete`
: Removes the given key.

  ```go-html-template
  {{ $s := newScratch }}
  {{ $s.Set "greeting" "Hello" }}
  {{ $s.Delete "greeting" }}
  ```

`Values`
: (`map`) Returns the raw backing map. Do not use with `Store` methods on a `Page` object due to concurrency issues.

  ```go-html-template
  {{ $s := newScratch }}
  {{ $s.SetInMap "greetings" "english" "Hello" }}
  {{ $s.SetInMap "greetings" "french" "Bonjour" }}

  {{ $map := $s.Values }}
  ```

{{% include "_common/store-scope.md" %}}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/collections/Querify.md
---


Specify the key-value pairs as a map, a slice, or a sequence of scalar values. For example, the following are equivalent:

```go-html-template
{{ collections.Querify (dict "a" 1 "b" 2) }}
{{ collections.Querify (slice "a" 1 "b" 2) }}
{{ collections.Querify "a" 1 "b" 2 }}
```

To append a query string to a URL:

```go-html-template
{{ $qs := collections.Querify (dict "a" 1 "b" 2) }}
{{ $href := printf "https://example.org?%s" $qs }}

<a href="{{ $href }}">Link</a>
```

Hugo renders this to:

```html
<a href="https://example.org?a=1&amp;b=2">Link</a>
```

You can also pass in a map from your project configuration or front matter. For example:

{{< code-toggle file=content/example.md fm=true >}}
title = 'Example'
[params.query]
a = 1
b = 2
{{< /code-toggle >}}

```go-html-template
{{ collections.Querify .Params.query }}
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/collections/Reverse.md
---


```go-html-template
{{ slice 2 1 3 | collections.Reverse }} → [3 1 2]
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/collections/Seq.md
---


```go-html-template
{{ seq 2 }} → [1 2]
{{ seq 0 2 }} → [0 1 2]
{{ seq -2 2 }} → [-2 -1 0 1 2]
{{ seq -2 2 2 }} → [-2 0 2]
```

A contrived example of iterating over a sequence of integers:

```go-html-template
{{ $product := 1 }}
{{ range seq 4 }}
  {{ $product = mul $product . }}
{{ end }}
{{ $product }} → 24
```

> [!NOTE]
> The slice created by this function is limited to 1 million elements.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/collections/Shuffle.md
---


```go-html-template
{{ collections.Shuffle (slice "a" "b" "c") }} → [b a c]
```

The result will vary from one build to the next.

To render an unordered list of 5 random pages from a page collection:

```go-html-template
<ul>
  {{ $p := site.RegularPages }}
  {{ range $p | collections.Shuffle | first 5 }}
    <li><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></li>
  {{ end }}
</ul>
```

{{< new-in 0.149.0 />}}

Using the [`collections.D`][] function for the same task is significantly faster.

[`collections.D`]: /functions/collections/D/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/collections/Slice.md
---


```go-html-template
{{ $s := slice "a" "b" "c" }}
{{ $s }} → [a b c]
```

To create an empty slice:

```go-html-template
{{ $s := slice }}
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/collections/Sort.md
---


The `KEY` is optional when sorting slices in ascending order, otherwise it is required. When sorting slices, use the literal `value` in place of the `KEY`. See examples below.

The `ORDER` may be either `asc` (ascending) or `desc` (descending). The default sort order is ascending.

## Sort a slice

The examples below assume this project configuration:

{{< code-toggle file=hugo >}}
[params]
grades = ['b','a','c']
{{< /code-toggle >}}

### Ascending order {#slice-ascending-order}

Sort slice elements in ascending order using either of these constructs:

```go-html-template
{{ sort site.Params.grades }} → [a b c]
{{ sort site.Params.grades "value" "asc" }} → [a b c]
```

In the examples above, `value` is the `KEY` representing the value of the slice element.

### Descending order {#slice-descending-order}

Sort slice elements in descending order:

```go-html-template
{{ sort site.Params.grades "value" "desc" }} → [c b a]
```

In the example above, `value` is the `KEY` representing the value of the slice element.

## Sort a map

The examples below assume this project configuration:

{{< code-toggle file=hugo >}}
[params.authors.a]
firstName = 'Marius'
lastName  = 'Pontmercy'
[params.authors.b]
firstName = 'Victor'
lastName  = 'Hugo'
[params.authors.c]
firstName = 'Jean'
lastName  = 'Valjean'
{{< /code-toggle >}}

> [!NOTE]
> When sorting maps, the `KEY` argument must be lowercase.

### Ascending order {#map-ascending-order}

Sort map objects in ascending order using either of these constructs:

```go-html-template
{{ range sort site.Params.authors "firstname" }}
  {{ .firstName }}
{{ end }}

{{ range sort site.Params.authors "firstname" "asc" }}
  {{ .firstName }}
{{ end }}
```

These produce:

```text
Jean Marius Victor
```

### Descending order {#map-descending-order}

Sort map objects in descending order:

```go-html-template
{{ range sort site.Params.authors "firstname" "desc" }}
  {{ .firstName }}
{{ end }}
```

This produces:

```text
Victor Marius Jean
```

### First level key removal

Hugo removes the first level keys when sorting a map.

Original map:

```json
{
  "felix": {
    "breed": "malicious",
    "type": "cat"
  },
  "spot": {
    "breed": "boxer",
    "type": "dog"
  }
}
```

After sorting:

```json
[
  {
    "breed": "malicious",
    "type": "cat"
  },
  {
    "breed": "boxer",
    "type": "dog"
  }
]
```

## Sort a page collection

> [!NOTE]
> Although you can use the `sort` function to sort a page collection, Hugo provides [sorting and grouping methods][] as well.

In this contrived example, sort the site's regular pages by `.Type` in descending order:

```go-html-template
{{ range sort site.RegularPages "Type" "desc" }}
  <h2><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></h2>
{{ end }}
```

[sorting and grouping methods]: /methods/pages/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/collections/SymDiff.md
---


Example:

```go-html-template
{{ slice 1 2 3 | symdiff (slice 3 4) }} → [1 2 4]
```

Also see <https://en.wikipedia.org/wiki/Symmetric_difference>.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/collections/Union.md
---




```go-html-template
{{ union (slice 1 2 3) (slice 3 4 5) }} → [1 2 3 4 5]
{{ union (slice 1 2 3) nil }}           → [1 2 3]
{{ union nil (slice 1 2 3) }}           → [1 2 3]
{{ union nil nil }}                     → []
```

## OR filter in where query

This is also useful as `OR` filters when combined with where:

```go-html-template
{{ $pages := where .Site.RegularPages "Type" "not in" (slice "page" "about") }}
{{ $pages = $pages | union (where .Site.RegularPages "Params.pinned" true) }}
{{ $pages = $pages | intersect (where .Site.RegularPages "Params.images" "!=" nil) }}
```

The above fetches regular pages not of `page` or `about` type unless they are pinned. And finally, we exclude all pages with no `images` set in Page parameters.

See [intersect][] for `AND`.

[intersect]: /functions/collections/intersect/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/collections/Uniq.md
---


```go-html-template
{{ slice 1 3 2 1 | uniq }} → [1 3 2]
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/collections/Where.md
---


The `where` function returns the given slice, removing elements that do not satisfy the comparison condition. The comparison condition is composed of the `KEY`, `OPERATOR`, and `VALUE` arguments:

```text
collections.Where SLICE KEY [OPERATOR] VALUE
                        --------------------
                        comparison condition
```

Hugo will test for equality if you do not provide an `OPERATOR` argument. For example:

```go-html-template
{{ $pages := where .Site.RegularPages "Section" "books" }}
{{ $books := where hugo.Data.books "genres" "suspense" }}
```

## Arguments

The where function takes three or four arguments. The `OPERATOR` argument is optional.

`SLICE`
: (`[]any`) A [page collection](g) or a [slice](g) of [maps](g).

`KEY`
: (`string`) The key of the page or map value to compare with `VALUE`. With page collections, commonly used comparison keys are `Section`, `Type`, and `Params`. To compare with a member of the page `Params` map, [chain](g) the subkey as shown below:

  ```go-html-template
  {{ $result := where .Site.RegularPages "Params.foo" "bar" }}
  ```

`OPERATOR`
: (`string`) The logical comparison [operator](#operators).

`VALUE`
: (`any`) The value with which to compare. The values to compare must have comparable data types. For example:

Comparison|Result
:--|:--
`"123" "eq" "123"`|`true`
`"123" "eq" 123`|`false`
`false "eq" "false"`|`false`
`false "eq" false`|`true`

When one or both of the values to compare is a slice, use the `in`, `not in`, or `intersect` operators as described below.

## Operators

Use any of the following logical operators:

`=`, `==`, `eq`
: (`bool`) Reports whether the given field value is equal to `VALUE`.

`!=`, `<>`, `ne`
: (`bool`) Reports whether the given field value is not equal to `VALUE`.

`>=`, `ge`
: (`bool`) Reports whether the given field value is greater than or equal to `VALUE`.

`>`, `gt`
: `true` Reports whether the given field value is greater than `VALUE`.

`<=`, `le`
: (`bool`) Reports whether the given field value is less than or equal to `VALUE`.

`<`, `lt`
: (`bool`) Reports whether the given field value is less than `VALUE`.

`in`
: (`bool`) Reports whether the given field value is a member of `VALUE`. Compare string to slice, or string to string.

`not in`
: (`bool`) Reports whether the given field value is not a member of `VALUE`. Compare string to slice, or string to string.
`intersect`
: (`bool`) Reports whether the given field value (a slice) contains one or more elements in common with `VALUE`.

`like`
: (`bool`) Reports whether the given field value matches the [regular expression](g) specified in `VALUE`. Use the `like` operator to compare `string` values. The `like` operator returns `false` when comparing other data types to the regular expression.

> [!NOTE]
> The examples below perform comparisons within a page collection, but the same comparisons are applicable to a slice of maps.

## String comparison

Compare the value of the given field to a [`string`](g):

```go-html-template
{{ $pages := where .Site.RegularPages "Section" "eq" "books" }}
{{ $pages := where .Site.RegularPages "Section" "ne" "books" }}
```

## Numeric comparison

Compare the value of the given field to an [`int`](g) or [`float`](g):

```go-html-template
{{ $books := where site.RegularPages "Section" "eq" "books" }}

{{ $pages := where $books "Params.price" "eq" 42 }}
{{ $pages := where $books "Params.price" "ne" 42.67 }}
{{ $pages := where $books "Params.price" "ge" 42 }}
{{ $pages := where $books "Params.price" "gt" 42.67 }}
{{ $pages := where $books "Params.price" "le" 42 }}
{{ $pages := where $books "Params.price" "lt" 42.67 }}
```

## Boolean comparison

Compare the value of the given field to a [`bool`](g):

```go-html-template
{{ $books := where site.RegularPages "Section" "eq" "books" }}

{{ $pages := where $books "Params.fiction" "eq" true }}
{{ $pages := where $books "Params.fiction" "eq" false }}
{{ $pages := where $books "Params.fiction" "ne" true }}
{{ $pages := where $books "Params.fiction" "ne" false }}
```

## Member comparison

Compare a [`scalar`](g) to a [`slice`](g).

For example, to return a slice of pages where the `color` page parameter is either "red" or "yellow":

```go-html-template
{{ $fruit := where site.RegularPages "Section" "eq" "fruit" }}

{{ $colors := slice "red" "yellow" }}
{{ $pages := where $fruit "Params.color" "in" $colors }}
```

To return a slice of pages where the `color` page parameter is neither `red` nor `yellow`:

```go-html-template
{{ $fruit := where site.RegularPages "Section" "eq" "fruit" }}

{{ $colors := slice "red" "yellow" }}
{{ $pages := where $fruit "Params.color" "not in" $colors }}
```

## Intersection comparison

Compare a `slice` to a `slice`, returning elements with common values. This is frequently used when comparing taxonomy terms.

For example, to return a slice of pages where any of the terms in the `genres` taxonomy are "suspense" or "romance":

```go-html-template
{{ $books := where site.RegularPages "Section" "eq" "books" }}

{{ $genres := slice "suspense" "romance" }}
{{ $pages := where $books "Params.genres" "intersect" $genres }}
```

## Regular expression comparison

To return a slice of pages where the `author` page parameter begins with either "victor" or "Victor":

```go-html-template
{{ $pages := where .Site.RegularPages "Params.author" "like" `(?i)^victor` }}
```

{{% include "/_common/functions/regular-expressions.md" %}}

> [!NOTE]
> Use the `like` operator to compare string values. Comparing other data types will result in an empty slice.

## Date comparison

### Predefined dates

There are four predefined front matter dates: [`date`][], [`publishDate`][], [`lastmod`][], and [`expiryDate`][]. Regardless of the front matter data format (TOML, YAML, or JSON) these are [`time.Time`][] values, allowing precise comparisons.

For example, to return a slice of pages that were created before the current year:

```go-html-template
{{ $startOfYear := time.AsTime (printf "%d-01-01" now.Year) }}
{{ $pages := where .Site.RegularPages "Date" "lt" $startOfYear }}
```

### Custom dates

With custom front matter dates, the comparison depends on the front matter data format (TOML, YAML, or JSON).

> [!NOTE]
> Using TOML for pages with custom front matter dates enables precise date comparisons.

With TOML, date values are first-class citizens. TOML has a date data type while JSON and YAML do not. If you quote a TOML date, it is a string. If you do not quote a TOML date value, it is [`time.Time`][] value, enabling precise comparisons.

In the TOML example below, note that the event date is not quoted.

```md {file="content/events/2024-user-conference.md"}
+++
title = '2024 User Conference"
eventDate = 2024-04-01
+++
```

To return a slice of future events:

```go-html-template
{{ $events := where .Site.RegularPages "Type" "events" }}
{{ $futureEvents := where $events "Params.eventDate" "gt" now }}
```

When working with YAML or JSON, or quoted TOML values, custom dates are strings; you cannot compare them with `time.Time` values. String comparisons may be possible if the custom date layout is consistent from one page to the next. To be safe, filter the pages by ranging over the slice:

```go-html-template
{{ $events := where .Site.RegularPages "Type" "events" }}
{{ $futureEvents := slice }}
{{ range $events }}
  {{ if gt (time.AsTime .Params.eventDate) now }}
    {{ $futureEvents = $futureEvents | append . }}
  {{ end }}
{{ end }}
```

## Nil comparison

To return a slice of pages where the "color" parameter is present in front matter, compare to `nil`:

```go-html-template
{{ $pages := where .Site.RegularPages "Params.color" "ne" nil }}
```

To return a slice of pages where the "color" parameter is not present in front matter, compare to `nil`:

```go-html-template
{{ $pages := where .Site.RegularPages "Params.color" "eq" nil }}
```

In both examples above, note that `nil` is not quoted.

## Nested comparison

These are equivalent:

```go-html-template
{{ $pages := where .Site.RegularPages "Type" "tutorials" }}
{{ $pages = where $pages "Params.level" "eq" "beginner" }}
```

```go-html-template
{{ $pages := where (where .Site.RegularPages "Type" "tutorials") "Params.level" "eq" "beginner" }}
```

## Portable section comparison

Useful for theme authors, avoid hardcoding section names by using the `where` function with the [`MainSections`][] method on a `Site` object.

```go-html-template
{{ $pages := where .Site.RegularPages "Section" "in" .Site.MainSections }}
```

With this construct, a theme author can instruct users to specify their main sections in their project configuration:

{{< code-toggle file=hugo >}}
mainSections = ['blog','galleries']
{{< /code-toggle >}}

If `mainSections` is not defined in your project configuration, the `MainSections` method returns a slice with one element---the top-level section with the most pages.

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

