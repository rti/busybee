
---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/images/AutoOrient.md
---


## Usage

Create the filter:

```go-html-template
{{ $filter := images.AutoOrient }}
```

{{% include "/_common/functions/images/apply-image-filter.md" %}}

> [!NOTE]
> When using with other filters, specify `images.AutoOrient` first.

```go-html-template
{{ $filters := slice
  images.AutoOrient
  (images.Process "resize 200x")
}}
{{ with resources.Get "images/original.jpg" }}
  {{ with images.Filter $filters . }}
    <img src="{{ .RelPermalink }}" width="{{ .Width }}" height="{{ .Height }}" alt="">
  {{ end }}
{{ end }}
```

## Example

{{< img
  src="images/examples/landscape-exif-orientation-5.jpg"
  alt="Zion National Park"
  filter="AutoOrient"
  filterArgs=""
  example=true
>}}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/images/Brightness.md
---


The percentage must be in the range [-100, 100] where 0 has no effect. A value of `-100` produces a solid black image, and a value of `100` produces a solid white image.

## Usage

Create the image filter:

```go-html-template
{{ $filter := images.Brightness 12 }}
```

{{% include "/_common/functions/images/apply-image-filter.md" %}}

## Example

{{< img
  src="images/examples/zion-national-park.jpg"
  alt="Zion National Park"
  filter="Brightness"
  filterArgs="12"
  example=true
>}}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/images/ColorBalance.md
---


The percentage for each channel (red, green, blue) must be in the range [-100, 500].

## Usage

Create the filter:

```go-html-template
{{ $filter := images.ColorBalance -10 10 50 }}
```

{{% include "/_common/functions/images/apply-image-filter.md" %}}

## Example

{{< img
  src="images/examples/zion-national-park.jpg"
  alt="Zion National Park"
  filter="ColorBalance"
  filterArgs="-10,10,50"
  example=true
>}}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/images/Colorize.md
---


The hue is the angle on the color wheel, typically in the range [0, 360].

The saturation must be in the range [0, 100].

The percentage specifies the strength of the effect, and must be in the range [0, 100].

## Usage

Create the filter:

```go-html-template
{{ $filter := images.Colorize 180 50 20 }}
```

{{% include "/_common/functions/images/apply-image-filter.md" %}}

## Example

{{< img
  src="images/examples/zion-national-park.jpg"
  alt="Zion National Park"
  filter="Colorize"
  filterArgs="180,50,20"
  example=true
>}}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/images/Config.md
---


> [!NOTE]
> This is a legacy function, superseded by the [`Width`][] and [`Height`][] methods for [global resources](g), [page resources](g), and [remote resources](g). See the [image processing][] section for details.

```go-html-template
{{ $ic := images.Config "/static/images/a.jpg" }}

{{ $ic.Width }} → 600 (int)
{{ $ic.Height }} → 400 (int)
```

Supported image formats include AVIF, BMP, GIF, HEIC, HEIF, JPEG, PNG, TIFF, and WebP.

[`Height`]: /methods/resource/height/
[`Width`]: /methods/resource/width/
[image processing]: /content-management/image-processing/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/images/Contrast.md
---


The percentage must be in the range [-100, 100] where 0 has no effect. A value of `-100` produces a solid grey image, and a value of `100` produces an over-contrasted image.

## Usage

Create the filter:

```go-html-template
{{ $filter := images.Contrast -20 }}
```

{{% include "/_common/functions/images/apply-image-filter.md" %}}

## Example

{{< img
  src="images/examples/zion-national-park.jpg"
  alt="Zion National Park"
  filter="Contrast"
  filterArgs="-20"
  example=true
>}}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/images/Dither.md
---


## Options

The `images.Dither` filter accepts an options map.

`colors`
: (`[]string`) A slice of two or more colors that make up the dithering palette, each expressed as an RGB or RGBA [hexadecimal][] value, with or without a leading hash mark. The default values are opaque black (`000000ff`) and opaque white (`ffffffff`).

