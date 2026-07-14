
---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/debug/Dump.md
---


```go-html-template
<pre>{{ debug.Dump hugo.Data.books }}</pre>
```

```json
[
  {
    "author": "Victor Hugo",
    "rating": 4,
    "title": "The Hunchback of Notre Dame"
  },
  {
    "author": "Victor Hugo",
    "rating": 5,
    "title": "Les Misérables"
  }
]
```

> [!NOTE]
> Output from this function may change from one release to the next. Use for debugging only.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/debug/Timer.md
---


Use the `debug.Timer` function to determine execution time for a block of code, useful for finding performance bottlenecks in templates.

The timer starts when you instantiate it, and stops when you call its `Stop` method.

```go-html-template
{{ $t := debug.Timer "TestSqrt" }}
{{ range 2000 }}
  {{ $f := math.Sqrt . }}
{{ end }}
{{ $t.Stop }}
```

Use the `--logLevel info` command line flag when you build the site.

```sh
hugo build --logLevel info
```

The results are displayed in the console at the end of the build. You can have as many timers as you want and if you don't stop them, they will be stopped at the end of build.

```text
INFO  timer:  name TestSqrt count 1002 duration 2.496017496s average 2.491035ms median 2.282291ms
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/debug/VisualizeSpaces.md
---


```go-html-template
{{ debug.VisualizeSpaces "foo  bar" }} → foo[SPACE][SPACE]bar
```

