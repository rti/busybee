
---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/resource/Colors.md
---


{{% include "/_common/methods/resource/global-page-remote-resources.md" %}}

The `Colors` method returns a slice of the most dominant colors in a [processable image](g), ordered from most dominant to least dominant.

> [!NOTE]
> Use the [`reflect.IsImageResourceProcessable`][] function to verify that an image can be processed.

## Usage

This method is fast, but if you downscale your image first, you can further improve performance by extracting colors from the smaller resource.

## Methods

Each color in the slice is an object with the following methods:

`ColorHex`
: (`string`) Returns the [hexadecimal color][] value, prefixed with a hash sign.

`Luminance`
: (`float64`) Returns the [relative luminance][] of the color in the sRGB colorspace in the range [0, 1]. A value of `0` represents the darkest black, while a value of `1` represents the lightest white.

> [!NOTE]
> Image filters such as [`images.Dither`][], [`images.Padding`][], and [`images.Text`][] accept either hexadecimal color values or `images.Color` objects as arguments. Hugo renders an `images.Color` object as a hexadecimal color value.

## Sorting

As a contrived example, create a table of an image's dominant colors with the most dominant color first, and display the relative luminance of each dominant color:

```go-html-template
{{ with resources.Get "images/a.jpg" }}
  <table>
    <thead>
      <tr>
        <th>Color</th>
        <th>Relative luminance</th>
      </tr>
    </thead>
    <tbody>
      {{ range .Colors }}
        <tr>
          <td>{{ .ColorHex }}</td>
          <td>{{ .Luminance | lang.FormatNumber 4 }}</td>
        </tr>
      {{ end }}
    </tbody>
  </table>
{{ end }}
```

Hugo renders this to:

ColorHex|Relative luminance
:--|:--
`#bebebd`|`0.5145`
`#514947`|`0.0697`
`#768a9a`|`0.2436`
`#647789`|`0.1771`
`#90725e`|`0.1877`
`#a48974`|`0.2704`

To sort by dominance with the least dominant color first:

```go-html-template
{{ range .Colors | collections.Reverse }}
```

To sort by relative luminance with the darkest color first:

```go-html-template
{{ range sort .Colors "Luminance" }}
```

To sort by relative luminance with the lightest color first, use either of these constructs:

```go-html-template
{{ range sort .Colors "Luminance" | collections.Reverse }}
{{ range sort .Colors "Luminance" "desc" }}
```

## Examples

### Image borders

To add a 5 pixel border to an image using the most dominant color:

```go-html-template
{{ with resources.Get "images/a.jpg" }}
  {{ $mostDominant := index .Colors 0 }}
  {{ $filter := images.Padding 5 $mostDominant }}
  {{ with .Filter $filter }}
    <img src="{{ .RelPermalink }}" width="{{ .Width }}" height="{{ .Height }}" alt="">
  {{ end }}
{{ end }}
```

To add a 5 pixel border to an image using the darkest dominant color:

```go-html-template
{{ with resources.Get "images/a.jpg" }}
  {{ $darkest := index (sort .Colors "Luminance") 0 }}
  {{ $filter := images.Padding 5 $darkest }}
  {{ with .Filter $filter }}
    <img src="{{ .RelPermalink }}" width="{{ .Width }}" height="{{ .Height }}" alt="">
  {{ end }}
{{ end }}
```

### Light text on dark background

To create a text box where the foreground and background colors are derived from an image's lightest and darkest dominant colors:

```go-html-template
{{ with resources.Get "images/a.jpg" }}
  {{ $darkest := index (sort .Colors "Luminance") 0 }}
  {{ $lightest := index (sort .Colors "Luminance" "desc") 0 }}
  <div style="background: {{ $darkest }};">
    <div style="color: {{ $lightest }};">
      <p>This is light text on a dark background.</p>
    </div>
  </div>
{{ end }}
```

### WCAG contrast ratio

In the previous example we placed light text on a dark background, but does this color combination conform to [WCAG][] guidelines for either the [minimum][] or the [enhanced][] contrast ratio?

