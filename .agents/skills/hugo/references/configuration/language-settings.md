## Language settings

Configure each language under the `languages` key:

{{< code-toggle config=languages />}}

In the above, `en` is the [language key](#language-keys).

`direction`
: (`string`) The language direction, either left-to-right (`ltr`) or right-to-left (`rtl`). Use this value in your templates with the global [`dir`][] HTML attribute. Access this value from a template using the [`Language.Direction`][] method on a `Site` or `Page` object. Default is `ltr`.

`disabled`
: (`bool`) Whether to disable this language when building the site. Default is `false`.

`label`
: (`string`) The language name, typically used when rendering a language switcher. Access this value from a template using the [`Language.Label`][] method on a `Site` or `Page` object.

`languageCode`
: {{<deprecated-in 0.158.0 />}}
: Use [`locale`](#locale) instead.

`languageDirection`
: {{<deprecated-in 0.158.0 />}}
: Use [`direction`](#direction) instead.

`languageName`
: {{<deprecated-in 0.158.0 />}}
: Use [`label`](#label) instead.

{{% include "/_common/configuration/locale.md" %}}

`title`
: (`string`) The site title for this language. Access this value from a template using the [`Title`][] method on a `Site` object.

`weight`
: (`int`) The language [weight](g). When set to a non-zero value, this is the primary sort criteria for this language.

