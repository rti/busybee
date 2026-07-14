## AVIF

{{< new-in 0.162.0 />}}

These settings apply when encoding AVIF images.

> [!NOTE]
> When exporting HDR AVIF images from Lightroom, in the Export dialog under File Settings, uncheck Maximize Compatibility to improve Hugo's AVIF decoding speed.

> [!NOTE]
> Encoding animated images to AVIF produces a single-frame (static) image. Converting an animated AVIF to another format such as GIF works as expected.

{{< code-toggle config=imaging.avif />}}

`compression`
: {{< new-in 0.163.0 />}}
: (`string`) The encoding strategy. Options are `lossy` or `lossless`. Default is `lossy`.

`encoderSpeed`
: (`int`) The encoder speed. Expressed as a whole number from `1` to `10`, inclusive, equivalent to the `-s` flag for the [`avifenc`][] CLI. Lower numbers reduce file size at the cost of build time. At typical web image sizes, quality is indistinguishable across settings. Values below `5` may cause significantly longer build times. Default is `10`.

`hint`
: {{< new-in 0.163.0 />}}
: (`string`) The content hint. Valid options include `drawing`, `icon`, `photo`, `picture`, or `text`. Hugo uses the `4:2:0` chroma subsampling format with `photo` and `picture`, and `4:4:4` with the remaining options. Default is `photo`.

  Value|Example
  :--|:--
  `drawing`|Hand or line drawing with high-contrast details
  `icon`|Small colorful image
  `photo`|Outdoor photograph with natural lighting
  `picture`|Indoor photograph such as a portrait
  `text`|Image that is primarily text

`quality`
: {{< new-in 0.163.0 />}}
: (`int`) The visual fidelity when using `lossy` compression. Expressed as a whole number from `1` to `100`, inclusive. Lower numbers prioritize smaller file size, while higher numbers prioritize visual clarity. Default is `60`. Quality values are encoder-specific and not directly comparable across formats; a value of `60` for AVIF is perceptually similar to `75` for JPEG.

