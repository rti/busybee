## Missing translations

If a string does not have a translation for the current language, Hugo will use the value from the default language. If no default value is set, an empty string will be shown.

While translating a Hugo website, it can be helpful to have a visual indicator of missing translations. The [`enableMissingTranslationPlaceholders`][] configuration setting will flag all untranslated strings with the placeholder `[i18n] identifier`, where `identifier` is the id of the missing translation.

> [!NOTE]
> Hugo will generate your website with these missing translation placeholders. It might not be suitable for production environments.

For merging of content from other languages (i.e. missing content translations), see [lang.Merge].

To track down missing translation strings, run Hugo with the `--printI18nWarnings` flag:

```sh
hugo build --printI18nWarnings | grep i18n
i18n|MISSING_TRANSLATION|en|wordCount
```

