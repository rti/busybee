
---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/math/Abs.md
---


```go-html-template
{{ math.Abs -2.1 }} → 2.1
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/math/Acos.md
---


```go-html-template
{{ math.Acos 1 }} → 0
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/math/Add.md
---


If one of the numbers is a [`float`](g), the result is a `float`.

```go-html-template
{{ add 12 3 2 }} → 17
```

You can also use the `add` function to concatenate strings.

```go-html-template
{{ add "hu" "go" }} → hugo
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/math/Asin.md
---


```go-html-template
{{ math.Asin 1 }} → 1.5707963267948966
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/math/Atan.md
---


```go-html-template
{{ math.Atan 1 }} → 0.7853981633974483
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/math/Atan2.md
---


```go-html-template
{{ math.Atan2 1 2 }} → 0.4636476090008061
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/math/Ceil.md
---


```go-html-template
{{ math.Ceil 2.1 }} → 3
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/math/Cos.md
---


```go-html-template
{{ math.Cos 1 }} → 0.5403023058681398
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/math/Counter.md
---


The counter is global for both monolingual and multilingual projects, and its initial value for each build is&nbsp;1.

```go-html-template {file="layouts/page.html"}
{{ warnf "page.html called %d times" math.Counter }}
```

```text
WARN  page.html called 1 times
WARN  page.html called 2 times
WARN  page.html called 3 times
```

Use this function to:

- Create unique warnings as shown above; the [`warnf`][] function suppresses duplicate messages
- Create unique target paths for the `resources.FromString` function where the target path is also the cache key

> [!NOTE]
> Due to concurrency, the value returned in a given template for a given page will vary from one build to the next. You cannot use this function to assign a static id to each page.

[`warnf`]: /functions/fmt/warnf/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/math/Div.md
---


If one of the numbers is a [`float`](g), the result is a `float`.

```go-html-template
{{ div 12 3 2 }} → 2
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/math/Floor.md
---


```go-html-template
{{ math.Floor 1.9 }} → 1
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/math/Log.md
---


```go-html-template
{{ math.Log 42 }} → 3.737
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/math/Max.md
---


```go-html-template
{{ math.Max 1 (slice 2 3) 4 }} → 4
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/math/MaxInt64.md
---


{{< new-in 0.147.3 />}}

```go-html-template
{{ math.MaxInt64 }} → 9223372036854775807
```

This function is helpful for simulating a loop that continues indefinitely until a break condition is met. For example:

```go-html-template
{{ range math.MaxInt64 }}
  {{ if eq . 42 }}
    {{ break }}
  {{ end }}
{{ end }}
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/math/Min.md
---


```go-html-template
{{ math.Min 1 (slice 2 3) 4 }} → 1
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/math/Mod.md
---


```go-html-template
{{ mod 15 3 }} → 0
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/math/ModBool.md
---


```go-html-template
{{ modBool 15 3 }} → true
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/math/Mul.md
---


If one of the numbers is a [`float`](g), the result is a `float`.

```go-html-template
{{ mul 12 3 2 }} → 72
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/math/Pi.md
---


```go-html-template
{{ math.Pi }} → 3.141592653589793
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/math/Pow.md
---


```go-html-template
{{ math.Pow 2 3 }} → 8
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/math/Product.md
---


```go-html-template
{{ math.Product 1 (slice 2 3) 4 }} → 24
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/math/Rand.md
---


The `math.Rand` function returns a pseudo-random number in the half-open [interval](g) [0.0, 1.0).

```go-html-template
{{ math.Rand }} → 0.6312770459590062
```

To generate a random integer in the closed interval [0, 5]:

```go-html-template
{{ math.Rand | mul 6 | math.Floor }}
```

To generate a random integer in the closed interval [1, 6]:

```go-html-template
{{ math.Rand | mul 6 | math.Ceil }}
```

To generate a random float, with one digit after the decimal point, in the closed interval [0, 4.9]:

```go-html-template
{{ div (math.Rand | mul 50 | math.Floor) 10 }}
```

To generate a random float, with one digit after the decimal point, in the closed interval [0.1, 5.0]:

```go-html-template
{{ div (math.Rand | mul 50 | math.Ceil) 10 }}
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/math/Round.md
---


```go-html-template
{{ math.Round 1.5 }} → 2
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/math/Sin.md
---


```go-html-template
{{ math.Sin 1 }} → 0.8414709848078965
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/math/Sqrt.md
---


```go-html-template
{{ math.Sqrt 81 }} → 9
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/math/Sub.md
---


If one of the numbers is a [`float`](g), the result is a `float`.

```go-html-template
{{ sub 12 3 2 }} → 7
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/math/Sum.md
---


```go-html-template
{{ math.Sum 1 (slice 2 3) 4 }} → 10
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/math/Tan.md
---


```go-html-template
{{ math.Tan 1 }} → 1.557407724654902
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/math/ToDegrees.md
---


```go-html-template
{{ math.ToDegrees 1.5707963267948966 }} → 90
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/math/ToRadians.md
---


```go-html-template
{{ math.ToRadians 90 }} → 1.5707963267948966
```