The WCAG defines the [contrast ratio][] as:

$$contrast\ ratio = { L_1 + 0.05 \over L_2 + 0.05 }$$

where \(L_1\) is the relative luminance of the lightest color and \(L_2\) is the relative luminance of the darkest color.

Calculate the contrast ratio to determine WCAG conformance:

```go-html-template
{{ with resources.Get "images/a.jpg" }}
  {{ $lightest := index (sort .Colors "Luminance" "desc") 0 }}
  {{ $darkest := index (sort .Colors "Luminance") 0 }}
  {{ $cr := div
    (add $lightest.Luminance 0.05)
    (add $darkest.Luminance 0.05)
  }}
  {{ if ge $cr 7.5 }}
    {{ printf "The %.2f contrast ratio conforms to WCAG Level AAA." $cr }}
  {{ else if ge $cr 4.5 }}
    {{ printf "The %.2f contrast ratio conforms to WCAG Level AA." $cr }}
  {{ else }}
    {{ printf "The %.2f contrast ratio does not conform to WCAG guidelines." $cr }}
  {{ end }}
{{ end }}
```

[WCAG]: https://en.wikipedia.org/wiki/Web_Content_Accessibility_Guidelines
[`images.Dither`]: /functions/images/dither/
[`images.Padding`]: /functions/images/padding/
[`images.Text`]: /functions/images/text/
[`reflect.IsImageResourceProcessable`]: /functions/reflect/isimageresourceprocessable/
[contrast ratio]: https://www.w3.org/TR/WCAG21/#dfn-contrast-ratio
[enhanced]: https://www.w3.org/WAI/WCAG22/quickref/?showtechniques=145#contrast-enhanced
[hexadecimal color]: https://developer.mozilla.org/en-US/docs/Web/CSS/hex-color
[minimum]: https://www.w3.org/WAI/WCAG22/quickref/?showtechniques=145#contrast-minimum
[relative luminance]: https://www.w3.org/TR/WCAG21/#dfn-relative-luminance


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/resource/Content.md
---


{{% include "/_common/methods/resource/global-page-remote-resources.md" %}}

The `Content` method on a `Resource` object returns `template.HTML` when the [resource type][] is `page`, otherwise it returns a `string`.

```text {file="assets/quotations/kipling.txt"}
He travels the fastest who travels alone.
```

To get the content:

```go-html-template
{{ with resources.Get "quotations/kipling.txt" }}
  {{ .Content }} → He travels the fastest who travels alone.
{{ end }}
```

To get the size in bytes:

```go-html-template
{{ with resources.Get "quotations/kipling.txt" }}
  {{ .Content | len }} → 42
{{ end }}
```

To create an inline image:

```go-html-template
{{ with resources.Get "images/a.jpg" }}
  <img src="data:{{ .MediaType.Type }};base64,{{ .Content | base64Encode }}">
{{ end }}
```

To create inline CSS:

```go-html-template
{{ with resources.Get "css/style.css" }}
  <style>{{ .Content | safeCSS }}</style>
{{ end }}
```

To create inline JavaScript:

```go-html-template
{{ with resources.Get "js/script.js" }}
  <script>{{ .Content | safeJS }}</script>
{{ end }}
```

[resource type]: /methods/resource/resourcetype/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/resource/Crop.md
---


{{% include "/_common/methods/resource/global-page-remote-resources.md" %}}

