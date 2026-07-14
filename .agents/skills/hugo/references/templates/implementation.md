## Implementation

To use a partial decorator, use a block-style call in your templates. The [`with`][] statement is required to initiate the partial and create a container for the content. This block can include any valid template code including page methods and functions.

```go-html-template {file="layouts/home.html" copy=true}
{{ with partial "components/wrapper.html" . }}
  <p>Everything in this block will be wrapped.</p>
  <p>{{ .Content | transform.Plainify | strings.Truncate 200 }}</p>
{{ end }}
```

Inside the partial template, place the `templates.Inner` function call where the wrapped content should appear.

```go-html-template {file="layouts/_partials/components/wrapper.html" copy=true}
<div class="wrapper-styling">
  {{ templates.Inner . }}
</div>
```

The `with` statement creates a new [scope](g). Variables defined outside of the `with` block are not available inside it. To use external data within the wrapped content, you must ensure it is part of the [context](g) passed in the partial call.

A key feature of the `templates.Inner` function is its ability to accept a context argument. By passing a context to the function, you define what the dot (`.`) represents inside the wrapped block. This ensures that the injected content has access to the correct data even when nested inside multiple layers of wrappers.

