## Base settings

Configure the following base settings:

{{< code-toggle file=hugo >}}
defaultContentLanguage = 'en'
defaultContentLanguageInSubdir = false
disableDefaultLanguageRedirect = false
disableLanguages = []
{{< /code-toggle >}}

`defaultContentLanguage`
: (`string`) The projects's default content language, conforming to the syntax described in [RFC 5646][]. This value must match one of the defined [language keys][]. Default is `en`.

`defaultContentLanguageInSubdir`
: (`bool`) Whether to publish the default content language to a subdirectory matching the [`defaultContentLanguage`](#defaultcontentlanguage). Default is `false`.

`disableDefaultLanguageRedirect`
: {{< new-in 0.140.0 />}}
: (`bool`) Whether to disable generation of the alias redirect for the default content language. When [`defaultContentLanguageInSubdir`](#defaultcontentlanguageinsubdir) is `true`, this setting prevents the root directory from redirecting to the language subdirectory. Conversely, when `defaultContentLanguageInSubdir` is `false`, this setting prevents the language subdirectory from redirecting to the root directory. This is superseded by the more general [`disableDefaultSiteRedirect`][] setting. Default is `false`.

`disableLanguages`
: (`[]string]`) A slice of language keys representing the languages to disable during the build process. Although this is functional, consider using the [`disabled`](#disabled) key under each language instead.

