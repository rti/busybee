
---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/time/AsTime.md
---


## Overview

Hugo provides [functions][] and [methods][] to format, localize, parse, compare, and manipulate date/time values. Before you can do any of these with string representations of date/time values, you must first convert them to [`time.Time`][] values using the `time.AsTime` function.

```go-html-template
{{ $t := "2023-10-15T13:18:50-07:00" }}
{{ time.AsTime $t }} → 2023-10-15 13:18:50 -0700 PDT (time.Time)
```

## Parsable strings

As shown above, the first argument must be a parsable string representation of a date/time value. For example:

{{% include "/_common/parsable-date-time-strings.md" %}}

To override the default time zone, set the [`timeZone`][] in your project configuration or provide a second argument to the `time.AsTime` function. For example:

```go-html-template
{{ time.AsTime "15 Oct 2023" "America/Los_Angeles" }}
```

The list of valid time zones may be system dependent, but should include `UTC`, `Local`, or any location in the [IANA Time Zone database][].

The order of precedence for determining the time zone is:

1. The time zone offset in the date/time string
1. The time zone provided as the second argument to the `time.AsTime` function
1. The time zone specified in your project configuration
1. The `Etc/UTC` time zone

[IANA Time Zone database]: https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
[`time.Time`]: https://pkg.go.dev/time#Time
[`timeZone`]: /configuration/all/#timezone
[functions]: /functions/time/
[methods]: /methods/time/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/time/Duration.md
---


The `time.Duration` function returns a [`time.Duration`][] value that you can use with any of the `Duration` [methods][].

This template:

```go-html-template
{{ $duration := time.Duration "hour" 24 }}
{{ printf "There are %.0f seconds in one day." $duration.Seconds }}
```

Is rendered to:

```text
There are 86400 seconds in one day.
```

The time unit must be one of the following:

Duration|Valid time units
:--|:--
hours|`hour`, `h`
minutes|`minute`, `m`
seconds|`second`, `s`
milliseconds|`millisecond`, `ms`
microseconds|`microsecond`, `us`, `µs`
nanoseconds|`nanosecond`, `ns`

[`time.Duration`]: https://pkg.go.dev/time#Duration
[methods]: /methods/duration/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/time/Format.md
---


Use the `time.Format` function with `time.Time` values:

```go-html-template
{{ $t := time.AsTime "2023-10-15T13:18:50-07:00" }}
{{ time.Format "2 Jan 2006" $t }} → 15 Oct 2023
```

Or use `time.Format` with a parsable string representation of a date/time value:

```go-html-template
{{ $t := "15 Oct 2023" }}
{{ time.Format "January 2, 2006" $t }} → October 15, 2023
```

Examples of parsable string representations:

{{% include "/_common/parsable-date-time-strings.md" %}}

To override the default time zone, set the [`timeZone`][] in your project configuration. The order of precedence for determining the time zone is:

1. The time zone offset in the date/time string
1. The time zone specified in your project configuration
1. The `Etc/UTC` time zone

## Layout string

{{% include "/_common/time-layout-string.md" %}}

## Localization

Use the `time.Format` function to localize `time.Time` values for the current language and region.

{{% include "/_common/functions/locales.md" %}}

Use the layout string as described above, or one of the tokens below. For example:

```go-html-template
{{ .Date | time.Format ":date_medium" }} → Jan 27, 2023
```

Localized to en-US:

Token|Result
:--|:--
`:date_full`|`Friday, January 27, 2023`
`:date_long`|`January 27, 2023`
`:date_medium`|`Jan 27, 2023`
`:date_short`|`1/27/23`
`:time_full`|`11:44:58 pm Pacific Standard Time`
`:time_long`|`11:44:58 pm PST`
`:time_medium`|`11:44:58 pm`
`:time_short`|`11:44 pm`

Localized to de-DE:

Token|Result
:--|:--
`:date_full`|`Freitag, 27. Januar 2023`
`:date_long`|`27. Januar 2023`
`:date_medium`|`27.01.2023`
`:date_short`|`27.01.23`
`:time_full`|`23:44:58 Nordamerikanische Westküsten-Normalzeit`
`:time_long`|`23:44:58 PST`
`:time_medium`|`23:44:58`
`:time_short`|`23:44`

[`timeZone`]: /configuration/all/#timezone


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/time/In.md
---


{{< new-in 0.146.0 />}}

The `time.In` function returns the given date/time as represented in the specified [IANA](g) time zone.

- If the time zone is an empty string or `UTC`, the time is returned in [UTC](g).
- If the time zone is `Local`, the time is returned in the system's local time zone.
- Otherwise, the time zone must be a valid IANA [time zone name][].

```go-html-template
{{ $layout := "2006-01-02T15:04:05-07:00" }}
{{ $t := time.AsTime "2025-03-31T14:45:00-00:00" }}

{{ $t | time.In "America/Denver" | time.Format $layout }}     → 2025-03-31T08:45:00-06:00
{{ $t | time.In "Australia/Adelaide" | time.Format $layout }} → 2025-04-01T01:15:00+10:30
{{ $t | time.In "Europe/Oslo" | time.Format $layout }}        → 2025-03-31T16:45:00+02:00
```

[time zone name]: https://en.wikipedia.org/wiki/List_of_tz_database_time_zones#List


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/time/Now.md
---


For example, when building a site on October 15, 2023 in the America/Los_Angeles time zone:

```go-html-template
{{ time.Now }}
```

This produces a `time.Time` value, with a string representation such as:

```text
2023-10-15 12:59:28.337140706 -0700 PDT m=+0.041752605
```

To format and [localize](g) the value, pass it through the [`time.Format`][] function:

```go-html-template
{{ time.Now | time.Format "Jan 2006" }} → Oct 2023
```

The `time.Now` function returns a `time.Time` value, so you can chain any of the [time methods][] to the resulting value. For example:

```go-html-template
{{ time.Now.Year }} → 2023 (int)
{{ time.Now.Weekday.String }} → Sunday
{{ time.Now.Month.String }} → October
{{ time.Now.Unix }} → 1697400955 (int64)
```

[`time.Format`]: /functions/time/format/
[time methods]: /methods/time/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/time/ParseDuration.md
---


The `time.ParseDuration` function returns a [`time.Duration`][] value that you can use with any of the `Duration` [methods][].

A duration string is a possibly signed sequence of decimal numbers, each with optional fraction and a unit suffix, such as `300ms`, `-1.5h` or `2h45m`. Valid time units are `ns`, `us` (or `µs`), `ms`, `s`, `m`, `h`.

This template:

```go-html-template
{{ $duration := time.ParseDuration "24h" }}
{{ printf "There are %.0f seconds in one day." $duration.Seconds }}
```

Is rendered to:

```text
There are 86400 seconds in one day.
```

[`time.Duration`]: https://pkg.go.dev/time#Duration
[methods]: /methods/duration/

