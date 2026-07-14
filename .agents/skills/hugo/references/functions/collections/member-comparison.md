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

