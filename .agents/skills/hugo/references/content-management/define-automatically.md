## Define automatically

To automatically define a menu entry for each top-level [section](g) of your site, enable the section pages menu in your project configuration.

{{< code-toggle file=hugo >}}
sectionPagesMenu = 'main'
{{< /code-toggle >}}

This creates a menu structure that you can access with `site.Menus.main` in your templates. See [menu templates][] for details.

