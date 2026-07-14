## Usage

To use this function, the calling template must use the block style syntax with a [`with`][] statement. This allows decorators to be deeply nested.

```go-html-template {file="layouts/home.html"}
{{ with partial "components/card.html" . }}
  <p>This content is passed to the partial.</p>
{{ end }}
```

Inside the partial, call `templates.Inner` to render the captured block.

```go-html-template {file="layouts/_partials/components/card.html"}
<div class="card-frame">
  {{ templates.Inner . }}
</div>
```

