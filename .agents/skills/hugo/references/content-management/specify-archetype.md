## Specify archetype

Use the `--kind` command line flag to specify an archetype when creating content.

For example, let's say your site has two sections: articles and tutorials. Create an archetype for each content type:

```tree
archetypes/
├── articles.md
├── default.md
└── tutorials.md
```

To create an article using the articles archetype:

```sh
hugo new content articles/something.md
```

To create an article using the tutorials archetype:

```sh
hugo new content --kind tutorials articles/something.md
```

[`strings.Replace`]: /functions/strings/replace/
[`time.Now`]: /functions/time/now/
[file information]: /methods/page/file/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/content-management/build-options.md
---


Build options are stored in a reserved front matter object named `build` with these defaults:

{{< code-toggle file=content/example/index.md fm=true >}}
[build]
list = 'always'
publishResources = true
render = 'always'
{{< /code-toggle >}}

`list`
: When to include the page within page collections. Specify one of:

  - `always`: Include the page in _all_ page collections. For example, `site.RegularPages`, `.Pages`, etc. This is the default value.
  - `local`: Include the page in _local_ page collections. For example, `.RegularPages`, `.Pages`, etc. Use this option to create fully navigable but headless content sections.
  - `never`: Do not include the page in _any_ page collection.

`publishResources`
: Applicable to [page bundles][], determines whether to publish the associated [page resources][]. Specify one of:

  - `true`: Always publish resources. This is the default value.
  - `false`: Only publish a resource when invoking its [`Permalink`][], [`RelPermalink`][], or [`Publish`][] method within a template.

`render`
: When to render the page. Specify one of:

  - `always`: Always render the page to disk. This is the default value.
  - `link`: Do not render the page to disk, but assign `Permalink` and `RelPermalink` values.
  - `never`: Never render the page to disk, and exclude it from all page collections.

> [!NOTE]
> Any page, regardless of its build options, will always be available by using the [`.Page.GetPage`][] or [`.Site.GetPage`][] method.

