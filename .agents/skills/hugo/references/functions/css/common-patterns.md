## Common patterns

The examples below cover the most frequent use cases for referencing resources within your project or within Node packages. These patterns apply to both `@import` statements and the `url()` functional notation used for images and fonts.

All resources referenced by a path, including images, fonts, and stylesheets, must reside in the `assets` directory of the [unified file system](g), or within a Node package.

### Files in the assets directory

To include a stylesheet from the `assets` directory, you can use a bare path, a relative path, or a root-relative path. When you use a bare path, Hugo searches relative to the current stylesheet, then relative to the `assets` directory.

```css {file="/assets/css/main.css"}
/* A bare path */
@import "variables.css";

/* A relative path */
@import "./theme.css";
@import "../layout.css";

/* A root-relative path */
@import "/css/grid.css";

/* A url() reference using the same resolution logic */
.logo { background: url("/images/logo.svg"); }
```

### Node packages

When referencing a Node package by name, Hugo consults the `package.json` file within that package to find the entry point.

```css {file="/assets/css/main.css"}
@import "bootstrap";
```

### Files within a package

To reference a specific file within a Node package, provide the path starting with the package name.

```css {file="/assets/css/main.css"}
@import "bootstrap/dist/css/bootstrap-grid.css";
```

[`css.Quoted`]: /functions/css/quoted/
[`evanw/esbuild`]: https://github.com/evanw/esbuild
[`publishDir`]: /configuration/all/#publishdir
[browserlist]: https://browsersl.ist
[esb external]: https://esbuild.github.io/api/#external
[esb loader]: https://esbuild.github.io/api/#loader
[esb mainfields]: https://esbuild.github.io/api/#main-fields
[esb minify]: https://esbuild.github.io/api/#minify
[esb sourcemap]: https://esbuild.github.io/api/#sourcemap
[esb sourcesContent]: https://esbuild.github.io/api/#sources-content
[esb target]: https://esbuild.github.io/api/#target


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/css/PostCSS.md
---


The `css.PostCSS` function transforms CSS using [PostCSS][] and any of its [plugins][].

