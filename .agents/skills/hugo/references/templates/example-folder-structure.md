## Example folder structure

```tree
layouts
├── baseof.html
├── baseof.term.html
├── home.html
├── page.html
├── section.html
├── taxonomy.html
├── term.html
├── term.mylayout.en.rss.xml
├── _markup
│   ├── render-codeblock-go.term.mylayout.no.rss.xml
│   └── render-link.html
├── _partials
│   └── mypartial.html
├── _shortcodes
│   ├── myshortcode.html
│   └── myshortcode.section.mylayout.en.rss.xml
├── docs
│   ├── baseof.html
│   ├── _shortcodes
│   │   └── myshortcode.html
│   └── api
│       ├── mylayout.html
│       ├── page.html
│       └── _markup
│           └── render-link.html
└── tags
    ├── taxonomy.html
    ├── term.html
    └── blue
        └── list.html
```

[^internal]: The old way of doing it made it difficult or impossible to, e.g., override `_internal/disqus.html` in a theme. Now you can just create a partial with the same name.
[^type]: The `type` set in front matter will effectively replace the `section` folder in [Page path][] when doing lookups.

[Hugo v0.146.0]: https://github.com/gohugoio/hugo/releases/tag/v0.146.0
[Page kinds]: https://gohugo.io/methods/page/kind/
[Page path]: https://gohugo.io/methods/page/path/
[template types]: /templates/types/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/templates/pagination.md
---


Displaying a large page collection on a list page is not user-friendly:

- A massive list can be intimidating and difficult to navigate. Users may get lost in the sheer volume of information.
- Large pages take longer to load, which can frustrate users and lead to them abandoning the site.
- Without any filtering or organization, finding a specific item becomes a tedious scrolling exercise.

Improve usability by paginating `home`, `section`, `taxonomy`, and `term` pages.

> [!NOTE]
> The most common templating mistake related to pagination is invoking pagination more than once for a given list page. See the [caching](#caching) section below.

