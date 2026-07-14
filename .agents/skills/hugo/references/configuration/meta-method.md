## Meta method

{{< new-in 0.155.0 />}}

The following parameters allow you to control how Hugo extracts and filters metadata when using the [`Meta`][] method, helping you balance data granularity with build performance.

`fields`
: (`[]string`) A [glob slice](g) matching the fields to include when extracting metadata. If empty, a default set excluding technical metadata is used. Set&nbsp;to&nbsp;`['**']`&nbsp;to include all fields.

  > [!NOTE]
  > By default, to improve performance and decrease cache size, Hugo excludes the following fields: `ColorSpace`, `Contrast`, `Exif`, `ExposureBias`, `ExposureMode`, `ExposureProgram`, `Flash`, `GPS`, `JPEG`, `Metering`, `Resolution`, `Saturation`, `Sensing`, `Sharp`, and `WhiteBalance`.

`sources`
: (`[]string`) The metadata sources to include, one or more of `exif`, `iptc`, or `xmp`. Default is `['exif', 'iptc']`. The XMP metadata is excluded by default to improve performance.

[`avifenc`]: https://github.com/aomediacodec/libavif
[`cwebp`]: https://developers.google.com/speed/webp/docs/cwebp
[`muesli/smartcrop`]: https://github.com/muesli/smartcrop
[hexadecimal color]: https://developer.mozilla.org/en-US/docs/Web/CSS/hex-color
[source documentation]: https://github.com/disintegration/imaging#image-resizing


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/configuration/introduction.md
---


