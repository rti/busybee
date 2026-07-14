## Navigation

As shown in the examples above, the easiest way to add navigation between pagers is with Hugo's embedded pagination template:

```go-html-template
{{ partial "pagination.html" . }}
```

The embedded pagination template has two formats: `default` and `terse`. The above is equivalent to:

```go-html-template
{{ partial "pagination.html" (dict "page" . "format" "default") }}
```

The `terse` format has fewer controls and page slots, consuming less space when styled as a horizontal list. To use the `terse` format:

```go-html-template
{{ partial "pagination.html" (dict "page" . "format" "terse") }}
```

> [!NOTE]
> To override Hugo's embedded pagination template, copy the [source code][] to a file with the same name in the `layouts/_partials` directory, then call it from your templates using the [`partial`][] function:
>
> `{{ partial "pagination.html" . }}`

Create custom navigation components using any of the `Pager` methods:

{{% render-list-of-pages-in-section path=/methods/pager %}}

