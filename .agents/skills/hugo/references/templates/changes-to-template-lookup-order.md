## Changes to template lookup order

We have consolidated the template lookup so it works the same across all [template types][]. The previous setup was difficult to understand and had a massive number of variants. The new setup aims to feel natural with few surprises.

The identifiers used in the template weighting, in order of importance, are:

| Identifier         | Description                                           |
|--------------------|-------------------------------------------------------|
| Layout custom      | The custom `layout` set in front matter.              |
| [Page kinds][]     | One of `home`, `section`, `taxonomy`, `term`, `page`. |
| Layouts standard 1 | `list` or `single`.                                   |
| Output format      | The output format (e.g., `html`, `rss`).              |
| Layouts standard 2 | `all`.                                                |
| Language           | The language (e.g., `en`).                            |
| Media type         | The media type (e.g., `text/html`).                   |
| [Page path][]      | The page path (e.g., `/blog/mypost`).                 |
| Type               | `type` set in front matter.[^type]                    |

For templates placed in a `layouts` folder partly or completely matching a [Page path][], a closer match upwards will be considered _better_. In the [Example folder structure](#example-folder-structure) below, this means that:

- `layouts/docs/api/_markup/render-link.html` will be used to render links from the Page path `/docs/api` and below.
- `layouts/docs/baseof.html` will be used as the base template for the Page path `/docs` and below.
- `layouts/tags/term.html` will be used for all `term` rendering in the `tags` taxonomy, except for the `blue` term, which will use `layouts/tags/blue/list.html`.

