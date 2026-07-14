## Headless bundles

Use [build options][] in front matter to create an unpublished leaf or branch bundle whose content and resources you can include in other pages.

[`Resources`]: /methods/page/resources/
[build options]: /content-management/build-options/
[home]: /templates/types/#home
[page resources]: /content-management/page-resources/
[section]: /templates/types/#section
[single]: /templates/types/#single
[taxonomy]: /templates/types/#taxonomy
[term]: /templates/types/#term


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/content-management/page-resources.md
---


Page resources are only accessible from [page bundles][], those directories with `index.md` or`_index.md` files at their root. Page resources are only available to the page with which they are bundled.

In this example, `first-post` is a page bundle with access to 10 page resources including audio, data, documents, images, and video. Although `second-post` is also a page bundle, it has no page resources and is unable to directly access the page resources associated with `first-post`.

```tree
content
└── post
    ├── first-post
    │   ├── images
    │   │   ├── a.jpg
    │   │   ├── b.jpg
    │   │   └── c.jpg
    │   ├── index.md (root of page bundle)
    │   ├── latest.html
    │   ├── manual.json
    │   ├── notice.md
    │   ├── office.mp3
    │   ├── pocket.mp4
    │   ├── rating.pdf
    │   └── safety.txt
    └── second-post
        └── index.md (root of page bundle)
```

