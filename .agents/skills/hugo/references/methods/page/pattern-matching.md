## Pattern matching

With the `GetMatch` and `Match` methods, Hugo determines a match using a case-insensitive [glob pattern](g).

{{% include "/_common/glob-patterns.md" %}}

[Page bundle]: /content-management/page-bundles/
[`js.Batch`]: /functions/js/batch/#import-context
[`resources.ByType`]: /functions/resources/bytype/
[`resources.GetMatch`]: /functions/resources/getmatch/
[`resources.Get`]: /functions/resources/get/
[`resources.Match`]: /functions/resources/match/
[`resources`]: /functions/resources/
[media type]: https://en.wikipedia.org/wiki/Media_type


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/Rotate.md
---


{{< new-in 0.153.0 />}}

The rotate method on a page object returns a collection of pages that vary along the specified [dimension](g), while holding the other dimensions constant. The result includes the current page and is sorted according to the rules of the specified dimension. For example, rotating along [language](g) returns all language variants that share the current page's [version](g) and [role](g).

The `DIMENSION` argument must be one of `language`, `version`, or `role`.

