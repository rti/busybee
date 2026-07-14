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

