
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

## Translation tables

{{% glossary-term "translation table" %}}

For example:

```text
i18n/en.toml
i18n/pt-BR.toml
```

Hugo searches for a matching translation table using the following base names, in order:

1. The [`locale`][] of the current language
1. The [key][] of the current language
1. The locale of the [`defaultContentLanguage`][]
1. The key of the [`defaultContentLanguage`][]

Artificial languages with private use subtags as defined in [RFC 5646 § 2.2.7][] are also supported. You may omit the `art-x-` prefix for brevity. For example:

```text
i18n/art-x-hugolang.toml
i18n/hugolang.toml
```

> [!NOTE]
> Private use subtags must not exceed 8 alphanumeric characters.

## Simple translations

Let's say your multilingual project supports two languages, English and Polish. Create a translation table for each language in the `i18n` directory.

```tree
i18n/
├── en.toml
└── pl.toml
```

The English translation table:

{{< code-toggle file=i18n/en >}}
privacy = 'privacy'
security = 'security'
{{< /code-toggle >}}

The Polish translation table:

{{< code-toggle file=i18n/pl >}}
privacy = 'prywatność'
security = 'bezpieczeństwo'
{{< /code-toggle >}}

> [!NOTE]
> The examples below use the `T` alias for brevity.

When viewing the English language site:

```go-html-template
{{ T "privacy" }} → privacy
{{ T "security" }} → security
````

When viewing the Polish language site:

```go-html-template
{{ T "privacy" }} → prywatność
{{ T "security" }} → bezpieczeństwo
```

## Translations with pluralization

Let's say your multilingual project supports two languages, English and Polish. Create a translation table for each language in the `i18n` directory.

```tree
i18n/
├── en.toml
└── pl.toml
```

The Unicode [CLDR Plural Rules chart][CLDR] describes the pluralization categories for each language.

The English translation table:

{{< code-toggle file=i18n/en >}}
[day]
one = 'day'
other = 'days'

[day_with_count]
one = '{{ . }} day'
other = '{{ . }} days'
{{< /code-toggle >}}

The Polish translation table:

{{< code-toggle file=i18n/pl >}}
[day]
one = 'miesiąc'
few = 'miesiące'
many = 'miesięcy'
other = 'miesiąca'

[day_with_count]
one = '{{ . }} miesiąc'
few = '{{ . }} miesiące'
many = '{{ . }} miesięcy'
other = '{{ . }} miesiąca'
{{< /code-toggle >}}

> [!NOTE]
> The examples below use the `T` alias for brevity.

When viewing the English language site:

```go-html-template
{{ T "day" 0 }} → days
{{ T "day" 1 }} → day
{{ T "day" 2 }} → days
{{ T "day" 5 }} → days

{{ T "day_with_count" 0 }} → 0 days
{{ T "day_with_count" 1 }} → 1 day
{{ T "day_with_count" 2 }} → 2 days
{{ T "day_with_count" 5 }} → 5 days
````

When viewing the Polish language site:

```go-html-template
{{ T "day" 0 }} → miesięcy
{{ T "day" 1 }} → miesiąc
{{ T "day" 2 }} → miesiące
{{ T "day" 5 }} → miesięcy

{{ T "day_with_count" 0 }} → 0 miesięcy
{{ T "day_with_count" 1 }} → 1 miesiąc
{{ T "day_with_count" 2 }} → 2 miesiące
{{ T "day_with_count" 5 }} → 5 miesięcy
```

In the pluralization examples above, we passed an integer in context (the second argument). You can also pass a map in context, providing a `count` key to control pluralization.

Translation table:

{{< code-toggle file=i18n/en >}}
[age]
one = '{{ .name }} is {{ .count }} year old.'
other = '{{ .name }} is {{ .count }} years old.'
{{< /code-toggle >}}

Template code:

```go-html-template
{{ T "age" (dict "name" "Will" "count" 1) }} → Will is 1 year old.
{{ T "age" (dict "name" "John" "count" 3) }} → John is 3 years old.
```

> [!NOTE]
> Translation tables may contain both simple translations and translations with pluralization.

## Reserved keys

Hugo uses the [`nicksnyder/go-i18n`][] package to look up values in translation tables. This package reserves the following keys for internal use:

`id`
: (`string`) Uniquely identifies the message.

`description`
: (`string`) Describes the message to give additional context to translators that may be relevant for translation.

`hash`
: (`string`) Uniquely identifies the content of the message that this message was translated from.

`leftdelim`
: (`string`) The left Go template delimiter.

`rightdelim`
: (`string`) The right Go template delimiter.

`zero`
: (`string`) The content of the message for the [CLDR][] plural form "zero".

`one`
: (`string`) The content of the message for the [CLDR][] plural form "one".

`two`
: (`string`) The content of the message for the [CLDR][] plural form "two".

`few`
: (`string`) The content of the message for the [CLDR][] plural form "few".

`many`
: (`string`) The content of the message for the [CLDR][] plural form "many".

`other`
: (`string`) The content of the message for the [CLDR][] plural form "other".

If you need to provide a translation for one of the reserved keys, you can prepend the word with an underscore. For example:

{{< code-toggle file=i18n/es >}}
_description = 'descripción'
_few = 'pocos'
_many = 'muchos'
_one = 'uno'
_other = 'otro'
_two = 'dos'
_zero = 'cero'
{{< /code-toggle >}}

Then in your templates:

```go-html-template
{{ T "_description" }} → descripción
{{ T "_few" }} → pocos
{{ T "_many" }} → muchos
{{ T "_one" }} → uno
{{ T "_two" }} → dos
{{ T "_zero" }} → cero
{{ T "_other" }} → otro
```

[CLDR]: https://www.unicode.org/cldr/charts/latest/supplemental/language_plural_rules.html
[RFC 5646 § 2.2.7]: https://datatracker.ietf.org/doc/html/rfc5646#section-2.2.7
[`defaultContentLanguage`]: /configuration/all/#defaultcontentlanguage
[`enableMissingTranslationPlaceholders`]: /configuration/all/#enablemissingtranslationplaceholders
[`locale`]: /configuration/all/#locale
[`nicksnyder/go-i18n`]: https://github.com/nicksnyder/go-i18n
[`printI18nWarnings`]: /configuration/all/#printi18nwarnings
[key]: /configuration/languages/#language-keys

