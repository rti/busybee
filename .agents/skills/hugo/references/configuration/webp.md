## WebP

{{< new-in 0.155.0 />}}

These settings apply when encoding WebP images.

{{< code-toggle config=imaging.webp />}}

`compression`
: {{< new-in 0.163.0 />}}
: (`string`) The encoding strategy. Options are `lossy` or `lossless`. Default is `lossy`.

`hint`
: (`string`) The content hint, equivalent to the `-preset` flag for the [`cwebp`][] CLI. Valid options include `drawing`, `icon`, `photo`, `picture`, or `text`. Default is `photo`.

  Value|Example
  :--|:--
  `drawing`|Hand or line drawing with high-contrast details
  `icon`|Small colorful image
  `photo`|Outdoor photograph with natural lighting
  `picture`|Indoor photograph such as a portrait
  `text`|Image that is primarily text

`method`
: (`int`) The effort level of the compression algorithm. Expressed as a whole number from `0` to `6`, inclusive, equivalent to the `-m` flag for the [`cwebp`][] CLI. Lower numbers prioritize processing speed, while higher numbers prioritize compression efficiency and image quality. Default is `2`.

`quality`
: {{< new-in 0.163.0 />}}
: (`int`) The visual fidelity when using `lossy` compression. Expressed as a whole number from `1` to `100`, inclusive. Lower numbers prioritize smaller file size, while higher numbers prioritize visual clarity. Default is `75`.

`useSharpYuv`
: (`bool`) The conversion method used for RGB-to-YUV encoding, equivalent to the `-sharp_yuv` flag for the [`cwebp`][] CLI. Enabling this prioritizes image sharpness at the expense of processing speed. Default is `false`.

