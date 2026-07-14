## Limitations

Do not use `resources.PostProcess` when running Hugo's built-in development server. The examples above specifically prevent this by verifying that the current environment is not `development`.

The `resources.PostProcess` function only works within templates that produce HTML files.

You cannot manipulate the values returned from the resource's methods. For example, the `strings.ToUpper` function in this example will not work as expected:

```go-html-template
{{ $css := resources.Get "css/main.css" }}
{{ $css = $css | css.PostCSS | minify | fingerprint | resources.PostProcess }}
{{ $css.RelPermalink | strings.ToUpper }}
```

[Autoprefixer]: https://github.com/postcss/autoprefixer
[Fingerprint]: /functions/resources/fingerprint/
[Minify]: /functions/resources/minify/
[Node.js]: https://nodejs.org/en
[PostCSS]: https://postcss.org/
[PurgeCSS]: https://github.com/FullHuman/purgecss
[`config/production`]: /configuration/introduction/#configuration-directory
[configure build]: /configuration/build/

