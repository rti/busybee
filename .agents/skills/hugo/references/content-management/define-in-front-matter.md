## Define in front matter

To add a page to the "main" menu:

{{< code-toggle file=content/about.md fm=true >}}
title = 'About'
menus = 'main'
{{< /code-toggle >}}

Access the entry with `site.Menus.main` in your templates. See [menu templates][] for details.

To add a page to the "main" and "footer" menus:

{{< code-toggle file=content/contact.md fm=true >}}
title = 'Contact'
menus = ['main','footer']
{{< /code-toggle >}}

Access the entry with `site.Menus.main` and `site.Menus.footer` in your templates. See [menu templates][] for details.

> [!NOTE]
> The configuration key in the examples above is `menus`. The `menu` (singular) configuration key is an alias for `menus`.

### Properties

Use these properties when defining menu entries in front matter:

{{% include "/_common/menu-entry-properties.md" %}}

### Example

This front matter menu entry demonstrates some of the available properties:

<!-- markdownlint-disable MD033 -->
{{< code-toggle file=content/products/software.md fm=true >}}
title = 'Software'
[menus.main]
parent = 'Products'
weight = 20
pre = '<i class="fa-solid fa-code"></i>'
[menus.main.params]
class = 'center'
{{< /code-toggle >}}
<!-- markdownlint-enable MD033 -->

Access the entry with `site.Menus.main` in your templates. See [menu templates][] for details.

