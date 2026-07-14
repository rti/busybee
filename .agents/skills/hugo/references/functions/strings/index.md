# strings


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/strings/Chomp.md
---


If the argument is of type `template.HTML`, returns `template.HTML`, else returns a `string`.

```go-html-template
{{ chomp "foo\n" }} → foo
{{ chomp "foo\n\n" }} → foo

{{ chomp "foo\r\n" }} → foo
{{ chomp "foo\r\n\r\n" }} → foo
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/strings/Contains.md
---


```go-html-template
{{ strings.Contains "Hugo" "go" }} → true
```

The check is case sensitive:

```go-html-template
{{ strings.Contains "Hugo" "Go" }} → false
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/strings/ContainsAny.md
---


```go-html-template
{{ strings.ContainsAny "Hugo" "gm" }} → true
```

The check is case sensitive:

```go-html-template
{{ strings.ContainsAny "Hugo" "Gm" }} → false
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/strings/ContainsNonSpace.md
---


Whitespace characters include `\t`, `\n`, `\v`, `\f`, `\r`, and characters in the [Unicode Space Separator][] category.

```go-html-template
{{ strings.ContainsNonSpace "\n" }} → false
{{ strings.ContainsNonSpace " " }} → false
{{ strings.ContainsNonSpace "\n abc" }} → true
```

[Unicode Space Separator]: https://www.compart.com/en/unicode/category/Zs


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/strings/Count.md
---


If `SUBSTR` is an empty string, this function returns 1 plus the number of Unicode code points in `STRING`.

```go-html-template
{{ "aaabaab" | strings.Count "a" }} → 5
{{ "aaabaab" | strings.Count "aa" }} → 2
{{ "aaabaab" | strings.Count "aaa" }} → 1
{{ "aaabaab" | strings.Count "" }} → 8
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/strings/CountRunes.md
---


In contrast with the [`strings.RuneCount`][] function, which counts every rune in a string, `strings.CountRunes` excludes whitespace.

```go-html-template
{{ "Hello, 世界" | strings.CountRunes }} → 8
```

[`strings.RuneCount`]: /functions/strings/runecount/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/strings/CountWords.md
---


```go-html-template
{{ "Hugo is a static site generator." | countwords }} → 6
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/strings/FindRESubmatch.md
---


By default, `findRESubmatch` finds all matches. You can limit the number of matches with an optional LIMIT argument. A return value of nil indicates no match.

{{% include "/_common/functions/regular-expressions.md" %}}


## Sections

- [`demonstrative-examples`](references/functions/strings/demonstrative-examples.md) — Demonstrative Examples
- [`practical-example`](references/functions/strings/practical-example.md) — Practical Example
- [`examples`](references/functions/strings/examples.md) — Examples
- [`edge-cases`](references/functions/strings/edge-cases.md) — Edge Cases
- [`performance`](references/functions/strings/performance.md) — Performance

