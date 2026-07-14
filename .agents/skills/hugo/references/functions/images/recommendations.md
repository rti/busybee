## Recommendations

Regardless of dithering method, do both of the following to obtain the best results:

1. Scale the image _before_ dithering
1. Output the image to a lossless format such as GIF or PNG

The example below does both of these, and it sets the dithering palette to the three most dominant colors in the image.

```go-html-template
{{ with resources.Get "original.jpg" }}
  {{ $opts := dict
    "method" "ClusteredDotSpiral5x5"
    "colors" (first 3 .Colors)
  }}
  {{ $filters := slice
    (images.Process "resize 800x")
    (images.Dither $opts)
    (images.Process "png")
  }}
  {{ with . | images.Filter $filters }}
    <img src="{{ .RelPermalink }}" width="{{ .Width }}" height="{{ .Height }}" alt="">
  {{ end }}
{{ end }}
```

For best results, if the dithering palette is grayscale, convert the image to grayscale before dithering.

```go-html-template
{{ $opts := dict "colors" (slice "222" "808080" "ddd") }}
{{ $filters := slice
  (images.Process "resize 800x")
  (images.Grayscale)
  (images.Dither $opts)
  (images.Process "png")
}}
{{ with images.Filter $filters . }}
  <img src="{{ .RelPermalink }}" width="{{ .Width }}" height="{{ .Height }}" alt="">
{{ end }}
```

The example above:

1. Resizes the image to be 800 px wide
1. Converts the image to grayscale
1. Dithers the image using the default (`FloydSteinberg`) dithering method with a grayscale palette
1. Converts the image to the PNG format

[Go documentation]: https://pkg.go.dev/github.com/makeworld-the-better-one/dither/v2#pkg-variables
[hexadecimal]: https://developer.mozilla.org/en-US/docs/Web/CSS/hex-color


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/images/Filter.md
---


{{% include "/_common/methods/resource/global-page-remote-resources.md" %}}

The `images.Filter` function returns a new resource from a [processable image](g) after applying one or more [image filters](#image-filters).

> [!NOTE]
> Use the [`reflect.IsImageResourceProcessable`][] function to verify that an image can be processed.

