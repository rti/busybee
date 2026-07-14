## Multihost

Hugo supports multiple languages in a multihost configuration. This means you can configure a `baseURL` per `language`.

> [!NOTE]
> If you define a `baseURL` for one language, you must define a unique `baseURL` for all languages.

For example:

{{< code-toggle file=hugo >}}
defaultContentLanguage = 'fr'
[languages.en]
baseURL = 'https://en.example.org/'
label = 'English'
title = 'In English'
weight = 2
[languages.fr]
baseURL = 'https://fr.example.org'
label = 'Français'
title = 'En Français'
weight = 1
{{</ code-toggle >}}

With the above, Hugo publishes two sites, each with their own root:

```tree
public
├── en
└── fr
```

[RFC 5646 § 2.2.7]: https://datatracker.ietf.org/doc/html/rfc5646#section-2.2.7
[RFC 5646]: https://datatracker.ietf.org/doc/html/rfc5646#section-2.1
[`Language.Direction`]: /methods/site/language/#direction
[`Language.Label`]: /methods/site/language/#label
[`Title`]: /methods/site/title/
[`dir`]: https://developer.mozilla.org/en-US/docs/Web/HTML/Global_attributes/dir
[`disableDefaultSiteRedirect`]: /configuration/all/#disabledefaultsiteredirect
[language keys]: /configuration/languages/#language-keys
[translating by file name]: /content-management/multilingual/#translation-by-file-name


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/configuration/markup.md
---


