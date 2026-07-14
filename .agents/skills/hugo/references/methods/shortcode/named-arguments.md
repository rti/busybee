## Named arguments

This shortcode call uses named arguments:

```md {file="content/about.md"}
{{</* myshortcode greeting="Hello" firstName="world" */>}}
```

To retrieve arguments by name:

```go-html-template {file="layouts/_shortcodes/myshortcode.html"}
{{ printf "%s %s." (.Get "greeting") (.Get "firstName") }} → Hello world.
```

> [!NOTE]
> Argument names are case-sensitive.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/shortcode/Inner.md
---


This content:

```md {file="content/services.md"}
{{</* card title="Product Design" */>}}
We design the **best** widgets in the world.
{{</* /card */>}}
```

With this shortcode:

```go-html-template {file="layouts/_shortcodes/card.html"}
<div class="card">
  {{ with .Get "title" }}
    <div class="card-title">{{ . }}</div>
  {{ end }}
  <div class="card-content">
    {{ .Inner | strings.TrimSpace }}
  </div>
</div>
```

Is rendered to:

```html
<div class="card">
  <div class="card-title">Product Design</div>
  <div class="card-content">
    We design the **best** widgets in the world.
  </div>
</div>
```

> [!NOTE]
> Content between opening and closing shortcode tags may include leading and/or trailing newlines, depending on placement within the Markdown. Use the [`strings.TrimSpace`][] function as shown above to remove carriage returns and newlines.

> [!NOTE]
> In the example above, the value returned by `Inner` is Markdown, but it was rendered as plain text. Use either of the following approaches to render Markdown to HTML.

