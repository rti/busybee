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

