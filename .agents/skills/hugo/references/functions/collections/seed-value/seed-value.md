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

