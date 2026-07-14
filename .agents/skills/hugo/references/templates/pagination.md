## Pagination

> [!NOTE]
> To override Hugo's embedded pagination template, copy the [source code](<{{% eturl pagination %}}>) to a file with the same name in the `layouts/_partials` directory, then call it from your templates using the [`partial`][] function:
>
> `{{ partial "pagination.html" . }}`

Hugo includes an embedded template for rendering navigation links between pagers. To include the embedded template:

```go-html-template
{{ partial "pagination.html" . }}
```

The embedded pagination template has two formats: `default` and `terse`. The `terse` format has fewer controls and page slots, consuming less space when styled as a horizontal list. See [pagination][] for details.

