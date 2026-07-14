
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

## Layout string

{{% include "/_common/time-layout-string.md" %}}

## Examples

Given this front matter:

{{< code-toggle fm=true >}}
title = "About time"
date = 2023-01-27T23:44:58-08:00
{{< /code-toggle >}}

The examples below were rendered in the `America/Los_Angeles` time zone:

Format string|Result
:--|:--
`Monday, January 2, 2006`|`Friday, January 27, 2023`
`Mon Jan 2 2006`|`Fri Jan 27 2023`
`January 2006`|`January 2023`
`2006-01-02`|`2023-01-27`
`Monday`|`Friday`
`02 Jan 06 15:04 MST`|`27 Jan 23 23:44 PST`
`Mon, 02 Jan 2006 15:04:05 MST`|`Fri, 27 Jan 2023 23:44:58 PST`
`Mon, 02 Jan 2006 15:04:05 -0700`|`Fri, 27 Jan 2023 23:44:58 -0800`

## UTC and local time

Convert and format any `time.Time` value to either Coordinated Universal Time (UTC) or local time.

```go-html-template
{{ $t := "2023-01-27T23:44:58-08:00" }}
{{ $t = time.AsTime $t }}
{{ $format := "2 Jan 2006 3:04:05 PM MST" }}

{{ $t.UTC.Format $format }} → 28 Jan 2023 7:44:58 AM UTC
{{ $t.Local.Format $format }} → 27 Jan 2023 11:44:58 PM PST
```

## Ordinal representation

Use the [`humanize`][] function to render the day of the month as an ordinal number:

```go-html-template
{{ $t := "2023-01-27T23:44:58-08:00" }}
{{ $t = time.AsTime $t }}

{{ humanize $t.Day }} of {{ $t.Format "January 2006" }} → 27th of January 2023
```

[`humanize`]: /functions/inflect/humanize/
[`time.Format`]: /functions/time/format/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/time/Hour.md
---


```go-html-template
{{ $t := time.AsTime "2023-01-27T23:44:58-08:00" }}
{{ $t.Hour }} → 23
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/time/IsDST.md
---


```go-html-template
{{ $t1 := time.AsTime "2023-01-01T00:00:00-08:00" }}
{{ $t2 := time.AsTime "2023-07-01T00:00:00-07:00" }}

{{ $t1.IsDST }} → false
{{ $t2.IsDST }} → true
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/time/IsZero.md
---


````go-html-template
{{ $t1 := time.AsTime "2023-01-01T00:00:00-08:00" }}
{{ $t2 := time.AsTime "0001-01-01T00:00:00-00:00" }}

{{ $t1.IsZero }} → false
{{ $t2.IsZero }} → true
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/time/Local.md
---


```go-html-template
{{ $t := time.AsTime "2023-01-28T07:44:58+00:00" }}
{{ $t.Local }} → 2023-01-27 23:44:58 -0800 PST
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/time/Minute.md
---


```go-html-template
{{ $t := time.AsTime "2023-01-27T23:44:58-08:00" }}
{{ $t.Minute }} → 44
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/time/Month.md
---


To convert the `time.Month` value to a string:

```go-html-template
{{ $t := time.AsTime "2023-01-27T23:44:58-08:00" }}
{{ $t.Month.String }} → January
```

To convert the `time.Month` value to an integer.

```go-html-template
{{ $t := time.AsTime "2023-01-27T23:44:58-08:00" }}
{{ $t.Month | int }} → 1
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/time/Nanosecond.md
---


```go-html-template
{{ $t := time.AsTime "2023-01-27T23:44:58-08:00" }}
{{ $t.Nanosecond }} → 0
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/time/Round.md
---


The rounding behavior for halfway values is to round up.

The `Round` method operates on TIME as an absolute duration since the [zero time](g); it does not operate on the presentation form of the time. If DURATION is a multiple of one hour, `Round` may return a time with a non-zero minute, depending on the time zone.

```go-html-template
{{ $t := time.AsTime "2023-01-27T23:44:58-08:00" }}
{{ $d := time.ParseDuration "1h" }}

{{ ($t.Round $d).Format "2006-01-02T15:04:05-00:00" }} → 2023-01-28T00:00:00-00:00
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/time/Second.md
---


```go-html-template
{{ $t := time.AsTime "2023-01-27T23:44:58-08:00" }}
{{ $t.Second }} → 58
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/time/Sub.md
---


```go-html-template
{{ $t1 := time.AsTime "2023-01-27T23:44:58-08:00" }}
{{ $t2 := time.AsTime "2023-01-26T22:34:38-08:00" }}

{{ $t1.Sub $t2 }} → 25h10m20s
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/time/Truncate.md
---


The `Truncate` method operates on TIME as an absolute duration since the [zero time](g); it does not operate on the presentation form of the time. If DURATION is a multiple of one hour, `Truncate` may return a time with a non-zero minute, depending on the time zone.

```go-html-template
{{ $t := time.AsTime "2023-01-27T23:44:58-08:00" }}
{{ $d := time.ParseDuration "1h" }}

{{ ($t.Truncate $d).Format "2006-01-02T15:04:05-00:00" }} → 2023-01-27T23:00:00-00:00
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/time/UTC.md
---


```go-html-template
{{ $t := time.AsTime "2023-01-27T23:44:58-08:00" }}
{{ $t.UTC }} → 2023-01-28 07:44:58 +0000 UTC


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/time/Unix.md
---


See [Unix epoch][].

```go-html-template
{{ $t := time.AsTime "2023-01-27T23:44:58-08:00" }}
{{ $t.Unix }} → 1674891898
```

[Unix epoch]: https://en.wikipedia.org/wiki/Unix_time


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/time/UnixMicro.md
---


See [Unix epoch][].

```go-html-template
{{ $t := time.AsTime "2023-01-27T23:44:58-08:00" }}
{{ $t.UnixMicro }} → 1674891898000000
```

[Unix epoch]: https://en.wikipedia.org/wiki/Unix_time


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/time/UnixMilli.md
---


See [Unix epoch][].

```go-html-template
{{ $t := time.AsTime "2023-01-27T23:44:58-08:00" }}
{{ $t.UnixMilli }} → 1674891898000
```

[Unix epoch]: https://en.wikipedia.org/wiki/Unix_time


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/time/UnixNano.md
---


See [Unix epoch][].

```go-html-template
{{ $t := time.AsTime "2023-01-27T23:44:58-08:00" }}
{{ $t.UnixNano }} → 1674891898000000000
```

[Unix epoch]: https://en.wikipedia.org/wiki/Unix_time


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/time/Weekday.md
---


To convert the `time.Weekday` value to a string:

```go-html-template
{{ $t := time.AsTime "2023-01-27T23:44:58-08:00" }}
{{ $t.Weekday.String }} → Friday
```

To convert the `time.Weekday` value to an integer.

```go-html-template
{{ $t := time.AsTime "2023-01-27T23:44:58-08:00" }}
{{ $t.Weekday | int }} → 5


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/time/Year.md
---


```go-html-template
{{ $t := time.AsTime "2023-01-27T23:44:58-08:00" }}
{{ $t.Year }} → 2023
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/time/YearDay.md
---


```go-html-template
{{ $t := time.AsTime "2023-01-27T23:44:58-08:00" }}
{{ $t.YearDay }} → 27
```