`method`
: (`string`) The dithering method. See the [dithering methods](#dithering-methods) section below for a list of the available methods. Default is `FloydSteinberg`.

`serpentine`
: (`bool`) Applicable to error diffusion dithering methods, whether to apply the error diffusion matrix in a serpentine manner, meaning that it goes right-to-left every other line. This greatly reduces line-type artifacts. Default is `true`.

`strength`
: (`float`) The strength at which to apply the dithering matrix, typically a value in the range [0, 1]. A value of `1.0` applies the dithering matrix at 100% strength (no modification of the dither matrix). The `strength` is inversely proportional to contrast; reducing the strength increases the contrast. Setting `strength` to a value such as `0.8` can be useful to reduce noise in the dithered image. Default is `1.0`.

## Usage

Create the options map:

```go-html-template
{{ $opts := dict
  "colors" (slice "222222" "808080" "dddddd")
  "method" "ClusteredDot4x4"
  "strength" 0.85
}}
```

Create the filter:

```go-html-template
{{ $filter := images.Dither $opts }}
```

Or create the filter using the default settings:

```go-html-template
{{ $filter := images.Dither }}
```

{{% include "/_common/functions/images/apply-image-filter.md" %}}

## Dithering methods

See the [Go documentation][] for descriptions of each of the dithering methods below.

Error diffusion dithering methods:

- Atkinson
- Burkes
- FalseFloydSteinberg
- FloydSteinberg
- JarvisJudiceNinke
- Sierra
- Sierra2
- Sierra2_4A
- Sierra3
- SierraLite
- Simple2D
- StevenPigeon
- Stucki
- TwoRowSierra

Ordered dithering methods:

- ClusteredDot4x4
- ClusteredDot6x6
- ClusteredDot6x6_2
- ClusteredDot6x6_3
- ClusteredDot8x8
- ClusteredDotDiagonal16x16
- ClusteredDotDiagonal6x6
- ClusteredDotDiagonal8x8
- ClusteredDotDiagonal8x8_2
- ClusteredDotDiagonal8x8_3
- ClusteredDotHorizontalLine
- ClusteredDotSpiral5x5
- ClusteredDotVerticalLine
- Horizontal3x5
- Vertical5x3

## Example

This example uses the default dithering options.

{{< img
  src="images/examples/zion-national-park.jpg"
  alt="Zion National Park"
  filter="Dither"
  filterArgs=""
  example=true
>}}

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

## Usage

Use the `images.Filter` function to apply effects such as blurring, sharpening, or grayscale conversion. You can pass a single filter or a slice of filters. When providing a slice, Hugo applies the filters from left to right.

To apply a single filter:

```go-html-template
{{ with resources.Get "images/original.jpg" }}
  {{ with images.Filter images.Grayscale . }}
    <img src="{{ .RelPermalink }}" width="{{ .Width }}" height="{{ .Height }}" alt="">
  {{ end }}
{{ end }}
```

To apply two or more filters, executing from left to right:

```go-html-template
{{ $filters := slice
  images.Grayscale
  (images.GaussianBlur 8)
}}
{{ with resources.Get "images/original.jpg" }}
  {{ with images.Filter $filters . }}
    <img src="{{ .RelPermalink }}" width="{{ .Width }}" height="{{ .Height }}" alt="">
  {{ end }}
{{ end }}
```

You can also apply image filters using the [`Filter`][] method on a `Resource` object.

## Example

```go-html-template
{{ with resources.Get "images/original.jpg" }}
  {{ with images.Filter images.Grayscale . }}
    <img src="{{ .RelPermalink }}" width="{{ .Width }}" height="{{ .Height }}" alt="">
  {{ end }}
{{ end }}
```

{{< img
  src="images/examples/zion-national-park.jpg"
  alt="Zion National Park"
  filter="Grayscale"
  filterArgs=""
  example=true
>}}

## Image filters

Use any of these filters with the `images.Filter` function, or with the `Filter` method on a `Resource` object.

{{% render-list-of-pages-in-section path=/functions/images filter=functions_images_no_filters filterType=exclude %}}

[`Filter`]: /methods/resource/filter/
[`reflect.IsImageResourceProcessable`]: /functions/reflect/isimageresourceprocessable/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/images/Gamma.md
---


The gamma value must be positive. A value greater than 1 lightens the image, while a value less than 1 darkens the image. The filter has no effect when the gamma value is&nbsp;1.

## Usage

Create the filter:

```go-html-template
{{ $filter := images.Gamma 1.667 }}
```

{{% include "/_common/functions/images/apply-image-filter.md" %}}

## Example

{{< img
  src="images/examples/zion-national-park.jpg"
  alt="Zion National Park"
  filter="Gamma"
  filterArgs="1.667"
  example=true
>}}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/images/GaussianBlur.md
---


The sigma value must be positive, and indicates how much the image will be blurred. The blur-affected radius is approximately 3 times the sigma value.

## Usage

Create the filter:

```go-html-template
{{ $filter := images.GaussianBlur 5 }}
```

{{% include "/_common/functions/images/apply-image-filter.md" %}}

## Example

{{< img
  src="images/examples/zion-national-park.jpg"
  alt="Zion National Park"
  filter="GaussianBlur"
  filterArgs="5"
  example=true
>}}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/images/Grayscale.md
---


## Usage

Create the filter:

```go-html-template
{{ $filter := images.Grayscale }}
```

{{% include "/_common/functions/images/apply-image-filter.md" %}}

## Example

{{< img
  src="images/examples/zion-national-park.jpg"
  alt="Zion National Park"
  filter="Grayscale"
  filterArgs=""
  example=true
>}}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/images/Hue.md
---


The hue angle shift is typically in the range [-180, 180] where 0 has no effect.

## Usage

Create the filter:

```go-html-template
{{ $filter := images.Hue -15 }}
```

{{% include "/_common/functions/images/apply-image-filter.md" %}}

## Example

{{< img
  src="images/examples/zion-national-park.jpg"
  alt="Zion National Park"
  filter="Hue"
  filterArgs="-15"
  example=true
>}}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/images/Invert.md
---


## Usage

Create the filter:

```go-html-template
{{ $filter := images.Invert }}
```

{{% include "/_common/functions/images/apply-image-filter.md" %}}

## Example

{{< img
  src="images/examples/zion-national-park.jpg"
  alt="Zion National Park"
  filter="Invert"
  filterArgs=""
  example=true
>}}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/images/Mask.md
---


{{< new-in 0.141.0 />}}

The `images.Mask` filter applies a mask to an image. Black pixels in the mask make the corresponding areas of the base image transparent, while white pixels keep them opaque. Color images are converted to grayscale for masking purposes. The mask is automatically resized to match the dimensions of the base image.

> [!NOTE]
> Of the formats supported by Hugo's imaging pipeline, only AVIF, PNG, and WebP have an alpha channel to support transparency. If your source image has a different format and you require transparent masked areas, convert it to AVIF, PNG, or WebP as shown in the example below.

When applying a mask to a non-transparent image format such as JPEG, the masked areas will be filled with the color specified by the `bgColor` parameter in your [project configuration][]. You can override that color with a `Process` image filter:

```go-html-template
{{ $filter := images.Process "#00ff00" }}
```

## Usage

Create a slice of filters, one for format conversion and the other for mask application:

```go-html-template
{{ $filter1 := images.Process "webp" }}
{{ $filter2 := images.Mask (resources.Get "images/mask.png") }}
{{ $filters := slice $filter1 $filter2 }}
```

Apply the filters using the [`images.Filter`][] function:

```go-html-template
{{ with resources.Get "images/original.jpg" }}
  {{ with . | images.Filter $filters }}
    <img src="{{ .RelPermalink }}" width="{{ .Width }}" height="{{ .Height }}" alt="">
  {{ end }}
{{ end }}
```

You can also apply the filter using the [`Filter`][] method on a 'Resource' object:

```go-html-template
{{ with resources.Get "images/original.jpg" }}
  {{ with .Filter $filters }}
    <img src="{{ .RelPermalink }}" width="{{ .Width }}" height="{{ .Height }}" alt="">
  {{ end }}
{{ end }}
```

## Example

Mask

{{< img
  src="images/examples/mask.png"
  example=false
>}}

{{< img
  src="images/examples/zion-national-park.jpg"
  alt="Zion National Park"
  filter="mask"
  filterArgs="images/examples/mask.png"
  example=true
>}}

[`Filter`]: /methods/resource/filter/
[`images.Filter`]: /functions/images/filter/
[project configuration]: /configuration/imaging/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/images/Opacity.md
---


The opacity value must be in the range [0, 1]. A value of `0` produces a transparent image, and a value of `1` produces an opaque image (no transparency).

## Usage

Create the filter:

```go-html-template
{{ $filter := images.Opacity 0.65 }}
```

{{% include "/_common/functions/images/apply-image-filter.md" %}}

The `images.Opacity` filter is most useful for target formats such as AVIF, PNG, and WebP that support transparency. If the source image does not support transparency, combine this filter with the `images.Process` filter:

```go-html-template
{{ with resources.Get "images/original.jpg" }}
  {{ $filters := slice
    (images.Opacity 0.65)
    (images.Process "png")
  }}
  {{ with . | images.Filter $filters }}
    <img src="{{ .RelPermalink }}" width="{{ .Width }}" height="{{ .Height }}" alt="">
  {{ end }}
{{ end }}
```

## Example

{{< img
  src="images/examples/zion-national-park.jpg"
  alt="Zion National Park"
  filter="Opacity"
  filterArgs="0.65"
  example=true
>}}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/images/Overlay.md
---


## Usage

Capture the overlay image as a resource:

```go-html-template
{{ $overlay := "" }}
{{ $path := "images/logo.png" }}
{{ with resources.Get $path }}
  {{ $overlay = . }}
{{ else }}
  {{ errorf "Unable to get resource %q" $path }}
{{ end }}
```

The overlay image can be a [global resource](g), a [page resource](g), or a [remote resource](g).

Create the filter:

```go-html-template
{{ $filter := images.Overlay $overlay 20 20 }}
```

{{% include "/_common/functions/images/apply-image-filter.md" %}}

## Example

{{< img
  src="images/examples/zion-national-park.jpg"
  alt="Zion National Park"
  filter="Overlay"
  filterArgs="images/logos/logo-64x64.png,20,20"
  example=true
>}}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/images/Padding.md
---


The last argument is the canvas color, expressed as an RGB or RGBA [hexadecimal color][]. The default value is `ffffffff` (opaque white). The preceding arguments are the padding values, in pixels, using the CSS [shorthand property][] syntax. Negative padding values will crop the image.

## Usage

Create the filter:

```go-html-template
{{ $filter := images.Padding 20 40 "#976941" }}
```

{{% include "/_common/functions/images/apply-image-filter.md" %}}

Combine with the [`Colors`][] method to create a border with one of the image's most dominant colors:

```go-html-template
{{ with resources.Get "images/original.jpg" }}
  {{ $filter := images.Padding 20 40 (index .Colors 2) }}
  {{ with . | images.Filter $filter }}
    <img src="{{ .RelPermalink }}" width="{{ .Width }}" height="{{ .Height }}" alt="">
  {{ end }}
{{ end }}
```

## Example

{{< img
  src="images/examples/zion-national-park.jpg"
  alt="Zion National Park"
  filter="Padding"
  filterArgs="20,40,20,40,#976941"
  example=true
>}}

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


## Usage

Create the filter:

```go-html-template
{{ $filter := images.Pixelate 4 }}
```

{{% include "/_common/functions/images/apply-image-filter.md" %}}

## Example

{{< img
  src="images/examples/zion-national-park.jpg"
  alt="Zion National Park"
  filter="Pixelate"
  filterArgs="4"
  example=true
>}}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/images/Process.md
---


Returns an image filter that processes an image according to the given [processing specification](#processing-specification). This versatile filter supports the full range of image transformations, including resizing, cropping, rotation, and format conversion, all within a single specification string. Use this as an argument to the [`Filter`][] method or the [`images.Filter`][] function.

```go-html-template
{{ with resources.Get "images/original.jpg" }}
  {{ $filter := images.Process "crop 200x200 TopRight webp q50" }}
  {{ with .Filter $filter }}
    <img src="{{ .RelPermalink }}" width="{{ .Width }}" height="{{ .Height }}" alt="">
  {{ end }}
{{ end }}
```

In the example above, `"crop 200x200 TopRight webp q50"` is the processing specification.

{{% include "/_common/methods/resource/processing-spec.md" %}}

## Usage

Create a filter:

```go-html-template
{{ $filter := images.Process "crop 200x200 TopRight webp q50" }}
```

{{% include "/_common/functions/images/apply-image-filter.md" %}}

## Example

{{< img
  src="images/examples/zion-national-park.jpg"
  alt="Zion National Park"
  filter="Process"
  filterArgs="crop 200x200 TopRight webp q50"
  example=true
>}}

[`Filter`]: /methods/resource/filter/
[`images.Filter`]: /functions/images/filter/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/images/QR.md
---


{{< new-in 0.141.0 />}}

The `images.QR` function encodes the given text into a [QR code][] using the specified options, returning an image resource. The size of the generated image depends on three factors:

- Data length: Longer text necessitates a larger image to accommodate the increased information density.
- Error correction level: Higher error correction levels enhance the QR code's resistance to damage, but this typically results in a slightly larger image size to maintain readability.
- Pixels per module: The number of image pixels assigned to each individual module (the smallest unit of the QR code) directly impacts the overall image size. A higher pixel count per module leads to a larger, higher-resolution image.

Although the default option values are sufficient for most applications, you should test the rendered QR code both on-screen and in print.

## Options

The `images.QR` function accepts an options map.

`level`
: (`string`) The error correction level to use when encoding the text, one of `low`, `medium`, `quartile`, or `high`. Default is `medium`.

  Error correction level|Redundancy
  :--|:--|:--
  low|20%
  medium|38%
  quartile|55%
  high|65%

`scale`
: (`int`) The number of image pixels per QR code module. Must be greater than or equal to `2`. Default is `4`.

`targetDir`
: (`string`) The subdirectory within the [`publishDir`][] where Hugo will place the generated image. Use Unix-style slashes (`/`) to separarate path segments. If empty or not provided, the image is placed directly in the `publishDir` root. Hugo automatically creates the necessary subdirectories if they don't exist.

## Examples

To create a QR code using the default values for `level` and `scale`:

```go-html-template
{{ $text := "https://gohugo.io" }}
{{ with images.QR $text }}
  <img src="{{ .RelPermalink }}" width="{{ .Width }}" height="{{ .Height }}" alt="">
{{ end }}
```

{{< qr text="https://gohugo.io" class="qrcode" targetDir="images/qr" />}}

Specify `level`, `scale`, and `targetDir` as needed to achieve the desired result:

```go-html-template
{{ $text := "https://gohugo.io" }}
{{ $opts := dict
  "level" "high"
  "scale" 3
  "targetDir" "images/qr"
}}
{{ with images.QR $text $opts }}
  <img src="{{ .RelPermalink }}" width="{{ .Width }}" height="{{ .Height }}" alt="">
{{ end }}
```

{{< qr text="https://gohugo.io" level="high" scale=3 targetDir="codes" class="qrcode" targetDir="images/qr" />}}

To include a QR code that points to the `Permalink` of the current page:

```go-html-template {file="layouts/page.html"}
{{ with images.QR .Permalink }}
  <img
    src="{{ .RelPermalink }}"
    width="{{ .Width }}"
    height="{{ .Height }}"
    alt="QR code linking to {{ $.Permalink }}"
    class="qr-code"
    loading="lazy"
  >
{{ end }}
```

Then hide the QR code with CSS unless printing the page:

```css
/* Hide QR code by default */
.qr-code {
  display: none;
}

/* Show QR code when printing */
@media print {
  .qr-code {
    display: block;
  }
}
```

## Scale

As you decrease the size of a QR code, the maximum distance at which it can be reliably scanned by a device also decreases.

In the example above, we set the `scale` to `2`, resulting in a QR code where each module consists of 2x2 pixels. While this might be sufficient for on-screen display, it's likely to be problematic when printed at 600 dpi.

\[ \frac{2\:px}{module} \times \frac{1\:inch}{600\:px} \times \frac{25.4\:mm}{1\:inch} = \frac{0.085\:mm}{module} \]

This module size is half of the commonly recommended minimum of 0.170 mm.\
If the QR code will be printed, use the default `scale` value of `4` pixels per module.

Avoid using Hugo's image processing methods to resize QR codes. Resizing can introduce blurring due to anti-aliasing when a QR code module occupies a fractional number of pixels.

> [!NOTE]
> Always test the rendered QR code both on-screen and in print.

## Shortcode

Call the `qr` shortcode to insert a QR code into your content.

Use the self-closing syntax to pass the text as an argument:

```md
{{</* qr text="https://gohugo.io" /*/>}}
```

Or insert the text between the opening and closing tags:

```md
{{</* qr */>}}
https://gohugo.io
{{</* /qr */>}}
```

The `qr` shortcode accepts several arguments including `level` and `scale`. See the [related documentation][] for details.

[QR code]: https://en.wikipedia.org/wiki/QR_code
[`publishDir`]: /configuration/all/#publishdir
[related documentation]: /shortcodes/qr/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/images/Saturation.md
---


The percentage must be in the range [-100, 500] where 0 has no effect.

## Usage

Create the filter:

```go-html-template
{{ $filter := images.Saturation 65 }}
```

{{% include "/_common/functions/images/apply-image-filter.md" %}}

## Example

{{< img
  src="images/examples/zion-national-park.jpg"
  alt="Zion National Park"
  filter="Saturation"
  filterArgs="65"
  example=true
>}}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/images/Sepia.md
---


The percentage must be in the range [0, 100] where 0 has no effect.

## Usage

Create the filter:

```go-html-template
{{ $filter := images.Sepia 75 }}
```

{{% include "/_common/functions/images/apply-image-filter.md" %}}

## Example

{{< img
  src="images/examples/zion-national-park.jpg"
  alt="Zion National Park"
  filter="Sepia"
  filterArgs="75"
  example=true
>}}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/images/Sigmoid.md
---


This is a non-linear contrast change useful for photo adjustments; it preserves highlight and shadow detail.

The midpoint is the midpoint of contrast. It must be in the range [0, 1], typically 0.5.

The factor indicates how much to increase or decrease the contrast, typically in the range [-10, 10] where 0 has no effect. A positive value increases contrast, while a negative value decrease contrast.

## Usage

Create the filter:

```go-html-template
{{ $filter := images.Sigmoid 0.6 -4 }}
```

{{% include "/_common/functions/images/apply-image-filter.md" %}}

## Example

{{< img
  src="images/examples/zion-national-park.jpg"
  alt="Zion National Park"
  filter="Sigmoid"
  filterArgs="0.6,-4"
  example=true
>}}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/images/Text.md
---


## Options

The `images.Text` filter accepts an options map.

Although none of the options are required, at a minimum you will want to set the `size` to be some reasonable percentage of the image height.

`alignx`
: {{< new-in 0.141.0 />}}
: (`string`) The horizontal alignment of the text relative to the horizontal offset, one of `left`, `center`, or `right`. Default is `left`.

`aligny`
: {{< new-in 0.147.0 />}}
: (`string`) The vertical alignment of the text relative to the vertical offset, one of `top`, `center`, or `bottom`. Default is `top`.

`color`
: (`string`) The font color, either a 3-digit or 6-digit hexadecimal color code. Default is `#ffffff` (white).

`font`
: (`resource.Resource`) The font can be a [global resource](g), a [page resource](g), or a [remote resource](g). Default is [Go Regular][], a proportional sans-serif TrueType font.

`linespacing`
: (`int`) The number of pixels between each line. For a line height of 1.4, set the `linespacing` to 0.4 multiplied by the `size`. Default is `2`.

`size`
: (`int`) The font size in pixels. Default is `20`.

`x`
: (`int`) The horizontal offset, in pixels, relative to the left of the image. Default is `10`.

`y`
: (`int`) The vertical offset, in pixels, relative to the top of the image. Default is `10`.

## Usage

Set the text and paths:

```go-html-template
{{ $text := "Zion National Park" }}
{{ $fontPath := "https://github.com/google/fonts/raw/main/ofl/lato/Lato-Regular.ttf" }}
{{ $imagePath := "images/original.jpg" }}
```

Capture the font as a resource:

```go-html-template
{{ $font := "" }}
{{ with try (resources.GetRemote $fontPath) }}
  {{ with .Err }}
    {{ errorf "%s" . }}
  {{ else with .Value }}
    {{ $font = . }}
  {{ else }}
    {{ errorf "Unable to get resource %s" $fontPath }}
  {{ end }}
{{ end }}
```

Create the filter, centering the text horizontally and vertically:

```go-html-template
{{ $r := "" }}
{{ $filter := "" }}
{{ with $r = resources.Get $imagePath }}
  {{ $opts := dict
    "alignx" "center"
    "aligny" "center"
    "color" "#fbfaf5"
    "font" $font
    "linespacing" 8
    "size" 60
    "x" (mul .Width 0.5 | int)
    "y" (mul .Height 0.5 | int)
  }}
  {{ $filter = images.Text $text $opts }}
{{ else }}
  {{ errorf "Unable to get resource %s" $imagePath }}
{{ end }}
```

Apply the filter using the [`images.Filter`][] function:

```go-html-template
{{ with $r }}
  {{ with . | images.Filter $filter }}
    <img src="{{ .RelPermalink }}" width="{{ .Width }}" height="{{ .Height }}" alt="">
  {{ end }}
{{ end }}
```

You can also apply the filter using the [`Filter`][] method on a `Resource` object:

```go-html-template
{{ with $r }}
  {{ with .Filter $filter }}
    <img src="{{ .RelPermalink }}" width="{{ .Width }}" height="{{ .Height }}" alt="">
  {{ end }}
{{ end }}
```

## Example

{{< img
  src="images/examples/zion-national-park.jpg"
  alt="Zion National Park"
  filter="Text"
  filterArgs="Zion National Park,25,190,40,1.2,#fbfaf5"
  example=true
>}}

[Go Regular]: https://go.dev/blog/go-fonts#sans-serif
[`Filter`]: /methods/resource/filter/
[`images.Filter`]: /functions/images/filter/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/images/UnsharpMask.md
---


The sigma argument is used in a gaussian function and affects the radius of effect. Sigma must be positive. The sharpen radius is approximately 3 times the sigma value.

The amount argument controls how much darker and how much lighter the edge borders become. Typically between 0.5 and 1.5.

The threshold argument controls the minimum brightness change that will be sharpened. Typically between 0 and 0.05.

## Usage

Create the filter:

```go-html-template
{{ $filter := images.UnsharpMask 10 0.4 0.03 }}
```

{{% include "/_common/functions/images/apply-image-filter.md" %}}

## Example

{{< img
  src="images/examples/zion-national-park.jpg"
  alt="Zion National Park"
  filter="UnsharpMask"
  filterArgs="10,0.4,0.03"
  example=true
>}}

