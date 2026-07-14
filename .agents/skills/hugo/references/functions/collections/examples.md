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

