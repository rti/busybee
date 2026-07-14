
---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/shortcodes/details.md
---


{{< new-in 0.140.0 />}}

> [!NOTE]
> To override Hugo's embedded `details` shortcode, copy the [source code][] to a file with the same name in the `layouts/_shortcodes` directory.

## Example

With this Markdown:

```md
{{</* details summary="See the details" */>}}
This is a **bold** word.
{{</* /details */>}}
```

Hugo renders this HTML:

```html
<details>
  <summary>See the details</summary>
  <p>This is a <strong>bold</strong> word.</p>
</details>
```

Which looks like this in your browser:

{{< details summary="See the details" >}}
This is a **bold** word.
{{< /details >}}

## Arguments

`summary`
: (`string`) The content of the child `summary` element rendered from Markdown to HTML. Default is `Details`.

`open`
: (`bool`) Whether to initially display the content of the `details` element. Default is `false`.

`class`
: (`string`) The `class` attribute of the `details` element.

`name`
: (`string`) The `name` attribute of the `details` element.

`title`
: (`string`) The `title` attribute of the `details` element.

## Styling

Use CSS to style the `details` element, the `summary` element, and the content itself.

```css
/* target the details element */
details { }

/* target the summary element */
details > summary { }

/* target the children of the summary element */
details > summary > * { }

/* target the content */
details > :not(summary) { }
```

[source code]: <{{% eturl details %}}>


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/shortcodes/figure.md
---


> [!NOTE]
> To override Hugo's embedded `figure` shortcode, copy the [source code][] to a file with the same name in the `layouts/_shortcodes` directory.

## Example

With this Markdown:

```md
{{</* figure
  src="/images/examples/zion-national-park.jpg"
  alt="A photograph of Zion National Park"
  link="https://www.nps.gov/zion/index.htm"
  caption="Zion National Park"
  class="ma0 w-75"
*/>}}
```

Hugo renders this HTML:

```html
<figure class="ma0 w-75">
  <a href="https://www.nps.gov/zion/index.htm">
    <img
      src="/images/examples/zion-national-park.jpg"
      alt="A photograph of Zion National Park"
    >
  </a>
  <figcaption>
    <p>Zion National Park</p>
  </figcaption>
</figure>
```

Which looks like this in your browser:

{{< figure
  src="/images/examples/zion-national-park.jpg"
  alt="A photograph of Zion National Park"
  link="https://www.nps.gov/zion/index.htm"
  caption="Zion National Park"
  class="ma0 w-75"
>}}

## Arguments

`src`
: (`string`) The `src` attribute of the `img` element. Typically this is a [page resource](g) or a [global resource](g).

`alt`
: (`string`) The `alt` attribute of the `img` element.

`width`
: (`int`) The `width` attribute of the `img` element.

`height`
: (`int`) The `height` attribute of the `img` element.

`loading`
: (`string`) The `loading` attribute of the `img` element.

`class`
: (`string`) The `class` attribute of the `figure` element.

`link`
: (`string`) The `href` attribute of the anchor element that wraps the `img` element.

`target`
: (`string`) The `target` attribute of the anchor element that wraps the `img` element.

`rel`
: (`rel`) The `rel` attribute of the anchor element that wraps the `img` element.

`title`
: (`string`) Within the `figurecaption` element, the title is at the top, wrapped within an `h4` element.

`caption`
: (`string`) Within the `figurecaption` element, the caption is at the bottom and may contain plain text or markdown.

`attr`
: (`string`) Within the `figurecaption` element, the attribution appears next to the caption and may contain plain text or markdown.

`attrlink`
: (`string`) The `href` attribute of the anchor element that wraps the attribution.

## Image location

The `figure` shortcode resolves internal Markdown destinations by looking for a matching [page resource](g), falling back to a matching [global resource](g). Remote destinations are passed through, and the render hook will not throw an error or warning if unable to resolve a destination.

You must place global resources in the `assets` directory. If you have placed your resources in the `static` directory, and you are unable or unwilling to move them, you must mount the `static` directory to the `assets` directory by including both of these entries in your project configuration:

{{< code-toggle file=hugo >}}
[[module.mounts]]
source = 'assets'
target = 'assets'

[[module.mounts]]
source = 'static'
target = 'assets'
{{< /code-toggle >}}

[source code]: <{{% eturl figure %}}>


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/shortcodes/highlight.md
---


