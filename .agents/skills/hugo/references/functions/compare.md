
---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/compare/Conditional.md
---


If CONTROL is truthy the function returns ARG1, otherwise it returns ARG2.

```go-html-template
{{ $qty := 42 }}
{{ cond (le $qty 3) "few" "many" }} → many
```

Unlike [ternary operators][] in other languages, the `compare.Conditional` function does not perform [short-circuit evaluation][]. It evaluates both ARG1 and ARG2 regardless of the CONTROL value.

Due to the absence of short-circuit evaluation, these examples throw an error:

```go-html-template
{{ cond true "true" (div 1 0) }}
{{ cond false (div 1 0) "false" }}
```

[short-circuit evaluation]: https://en.wikipedia.org/wiki/Short-circuit_evaluation
[ternary operators]: https://en.wikipedia.org/wiki/Ternary_conditional_operator


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/compare/Default.md
---


The `default` function returns the second argument if set, else the first argument.

> [!NOTE]
> When the second argument is the boolean `false` value, the `default` function returns `false`. All _other_ falsy values are considered unset.
>
> The falsy values are `false`, `0`, any `nil` pointer or interface value, any array, slice, map, or string of length zero, and zero `time.Time` values.
>
> Everything else is truthy.
>
> To set a default value based on truthiness, use the [`or`][] operator instead.

The `default` function returns the second argument if set:

```go-html-template
{{ default 42 1 }} → 1
{{ default 42 "foo" }} → foo
{{ default 42 (dict "k" "v") }} → map[k:v]
{{ default 42 (slice "a" "b") }} → [a b]
{{ default 42 true }} → true

<!-- As noted above, the boolean "false" is considered set -->
{{ default 42 false }} → false
```

The `default` function returns the first argument if the second argument is not set:

```go-html-template
{{ default 42 0 }} → 42
{{ default 42 "" }} → 42
{{ default 42 dict }} → 42
{{ default 42 slice }} → 42
{{ default 42 nil }} → 42
```

[`or`]: /functions/go-template/or/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/compare/Eq.md
---


```go-html-template
{{ eq 1 1 }} → true
{{ eq 1 2 }} → false

{{ eq 1 1 1 }} → true
{{ eq 1 1 2 }} → true
{{ eq 1 2 1 }} → true
{{ eq 1 2 2 }} → false
```

You can also use the `compare.Eq` function to compare strings, boolean values, dates, slices, maps, and pages.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/compare/Ge.md
---


```go-html-template
{{ ge 1 1 }} → true
{{ ge 1 2 }} → false
{{ ge 2 1 }} → true

{{ ge 1 1 1 }} → true
{{ ge 1 1 2 }} → false
{{ ge 1 2 1 }} → false
{{ ge 1 2 2 }} → false

{{ ge 2 1 1 }} → true
{{ ge 2 1 2 }} → true
{{ ge 2 2 1 }} → true
```

Use the `compare.Ge` function to compare other data types as well:

```go-html-template
{{ ge "ab" "a" }} → true
{{ ge time.Now (time.AsTime "1964-12-30") }} → true
{{ ge true false }} → true
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/compare/Gt.md
---


```go-html-template
{{ gt 1 1 }} → false
{{ gt 1 2 }} → false
{{ gt 2 1 }} → true

{{ gt 1 1 1 }} → false
{{ gt 1 1 2 }} → false
{{ gt 1 2 1 }} → false
{{ gt 1 2 2 }} → false

{{ gt 2 1 1 }} → true
{{ gt 2 1 2 }} → false
{{ gt 2 2 1 }} → false
```

Use the `compare.Gt` function to compare other data types as well:

```go-html-template
{{ gt "ab" "a" }} → true
{{ gt time.Now (time.AsTime "1964-12-30") }} → true
{{ gt true false }} → true
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/compare/Le.md
---


```go-html-template
{{ le 1 1 }} → true
{{ le 1 2 }} → true
{{ le 2 1 }} → false

{{ le 1 1 1 }} → true
{{ le 1 1 2 }} → true
{{ le 1 2 1 }} → true
{{ le 1 2 2 }} → true

{{ le 2 1 1 }} → false
{{ le 2 1 2 }} → false
{{ le 2 2 1 }} → false
```

Use the `compare.Le` function to compare other data types as well:

```go-html-template
{{ le "ab" "a" }} → false
{{ le time.Now (time.AsTime "1964-12-30") }} → false
{{ le true false }} → false
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/compare/Lt.md
---


```go-html-template
{{ lt 1 1 }} → false
{{ lt 1 2 }} → true
{{ lt 2 1 }} → false

{{ lt 1 1 1 }} → false
{{ lt 1 1 2 }} → false
{{ lt 1 2 1 }} → false
{{ lt 1 2 2 }} → true

{{ lt 2 1 1 }} → false
{{ lt 2 1 2 }} → false
{{ lt 2 2 1 }} → false
```

Use the `compare.Lt` function to compare other data types as well:

```go-html-template
{{ lt "ab" "a" }} → false
{{ lt time.Now (time.AsTime "1964-12-30") }} → false
{{ lt true false }} → false
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/compare/Ne.md
---


```go-html-template
{{ ne 1 1 }} → false
{{ ne 1 2 }} → true

{{ ne 1 1 1 }} → false
{{ ne 1 1 2 }} → false
{{ ne 1 2 1 }} → false
{{ ne 1 2 2 }} → true
```

You can also use the `compare.Ne` function to compare strings, boolean values, dates, slices, maps, and pages.

