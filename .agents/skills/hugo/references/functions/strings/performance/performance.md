## Performance

While `strings.Replace` and `strings.ReplacePairs` can produce the same results, they handle data differently. Choosing the right one can noticeably reduce the time Hugo takes to build your project.

### Single pass vs. multiple passes

When using `strings.Replace`, Hugo must scan the text from start to finish to find a match. If you chain three replacements together, Hugo performs three separate passes over the entire string.

The `strings.ReplacePairs` function is more efficient because it performs a single pass. Hugo looks through the text once and applies all replacements simultaneously.

### Caching

Unlike `strings.Replace`, which performs a direct substitution, `strings.ReplacePairs` requires an initialization step to prepare the single-pass replacement logic. To make this efficient, Hugo manages this logic using a cache:

- During the initial call, Hugo initializes and stores the logic for that specific set of pairs.
- During subsequent calls, Hugo retrieves the stored logic, skipping the initialization step and reducing the duration of the call.

### Choosing the right function

The efficiency of `strings.ReplacePairs` increases as the text gets longer or the number of pairs grows. Consider these scenarios when deciding which function to use:

- For a single replacement on a short string like a title, `strings.Replace` is efficient.
- For multiple replacements or long strings like a long-form article, `strings.ReplacePairs` is much faster.

For a document with about 8000 characters, which is roughly the length of a long-form article, `strings.ReplacePairs` outperforms five sequential `strings.Replace` calls during the initial call. Once cached, it is the faster choice for almost any situation with two or more pairs.

[`strings.Replace`]: /functions/strings/replace/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/strings/ReplaceRE.md
---


{{% include "/_common/functions/regular-expressions.md" %}}

```go-html-template
{{ $s := "a-b--c---d" }}
{{ replaceRE `(-{2,})` "-" $s }} → a-b-c-d
```

Limit the number of replacements using the LIMIT argument:

```go-html-template
{{ $s := "a-b--c---d" }}
{{ replaceRE `(-{2,})` "-" $s 1 }} → a-b-c---d
```

Use `$1`, `$2`, etc. within the replacement string to insert the content of each capturing group within the regular expression:

```go-html-template
{{ $s := "http://gohugo.io/docs" }}
{{ replaceRE "^https?://([^/]+).*" "$1" $s }} → gohugo.io
```

> [!NOTE]
> You can write and test your regular expression using [regex101.com][]. Be sure to select the Go flavor before you begin.

[regex101.com]: https://regex101.com/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/strings/RuneCount.md
---


In contrast with the [`strings.CountRunes`][] function, which excludes whitespace, `strings.RuneCount` counts every rune in a string.

```go-html-template
{{ "Hello, 世界" | strings.RuneCount }} → 9
```

[`strings.CountRunes`]: /functions/strings/countrunes/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/strings/SliceString.md
---


The START and END positions are zero-based, where `0` represents the first character of the string. If START is not specified, the substring will begin at position `0`. If END is not specified, the substring will end after the last character.

```go-html-template
{{ slicestr "BatMan" }} → BatMan
{{ slicestr "BatMan" 3 }} → Man
{{ slicestr "BatMan" 0 3 }} → Bat
```

The START and END arguments represent the endpoints of a half-open [interval](g), a concept that may be difficult to grasp when first encountered. You may find that the [`strings.Substr`][] function is easier to understand.

[`strings.Substr`]: /functions/strings/substr/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/strings/Split.md
---


Examples:

```go-html-template
{{ split "tag1,tag2,tag3" "," }} → ["tag1", "tag2", "tag3"]
{{ split "abc" "" }} → ["a", "b", "c"]
```

> [!NOTE]
> The `strings.Split` function essentially does the opposite of the [`collections.Delimit`][] function. While `split` creates a slice from a string, `delimit` creates a string from a slice.

[`collections.Delimit`]: /functions/collections/delimit/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/strings/Substr.md
---


The start position is zero-based, where `0` represents the first character of the string. If START is not specified, the substring will begin at position `0`. Specify a negative START position to extract characters from the end of the string.

