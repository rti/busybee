## Usage

Resize an image according to the given processing specification. You may specify only the width (such as `300x`) or only the height (such as `x150`) for proportional scaling.

If you specify both width and height (such as `300x150`), the resulting image will be scaled to those exact dimensions. If the target aspect ratio differs from the original, the image will be non-proportionally scaled (stretched or squashed).

```go-html-template
{{ with resources.Get "images/original.jpg" }}
  {{ with .Resize "300x" }}
    <img src="{{ .RelPermalink }}" width="{{ .Width }}" height="{{ .Height }}" alt="">
  {{ end }}
{{ end }}
```

In the example above, `"300x"` is the processing specification.

{{% include "/_common/methods/resource/processing-spec.md" %}}

