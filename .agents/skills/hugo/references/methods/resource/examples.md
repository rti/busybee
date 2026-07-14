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

