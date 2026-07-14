## Privacy

See [configure privacy][].

For example, to disable usage of the built-in YouTube shortcode:

{{< code-toggle file=hugo >}}
[privacy.youtube]
disable = true
{{< /code-toggle >}}

To access this value from a template:

```go-html-template
{{ .Site.Config.Privacy.YouTube.Disable }} → true
```

You must capitalize each identifier as shown above.

[Google tag ID]: https://support.google.com/tagmanager/answer/12326985?hl=en
[configure privacy]: /configuration/privacy/
[configure services]: /configuration/services/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/site/Copyright.md
---


Project configuration:

{{< code-toggle file=hugo >}}
copyright = '© 2023 ABC Widgets, Inc.'
{{< /code-toggle >}}

Template:

```go-html-template
{{ .Site.Copyright }} → © 2023 ABC Widgets, Inc.
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/site/Data.md
---


{{< deprecated-in 0.156.0 >}}
Use the [`hugo.Data`](/functions/hugo/data/) function instead.
{{< /deprecated-in >}}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/site/Dimension.md
---


{{< new-in 0.153.0 />}}

The `Dimension` method on a `Site` object returns the dimension object for the given [dimension](g).

The `DIMENSION` argument must be one of `language`, `version`, or `role`.

Example|Returns|Equivalent to
:--|:--|:--
`{{ .Site.Dimension "language" }}`|`langs.Language`|`{{ .Site.Language }}`
`{{ .Site.Dimension "version" }}`|`version.Version`|`{{ .Site.Version }}`
`{{ .Site.Dimension "role" }}`|`roles.Role`|`{{ .Site.Role }}`

```go-html-template
{{ $languageObject := .Site.Dimension "language" }}
{{ $languageObject.IsDefault }} → true
{{ $languageObject.Name }} → en

{{ $versionObject := .Site.Dimension "version" }}
{{ $versionObject.IsDefault }} → true
{{ $versionObject.Name }} → v1.0.0

{{ $roleObject := .Site.Dimension "role" }}
{{ $roleObject.IsDefault }} → true
{{ $roleObject.Name }} → guest
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/site/GetPage.md
---


The `GetPage` method is also available on `Page` objects, allowing you to specify a path relative to the current page. See [details][].

When using the `GetPage` method on a `Site` object, specify a path relative to the `content` directory.

If Hugo cannot resolve the path to a page, the method returns nil.

Consider this content structure:

```tree
content/
├── works/
│   ├── paintings/
│   │   ├── _index.md
│   │   ├── starry-night.md
│   │   └── the-mona-lisa.md
│   ├── sculptures/
│   │   ├── _index.md
│   │   ├── david.md
│   │   └── the-thinker.md
│   └── _index.md
└── _index.md
```

This _home_ template:

```go-html-template {file="layouts/home.html"}
{{ with .Site.GetPage "/works/paintings" }}
  <ul>
    {{ range .Pages }}
      <li>{{ .Title }} by {{ .Params.artist }}</li>
    {{ end }}
  </ul>
{{ end }}
```

Is rendered to:

```html
<ul>
  <li>Starry Night by Vincent van Gogh</li>
  <li>The Mona Lisa by Leonardo da Vinci</li>
</ul>
```

To get a regular page instead of a section page:

```go-html-template {file="layouts/home.html"}
{{ with .Site.GetPage "/works/paintings/starry-night" }}
  {{ .Title }} → Starry Night
  {{ .Params.artist }} → Vincent van Gogh
{{ end }}
```

