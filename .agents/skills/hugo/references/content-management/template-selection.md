## Template selection

Hugo has a defined [lookup order][] to determine which template to use when rendering a page. The [lookup rules][] consider the top-level section name; subsection names are not considered when selecting a template.

With the file structure from the [example above](#overview):

Content directory|Section template
:--|:--
`content/products`|`layouts/products/section.html`
`content/products/product-1`|`layouts/products/section.html`
`content/products/product-1/benefits`|`layouts/products/section.html`

Content directory|Page template
:--|:--
`content/products`|`layouts/products/page.html`
`content/products/product-1`|`layouts/products/page.html`
`content/products/product-1/benefits`|`layouts/products/page.html`

If you need to use a different template for a subsection, specify `type` and/or `layout` in front matter.

