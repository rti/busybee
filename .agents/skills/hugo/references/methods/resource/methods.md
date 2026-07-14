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

