## Overview

Hugo provides [functions][] and [methods][] to format, localize, parse, compare, and manipulate date/time values. Before you can do any of these with string representations of date/time values, you must first convert them to [`time.Time`][] values using the `time.AsTime` function.

```go-html-template
{{ $t := "2023-10-15T13:18:50-07:00" }}
{{ time.AsTime $t }} → 2023-10-15 13:18:50 -0700 PDT (time.Time)
```

