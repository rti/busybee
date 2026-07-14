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

