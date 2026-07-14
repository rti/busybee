## Page collisions

Two or more pages collide when they have the same publication path. Due to concurrency, the content of the published page is indeterminate. Consider this example:

```tree
content/
└── books/
    ├── _content.gotmpl  <-- content adapter
    ├── _index.md
    └── the-hunchback-of-notre-dame.md
```

If the content adapter also creates `books/the-hunchback-of-notre-dame`, the content of the published page is indeterminate. You can not define the processing order.

To detect page collisions, use the `--printPathWarnings` flag when building your project.

[content formats]: /content-management/formats/#classification
[examples]: /methods/page/store/
[front matter field]: /content-management/front-matter/#fields
[media type]: https://en.wikipedia.org/wiki/Media_type
[syntax]: /templates/introduction/
[template functions]: /functions/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/content-management/data-sources.md
---


Hugo can access and [unmarshal](g) local and remote data sources including CSV, JSON, TOML, YAML, and XML. Use this data to augment existing content or to create new content.

A data source might be a file in the `data` directory, a [global resource](g), a [page resource](g), or a [remote resource](g).

