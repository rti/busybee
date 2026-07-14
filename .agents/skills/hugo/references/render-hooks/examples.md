## Examples

> [!NOTE]
> With inline elements such as images and links, remove leading and trailing whitespace using the `{{‑ ‑}}` delimiter notation to prevent whitespace between adjacent inline elements and text.

In its default configuration, Hugo renders Markdown links according to the [CommonMark][] specification. To create a render hook that does the same thing:

```go-html-template {file="layouts/_markup/render-link.html" copy=true}
<a href="{{ .Destination | safeURL }}"
  {{- with .Title }} title="{{ . }}"{{ end -}}
>
  {{- with .Text }}{{ . }}{{ end -}}
</a>
{{- /* chomp trailing newline */ -}}
```

To include a `rel` attribute set to `external` for external links:

```go-html-template {file="layouts/_markup/render-link.html" copy=true}
{{- $u := urls.Parse .Destination -}}
<a href="{{ .Destination | safeURL }}"
  {{- with .Title }} title="{{ . }}"{{ end -}}
  {{- if $u.IsAbs }} rel="external"{{ end -}}
>
  {{- with .Text }}{{ . }}{{ end -}}
</a>
{{- /* chomp trailing newline */ -}}
```

