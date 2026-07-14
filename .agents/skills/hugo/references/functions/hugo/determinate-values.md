## Determinate values

The `Store` method is often used to set values within a _shortcode_ template, a _partial_ template called by a _shortcode_ template, or by a _render hook_ template. In all three cases, the stored values are indeterminate until Hugo renders the page content.

If you need to access a stored value from a parent template, and the parent template has not yet rendered the page content, you can trigger content rendering by assigning the returned value to a [noop](g) variable:

```go-html-template
{{ $noop := .Content }}
{{ hugo.Store.Get "mykey" }}
```

You can also trigger content rendering with the `ContentWithoutSummary`, `FuzzyWordCount`, `Len`, `Plain`, `PlainWords`, `ReadingTime`, `Summary`, `Truncated`, and `WordCount` methods. For example:

```go-html-template
{{ $noop := .WordCount }}
{{ hugo.Store.Get "mykey" }}
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/hugo/Version.md
---


```go-html-template
{{ hugo.Version }} → 0.163.3
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/hugo/WorkingDir.md
---


```go-html-template
{{ hugo.WorkingDir }} → /home/user/projects/my-hugo-site
```

