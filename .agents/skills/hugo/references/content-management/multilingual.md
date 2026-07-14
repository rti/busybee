## Multilingual

By default, with a multilingual single-host project, Hugo does not duplicate shared page during the build.

> [!NOTE]
> This behavior is limited to Markdown content. Shared page resources for other [content formats][] are copied into each language bundle.

Consider this project configuration:

{{< code-toggle file=hugo >}}
defaultContentLanguage = 'de'
defaultContentLanguageInSubdir = true

[languages.de]
label = 'Deutsch'
locale = 'de-DE'
weight = 1

[languages.en]
label = 'English'
locale = 'en-US'
weight = 2
{{< /code-toggle >}}

And this content:

```tree
content/
└── my-bundle/
    ├── a.jpg     <-- shared page resource
    ├── b.jpg     <-- shared page resource
    ├── c.de.jpg
    ├── c.en.jpg
    ├── index.de.md
    └── index.en.md
```

Hugo places the shared resources in the page bundle for the default content language:

```tree
public/
├── de/
│   ├── my-bundle/
│   │   ├── a.jpg     <-- shared page resource
│   │   ├── b.jpg     <-- shared page resource
│   │   ├── c.de.jpg
│   │   └── index.html
│   └── index.html
├── en/
│   ├── my-bundle/
│   │   ├── c.en.jpg
│   │   └── index.html
│   └── index.html
└── index.html
```

This approach reduces build times, storage requirements, bandwidth consumption, and deployment times, ultimately reducing cost.

> [!IMPORTANT]
> To resolve Markdown link and image destinations to the correct location, you must use link and image render hooks that capture the page resource with the [`Resources.Get`][] method, and then invoke its [`RelPermalink`][] method.
>
> In its default configuration, Hugo automatically uses the [embedded link render hook][] and the [embedded image render hook][] for multilingual single-host projects, specifically when the [duplication of shared page resources][] feature is disabled. This is the default behavior for such projects. If custom link or image render hooks are defined by your project, modules, or themes, these will be used instead.
>
> You can also configure Hugo to `always` use the embedded link or image render hook, use it only as a `fallback`, or `never` use it. See [details][].

Although duplicating shared page resources is inefficient, you can enable this feature in your project configuration if desired:

{{< code-toggle file=hugo >}}
[markup.goldmark]
duplicateResourceFiles = true
{{< /code-toggle >}}

[`Name`]: /methods/resource/name/
[`RelPermalink`]: /methods/resource/relpermalink/
[`Resource`]: /methods/resource/
[`Resources.ByType`]: /methods/page/resources#bytype
[`Resources.GetMatch`]: /methods/page/resources#getmatch
[`Resources.Get`]: /methods/page/resources/#get
[`Resources.Match`]: /methods/page/resources#match
[`Title`]: /methods/resource/title/
[content formats]: /content-management/formats/
[details]: /configuration/markup/#renderhookslinkuseembedded
[duplication of shared page resources]: /configuration/markup/#duplicateresourcefiles
[embedded image render hook]: /render-hooks/images/#embedded
[embedded link render hook]: /render-hooks/links/#embedded
[page bundles]: /content-management/page-bundles/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/content-management/related-content.md
---


Hugo uses a set of factors to identify a page's related content based on front matter parameters. This can be tuned to the desired set of indices and parameters.

