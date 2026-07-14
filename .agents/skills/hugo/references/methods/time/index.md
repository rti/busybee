# time


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/time/Add.md
---


```go-html-template
{{ $t := time.AsTime "2023-01-27T23:44:58-08:00" }}

{{ $d1 = time.ParseDuration "3h20m10s" }}
{{ $d2 = time.ParseDuration "-3h20m10s" }}

{{ $t.Add $d1 }} → 2023-01-28 03:05:08 -0800 PST
{{ $t.Add $d2 }} → 2023-01-27 20:24:48 -0800 PST
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/time/AddDate.md
---


```go-html-template
{{ $d := "2022-01-01" | time.AsTime }}

{{ $d.AddDate 0 0 1 | time.Format "2006-01-02" }} → 2022-01-02
{{ $d.AddDate 0 1 1 | time.Format "2006-01-02" }} → 2022-02-02
{{ $d.AddDate 1 1 1 | time.Format "2006-01-02" }} → 2023-02-02

{{ $d.AddDate -1 -1 -1 | time.Format "2006-01-02" }} → 2020-11-30
```

> [!NOTE]
> When adding months or years, Hugo normalizes the final `time.Time` value if the resulting day does not exist. For example, adding one month to 31 January produces 2 March or 3 March, depending on the year.
>
> See [this explanation][] from the Go team.

```go-html-template
{{ $d := "2023-01-31" | time.AsTime }}
{{ $d.AddDate 0 1 0 | time.Format "2006-01-02" }} → 2023-03-03

{{ $d := "2024-01-31" | time.AsTime }}
{{ $d.AddDate 0 1 0 | time.Format "2006-01-02" }} → 2024-03-02

{{ $d := "2024-02-29" | time.AsTime }}
{{ $d.AddDate 1 0 0 | time.Format "2006-01-02" }} → 2025-03-01
```

[this explanation]: https://github.com/golang/go/issues/31145#issuecomment-479067967


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/time/After.md
---


```go-html-template
{{ $t1 := time.AsTime "2023-01-01T17:00:00-08:00" }}
{{ $t2 := time.AsTime "2010-01-01T17:00:00-08:00" }}

{{ $t1.After $t2 }} → true
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/time/Before.md
---


```go-html-template
{{ $t1 := time.AsTime "2023-01-01T17:00:00-08:00" }}
{{ $t2 := time.AsTime "2030-01-01T17:00:00-08:00" }}

{{ $t1.Before $t2 }} → true


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/time/Day.md
---


```go-html-template
{{ $t := time.AsTime "2023-01-27T23:44:58-08:00" }}
{{ $t.Day }} → 27
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/time/Equal.md
---


```go-html-template
{{ $t1 := time.AsTime "2023-01-01T17:00:00-08:00" }}
{{ $t2 := time.AsTime "2023-01-01T20:00:00-05:00" }}

{{ $t1.Equal $t2 }} → true
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/time/Format.md
---


```go-template
{{ $t := "2023-01-27T23:44:58-08:00" }}
{{ $t = time.AsTime $t }}
{{ $format := "2 Jan 2006" }}

{{ $t.Format $format }} → 27 Jan 2023
```

> [!NOTE]
> To [localize](g) the return value, use the [`time.Format`][] function instead.

Use the `Format` method with any `time.Time` value, including the four predefined front matter dates:

```go-html-template
{{ $format := "2 Jan 2006" }}

{{ .Date.Format $format }}
{{ .PublishDate.Format $format }}
{{ .ExpiryDate.Format $format }}
{{ .Lastmod.Format $format }}
```

> [!NOTE]
> Use the [`time.Format`][] function to format string representations of dates, and to format raw TOML dates that exclude time and time zone offset.


## Sections

- [`layout-string`](references/methods/time/layout-string.md) — Layout String
- [`examples`](references/methods/time/examples.md) — Examples
- [`utc-and-local-time`](references/methods/time/utc-and-local-time.md) — UTC And Local Time
- [`ordinal-representation`](references/methods/time/ordinal-representation.md) — Ordinal Representation