The `Crop` method returns a new resource from a [processable image](g) according to the given [processing specification](#processing-specification).

> [!NOTE]
> Use the [`reflect.IsImageResourceProcessable`][] function to verify that an image can be processed.

## Usage

When cropping, you must provide both width and height (such as `200x200`) within the specification. This method does not perform any resizing; it simply extracts a region of the image based on the dimensions and the [anchor](#anchor) provided, if any.

```go-html-template
{{ with resources.Get "images/original.jpg" }}
  {{ with .Crop "200x200 TopRight" }}
    <img src="{{ .RelPermalink }}" width="{{ .Width }}" height="{{ .Height }}" alt="">
  {{ end }}
{{ end }}
```

In the example above, `"200x200 TopRight"` is the processing specification.

{{% include "/_common/methods/resource/processing-spec.md" %}}

## Example

```go-html-template
{{ with resources.Get "images/original.jpg" }}
  {{ with .Crop "200x200 TopRight" }}
    <img src="{{ .RelPermalink }}" width="{{ .Width }}" height="{{ .Height }}" alt="">
  {{ end }}
{{ end }}
```

{{< img
  src="images/examples/zion-national-park.jpg"
  alt="Zion National Park"
  filter="Process"
  filterArgs="crop 200x200 TopRight"
  example=true
>}}

[`reflect.IsImageResourceProcessable`]: /functions/reflect/isimageresourceprocessable/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/resource/Data.md
---


The `Data` method on a resource returned by the [`resources.GetRemote`][] function returns information from the HTTP response.

## Example

```go-html-template
{{ $url := "https://example.org/images/a.jpg" }}
{{ $opts := dict "responseHeaders" (slice "Server") }}
{{ with try (resources.GetRemote $url) }}
  {{ with .Err }}
    {{ errorf "%s" . }}
  {{ else with .Value }}
    {{ with .Data }}
      {{ .ContentLength }} → 42764
      {{ .ContentType }} → image/jpeg
      {{ .Headers }} → map[Server:[Netlify]]
      {{ .Status }} → 200 OK
      {{ .StatusCode }} → 200
      {{ .TransferEncoding }} → []
    {{ end }}
  {{ else }}
    {{ errorf "Unable to get remote resource %q" $url }}
  {{ end }}
{{ end }}
```

## Methods

Use these methods on the `Data` object.

`ContentLength`
: (`int`) The content length in bytes.

`ContentType`
: (`string`) The content type.

`Headers`
: (`map[string][]string`) A map of response headers matching those requested in the [`responseHeaders`][] option passed to the `resources.GetRemote` function. The header name matching is case-insensitive. In most cases there will be one value per header key.

`Status`
: (`string`) The HTTP status text.

`StatusCode`
: (`int`) The HTTP status code.

`TransferEncoding`
: (`string`) The transfer encoding.

[`resources.GetRemote`]: /functions/resources/getremote/
[`responseHeaders`]: /functions/resources/getremote/#responseheaders


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/resource/Err.md
---


{{< deprecated-in 0.141.0 >}}
Use the [`try`](/functions/go-template/try/) statement instead.
{{< /deprecated-in >}}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/resource/Exif.md
---


{{< deprecated-in 0.155.0 >}}
Use the [`Meta`](/methods/resource/meta/) method instead.
{{< /deprecated-in >}}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/resource/Fill.md
---


{{% include "/_common/methods/resource/global-page-remote-resources.md" %}}

The `Fill` method returns a new resource from a [processable image](g) according to the given [processing specification](#processing-specification).

> [!NOTE]
> Use the [`reflect.IsImageResourceProcessable`][] function to verify that an image can be processed.

## Usage

When filling, you must provide both width and height (such as `500x200`) within the specification. `Fill` maintains the original aspect ratio by resizing the image to cover the target area and cropping any overflowing pixels based on the [anchor](#anchor) provided.

```go-html-template
{{ with resources.Get "images/original.jpg" }}
  {{ with .Fill "500x200 TopRight" }}
    <img src="{{ .RelPermalink }}" width="{{ .Width }}" height="{{ .Height }}" alt="">
  {{ end }}
{{ end }}
```

In the example above, `"500x200 TopRight"` is the _processing specification.

{{% include "/_common/methods/resource/processing-spec.md" %}}

## Example

```go-html-template
{{ with resources.Get "images/original.jpg" }}
  {{ with .Fill "500x200 TopRight" }}
    <img src="{{ .RelPermalink }}" width="{{ .Width }}" height="{{ .Height }}" alt="">
  {{ end }}
{{ end }}
```

{{< img
  src="images/examples/zion-national-park.jpg"
  alt="Zion National Park"
  filter="Process"
  filterArgs="fill 500x200 TopRight"
  example=true
>}}

[`reflect.IsImageResourceProcessable`]: /functions/reflect/isimageresourceprocessable/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/resource/Filter.md
---


{{% include "/_common/methods/resource/global-page-remote-resources.md" %}}

The `Filter` method returns a new resource from a [processable image](g) after applying one or more [image filters](#image-filters).

> [!NOTE]
> Use the [`reflect.IsImageResourceProcessable`][] function to verify that an image can be processed.

## Usage

Use the `Filter` method to apply effects such as blurring, sharpening, or grayscale conversion. You can pass a single filter or a slice of filters. When providing a slice, Hugo applies the filters from left to right.

To apply a single filter:

```go-html-template
{{ with resources.Get "images/original.jpg" }}
  {{ with .Filter images.Grayscale }}
    <img src="{{ .RelPermalink }}" width="{{ .Width }}" height="{{ .Height }}" alt="">
  {{ end }}
{{ end }}
```

To apply multiple filters:

```go-html-template
{{ $filters := slice
  images.Grayscale
  (images.GaussianBlur 8)
}}
{{ with resources.Get "images/original.jpg" }}
  {{ with .Filter $filters }}
    <img src="{{ .RelPermalink }}" width="{{ .Width }}" height="{{ .Height }}" alt="">
  {{ end }}
{{ end }}
```

You can also apply image filters using the [`images.Filter`][] function.

## Example

```go-html-template
{{ with resources.Get "images/original.jpg" }}
  {{ with .Filter images.Grayscale }}
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

Use any of these filters with the `Filter` method.

{{% render-list-of-pages-in-section path=/functions/images filter=functions_images_no_filters filterType=exclude %}}

[`images.Filter`]: /functions/images/filter/
[`reflect.IsImageResourceProcessable`]: /functions/reflect/isimageresourceprocessable/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/resource/Fit.md
---


{{% include "/_common/methods/resource/global-page-remote-resources.md" %}}

The `Fit` method returns a new resource from a [processable image](g) according to the given [processing specification](#processing-specification).

> [!NOTE]
> Use the [`reflect.IsImageResourceProcessable`][] function to verify that an image can be processed.

## Usage

When fitting, you must provide both width and height (such as `300x175`) within the specification. `Fit` maintains the original aspect ratio by downscaling the image until it fits within the specified dimensions. Unlike [`Fill`][] or [`Resize`][], this method will never upscale an image; if the source image is smaller than the target dimensions, the dimensions of the resulting image are the same as the original.

```go-html-template
{{ with resources.Get "images/original.jpg" }}
  {{ with .Fit "300x175" }}
    <img src="{{ .RelPermalink }}" width="{{ .Width }}" height="{{ .Height }}" alt="">
  {{ end }}
{{ end }}
```

In the example above, `"300x175"` is the processing specification.

{{% include "/_common/methods/resource/processing-spec.md" %}}

## Example

```go-html-template
{{ with resources.Get "images/original.jpg" }}
  {{ with .Fit "300x175" }}
    <img src="{{ .RelPermalink }}" width="{{ .Width }}" height="{{ .Height }}" alt="">
  {{ end }}
{{ end }}
```

{{< img
  src="images/examples/zion-national-park.jpg"
  alt="Zion National Park"
  filter="Process"
  filterArgs="fit 300x175"
  example=true
>}}

[`Fill`]: /methods/resource/fill/
[`Resize`]: /methods/resource/resize/
[`reflect.IsImageResourceProcessable`]: /functions/reflect/isimageresourceprocessable/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/resource/Height.md
---


{{% include "/_common/methods/resource/global-page-remote-resources.md" %}}

Use the [`reflect.IsImageResourceWithMeta`][] function to verify that Hugo can determine the dimensions before calling the `Height` method.

```go-html-template
{{ with resources.GetMatch "images/featured.*" }}
  {{ if reflect.IsImageResourceWithMeta . }}
    <img src="{{ .RelPermalink }}" width="{{ .Width }}" height="{{ .Height }}" alt="">
  {{ else }}
    <img src="{{ .RelPermalink }}" alt="">
  {{ end }}
{{ end }}
```

[`reflect.IsImageResourceWithMeta`]: /functions/reflect/isimageresourcewithmeta/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/resource/MediaType.md
---


{{% include "/_common/methods/resource/global-page-remote-resources.md" %}}

## Example

```go-html-template
{{ with resources.Get "images/a.jpg" }}
  {{ .MediaType.Type }} → image/jpeg
  {{ .MediaType.MainType }} → image
  {{ .MediaType.SubType }} → jpeg
  {{ .MediaType.Suffixes }} → [jpg jpeg jpe jif jfif]
  {{ .MediaType.FirstSuffix.Suffix }} → jpg
{{ end }}
```

## Methods

Use these methods on the `MediaType` object.

{{% include "/_common/methods/media-type/core-methods.md" %}}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/resource/Meta.md
---


{{< new-in 0.155.3 />}}

{{% include "/_common/methods/resource/global-page-remote-resources.md" %}}

The `Meta` method on an image `Resource` object returns an object containing [Exif][], [IPTC][], and [XMP][] metadata.

While Hugo classifies many file types as images, only certain formats support metadata extraction. Supported formats include AVIF, BMP, GIF, HEIC, HEIF, JPEG, PNG, TIFF, and WebP.

> [!NOTE]
> Metadata is not preserved during image transformation. Use this method with the _original_ image resource to extract metadata from supported formats.

## Usage

Use the [`reflect.IsImageResourceWithMeta`][] function to verify that a resource supports metadata extraction before calling the `Meta` method.

```go-html-template
{{ with resources.GetMatch "images/featured.*" }}
  {{ if reflect.IsImageResourceWithMeta . }}
    {{ with .Meta }}
      {{ .Date.Format "2006-01-02" }}
    {{ end }}
  {{ end }}
{{ end }}
```

## Methods

Use these methods on the `Meta` object.

`Date`
: (`time.Time`) Returns the image creation date/time. Format with the [`time.Format`][] function.

`Lat`
: (`float64`) Returns the GPS latitude in degrees from Exif metadata, with a fallback to XMP metadata.

`Long`
: (`float64`) Returns the GPS longitude in degrees from Exif metadata, with a fallback to XMP metadata.

`Orientation`
: (`int`) Returns the value of the Exif `Orientation` tag, one of eight possible values.

  Value|Description
  :--|:--
  `1`|Horizontal (normal)
  `2`|Mirrored horizontal
  `3`|Rotated 180 degrees
  `4`|Mirrored vertical
  `5`|Mirrored horizontal and rotated 270 degrees clockwise
  `6`|Rotated 90 degrees clockwise
  `7`|Mirrored horizontal and rotated 90 degrees clockwise
  `8`|Rotated 270 degrees clockwise

  > [!TIP]
  > Use the [`images.AutoOrient`][] image filter to rotate and flip an image as needed per its Exif orientation tag

`Exif`
: (`meta.Tags`) Returns a collection of available Exif fields for this image. Availability is determined by the [`sources`][] setting and specific fields are managed via the [`fields`][] setting, both of which are managed in your project configuration.

`IPTC`
: (`meta.Tags`) Returns a collection of available IPTC fields for this image. Availability is determined by the [`sources`][] setting and specific fields are managed via the [`fields`][] setting, both of which are managed in your project configuration.

`XMP`
: (`meta.Tags`) Returns a collection of available XMP fields for this image. Availability is determined by the [`sources`][] setting and specific fields are managed via the [`fields`][] setting, both of which are managed in your project configuration.

## Examples

To list the creation date, latitude, longitude, and orientation:

```go-html-template
{{ with resources.GetMatch "images/featured.*" }}
  {{ if reflect.IsImageResourceWithMeta . }}
    {{ with .Meta }}
      <pre>
        {{ printf "%-25s %v\n" "Date" .Date }}
        {{ printf "%-25s %v\n" "Latitude" .Lat }}
        {{ printf "%-25s %v\n" "Longitude" .Long }}
        {{ printf "%-25s %v\n" "Orientation" .Orientation }}
      </pre>
    {{ end }}
  {{ end }}
{{ end }}
```

{{% include "/_common/functions/reflect/image-reflection-functions.md" %}}

[Exif]: https://en.wikipedia.org/wiki/Exif
[IPTC]: https://en.wikipedia.org/wiki/IPTC_Information_Interchange_Model
[XMP]: https://en.wikipedia.org/wiki/Extensible_Metadata_Platform
[`fields`]: /configuration/imaging/#fields
[`images.AutoOrient`]: /functions/images/autoorient/
[`reflect.IsImageResourceWithMeta`]: /functions/reflect/isimageresourcewithmeta/
[`sources`]: /configuration/imaging/#sources
[`time.Format`]: /functions/time/format/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/resource/Name.md
---


The value returned by the `Name` method on a `Resource` object depends on the resource type.

## Global resource

With a [global resource](g), the `Name` method returns the path to the resource, relative to the `assets` directory.

```tree
assets/
└── images/
    └── Sunrise in Bryce Canyon.jpg
```

```go-html-template
{{ with resources.Get "images/Sunrise in Bryce Canyon.jpg" }}
  {{ .Name }} → /images/Sunrise in Bryce Canyon.jpg
{{ end }}
```

## Page resource

With a [page resource](g), if you create an element in the `resources` array in front matter, the `Name` method returns the value of the `name` parameter.

```tree
content/
├── example/
│   ├── images/
│   │   └── a.jpg
│   └── index.md
└── _index.md
```

{{< code-toggle file=content/example/index.md fm=true >}}
title = 'Example'
[[resources]]
src = 'images/a.jpg'
name = 'Sunrise in Bryce Canyon'
{{< /code-toggle >}}

```go-html-template
{{ with .Resources.Get "images/a.jpg" }}
  {{ .Name }} → Sunrise in Bryce Canyon
{{ end }}
```

You can also capture the image by specifying its `name` instead of its path:

```go-html-template
{{ with .Resources.Get "Sunrise in Bryce Canyon" }}
  {{ .Name }} → Sunrise in Bryce Canyon
{{ end }}
```

If you do not create an element in the `resources` array in front matter, the `Name` method returns the file path, relative to the page bundle.

```tree
content/
├── example/
│   ├── images/
│   │   └── Sunrise in Bryce Canyon.jpg
│   └── index.md
└── _index.md
```

```go-html-template
{{ with .Resources.Get "images/Sunrise in Bryce Canyon.jpg" }}
  {{ .Name }} → images/Sunrise in Bryce Canyon.jpg
{{ end }}
```

## Remote resource

With a [remote resource](g), the `Name` method returns a hashed file name.

```go-html-template
{{ with resources.GetRemote "https://example.org/images/a.jpg" }}
  {{ .Name }} → /a_18432433023265451104.jpg
{{ end }}
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/resource/Params.md
---


Use the `Params` method with [page resources](g). It is not applicable to either [global resources](g) or [remote resources](g).

With this content structure:

```tree
content/
├── posts/
│   ├── cats/
│   │   ├── images/
│   │   │   └── a.jpg
│   │   └── index.md
│   └── _index.md
└── _index.md
```

And this front matter:

{{< code-toggle file=content/posts/cats.md fm=true >}}
title = 'Cats'
[[resources]]
  src = 'images/a.jpg'
  title = 'Felix the cat'
  [resources.params]
    alt = 'Photograph of black cat'
    temperament = 'vicious'
{{< /code-toggle >}}

And this template:

```go-html-template
{{ with .Resources.Get "images/a.jpg" }}
  <figure>
    <img alt="{{ .Params.alt }}" src="{{ .RelPermalink }}" width="{{ .Width }}" height="{{ .Height }}">
    <figcaption>{{ .Title }} is {{ .Params.temperament }}</figcaption>
  </figure>
{{ end }}
```

Hugo renders:

```html
<figure>
  <img alt="Photograph of black cat" src="/posts/post-1/images/a.jpg" width="600" height="400">
  <figcaption>Felix the cat is vicious</figcaption>
</figure>
```

See the [page resources][] section for more information.

[page resources]: /content-management/page-resources/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/resource/Permalink.md
---


{{% include "/_common/methods/resource/global-page-remote-resources.md" %}}

The `Permalink` method on a `Resource` object writes the resource to the publish directory, typically `public`, and returns its [permalink](g).

```go-html-template
{{ with resources.Get "images/a.jpg" }}
  {{ .Permalink }} → https://example.org/images/a.jpg
{{ end }}
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/resource/Process.md
---


{{% include "/_common/methods/resource/global-page-remote-resources.md" %}}

The `Process` method returns a new resource from a [processable image](g) according to the given [processing specification](#processing-specification).

> [!NOTE]
> Use the [`reflect.IsImageResourceProcessable`][] function to verify that an image can be processed.

## Usage

This versatile method supports the full range of image transformations including resizing, cropping, rotation, and format conversion within a single specification string. Unlike specialized methods such as [`Resize`][] or [`Crop`][], you must explicitly include the [action](#action) in the specification if you are changing the image dimensions.

```go-html-template
{{ with resources.Get "images/original.jpg" }}
  {{ with .Process "crop 200x200 TopRight webp q50" }}
    <img src="{{ .RelPermalink }}" width="{{ .Width }}" height="{{ .Height }}" alt="">
  {{ end }}
{{ end }}
```

In the example above, `"crop 200x200 TopRight webp q50"` is the processing specification.

You can also use this method to apply simple transformations such as rotation and conversion:

```go-html-template
{{/* Rotate 90 degrees counter-clockwise. */}}
{{ $image := $image.Process "r90" }}

{{/* Convert to WebP. */}}
{{ $image := $image.Process "webp" }}
```

The `Process` method is also available as a filter. This is more effective if you need to apply multiple filters to an image. See [`images.Process`][].

{{% include "/_common/methods/resource/processing-spec.md" %}}

## Example

```go-html-template
{{ with resources.Get "images/original.jpg" }}
  {{ with .Process "crop 200x200 TopRight webp q50" }}
    <img src="{{ .RelPermalink }}" width="{{ .Width }}" height="{{ .Height }}" alt="">
  {{ end }}
{{ end }}
```

{{< img
  src="images/examples/zion-national-park.jpg"
  alt="Zion National Park"
  filter="Process"
  filterArgs="crop 200x200 TopRight webp q50"
  example=true
>}}

[`Crop`]: /methods/resource/crop/
[`Resize`]: /methods/resource/resize/
[`images.Process`]: /functions/images/process/
[`reflect.IsImageResourceProcessable`]: /functions/reflect/isimageresourceprocessable/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/resource/Publish.md
---


{{% include "/_common/methods/resource/global-page-remote-resources.md" %}}

The `Publish` method on a `Resource` object writes the resource to the publish directory, typically `public`.

```go-html-template
{{ with resources.Get "images/a.jpg" }}
  {{ .Publish }}
{{ end }}
```

The `Permalink` and `RelPermalink` methods also publish a resource. `Publish` is a convenience method for publishing without a return value. For example, this:

```go-html-template
{{ $resource.Publish }}
```

Instead of this:

```go-html-template
{{ $noop := $resource.Permalink }}
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/resource/RelPermalink.md
---


{{% include "/_common/methods/resource/global-page-remote-resources.md" %}}

The `Permalink` method on a `Resource` object writes the resource to the publish directory, typically `public`, and returns its [relative permalink](g).

```go-html-template
{{ with resources.Get "images/a.jpg" }}
  {{ .RelPermalink }} → /images/a.jpg
{{ end }}
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/resource/Resize.md
---


{{% include "/_common/methods/resource/global-page-remote-resources.md" %}}

The `Resize` method returns a new resource from a [processable image](g) according to the given [processing specification](#processing-specification).

> [!NOTE]
> Use the [`reflect.IsImageResourceProcessable`][] function to verify that an image can be processed.

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

## Example

```go-html-template
{{ with resources.Get "images/original.jpg" }}
  {{ with .Resize "300x" }}
    <img src="{{ .RelPermalink }}" width="{{ .Width }}" height="{{ .Height }}" alt="">
  {{ end }}
{{ end }}
```

{{< img
  src="images/examples/zion-national-park.jpg"
  alt="Zion National Park"
  filter="Process"
  filterArgs="resize 300x"
  example=true
>}}

[`reflect.IsImageResourceProcessable`]: /functions/reflect/isimageresourceprocessable/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/resource/ResourceType.md
---


{{% include "/_common/methods/resource/global-page-remote-resources.md" %}}

Common resource types include `audio`, `image`, `text`, and `video`.

```go-html-template
{{ with resources.Get "image/a.jpg" }}
  {{ .ResourceType }} → image
  {{ .MediaType.MainType }} → image
{{ end }}
```

When working with content files, the resource type is `page`.

```tree
content/
├── lessons/
│   ├── lesson-1/
│   │   ├── _objectives.md  <-- resource type = page
│   │   ├── _topics.md      <-- resource type = page
│   │   ├── _example.jpg    <-- resource type = image
│   │   └── index.md
│   └── _index.md
└── _index.md
```

With the structure above, we can range through page resources of type `page` to build content:

```go-html-template {file="layouts/lessons/page.html"}
{{ range .Resources.ByType "page" }}
  {{ .Content }}
{{ end }}
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/resource/Title.md
---


The value returned by the `Title` method on a `Resource` object depends on the resource type.

## Global resource

With a [global resource](g), the `Title` method returns the path to the resource, relative to the `assets` directory.

```tree
assets/
└── images/
    └── Sunrise in Bryce Canyon.jpg
```

```go-html-template
{{ with resources.Get "images/Sunrise in Bryce Canyon.jpg" }}
  {{ .Title }} → /images/Sunrise in Bryce Canyon.jpg
{{ end }}
```

## Page resource

With a [page resource](g), if you create an element in the `resources` array in front matter, the `Title` method returns the value of the `title` parameter.

```tree
content/
├── example/
│   ├── images/
│   │   └── a.jpg
│   └── index.md
└── _index.md
```

{{< code-toggle file=content/example/index.md fm=true >}}
title = 'Example'
[[resources]]
src = 'images/a.jpg'
title = 'A beautiful sunrise in Bryce Canyon'
{{< /code-toggle >}}

```go-html-template
{{ with .Resources.Get "images/a.jpg" }}
  {{ .Title }} → A beautiful sunrise in Bryce Canyon
{{ end }}
```

If you do not create an element in the `resources` array in front matter, the `Title` method returns the file path, relative to the page bundle.

```tree
content/
├── example/
│   ├── images/
│   │   └── Sunrise in Bryce Canyon.jpg
│   └── index.md
└── _index.md
```

```go-html-template
{{ with .Resources.Get "Sunrise in Bryce Canyon.jpg" }}
  {{ .Title }} → images/Sunrise in Bryce Canyon.jpg
{{ end }}
```

## Remote resource

With a [remote resource](g), the `Title` method returns a hashed file name.

```go-html-template
{{ with resources.GetRemote "https://example.org/images/a.jpg" }}
  {{ .Title }} → /a_18432433023265451104.jpg
{{ end }}
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/resource/Width.md
---


{{% include "/_common/methods/resource/global-page-remote-resources.md" %}}

Use the [`reflect.IsImageResourceWithMeta`][] function to verify that Hugo can determine the dimensions before calling the `Width` method.

```go-html-template
{{ with resources.GetMatch "images/featured.*" }}
  {{ if reflect.IsImageResourceWithMeta . }}
    <img src="{{ .RelPermalink }}" width="{{ .Width }}" height="{{ .Height }}" alt="">
  {{ else }}
    <img src="{{ .RelPermalink }}" alt="">
  {{ end }}
{{ end }}
```

[`reflect.IsImageResourceWithMeta`]: /functions/reflect/isimageresourcewithmeta/

