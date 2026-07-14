
---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/duration/Abs.md
---


```go-html-template
{{ $d = time.ParseDuration "-3h" }}
{{ $d.Abs }} → 3h0m0s
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/duration/Hours.md
---


```go-html-template
{{ $d = time.ParseDuration "3.5h2.5m1.5s" }}
{{ $d.Hours }} → 3.5420833333333333
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/duration/Microseconds.md
---


```go-html-template
{{ $d = time.ParseDuration "3.5h2.5m1.5s" }}
{{ $d.Microseconds }} → 12751500000
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/duration/Milliseconds.md
---


```go-html-template
{{ $d = time.ParseDuration "3.5h2.5m1.5s" }}
{{ $d.Milliseconds }} → 12751500
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/duration/Minutes.md
---


```go-html-template
{{ $d = time.ParseDuration "3.5h2.5m1.5s" }}
{{ $d.Minutes }} → 212.525
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/duration/Nanoseconds.md
---


```go-html-template
{{ $d = time.ParseDuration "3.5h2.5m1.5s" }}
{{ $d.Nanoseconds }} → 12751500000000
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/duration/Round.md
---


```go-html-template
{{ $d = time.ParseDuration "3.5h2.5m1.5s" }}

{{ $d.Round (time.ParseDuration "2h") }} → 4h0m0s
{{ $d.Round (time.ParseDuration "3m") }} → 3h33m0s
{{ $d.Round (time.ParseDuration "4s") }} → 3h32m32s
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/duration/Seconds.md
---


```go-html-template
{{ $d = time.ParseDuration "3.5h2.5m1.5s" }}
{{ $d.Seconds }} → 12751.5
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/duration/Truncate.md
---


```go-html-template
{{ $d = time.ParseDuration "3.5h2.5m1.5s" }}

{{ $d.Truncate (time.ParseDuration "2h") }} → 2h0m0s
{{ $d.Truncate (time.ParseDuration "3m") }} → 3h30m0s
{{ $d.Truncate (time.ParseDuration "4s") }} → 3h32m28s
```

