## Nested menu

This nested menu demonstrates some of the available properties:

<!-- markdownlint-disable MD033 -->
{{< code-toggle file=hugo >}}
[[menus.main]]
name = 'Products'
pageRef = '/products'
weight = 10

[[menus.main]]
name = 'Hardware'
pageRef = '/products/hardware'
parent = 'Products'
weight = 1

[[menus.main]]
name = 'Software'
pageRef = '/products/software'
parent = 'Products'
weight = 2

[[menus.main]]
name = 'Services'
pageRef = '/services'
weight = 20

[[menus.main]]
name = 'Hugo'
pre = '<i class="fa fa-heart"></i>'
url = 'https://gohugo.io/'
weight = 30
[menus.main.params]
rel = 'external'
{{< /code-toggle >}}
<!-- markdownlint-enable MD033 -->

[Automatically]: /content-management/menus/#define-automatically
[`Menus`]: /methods/site/menus/
[front matter]: /content-management/menus/#define-in-front-matter
[menu templates]: /templates/menu/
[menus]: /content-management/menus/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/configuration/minify.md
---


This is the default configuration:

{{< code-toggle config=minify />}}

See the [`tdewolff/minify`][] project page for details, but note the following:

- `css.inline` is for internal use. Changing this setting has no effect.
- `html.keepConditionalComments` has been deprecated. Use `html.keepSpecialComments` instead.

[`tdewolff/minify`]: https://github.com/tdewolff/minify


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/configuration/module.md
---


{{% include "/_common/gomodules-info.md" %}}

