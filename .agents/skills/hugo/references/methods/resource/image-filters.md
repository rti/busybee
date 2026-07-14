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

