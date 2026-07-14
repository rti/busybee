## Use RenderString

Let's modify the example above to pass the value returned by `Inner` through the [`RenderString`][] method on the `Page` object:

```go-html-template {file="layouts/_shortcodes/card.html"}
<div class="card">
  {{ with .Get "title" }}
    <div class="card-title">{{ . }}</div>
  {{ end }}
  <div class="card-content">
    {{ .Inner | strings.TrimSpace | .Page.RenderString }}
  </div>
</div>
```

Hugo renders this to:

```html
<div class="card">
  <div class="card-title">Product design</div>
  <div class="card-content">
    We produce the <strong>best</strong> widgets in the world.
  </div>
</div>
```

You can use the [`markdownify`][] function instead of the `RenderString` method, but the latter is more flexible. See [details][].

