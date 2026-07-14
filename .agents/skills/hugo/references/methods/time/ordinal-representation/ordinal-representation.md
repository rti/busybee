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

