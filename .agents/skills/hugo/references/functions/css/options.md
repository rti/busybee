## Options

The `css.TailwindCSS` function accepts an options map.

`minify`
: (`bool`) Whether to optimize and minify the output. Default is `false`.

`optimize`
: (`bool`) Whether to optimize the output without minifying. Default is `false`.

`disableInlineImports`
: {{< new-in 0.147.4 />}}
: (`bool`) Whether to disable inlining of `@import` statements. Inlining is performed recursively, but currently once only per file. It is not possible to import the same file in different scopes (root, media query, etc.). Note that this import routine does not care about the CSS specification, so you can have `@import` statements anywhere in the file. Default is `false`.

`skipInlineImportsNotFound`
: (`bool`) Whether to allow the build process to continue despite unresolved import statements, preserving the original import declarations. It is important to note that the inline importer does not process URL-based imports or those with media queries, and these will remain unaltered even when this option is disabled. Default is `false`.

