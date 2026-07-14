## Other recipes

This example resizes an image to 300px wide, converts it to the WebP format, adds 20px vertical padding and 50px horizontal padding, then sets the canvas color to dark green with 33% opacity.

In the example below, conversion to WebP is required to support transparency. AVIF, PNG, and WebP images have an alpha channel; JPEG and GIF do not.

```go-html-template
{{ $img := resources.Get "images/a.jpg" }}
{{ $filters := slice
  (images.Process "resize 300x webp")
  (images.Padding 20 50 "#0705")
}}
{{ $img = $img.Filter $filters }}
```

To add a 2px gray border to an image:

```go-html-template
{{ $img = $img.Filter (images.Padding 2 "#777") }}
```

[`Colors`]: /methods/resource/colors/
[hexadecimal color]: https://developer.mozilla.org/en-US/docs/Web/CSS/hex-color
[shorthand property]: https://developer.mozilla.org/en-US/docs/Web/CSS/Shorthand_properties#edges_of_a_box


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/images/Pixelate.md
---


