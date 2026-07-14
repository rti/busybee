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

