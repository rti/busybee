## Image filters

Use any of these filters with the `images.Filter` function, or with the `Filter` method on a `Resource` object.

{{% render-list-of-pages-in-section path=/functions/images filter=functions_images_no_filters filterType=exclude %}}

[`Filter`]: /methods/resource/filter/
[`reflect.IsImageResourceProcessable`]: /functions/reflect/isimageresourceprocessable/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/images/Gamma.md
---


The gamma value must be positive. A value greater than 1 lightens the image, while a value less than 1 darkens the image. The filter has no effect when the gamma value is&nbsp;1.