> [!NOTE]
> To override Hugo's embedded `highlight` shortcode, copy the [source code][] to a file with the same name in the `layouts/_shortcodes` directory.

> [!NOTE]
> With the Markdown [content format][], the `highlight` shortcode is rarely needed because, by default, Hugo automatically applies syntax highlighting to fenced code blocks.
>
> The primary use case for the `highlight` shortcode in Markdown is to apply syntax highlighting to inline code snippets.

The `highlight` shortcode calls the [`transform.Highlight`][] function to generate syntax-highlighted HTML from the provided code, [language][], and [options](#options-1).

## Arguments

The `highlight` shortcode takes three arguments.

```md
{{</* highlight LANG OPTIONS */>}}
CODE
{{</* /highlight */>}}
```

`CODE`
: (`string`) The code to highlight.

`LANG`
: (`string`) The [language][] of the code to highlight. This value is case-insensitive.

`OPTIONS`
: (`string`) Zero or more space-separated key-value pairs wrapped in quotation marks. You can set default values for each option in your [project configuration][]. The key names are case-insensitive.

## Example

```md {file="content/example.md"}
{{</* highlight go "linenos=inline, hl_lines=3 6-8, style=emacs" */>}}
package main

import "fmt"

func main() {
    for i := 0; i < 3; i++ {
        fmt.Println("Value of i:", i)
    }
}
{{</* /highlight */>}}
```

Hugo renders this to:

{{< highlight go "linenos=inline, hl_Lines=3 6-8, noClasses=true" >}}
package main

import "fmt"

func main() {
    for i := 0; i < 3; i++ {
            fmt.Println("Value of i:", i)
    }
}
{{< /highlight >}}

You can also use the `highlight` shortcode for inline code snippets:

```md
This is some {{</* highlight go "hl_inline=true" */>}}fmt.Println("inline"){{</* /highlight */>}} code.
```

Hugo renders this to:

This is some {{< highlight go "hl_inline=true, noClasses=true" >}}fmt.Println("inline"){{< /highlight >}} code.

Given the verbosity of the example above, if you need to frequently highlight inline code snippets, create your own shortcode using a shorter name with preset options.

```go-html-template {file="layouts/_shortcodes/hl.html"}
{{ $code := .Inner | strings.TrimSpace }}
{{ $lang := or (.Get 0) "go" }}
{{ $opts := dict "hl_inline" true "noClasses" true }}
{{ transform.Highlight $code $lang $opts }}
```

```md
This is some {{</* hl */>}}fmt.Println("inline"){{</* /hl */>}} code.
```

Hugo renders this to:

This is some {{< hl >}}fmt.Println("inline"){{< /hl >}} code.

## Options

{{% include "_common/syntax-highlighting-options.md" %}}

[`transform.Highlight`]: /functions/transform/highlight/
[content format]: /content-management/formats/
[language]: /content-management/syntax-highlighting/#languages
[project configuration]: /configuration/markup/#highlight
[source code]: <{{% eturl highlight %}}>


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/shortcodes/instagram.md
---


> [!NOTE]
> To override Hugo's embedded `instagram` shortcode, copy the [source code][] to a file with the same name in the `layouts/_shortcodes` directory.

## Example

To display an Instagram post with this URL:

```text
https://www.instagram.com/p/CxOWiQNP2MO/
```

Include this in your Markdown:

```md
{{</* instagram CxOWiQNP2MO */>}}
```

Huge renders this to:

{{< instagram CxOWiQNP2MO >}}

## Privacy

Adjust the relevant privacy settings in your project configuration.

{{< code-toggle config=privacy.instagram />}}

`disable`
: (`bool`) Whether to disable the shortcode. Default is `false`.

`simple`
: (`bool`) Whether to enable simple mode for image card generation. If `true`, Hugo creates a static card without JavaScript. This mode only supports image cards, and the image is fetched directly from Instagram's servers. Default is `false`.

[source code]: <{{% eturl instagram %}}>


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/shortcodes/param.md
---


> [!NOTE]
> To override Hugo's embedded `param` shortcode, copy the [source code][] to a file with the same name in the `layouts/_shortcodes` directory.

The `param` shortcode renders a parameter from front matter, falling back to a site parameter of the same name. The shortcode throws an error if the parameter does not exist.

```md {file="content/example.md"}

We found a {{%/* param "color" */%}} shirt.
```

Hugo renders this to:

```html
<p>We found a red shirt.</p>
```

Access nested values by [chaining](g) the [identifiers](g):

```md
{{%/* param my.nested.param */%}}
```

[source code]: <{{% eturl param %}}>


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/shortcodes/qr.md
---


{{< new-in 0.141.0 />}}

> [!NOTE]
> To override Hugo's embedded `qr` shortcode, copy the [source code][] to a file with the same name in the `layouts/_shortcodes` directory.

The `qr` shortcode encodes the given text into a [QR code][] using the specified options and renders the resulting image.

Internally this shortcode calls the `images.QR` function. Please read the [related documentation][] for implementation details and guidance.

## Examples

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

Both of the above produce this image:

{{< qr text="https://gohugo.io" class="qrcode" targetDir="images/qr" />}}

To create a QR code for a phone number:

```md
{{</* qr text="tel:+12065550101" /*/>}}
```

{{< qr text="tel:+12065550101" class="qrcode" targetDir="images/qr" />}}

To create a QR code containing contact information in the [vCard][] format:

```md
{{</* qr level="low" scale=2 alt="QR code of vCard for John Smith" */>}}
BEGIN:VCARD
VERSION:2.1
N;CHARSET=UTF-8:Smith;John;R.;Dr.;PhD
FN;CHARSET=UTF-8:Dr. John R. Smith, PhD.
ORG;CHARSET=UTF-8:ABC Widgets
TITLE;CHARSET=UTF-8:Vice President Engineering
TEL;TYPE=WORK:+12065550101
EMAIL;TYPE=WORK:jsmith@example.org
END:VCARD
{{</* /qr */>}}
```

{{< qr level="low" scale=2 alt="QR code of vCard for John Smith" class="qrcode" targetDir="images/qr" >}}
BEGIN:VCARD
VERSION:2.1
N;CHARSET=UTF-8:Smith;John;R.;Dr.;PhD
FN;CHARSET=UTF-8:Dr. John R. Smith, PhD.
ORG;CHARSET=UTF-8:ABC Widgets
TITLE;CHARSET=UTF-8:Vice President Engineering
TEL;TYPE=WORK:+12065550101
EMAIL;TYPE=WORK:jsmith@example.org
END:VCARD
{{< /qr >}}

## Arguments

`text`
: (`string`) The text to encode, falling back to the text between the opening and closing shortcode tags.

`level`
: (`string`) The error correction level to use when encoding the text, one of `low`, `medium`, `quartile`, or `high`. Default is `medium`.

`scale`
: (`int`) The number of image pixels per QR code module. Must be greater than or equal to 2. Default is `4`.

`targetDir`
: (`string`) The subdirectory within the [`publishDir`][] where Hugo will place the generated image.

`alt`
: (`string`) The `alt` attribute of the `img` element.

`class`
: (`string`) The `class` attribute of the `img` element.

`id`
: (`string`) The `id` attribute of the `img` element.

`loading`
: (`string`) The `loading` attribute of the `img` element, either `eager` or `lazy`.

`title`
: (`string`) The `title` attribute of the `img` element.

[QR code]: https://en.wikipedia.org/wiki/QR_code
[`publishDir`]: /configuration/all/#publishdir
[related documentation]: /functions/images/qr/
[source code]: <{{% eturl qr %}}>
[vCard]: <https://en.wikipedia.org/wiki/VCard>


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/shortcodes/ref.md
---


> [!NOTE]
> To override Hugo's embedded `ref` shortcode, copy the [source code][] to a file with the same name in the `layouts/_shortcodes` directory.

> [!NOTE]
> When working with Markdown this shortcode is obsolete. Instead, to properly resolve Markdown link destinations, use the [embedded link render hook][] or create your own.
>
> In its default configuration, Hugo automatically uses the embedded link render hook for multilingual single-host projects, specifically when the [duplication of shared page resources][] feature is disabled. This is the default behavior for such projects. If custom link render hooks are defined by your project, modules, or themes, these will be used instead.
>
> You can also configure Hugo to `always` use the embedded link render hook, use it only as a `fallback`, or `never` use it. See [details][].

## Usage

The `ref` shortcode accepts either a single positional argument (the path) or one or more named arguments, as listed below.

## Arguments

{{% include "_common/ref-and-relref-options.md" %}}

## Examples

The `ref` shortcode typically provides the destination for a Markdown link.

> [!NOTE]
> Always use [Markdown notation][] notation when calling this shortcode.

The following examples show the rendered output for a page on the English version of the site:

```md
[Link A]({{%/* ref "/books/book-1" */%}})

[Link B]({{%/* ref path="/books/book-1" */%}})

[Link C]({{%/* ref path="/books/book-1" lang="de" */%}})

[Link D]({{%/* ref path="/books/book-1" lang="de" outputFormat="json" */%}})
```

Rendered:

```html
<a href="https://example.org/en/books/book-1/">Link A</a>

<a href="https://example.org/en/books/book-1/">Link B</a>

<a href="https://example.org/de/books/book-1/">Link C</a>

<a href="https://example.org/de/books/book-1/index.json">Link D</a>
```

## Error handling

{{% include "_common/ref-and-relref-error-handling.md" %}}

[Markdown notation]: /content-management/shortcodes/#notation
[details]: /configuration/markup/#renderhookslinkuseembedded
[duplication of shared page resources]: /configuration/markup/#duplicateresourcefiles
[embedded link render hook]: /render-hooks/links/#embedded
[source code]: <{{% eturl ref %}}>


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/shortcodes/relref.md
---


> [!NOTE]
> To override Hugo's embedded `relref` shortcode, copy the [source code][] to a file with the same name in the `layouts/_shortcodes` directory.

> [!NOTE]
> When working with Markdown this shortcode is obsolete. Instead, to properly resolve Markdown link destinations, use the [embedded link render hook][] or create your own.
>
> In its default configuration, Hugo automatically uses the embedded link render hook for multilingual single-host projects, specifically when the [duplication of shared page resources][] feature is disabled. This is the default behavior for such projects. If custom link render hooks are defined by your project, modules, or themes, these will be used instead.
>
> You can also configure Hugo to `always` use the embedded link render hook, use it only as a `fallback`, or `never` use it. See [details][].

## Usage

The `relref` shortcode accepts either a single positional argument (the path) or one or more named arguments, as listed below.

## Arguments

{{% include "_common/ref-and-relref-options.md" %}}

## Examples

The `relref` shortcode typically provides the destination for a Markdown link.

> [!NOTE]
> Always use [Markdown notation][] notation when calling this shortcode.

The following examples show the rendered output for a page on the English version of the site:

```md
[Link A]({{%/* relref "/books/book-1" */%}})

[Link B]({{%/* relref path="/books/book-1" */%}})

[Link C]({{%/* relref path="/books/book-1" lang="de" */%}})

[Link D]({{%/* relref path="/books/book-1" lang="de" outputFormat="json" */%}})
```

Rendered:

```html
<a href="/en/books/book-1/">Link A</a>

<a href="/en/books/book-1/">Link B</a>

<a href="/de/books/book-1/">Link C</a>

<a href="/de/books/book-1/index.json">Link D</a>
```

## Error handling

{{% include "_common/ref-and-relref-error-handling.md" %}}

[Markdown notation]: /content-management/shortcodes/#notation
[details]: /configuration/markup/#renderhookslinkuseembedded
[duplication of shared page resources]: /configuration/markup/#duplicateresourcefiles
[embedded link render hook]: /render-hooks/links/#embedded
[source code]: <{{% eturl relref %}}>


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/shortcodes/vimeo.md
---


> [!NOTE]
> To override Hugo's embedded `vimeo` shortcode, copy the [source code][] to a file with the same name in the `layouts/_shortcodes` directory.

## Example

To display a Vimeo video with this URL:

```text
https://vimeo.com/19899678
```

Include this in your Markdown:

```md
{{</* vimeo 19899678 */>}}
```

Hugo renders this to:

{{< vimeo 19899678 >}}

## Arguments

`id`
: (string) The video `id`. Optional if the `id` is the first and only positional argument.

`allowFullScreen`
: {{< new-in 0.146.0 />}}
: (`bool`) Whether the `iframe` element can activate full screen mode. Default is `true`.

`class`
: (`string`) The `class` attribute of the wrapping `div` element. Adding one or more CSS classes disables inline styling.

`loading`
: {{< new-in 0.146.0 />}}
: (`string`) The loading attribute of the `iframe` element, either `eager` or `lazy`. Default is `eager`.

`title`
: (`string`) The `title` attribute of the `iframe` element.

Here's an example using some of the available arguments:

```md
{{</* vimeo id=19899678 allowFullScreen=false loading=lazy */>}}
```

## Privacy

Adjust the relevant privacy settings in your project configuration.

{{< code-toggle config=privacy.vimeo />}}

`disable`
: (`bool`) Whether to disable the shortcode. Default is `false`.

`enableDNT`
: (`bool`) Whether to block the Vimeo player from tracking session data and analytics. Default is `false`.

`simple`
: (`bool`) Whether to enable simple mode. If `true`, the video thumbnail is fetched from Vimeo and overlaid with a play button. Clicking the thumbnail opens the video in a new Vimeo tab. Default is `false`.

The source code for the simple version of the shortcode is available [in this file][].

[in this file]: <{{% eturl vimeo_simple %}}>
[source code]: <{{% eturl vimeo %}}>


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/shortcodes/x.md
---


{{< new-in 0.141.0 />}}

> [!NOTE]
> To override Hugo's embedded `x` shortcode, copy the [source code][] to a file with the same name in the `layouts/_shortcodes` directory.

## Example

To display an X post with this URL:

```txt
https://x.com/SanDiegoZoo/status/1453110110599868418
```

Include this in your Markdown:

```md
{{</* x user="SanDiegoZoo" id="1453110110599868418" */>}}
```

Rendered:

{{< x user="SanDiegoZoo" id="1453110110599868418" >}}

## Privacy

Adjust the relevant privacy settings in your project configuration.

{{< code-toggle config=privacy.x />}}

`disable`
: (`bool`) Whether to disable the shortcode. Default is `false`.

`enableDNT`
: (`bool`) Whether to prevent X from using post and embedded page data for personalized suggestions and ads. Default is `false`.

`simple`
: (`bool`) Whether to enable simple mode. If `true`, Hugo builds a static version of the of the post without JavaScript. Default is `false`.

The source code for the simple version of the shortcode is available [in this file][].

If you enable simple mode you may want to disable the hardcoded inline styles by setting `disableInlineCSS` to `true` in your project configuration. The default value for this setting is `false`.

{{< code-toggle config=services.x />}}

[in this file]: <{{% eturl x_simple %}}>
[source code]: <{{% eturl x %}}>


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/shortcodes/youtube.md
---


> [!NOTE]
> To override Hugo's embedded `youtube` shortcode, copy the [source code][] to a file with the same name in the `layouts/_shortcodes` directory.

## Example

To display a YouTube video with this URL:

```text
https://www.youtube.com/watch?v=0RKpf3rK57I
```

Include this in your Markdown:

```md
{{</* youtube 0RKpf3rK57I */>}}
```

Hugo renders this to:

{{< youtube 0RKpf3rK57I >}}

## Arguments

`id`
: (`string`) The video `id`. Optional if the `id` is the first and only positional argument.

`allowFullScreen`
: (`bool`) Whether the `iframe` element can activate full screen mode. Default is `true`.

`autoplay`
: (`bool`) Whether to automatically play the video. Forces `mute` to `true`. Default is `false`.

`class`
: (`string`) The `class` attribute of the wrapping `div` element. When specified, removes the `style` attributes from the `iframe` element and its wrapping `div` element.

`controls`
: (`bool`) Whether to display the video controls. Default is `true`.

`end`
: (`int`) The time, measured in seconds from the start of the video, when the player should stop playing the video.

`loading`
: (`string`) The loading attribute of the `iframe` element, either `eager` or `lazy`. Default is `eager`.

`loop`
: (`bool`) Whether to indefinitely repeat the video. Ignores the `start` and `end` arguments after the first play. Default is `false`.

`mute`
: (`bool`) Whether to mute the video. Always `true` when `autoplay` is `true`. Default is `false`.

`start`
: (`int`) The time, measured in seconds from the start of the video, when the player should start playing the video.

`title`
: (`string`) The `title` attribute of the `iframe` element. Defaults to "YouTube video".

Here's an example using some of the available arguments:

```md
{{</* youtube id=0RKpf3rK57I start=30 end=60 loading=lazy */>}}
```

## Privacy

Adjust the relevant privacy settings in your project configuration.

{{< code-toggle config=privacy.youTube />}}

`disable`
: (`bool`) Whether to disable the shortcode. Default is `false`.

`privacyEnhanced`
: (`bool`) Whether to block YouTube from storing information about visitors on your website unless the user plays the embedded video. Default is `false`.

[source code]: <{{% eturl youtube %}}>

