# lang


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/lang/FormatAccounting.md
---


```go-html-template
{{ 512.5032 | lang.FormatAccounting 2 "NOK" }} → NOK512.50
```

{{% include "/_common/functions/locales.md" %}}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/lang/FormatCurrency.md
---


```go-html-template
{{ 512.5032 | lang.FormatCurrency 2 "USD" }} → $512.50
```

{{% include "/_common/functions/locales.md" %}}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/lang/FormatNumber.md
---


```go-html-template
{{ 512.5032 | lang.FormatNumber 2 }} → 512.50
```

{{% include "/_common/functions/locales.md" %}}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/lang/FormatNumberCustom.md
---


This function formats a number with the given precision. The first options parameter is a space-delimited string of characters to represent negativity, the decimal point, and grouping. The default value is `- . ,`. The second options parameter defines an alternative delimiting character.

Note that numbers are rounded up at 5 or greater. So, with precision set to 0, 1.5 becomes 2, and 1.4 becomes&nbsp;1.

For a simpler function that adapts to the current language, see [`lang.FormatNumber`][].

```go-html-template
{{ lang.FormatNumberCustom 2 12345.6789 }} → 12,345.68
{{ lang.FormatNumberCustom 2 12345.6789 "- , ." }} → 12.345,68
{{ lang.FormatNumberCustom 6 -12345.6789 "- ." }} → -12345.678900
{{ lang.FormatNumberCustom 0 -12345.6789 "- . ," }} → -12,346
{{ lang.FormatNumberCustom 0 -12345.6789 "-|.| " "|" }} → -12 346
```

{{% include "/_common/functions/locales.md" %}}

[`lang.FormatNumber`]: /functions/lang/formatnumber/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/lang/FormatPercent.md
---


```go-html-template
{{ 512.5032 | lang.FormatPercent 2 }} → 512.50%
```

{{% include "/_common/functions/locales.md" %}}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/lang/Merge.md
---


As an example:

```sh
{{ $pages := .Site.RegularPages | lang.Merge $frSite.RegularPages | lang.Merge $enSite.RegularPages }}
```

Will "fill in the gaps" in the current site with, from left to right, content from the French site, and lastly the English.

A more practical example is to fill in the missing translations from the other languages:

```sh
{{ $pages := .Site.RegularPages }}
{{ range .Site.Home.Translations }}
  {{ $pages = $pages | lang.Merge .Site.RegularPages }}
{{ end }}
 ```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/lang/Translate.md
---


The `lang.Translate` function returns the value associated with the given key by searching the current language's [translation tables](#translation-tables), then those for the [`defaultContentLanguage`][].

If not found, the function returns an empty string.

> [!NOTE]
> To list missing and fallback translations, set [`printI18nWarnings`][] to `true` in your project configuration, or use the `--printI18nWarnings` flag when building your project.
>
> To render placeholders for missing and fallback translations, set [`enableMissingTranslationPlaceholders`][] to `true` in your project configuration.


## Sections

- [`translation-tables`](references/functions/lang/translation-tables.md) — Translation Tables
- [`simple-translations`](references/functions/lang/simple-translations.md) — Simple Translations
- [`translations-with-pluralization`](references/functions/lang/translations-with-pluralization.md) — Translations With Pluralization
- [`reserved-keys`](references/functions/lang/reserved-keys.md) — Reserved Keys

