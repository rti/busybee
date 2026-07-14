## Multilingual themes support

To support Multilingual mode in your themes, some considerations must be taken for the URLs in the templates. If there is more than one language, URLs must meet the following criteria:

- Come from the built-in `.Permalink` or `.RelPermalink`
- Be constructed with the [`urls.RelLangURL`][] or [`urls.AbsLangURL`][] function, or be prefixed with `{{ .LanguagePrefix }}`

If there is more than one language defined, the `LanguagePrefix` method will return `/en` (or whatever the current language is). If not enabled, it will be an empty string (and is therefore harmless for single-language Hugo websites).

