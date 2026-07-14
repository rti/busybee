## Example -- conditionally hide section

Consider this example. A documentation site has a team of contributors with access to 20 custom shortcodes. Each shortcode takes several arguments, and requires documentation for the contributors to reference when using them.

Instead of external documentation for the shortcodes, include an `internal` section that is hidden when building the production site.

```tree
content/
├── internal/
│   ├── shortcodes/
│   │   ├── _index.md
│   │   ├── shortcode-1.md
│   │   └── shortcode-2.md
│   └── _index.md
├── reference/
│   ├── _index.md
│   ├── reference-1.md
│   └── reference-2.md
├── tutorials/
│   ├── _index.md
│   ├── tutorial-1.md
│   └── tutorial-2.md
└── _index.md
```

Set the build options in front matter, using the `cascade` keyword to "cascade" the values down to descendant pages, and use the `target` keyword to target the production environment.

{{< code-toggle file=content/internal/_index.md >}}
title = 'Internal'
[[cascade]]
[cascade.build]
render = 'never'
list = 'never'
[cascade.target]
environment = 'production'
{{< /code-toggle >}}

The production site will have this structure:

```tree
public/
├── reference/
│   ├── reference-1/
│   │   └── index.html
│   ├── reference-2/
│   │   └── index.html
│   └── index.html
├── tutorials/
│   ├── tutorial-1/
│   │   └── index.html
│   ├── tutorial-2/
│   │   └── index.html
│   └── index.html
└── index.html
```

[`.Page.GetPage`]: /methods/page/getpage/
[`.Site.GetPage`]: /methods/site/getpage/
[`Permalink`]: /methods/resource/permalink/
[`Publish`]: /methods/resource/publish/
[`RelPermalink`]: /methods/resource/relpermalink/
[page bundles]: /content-management/page-bundles/
[page resources]: /content-management/page-resources/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/content-management/comments.md
---


Hugo ships with support for [Disqus][], a third-party service that provides comment and community capabilities to websites via JavaScript.

Your theme may already support Disqus, but if not, it is easy to add to your templates via Hugo's [embedded partial][].

