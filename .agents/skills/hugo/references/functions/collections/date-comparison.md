## Date comparison

### Predefined dates

There are four predefined front matter dates: [`date`][], [`publishDate`][], [`lastmod`][], and [`expiryDate`][]. Regardless of the front matter data format (TOML, YAML, or JSON) these are [`time.Time`][] values, allowing precise comparisons.

For example, to return a slice of pages that were created before the current year:

```go-html-template
{{ $startOfYear := time.AsTime (printf "%d-01-01" now.Year) }}
{{ $pages := where .Site.RegularPages "Date" "lt" $startOfYear }}
```

### Custom dates

With custom front matter dates, the comparison depends on the front matter data format (TOML, YAML, or JSON).

> [!NOTE]
> Using TOML for pages with custom front matter dates enables precise date comparisons.

With TOML, date values are first-class citizens. TOML has a date data type while JSON and YAML do not. If you quote a TOML date, it is a string. If you do not quote a TOML date value, it is [`time.Time`][] value, enabling precise comparisons.

In the TOML example below, note that the event date is not quoted.

```md {file="content/events/2024-user-conference.md"}
+++
title = '2024 User Conference"
eventDate = 2024-04-01
+++
```

To return a slice of future events:

```go-html-template
{{ $events := where .Site.RegularPages "Type" "events" }}
{{ $futureEvents := where $events "Params.eventDate" "gt" now }}
```

When working with YAML or JSON, or quoted TOML values, custom dates are strings; you cannot compare them with `time.Time` values. String comparisons may be possible if the custom date layout is consistent from one page to the next. To be safe, filter the pages by ranging over the slice:

```go-html-template
{{ $events := where .Site.RegularPages "Type" "events" }}
{{ $futureEvents := slice }}
{{ range $events }}
  {{ if gt (time.AsTime .Params.eventDate) now }}
    {{ $futureEvents = $futureEvents | append . }}
  {{ end }}
{{ end }}
```

