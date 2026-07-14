## Explanation

By way of example, let's divide a number by zero:

```go-html-template
{{ $x := 1 }}
{{ $y := 0 }}
{{ $result := div $x $y }}
{{ printf "%v divided by %v equals %v" $x $y .Value }}
```

As expected, the example above throws an error and fails the build:

```terminfo
Error: error calling div: can't divide the value by 0
```

Instead of failing the build, we can catch the error and emit a warning:

```go-html-template
{{ $x := 1 }}
{{ $y := 0 }}
{{ with try (div $x $y) }}
  {{ with .Err }}
    {{ warnf "%s" . }}
  {{ else }}
    {{ printf "%v divided by %v equals %v" $x $y .Value }}
  {{ end }}
{{ end }}
```

The error thrown by the expression is logged to the console as a warning:

```terminfo
WARN error calling div: can't divide the value by 0
```

Now let's change the arguments to avoid dividing by zero:

```go-html-template
{{ $x := 42 }}
{{ $y := 6 }}
{{ with try (div $x $y) }}
  {{ with .Err }}
    {{ warnf "%s" . }}
  {{ else }}
    {{ printf "%v divided by %v equals %v" $x $y .Value }}
  {{ end }}
{{ end }}
```

Hugo renders the above to:

```html
42 divided by 6 equals 7
```

