# css


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/css/Build.md
---


{{< new-in 0.158.0 />}}

> [!NOTE]
> The `css.Build` function is backed by the [`evanw/esbuild`][] package, providing a mature, high-performance foundation for bundling, transformation, and minification.

Use the `css.Build` function to:

- Recursively replace `@import` statements in CSS files with the content of the imported files
- Transform syntax for browser compatibility
- Apply vendor prefixes for browser compatibility
- Minify the bundled CSS code
- Create a source map

If an `@import` statement includes a media query, a feature query, or a cascade layer assignment, the function wraps the imported content in the corresponding `@media`, `@supports`, or `@layer` rule.


## Sections

- [`usage`](references/functions/css/usage.md) — Usage
- [`options`](references/functions/css/options.md) — Options
- [`example`](references/functions/css/example.md) — Example
- [`common-patterns`](references/functions/css/common-patterns.md) — Common Patterns
- [`setup`](references/functions/css/setup.md) — Setup
- [`options`](references/functions/css/options.md) — Options
- [`options`](references/functions/css/options.md) — Options
- [`example`](references/functions/css/example.md) — Example
- [`dart-sass`](references/functions/css/dart-sass.md) — Dart Sass
- [`setup`](references/functions/css/setup.md) — Setup
- [`options`](references/functions/css/options.md) — Options
- [`inject-css-variables`](references/functions/css/inject-css-variables.md) — Inject CSS Variables