If LENGTH is not specified, the substring will include all characters from the START position to the end of the string. If negative, that number of characters will be omitted from the end of string.

```go-html-template
{{ substr "abcdef" 0 }} → abcdef
{{ substr "abcdef" 1 }} → bcdef

{{ substr "abcdef" 0 1 }} → a
{{ substr "abcdef" 1 1 }} → b

{{ substr "abcdef" 0 -1 }} → abcde
{{ substr "abcdef" 1 -1 }} → bcde

{{ substr "abcdef" -1 }} → f
{{ substr "abcdef" -2 }} → ef

{{ substr "abcdef" -1 1 }} → f
{{ substr "abcdef" -2 1 }} → e

{{ substr "abcdef" -3 -1 }} → de
{{ substr "abcdef" -3 -2 }} → d
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/strings/Title.md
---


```go-html-template
{{ title "table of contents (TOC)" }} → Table of Contents (TOC)
```

By default, Hugo follows the capitalization rules published in the [Associated Press Stylebook][]. Change your [project configuration][] if you would prefer to:

- Follow the capitalization rules published in the [Chicago Manual of Style][]
- Capitalize the first letter of every word
- Capitalize the first letter of the first word
- Disable the effects of the `title` function

The last option is useful if your theme uses the `title` function, and you would prefer to manually capitalize strings as needed.

[Associated Press Stylebook]: https://www.apstylebook.com/
[Chicago Manual of Style]: https://www.chicagomanualofstyle.org/home.html
[project configuration]: /configuration/all/#title-case-style


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/strings/ToLower.md
---


```go-html-template
{{ lower "BatMan" }} → batman
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/strings/ToUpper.md
---


```go-html-template
{{ upper "BatMan" }} → BATMAN
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/strings/Trim.md
---


```go-html-template
{{ trim "++foo--" "+-" }} → foo
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/strings/TrimLeft.md
---


```go-html-template
{{ strings.TrimLeft "a" "abba" }} → bba
```

The `strings.TrimLeft` function converts the arguments to strings if possible:

```go-html-template
{{ strings.TrimLeft 21 12345 }} → 345 (string)
{{ strings.TrimLeft "rt" true }} → ue
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/strings/TrimPrefix.md
---


```go-html-template
{{ strings.TrimPrefix "a" "aabbaa" }} → abbaa
{{ strings.TrimPrefix "aa" "aabbaa" }} → bbaa
{{ strings.TrimPrefix "aaa" "aabbaa" }} → aabbaa
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/strings/TrimRight.md
---


```go-html-template
{{ strings.TrimRight "a" "abba" }} → abb
```

The `strings.TrimRight` function converts the arguments to strings if possible:

```go-html-template
{{ strings.TrimRight 54 12345 }} → 123 (string)
{{ strings.TrimRight "eu" true }} → tr
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/strings/TrimSpace.md
---


{{< new-in 0.136.3 />}}

Whitespace characters include `\t`, `\n`, `\v`, `\f`, `\r`, and characters in the [Unicode Space Separator][] category.

```go-html-template
{{ strings.TrimSpace "\n\r\t   foo   \n\r\t" }} → foo
```

[Unicode Space Separator]: https://www.compart.com/en/unicode/category/Zs


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/strings/TrimSuffix.md
---


```go-html-template
{{ strings.TrimSuffix "a" "aabbaa" }} → aabba
{{ strings.TrimSuffix "aa" "aabbaa" }} → aabb
{{ strings.TrimSuffix "aaa" "aabbaa" }} → aabbaa
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/strings/Truncate.md
---


Since Go templates are HTML-aware, `truncate` will intelligently handle normal strings vs HTML strings:

```go-html-template
{{ "<em>Keep my HTML</em>" | safeHTML | truncate 10 }} → <em>Keep my …</em>
```

> [!NOTE]
> If you have a raw string that contains HTML tags you want to remain treated as HTML, you will need to convert the string to HTML using the [`safe.HTML`][] function before sending the value to `truncate`. Otherwise, the HTML tags will be escaped when passed through the `truncate` function.

[`safe.HTML`]: /functions/safe/html/

