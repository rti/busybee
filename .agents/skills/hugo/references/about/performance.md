## Performance

[Caching][]
: Reduce build time and cost by rendering a _partial_ template once then cache the result, either globally or within a given context. For example, cache the result of an asset pipeline to prevent reprocessing on every rendered page.

[Segmentation][]
: Reduce build time and cost by partitioning your sites into segments. For example, render the home page and the "news section" every hour, and render the entire project once a week.

[Minification][]
: Minify HTML, CSS, and JavaScript to reduce file size, bandwidth consumption, and loading times.

[CSS Processing]: /functions/css/build/
[Caching]: /functions/partials/includecached/
[CommonMark]: https://spec.commonmark.org/current/
[Content adapters]: /content-management/content-adapters/
[Content formats]: /content-management/formats/
[Data]: /content-management/data-sources/
[Diagrams]: /content-management/diagrams/
[GitHub Flavored Markdown]: https://github.github.com/gfm/
[Image processing]: /content-management/image-processing/
[JavaScript bundling]: /functions/js/build/
[Markdown attributes]: /content-management/markdown-attributes/
[Markdown extensions]: /configuration/markup/#extensions
[Markdown render hooks]: /render-hooks/introduction/
[Mathematics]: /content-management/mathematics/
[Menus]: /content-management/menus/
[Minification]: /configuration/minify/
[Modules]: /hugo-modules/
[Multidimensional content model]: /quick-reference/glossary/#sites-matrix
[Multilingual]: /content-management/multilingual/
[Multiplatform]: /installation/
[Output formats]: /configuration/output-formats/
[Privacy]: /configuration/privacy/
[Sass processing]: /functions/css/sass/
[Security]: /about/security/
[Segmentation]: /configuration/segments/
[Shortcodes]: /content-management/shortcodes/
[Syntax highlighting]: /content-management/syntax-highlighting/
[Tailwind CSS processing]: /functions/css/tailwindcss/
[Taxonomies]: /content-management/taxonomies/
[Templates]: /templates/introduction/
[Themes]: https://themes.gohugo.io/
[URL management]: /content-management/urls/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/about/introduction.md
---


Hugo is a [static site generator][] written in [Go][], optimized for speed and designed for flexibility. With its advanced templating system and fast asset pipelines, Hugo renders a complete site in seconds, often less.

Due to its flexible framework, multilingual support, and powerful taxonomy system, Hugo is widely used to create:

- Corporate, government, nonprofit, education, news, event, and project sites
- Documentation sites
- Image portfolios
- Landing pages
- Business, professional, and personal blogs
- Resumes and CVs

Use Hugo's embedded web server during development to instantly see changes to content, structure, behavior, and presentation. Then deploy the site to your host, or push changes to your Git provider for automated builds and deployment.

And with [modules][] you can share content, assets, data, translations, themes, templates, and configuration with other projects via public or private Git repositories.

Learn more about Hugo's [features][], [privacy protections][], and [security model][].

{{< youtube 0RKpf3rK57I >}}

[Go]: https://go.dev
[features]: /about/features/
[modules]: /hugo-modules/
[privacy protections]: /configuration/privacy/
[security model]: /about/security/
[static site generator]: https://en.wikipedia.org/wiki/Static_site_generator


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/about/license.md
---


