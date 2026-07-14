## Generate multilingual content with `hugo new content`

If you organize content with translations in the same directory:

```sh
hugo new content post/test.en.md
hugo new content post/test.de.md
```

If you organize content with translations in different directories:

```sh
hugo new content content/en/post/test.md
hugo new content content/de/post/test.md
```

[`enableMissingTranslationPlaceholders`]: /configuration/all/#enablemissingtranslationplaceholders
[`lang.Translate`]: /functions/lang/translate/
[`slug`]: /content-management/urls/#slug
[`time.Format`]: /functions/time/format/
[`url`]: /content-management/urls/#url
[`urls.AbsLangURL`]: /functions/urls/abslangurl/
[`urls.RelLangURL`]: /functions/urls/rellangurl/
[automatically]: /content-management/menus/#define-automatically
[configuration directory]: /configuration/introduction/#configuration-directory
[configure languages]: /configuration/languages/
[example menu template]: /templates/menu/#example
[front matter]: /content-management/menus/#define-in-front-matter
[lang.FormatAccounting]: /functions/lang/formataccounting/
[lang.FormatCurrency]: /functions/lang/formatcurrency/
[lang.FormatNumberCustom]: /functions/lang/formatnumbercustom/
[lang.FormatNumber]: /functions/lang/formatnumber/
[lang.FormatPercent]: /functions/lang/formatpercent/
[lang.Merge]: /functions/lang/merge/
[project configuration]: /content-management/menus/#define-in-project-configuration


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/content-management/page-bundles.md
---


