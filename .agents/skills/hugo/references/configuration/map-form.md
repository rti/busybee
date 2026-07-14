## Map form

Define URL patterns for each top-level [section](g), keyed by [page kind](g). For example, to configure URL patterns for the `articles` section:

{{< code-toggle file=hugo >}}
[permalinks.page]
articles = '/blog/:year/:month/:slug/'
[permalinks.section]
articles = '/blog/'
{{< /code-toggle >}}

To configure permalinks per language, nest the `permalinks` key under the language key:

{{< code-toggle file=hugo >}}
[languages]
  [languages.de]
    label = 'Deutsch'
    locale = 'de-DE'
    weight = 1
    [languages.de.permalinks]
      [languages.de.permalinks.page]
        articles = '/artikel/:year/:month/:slug/'
      [languages.de.permalinks.section]
        articles = '/artikel/'
  [languages.en]
    label = 'English'
    locale = 'en-US'
    weight = 2
    [languages.en.permalinks]
      [languages.en.permalinks.page]
        articles = '/blog/:year/:month/:slug/'
      [languages.en.permalinks.section]
        articles = '/blog/'
{{< /code-toggle >}}

