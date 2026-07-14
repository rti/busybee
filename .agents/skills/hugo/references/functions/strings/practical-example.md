## Practical example

This Markdown:

```md
- [Example](https://example.org)
- [Hugo](https://gohugo.io)
```

Produces this HTML:

```html
<ul>
  <li><a href="https://example.org">Example</a></li>
  <li><a href="https://gohugo.io">Hugo</a></li>
</ul>
```

To match the anchor elements, capturing the link destination and text:

```go-html-template
{{ $regex := `<a\s*href="(.+?)">(.+?)</a>` }}
{{ $matches := findRESubmatch $regex .Content }}
```

Viewed as JSON, the data structure of `$matches` in the code above is:

```json
[
  [
    "<a href=\"https://example.org\"></a>Example</a>",
    "https://example.org",
    "Example"
  ],
  [
    "<a href=\"https://gohugo.io\">Hugo</a>",
    "https://gohugo.io",
    "Hugo"
  ]
]
```

To render the `href` attributes:

```go-html-template
{{ range $matches }}
  {{ index . 1 }}
{{ end }}
```

Result:

```text
https://example.org
https://gohugo.io
```

> [!NOTE]
> You can write and test your regular expression using [regex101.com][]. Be sure to select the Go flavor before you begin.

[regex101.com]: https://regex101.com/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/strings/FindRe.md
---

By default, `findRE` finds all matches. You can limit the number of matches with an optional LIMIT argument.

{{% include "/_common/functions/regular-expressions.md" %}}

This example returns a slice of all second level headings (`h2` elements) within the rendered `.Content`:

```go-html-template
{{ findRE `(?s)<h2.*?>.*?</h2>` .Content }}
```

The `s` flag causes `.` to match `\n` as well, allowing us to find an `h2` element that contains newlines.

To limit the number of matches to one:

```go-html-template
{{ findRE `(?s)<h2.*?>.*?</h2>` .Content 1 }}
```

> [!NOTE]
> You can write and test your regular expression using [regex101.com][]. Be sure to select the Go flavor before you begin.

[regex101.com]: https://regex101.com/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/strings/FirstUpper.md
---


```go-html-template
{{ strings.FirstUpper "foo" }} → Foo
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/strings/HasPrefix.md
---


```go-html-template
{{ hasPrefix "Hugo" "Hu" }} → true
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/strings/HasSuffix.md
---


```go-html-template
{{ hasSuffix "Hugo" "go" }} → true
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/strings/Repeat.md
---


```go-html-template
{{ strings.Repeat 3 "yo" }} → yoyoyo
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/strings/Replace.md
---


```go-html-template
{{ $s := "Batman and Robin" }}
{{ replace $s "Robin" "Catwoman" }} → Batman and Catwoman
```

Limit the number of replacements using the `LIMIT` argument:

```go-html-template
{{ replace "aabbaabb" "a" "z" 2 }} → zzbbaabb
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/strings/ReplacePairs.md
---


{{< new-in 0.158.0 />}}

Use the `strings.ReplacePairs` function to perform multiple replacements on a string in a single operation. This approach is faster than sequentially calling the [`strings.Replace`][] function.

Replacing strings sequentially requires multiple function calls and variable re-assignments.

```go-html-template
{{ $s := "aabbcc" }}
{{ $s = strings.Replace $s "a" "x" }}
{{ $s = strings.Replace $s "b" "y" }}
{{ $s = strings.Replace $s "c" "z" }}
{{ $s }} → xxyyzz
```

Using `strings.ReplacePairs` produces the same result with fewer function calls in less time.

```go-html-template
{{ "aabbcc" | strings.ReplacePairs "a" "x" "b" "y" "c" "z" }} → xxyyzz
```

Pairs may also be passed as a single slice:

```go-html-template
{{ $pairs := slice
  "a" "x"
  "b" "y"
  "c" "z"
}}
{{ "aabbcc" | strings.ReplacePairs $pairs }} → xxyyzz
```

