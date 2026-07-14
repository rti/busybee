## Array

Define an array of cascade maps to apply different values to different targets. For example:

{{< code-toggle file=hugo >}}
[[cascade]]
[cascade.params]
color = 'red'
[cascade.target]
path = '{/articles,/articles/**}'
[[cascade]]
[cascade.params]
color = 'blue'
[cascade.target]
path = '{/tutorials,/tutorials/**}'
{{< /code-toggle >}}

[^1]: The `_target` alias for `target` is deprecated and will be removed in a future release.

[details]: /content-management/front-matter/#cascade-1


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/configuration/content-types.md
---


{{< new-in 0.144.0 />}}

Hugo supports six [content formats](g):

{{% include "/_common/content-format-table.md" %}}

These can be used as either page content or [page resources](g). When used as page resources, their [resource type](g) is `page`.

Consider this example of a [page bundle](g):

```tree
content/
└── example/
    ├── index.md  <-- content
    ├── a.adoc    <-- resource (resource type: page)
    ├── b.html    <-- resource (resource type: page)
    ├── c.md      <-- resource (resource type: page)
    ├── d.org     <-- resource (resource type: page)
    ├── e.pdc     <-- resource (resource type: page)
    ├── f.rst     <-- resource (resource type: page)
    ├── g.jpg     <-- resource (resource type: image)
    └── h.png     <-- resource (resource type: image)
```

The `index.md` file is the page's content, while the other files are page resources. Files `a` through `f` are of resource type `page`, while `g` and `h` are of resource type `image`.

When you build a site, Hugo does not publish page resources having a resource type of `page`. For example, this is the result of building the site above:

```tree
public/
├── example/
│   ├── g.jpg
│   ├── h.png
│   └── index.html
└── index.html
```

The default behavior is appropriate in most cases. Given that page resources containing markup are typically intended for inclusion in the main content, publishing them independently is generally undesirable.

The default behavior is determined by the `contentTypes` configuration:

{{< code-toggle config=contentTypes />}}

In this default configuration, page resources with those media types will have a resource type of `page`, and will not be automatically published. To change the resource type assignment from `page` to `text` for a given media type, remove the corresponding entry from the list.

For example, to set the resource type of `text/html` files to `text`, thereby enabling automatic publication, remove the `text/html` entry:

{{< code-toggle file=hugo >}}
contentTypes:
  text/asciidoc: {}
  text/markdown: {}
  text/org: {}
  text/pandoc: {}
  text/rst: {}
{{< /code-toggle >}}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/configuration/deployment.md
---


> [!NOTE]
> This configuration is only relevant when running `hugo deploy`. See [details][hugo deploy].

