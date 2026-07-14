## Dates

When populating a date field, whether a [custom page parameter](#parameters) or one of the four predefined fields ([`date`](#date), [`expiryDate`](#expirydate), [`lastmod`](#lastmod), [`publishDate`](#publishdate)), use one of these parsable formats:

{{% include "/_common/parsable-date-time-strings.md" %}}

To override the default time zone, set the [`timeZone`][] in your project configuration. The order of precedence for determining the time zone is:

1. The time zone offset in the date/time string
1. The time zone specified in your project configuration
1. The `Etc/UTC` time zone

[^1]: The `_target` alias for `target` is deprecated and will be removed in a future release.

[Emacs Org Mode]: https://orgmode.org/
[JSON]: https://www.json.org/
[TOML]: https://toml.io/
[URL management]: /content-management/urls/#slug
[YAML]: https://yaml.org/
[`Aliases`]: /methods/page/aliases/
[`Date`]: /methods/page/date/
[`Description`]: /methods/page/description/
[`Draft`]: /methods/page/draft/
[`ExpiryDate`]: /methods/page/expirydate/
[`FuzzyWordCount`]: /methods/page/wordcount/
[`GetTerms`]: /methods/page/getterms/
[`Keywords`]: /methods/page/keywords/
[`Lastmod`]: /methods/page/date/
[`Layout`]: /methods/page/layout/
[`LinkTitle`]: /methods/page/linktitle/
[`Param`]: /methods/page/param/
[`Params`]: /methods/page/params/
[`PublishDate`]: /methods/page/publishdate/
[`ReadingTime`]: /methods/page/readingtime/
[`Sitemap`]: /methods/page/sitemap/
[`Slug`]: /methods/page/slug/
[`Summary`]: /methods/page/summary/
[`Title`]: /methods/page/title/
[`TranslationKey`]: /methods/page/translationkey/
[`Type`]: /methods/page/type/
[`Weight`]: /methods/page/weight/
[`WordCount`]: /methods/page/wordcount/
[`timeZone`]: /configuration/all/#timezone
[aliases]: /content-management/urls/#aliases
[build options]: /content-management/build-options/
[configure outputs]: /configuration/outputs/#outputs-per-page
[content format]: /content-management/formats/
[content formats]: /content-management/formats/#classification
[details]: /configuration/cascade/
[leaf bundles]: /content-management/page-bundles/#leaf-bundles
[menus]: /content-management/menus/#define-in-front-matter
[output formats]: /configuration/output-formats/
[page resources]: /content-management/page-resources/#metadata
[sitemap templates]: /templates/sitemap/
[target a specific template]: /templates/lookup-order/#target-a-template
[template lookup order]: /templates/lookup-order/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/content-management/markdown-attributes.md
---


