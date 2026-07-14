## Image location

The `figure` shortcode resolves internal Markdown destinations by looking for a matching [page resource](g), falling back to a matching [global resource](g). Remote destinations are passed through, and the render hook will not throw an error or warning if unable to resolve a destination.

You must place global resources in the `assets` directory. If you have placed your resources in the `static` directory, and you are unable or unwilling to move them, you must mount the `static` directory to the `assets` directory by including both of these entries in your project configuration:

{{< code-toggle file=hugo >}}
[[module.mounts]]
source = 'assets'
target = 'assets'

[[module.mounts]]
source = 'static'
target = 'assets'
{{< /code-toggle >}}

[source code]: <{{% eturl figure %}}>


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/shortcodes/highlight.md
---


> [!NOTE]
> To override Hugo's embedded `highlight` shortcode, copy the [source code][] to a file with the same name in the `layouts/_shortcodes` directory.

> [!NOTE]
> With the Markdown [content format][], the `highlight` shortcode is rarely needed because, by default, Hugo automatically applies syntax highlighting to fenced code blocks.
>
> The primary use case for the `highlight` shortcode in Markdown is to apply syntax highlighting to inline code snippets.

The `highlight` shortcode calls the [`transform.Highlight`][] function to generate syntax-highlighted HTML from the provided code, [language][], and [options](#options-1).

