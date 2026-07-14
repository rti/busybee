## Inject CSS variables

The [`css.Build`][] function has a [`vars`][] option that can be used to inject CSS variables into your stylesheets. This is particularly useful for dynamically setting values based on your site's configuration or other data. To use this with Tailwind CSS, you can use `css.Build` as a preprocessor step before passing the result to `css.TailwindCSS`. Here's how you can do it:

```go-html-template
{{ with resources.Get "css/styles.css" }}
  {{ $cssOpts := dict
    "vars" (dict "favourite-color" "#7f93c9")
    "externals" (slice "tailwindcss")
  }}
  {{ $tailwindOpts := dict "disableInlineImports" true }}
  {{ with . | css.Build $cssOpts | css.TailwindCSS $tailwindOpts }}
    <link rel="stylesheet" href="{{ .RelPermalink }}">
  {{ end }}
{{ end }}
```

Some notes to the above:

- Marking `tailwindcss` as an external in the `css.Build` options prevents it from being processed by the build step, allowing it to be correctly handled by the Tailwind CSS CLI in the subsequent step.
- The `disableInlineImports` option is set to `true` for the Tailwind CSS step as imports are handled by the `css.Build`.

[modern browser]: https://tailwindcss.com/docs/compatibility#browser-support
[standalone binary]: https://github.com/tailwindlabs/tailwindcss/releases/latest
[`css.Build`]: /functions/css/build/
[`vars`]: /functions/css/build/#vars


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/css/Unquoted.md
---


> [!NOTE]
> This function is only applicable to the `vars` option passed to the [`css.Sass`][] function.

When passing a `vars` map to the `css.Sass` function, Hugo detects common typed CSS values such as `24px` or `#FF0000` using regular expression matching. If necessary, you can bypass automatic type inference by using the `css.Unquoted` function to explicitly indicate that the value must be treated as an unquoted string.

In the example below, we use `css.Unquoted` to ensure the value for the `font-family` property is injected without quotes.

```go-html-template
{{ $vars := dict
  "font-main" ("sans-serif" | css.Unquoted)
}}

{{ $opts := dict "vars" $vars "transpiler" "dartsass" }}
{{ with resources.Get "sass/main.scss" | css.Sass $opts }}
  <link rel="stylesheet" href="{{ .RelPermalink }}">
{{ end }}
```

Using the `hugo:vars` identifier in your stylesheet:

```scss
@use "hugo:vars" as h;

body {
  font-family: h.$font-main;
}
```

The resulting CSS contains an unquoted string:

```css
body {
  font-family: sans-serif;
}
```

[`css.Sass`]: /functions/css/sass/#vars

