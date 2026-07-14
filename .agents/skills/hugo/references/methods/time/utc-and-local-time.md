## UTC and local time

Convert and format any `time.Time` value to either Coordinated Universal Time (UTC) or local time.

```go-html-template
{{ $t := "2023-01-27T23:44:58-08:00" }}
{{ $t = time.AsTime $t }}
{{ $format := "2 Jan 2006 3:04:05 PM MST" }}

{{ $t.UTC.Format $format }} → 28 Jan 2023 7:44:58 AM UTC
{{ $t.Local.Format $format }} → 27 Jan 2023 11:44:58 PM PST
```

