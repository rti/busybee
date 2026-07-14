## Understanding context

See the [context][] section in the introduction to templating.

For example, at the top of a _page_ template, the [context](g) (the dot) is a `Page` object. Inside of the `with` block, the context is bound to the value passed to the `with` statement.

With this contrived example:

```go-html-template
{{ with 42 }}
  {{ .Title }}
{{ end }}
```

Hugo will throw an error:

    can't evaluate field Title in type int

The error occurs because we are trying to use the `.Title` method on an integer instead of a `Page` object. Inside of the `with` block, if we want to render the page title, we need to get the context passed into the template.

> [!NOTE]
> Use the `$` to get the context passed into the template.

This template will render the page title as desired:

```go-html-template
{{ with 42 }}
  {{ $.Title }}
{{ end }}
```

> [!NOTE]
> Gaining a thorough understanding of context is critical for anyone writing template code.

{{% include "/_common/functions/go-template/text-template.md" %}}

[`else`]: /functions/go-template/else/
[context]: /templates/introduction/#context

