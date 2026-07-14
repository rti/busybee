
---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/site/AllPages.md
---


{{< deprecated-in 0.156.0 >}}
See [details](https://discourse.gohugo.io/t/56732).
{{< /deprecated-in >}}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/site/BaseURL.md
---


Project configuration:

{{< code-toggle file=hugo >}}
baseURL = 'https://example.org/docs/'
{{< /code-toggle >}}

Template:

```go-html-template
{{ .Site.BaseURL }} → https://example.org/docs/
```

> [!NOTE]
> There is almost never a good reason to use this method in your templates. Its usage tends to be fragile due to misconfiguration.
>
> Use the [`absURL`][], [`absLangURL`][], [`relURL`][], or [`relLangURL`][] functions instead.

[`absLangURL`]: /functions/urls/absLangURL/
[`absURL`]: /functions/urls/absURL/
[`relLangURL`]: /functions/urls/relLangURL/
[`relURL`]: /functions/urls/relURL/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/site/BuildDrafts.md
---


{{< deprecated-in 0.156.0 >}}
See [details](https://discourse.gohugo.io/t/56732).
{{< /deprecated-in >}}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/site/Config.md
---


The `Config` method on a `Site` object provides access to a subset of your project configuration, specifically the `services` and `privacy` keys.

## Services

See [configure services][].

For example, to use Hugo's built-in Google Analytics template you must add a [Google tag ID][]:

{{< code-toggle file=hugo >}}
[services.googleAnalytics]
id = 'G-XXXXXXXXX'
{{< /code-toggle >}}

To access this value from a template:

```go-html-template
{{ .Site.Config.Services.GoogleAnalytics.ID }} → G-XXXXXXXXX
```

You must capitalize each identifier as shown above.

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

## Multilingual projects

With multilingual projects, the `GetPage` method on a `Site` object resolves the given path to a page in the current language.

To get a page from a different language, query the `Sites` object:

```go-html-template
{{ with where hugo.Sites "Language.Name" "eq" "de" }}
  {{ with index . 0 }}
    {{ with .GetPage "/works/paintings/starry-night" }}
      {{ .Title }} → Sternenklare Nacht
    {{ end }}
  {{ end }}
{{ end }}
```

## Page bundles

Consider this content structure:

```tree
content/
├── headless/
│   ├── a.jpg
│   ├── b.jpg
│   ├── c.jpg
│   └── index.md  <-- front matter: headless = true
└── _index.md
```

In the _home_ template, use the `GetPage` method on a `Site` object to render all the images in the headless [page bundle](g):

```go-html-template {file="layouts/home.html"}
{{ with .Site.GetPage "/headless" }}
  {{ range .Resources.ByType "image" }}
    <img src="{{ .RelPermalink }}" width="{{ .Width }}" height="{{ .Height }}" alt="">
  {{ end }}
{{ end }}
```

[details]: /methods/page/getpage/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/site/Home.md
---


The `Home` method on a `Site` object is a convenient way to access the home page, and is functionally equivalent to:

```go-html-template
{{ .Site.GetPage "/" }}
```

Because it returns a `Page` object, you can use any of the available [page methods][] by chaining them. For example:

```go-html-template
{{ .Site.Home.Store.Set "greeting" "Hello" }}
```

This method is commonly used to generate a link to the home page. For example:

Project configuration:

{{< code-toggle file=hugo >}}
baseURL = 'https://example.org/docs/'
{{< /code-toggle >}}

Template:

```go-html-template
{{ .Site.Home.Permalink }} → https://example.org/docs/
{{ .Site.Home.RelPermalink }} → /docs/
```

[page methods]: /methods/page/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/site/IsDefault.md
---


{{< new-in 0.156.0 />}}

The `IsDefault` method on a `Site` object reports whether the given site is the [default site](g) across all dimensions: [language](g), [version](g), and [role](g). This is useful to ensure that a block of code executes only once per build, regardless of the number of [sites](g) generated by your [dimensions](g).

For example, the following configuration defines a matrix of sites across language and version dimensions.

{{< code-toggle file=hugo >}}
[languages.de]
contentDir = 'content/de'
direction = 'ltr'
label = 'Deutsch'
locale = 'de-DE'
title = 'Projekt Dokumentation'
weight = 1

[languages.en]
contentDir = 'content/en'
direction = 'ltr'
label = 'English'
locale = 'en-US'
title = 'Project Documentation'
weight = 2

[versions.'v1.0.0']
[versions.'v2.0.0']
[versions.'v3.0.0']
{{< /code-toggle >}}

If you call an initialization partial to handle one-time build logic or global variable setup, wrap that call in an [`if`][] statement using this function. This prevents the logic from being executed for every dimensional variation.

```go-html-template
{{ if .Site.IsDefault }}
  {{ partial "init.html" . }}
{{ end }}
```

In this setup, the code block is only executed for the English version v3.0.0 site. English is selected because it has the lowest weight, and version v3.0.0 is selected because it is the first version when sorted semantically in descending order.

[`if`]: /functions/go-template/if/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/site/Language.md
---


The `Language` method on a `Site` object returns the `Language` object for the given site, derived from the language definition in your project configuration.

You can also use the `Language` method on a `Page` object. See [details][].

## Methods

Use these methods on the `Language` object.

The examples below assume the following language definition.

{{< code-toggle file=hugo >}}
[languages.de]
direction = 'ltr'
label = 'Deutsch'
locale = 'de-DE'
weight = 2
{{< /code-toggle >}}

`Direction`
: {{< new-in 0.158.0 />}}
: (`string`) Returns the [`direction`][] from the language definition.

  ```go-html-template
  {{ .Site.Language.Direction }} → ltr
  ```

`IsDefault`
: {{< new-in 0.153.0 />}}
: (`bool`) Reports whether this is the [default language](g).

  ```go-html-template
  {{ .Site.Language.IsDefault }} → true
  ```

`Label`
: {{< new-in 0.158.0 />}}
: (`string`) Returns the [`label`][] from the language definition.

  ```go-html-template
  {{ .Site.Language.Label }} → Deutsch
  ```

`Lang`
: {{<deprecated-in 0.158.0 />}}
: Use [`Name`](#name) instead.

`LanguageCode`
: {{<deprecated-in 0.158.0 />}}
: Use [`Locale`](#locale) instead.

`LanguageDirection`
: {{<deprecated-in 0.158.0 />}}
: Use [`Direction`](#direction) instead.

`LanguageName`
: {{<deprecated-in 0.158.0 />}}
: Use [`Label`](#label) instead.

`Locale`
: {{< new-in 0.158.0 />}}
: (`string`) Returns the [`locale`][] from the language definition, falling back to [`Name`](#name).

  ```go-html-template
  {{ .Site.Language.Locale }} → de-DE
  ```

`Name`
: {{< new-in 0.153.0 />}}
: (`string`) Returns the language tag as defined by [RFC 5646][]. This is the lowercased key from the language definition.

  ```go-html-template
  {{ .Site.Language.Name }} → de
  ```

`Weight`
: {{<deprecated-in 0.158.0 />}}

## Example

Some of the methods above are commonly used in a base template as attributes for the `html` element.

```go-html-template
<html
  lang="{{ .Site.Language.Locale }}"
  dir="{{ or .Site.Language.Direction `ltr` }}"
>
```

[RFC 5646]: https://datatracker.ietf.org/doc/html/rfc5646
[`direction`]: /configuration/languages/#direction
[`label`]: /configuration/languages/#label
[`locale`]: /configuration/languages/#locale
[details]: /methods/page/language/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/site/LanguagePrefix.md
---


Consider this project configuration:

{{< code-toggle file=hugo >}}
defaultContentLanguage = 'de'
defaultContentLanguageInSubdir = false

[languages.de]
direction = 'ltr'
label = 'Deutsch'
locale = 'de-DE'
title = 'Projekt Dokumentation'
weight = 1

[languages.en]
direction = 'ltr'
label = 'English'
locale = 'en-US'
title = 'Project Documentation'
weight = 2
{{< /code-toggle >}}

When visiting the German language site:

```go-html-template
{{ .Site.LanguagePrefix }} → ""
```

When visiting the English language site:

```go-html-template
{{ .Site.LanguagePrefix }} → /en
```

If you change `defaultContentLanguageInSubdir` to `true`, when visiting the German language site:

```go-html-template
{{ .Site.LanguagePrefix }} → /de
```

You may use the `LanguagePrefix` method with both monolingual and multilingual projects.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/site/Languages.md
---


{{< deprecated-in 0.156.0 >}}
See [details](https://discourse.gohugo.io/t/56732).
{{< /deprecated-in >}}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/site/Lastmod.md
---


The `Lastmod` method on a `Site` object returns a [`time.Time`][] value. Use this with time [functions][] and [methods][]. For example:

```go-html-template
{{ .Site.Lastmod | time.Format ":date_long" }} → January 31, 2024

```

[`time.Time`]: https://pkg.go.dev/time#Time
[functions]: /functions/time/
[methods]: /methods/time/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/site/MainSections.md
---


Project configuration:

{{< code-toggle file=hugo >}}
mainSections = ['books','films']
{{< /code-toggle >}}

Template:

```go-html-template
{{ .Site.MainSections }} → [books films]
```

If `mainSections` is not defined in your project configuration, this method returns a slice with one element---the top-level section with the most pages.

With this content structure, the `films` section has the most pages:

```tree
content/
├── books/
│   ├── book-1.md
│   └── book-2.md
├── films/
│   ├── film-1.md
│   ├── film-2.md
│   └── film-3.md
└── _index.md
```

Template:

```go-html-template
{{ .Site.MainSections }} → [films]
```

When creating a theme, instead of hardcoding section names when listing the most relevant pages on the front page, instruct users to set `mainSections` in their project configuration.

Then your _home_ template can do something like this:

```go-html-template {file="layouts/home.html"}
{{ range where .Site.RegularPages "Section" "in" .Site.MainSections }}
  <h2><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></h2>
{{ end }}
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/site/Menus.md
---


The `Menus` method on a `Site` object returns a collection of menus, where each menu contains one or more entries, either flat or nested. Each entry points to a page within the site, or to an external resource.

> [!NOTE]
> Menus can be defined and localized in several ways. Please see the [menus][] section for a complete explanation and examples.

A site can have multiple menus. For example, a main menu and a footer menu:

{{< code-toggle file=hugo >}}
[[menus.main]]
name = 'Home'
pageRef = '/'
weight = 10

[[menus.main]]
name = 'Books'
pageRef = '/books'
weight = 20

[[menus.main]]
name = 'Films'
pageRef = '/films'
weight = 30

[[menus.footer]]
name = 'Legal'
pageRef = '/legal'
weight = 10

[[menus.footer]]
name = 'Privacy'
pageRef = '/privacy'
weight = 20
{{< /code-toggle >}}

This template renders the main menu:

```go-html-template
{{ with site.Menus.main }}
  <nav class="menu">
    {{ range . }}
      {{ if $.IsMenuCurrent .Menu . }}
        <a class="active" aria-current="page" href="{{ .URL }}">{{ .Name }}</a>
      {{ else }}
        <a href="{{ .URL }}">{{ .Name }}</a>
      {{ end }}
    {{ end }}
  </nav>
{{ end }}
```

When viewing the home page, the result is:

```html
<nav class="menu">
  <a class="active" aria-current="page" href="/">Home</a>
  <a href="/books/">Books</a>
  <a href="/films/">Films</a>
</nav>
```

When viewing the `books` page, the result is:

```html
<nav class="menu">
  <a href="/">Home</a>
  <a class="active" aria-current="page" href="/books/">Books</a>
  <a href="/films/">Films</a>
</nav>
```

You will typically render a menu using a _partial_ template. As the active menu entry will be different on each page, use the [`partial`][] function to call the template. Do not use the [`partialCached`][] function.

The example above is simplistic. Please see the [menu templates][] section for more information.

[`partialCached`]: /functions/partials/includecached/
[`partial`]: /functions/partials/include/
[menu templates]: /templates/menu/
[menus]: /content-management/menus/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/site/Pages.md
---


This method returns all page [kinds](g) in the current language, in the [default sort order](g). That includes the home page, section pages, taxonomy pages, term pages, and regular pages.

In most cases you should use the [`RegularPages`][] method instead.

```go-html-template
{{ range .Site.Pages }}
  <h2><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></h2>
{{ end }}
```

[`RegularPages`]: /methods/site/regularpages/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/site/Param.md
---


The `Param` method on a `Site` object is a convenience method to return the value of a user-defined parameter in your project configuration.

{{< code-toggle file=hugo >}}
[params]
display_toc = true
{{< /code-toggle >}}

```go-html-template
{{ .Site.Param "display_toc" }} → true
```

The above is equivalent to either of these:

```go-html-template
{{ .Site.Params.display_toc }}
{{ index .Site.Params "display_toc" }}
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/site/Params.md
---


With this project configuration:

{{< code-toggle file=hugo >}}
[params]
  subtitle = 'The Best Widgets on Earth'
  copyright-year = '2023'
  [params.author]
    email = 'jsmith@example.org'
    name = 'John Smith'
  [params.layouts]
    rfc_1123 = 'Mon, 02 Jan 2006 15:04:05 MST'
    rfc_3339 = '2006-01-02T15:04:05-07:00'
{{< /code-toggle >}}

Access the custom parameters by [chaining](g) the [identifiers](g):

```go-html-template
{{ .Site.Params.subtitle }} → The Best Widgets on Earth
{{ .Site.Params.author.name }} → John Smith

{{ $layout := .Site.Params.layouts.rfc_1123 }}
{{ .Site.Lastmod.Format $layout }} → Tue, 17 Oct 2023 13:21:02 PDT
```

In the template example above, each of the keys is a valid identifier. For example, none of the keys contains a hyphen. To access a key that is not a valid identifier, use the [`index`][] function:

```go-html-template
{{ index .Site.Params "copyright-year" }} → 2023
```

[`index`]: /functions/collections/indexfunction/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/site/RegularPages.md
---


The `RegularPages` method on a `Site` object returns a collection of all [regular pages](g), in the [default sort order](g).

```go-html-template
{{ range .Site.RegularPages }}
  <h2><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></h2>
{{ end }}
```

{{% glossary-term "default sort order" %}}

[default sort order](g)

To change the sort order, use any of the `Pages` [sorting methods][]. For example:

```go-html-template
{{ range .Site.RegularPages.ByTitle }}
  <h2><a href="{{ .RelPermalink }}">{{ .Title }}</a></h2>
{{ end }}
```

[sorting methods]: /methods/pages/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/site/Role.md
---


{{< new-in 0.153.0 />}}

## Overview

The `Role` method on a `Site` object returns the `Role` object for the given site, derived from the role definition in your project configuration.

## Methods

Use these methods on the `Role` object.

`IsDefault`
: (`bool`) Reports whether this is the [default role](g).

  ```go-html-template
  {{ .Site.Role.IsDefault }} → true
  ```

`Name`
: (`string`) Returns the role name. This is the lowercased key from your project configuration.

  ```go-html-template
  {{ .Site.Role.Name }} → guest
  ```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/site/Sections.md
---


The `Sections` method on a `Site` object returns a collection of top-level [section pages](g), in the [default sort order](g).

Given this content structure:

```tree
content/
├── books/
│   ├── book-1.md
│   └── book-2.md
├── films/
│   ├── film-1.md
│   └── film-2.md
└── _index.md
```

This template:

```go-html-template
{{ range .Site.Sections }}
  <h2><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></h2>
{{ end }}
```

Is rendered to:

```html
<h2><a href="/books/">Books</a></h2>
<h2><a href="/films/">Films</a></h2>
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/site/Sites.md
---


{{< deprecated-in 0.156.0 >}}
Use the [`hugo.Sites`](/functions/hugo/sites/) function instead.
{{< /deprecated-in >}}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/site/Store.md
---


{{< new-in 0.139.0 />}}

Use the `Store` method on a `Site` object to create a persistent data structure for storing and manipulating keyed values, scoped to the current site. To create a data structure with a different [scope](g), refer to the [scope](#scope) section below.

## Methods

Use these methods on the data structure.

`Set`
: Sets the value of a given key.

  ```go-html-template
  {{ site.Store.Set "greeting" "Hello" }}
  ```

`Get`
: (`any`) Gets the value of a given key.

  ```go-html-template
  {{ site.Store.Set "greeting" "Hello" }}
  {{ site.Store.Get "greeting" }} → Hello
  ```

`Add`
: Adds a given value to existing value(s) of the given key.

  For single values, `Add` accepts values that support Go's `+` operator. If the first `Add` for a key is an array or slice, the following adds will be appended to that list.

  ```go-html-template
  {{ site.Store.Set "greeting" "Hello" }}
  {{ site.Store.Add "greeting" "Welcome" }}
  {{ site.Store.Get "greeting" }} → HelloWelcome
  ```

  ```go-html-template
  {{ site.Store.Set "total" 3 }}
  {{ site.Store.Add "total" 7 }}
  {{ site.Store.Get "total" }} → 10
  ```

  ```go-html-template
  {{ site.Store.Set "greetings" (slice "Hello") }}
  {{ site.Store.Add "greetings" (slice "Welcome" "Cheers") }}
  {{ site.Store.Get "greetings" }} → [Hello Welcome Cheers]
  ```

`SetInMap`
: Takes a `key`, `mapKey` and `value` and adds a map of `mapKey` and `value` to the given `key`.

  ```go-html-template
  {{ site.Store.SetInMap "greetings" "english" "Hello" }}
  {{ site.Store.SetInMap "greetings" "french" "Bonjour" }}
  {{ site.Store.Get "greetings" }} → map[english:Hello french:Bonjour]
  ```

`DeleteInMap`
: Takes a `key` and `mapKey` and removes the map of `mapKey` from the given `key`.

  ```go-html-template
  {{ site.Store.SetInMap "greetings" "english" "Hello" }}
  {{ site.Store.SetInMap "greetings" "french" "Bonjour" }}
  {{ site.Store.DeleteInMap "greetings" "english" }}
  {{ site.Store.Get "greetings" }} → map[french:Bonjour]
  ```

`GetSortedMapValues`
: (`[]any`) Returns an array of values from `key` sorted by `mapKey`.

  ```go-html-template
  {{ site.Store.SetInMap "greetings" "english" "Hello" }}
  {{ site.Store.SetInMap "greetings" "french" "Bonjour" }}
  {{ site.Store.GetSortedMapValues "greetings" }} → [Hello Bonjour]
  ```

`Delete`
: Removes the given key.

  ```go-html-template
  {{ site.Store.Set "greeting" "Hello" }}
  {{ site.Store.Delete "greeting" }}
  ```

{{% include "_common/store-scope.md" %}}

## Determinate values

The `Store` method is often used to set values within a _shortcode_ template, a _partial_ template called by a _shortcode_ template, or by a _render hook_ template. In all three cases, the stored values are indeterminate until Hugo renders the page content.

If you need to access a stored value from a parent template, and the parent template has not yet rendered the page content, you can trigger content rendering by assigning the returned value to a [noop](g) variable:

```go-html-template
{{ $noop := .Content }}
{{ site.Store.Get "mykey" }}
```

You can also trigger content rendering with the `ContentWithoutSummary`, `FuzzyWordCount`, `Len`, `Plain`, `PlainWords`, `ReadingTime`, `Summary`, `Truncated`, and `WordCount` methods. For example:

```go-html-template
{{ $noop := .WordCount }}
{{ site.Store.Get "mykey" }}
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/site/Taxonomies.md
---


Conceptually, the `Taxonomies` method on a `Site` object returns a data structure such&nbsp;as:

<!-- markdownlint-disable MD007 MD032 -->
{{< code-toggle file=hugo >}}
taxonomy a:
  - term 1:
    - page 1
    - page 2
  - term 2:
    - page 1
taxonomy b:
  - term 1:
    - page 2
  - term 2:
    - page 1
    - page 2
{{< /code-toggle >}}
<!-- markdownlint-enable MD007 MD032 -->

For example, on a book review site you might create two taxonomies; one for genres and another for authors.

With this project configuration:

{{< code-toggle file=hugo >}}
[taxonomies]
genre = 'genres'
author = 'authors'
{{< /code-toggle >}}

And this content structure:

```tree
content/
├── books/
│   ├── and-then-there-were-none.md --> genres: suspense
│   ├── death-on-the-nile.md        --> genres: suspense
│   └── jamaica-inn.md              --> genres: suspense, romance
│   └── pride-and-prejudice.md      --> genres: romance
└── _index.md
```

Conceptually, the taxonomies data structure looks like:

<!-- markdownlint-disable MD007 MD032 -->
{{< code-toggle file=hugo >}}
genres:
  - suspense:
    - And Then There Were None
    - Death on the Nile
    - Jamaica Inn
  - romance:
    - Jamaica Inn
    - Pride and Prejudice
authors:
  - achristie:
    - And Then There Were None
    - Death on the Nile
  - ddmaurier:
    - Jamaica Inn
  - jausten:
    - Pride and Prejudice
{{< /code-toggle >}}
<!-- markdownlint-enable MD007 MD032 -->

To list the "suspense" books:

```go-html-template
<ul>
  {{ range .Site.Taxonomies.genres.suspense }}
    <li><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></li>
  {{ end }}
</ul>
```

Hugo renders this to:

```html
<ul>
  <li><a href="/books/and-then-there-were-none/">And Then There Were None</a></li>
  <li><a href="/books/death-on-the-nile/">Death on the Nile</a></li>
  <li><a href="/books/jamaica-inn/">Jamaica Inn</a></li>
</ul>
```

> [!NOTE]
> Hugo's taxonomy system is powerful, allowing you to classify content and create relationships between pages.
>
> Please see the [taxonomies][] section for a complete explanation and examples.

## Examples

### List content with the same taxonomy term

If you are using a taxonomy for something like a series of posts, you can list individual pages associated with the same term. For example:

```go-html-template
<ul>
  {{ range .Site.Taxonomies.series.golang }}
    <li><a href="{{ .Page.RelPermalink }}">{{ .Page.Title }}</a></li>
  {{ end }}
</ul>
```

### List all content in a given taxonomy

This is useful in a sidebar as "featured content". You could even have different sections of "featured content" by assigning different terms to the content.

```go-html-template
<section id="menu">
  <ul>
    {{ range $term, $taxonomy := .Site.Taxonomies.featured }}
      <li>{{ $term }}</li>
      <ul>
        {{ range $taxonomy.Pages }}
          <li><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></li>
        {{ end }}
      </ul>
    {{ end }}
  </ul>
</section>
```

### Render a site's taxonomies

The following example displays all terms in a site's tags taxonomy:

```go-html-template
<ul>
  {{ range .Site.Taxonomies.tags }}
    <li><a href="{{ .Page.Permalink }}">{{ .Page.Title }}</a> {{ .Count }}</li>
  {{ end }}
</ul>
```

This example will list all taxonomies and their terms, as well as all the content assigned to each of the terms.

```go-html-template {file="layouts/_partials/all-taxonomies.html"}
{{ with .Site.Taxonomies }}
  {{ $numberOfTerms := 0 }}
  {{ range $taxonomy, $terms := . }}
    {{ $numberOfTerms = len . | add $numberOfTerms }}
  {{ end }}

  {{ if gt $numberOfTerms 0 }}
    <ul>
      {{ range $taxonomy, $terms := . }}
        {{ with $terms }}
          <li>
            <a href="{{ .Page.RelPermalink }}">{{ .Page.LinkTitle }}</a>
            <ul>
              {{ range $term, $weightedPages := . }}
                <li>
                  <a href="{{ .Page.RelPermalink }}">{{ .Page.LinkTitle }}</a>
                  <ul>
                    {{ range $weightedPages }}
                      <li><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></li>
                    {{ end }}
                  </ul>
                </li>
              {{ end }}
            </ul>
          </li>
        {{ end }}
      {{ end }}
    </ul>
  {{ end }}
{{ end }}
```

[taxonomies]: /content-management/taxonomies/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/site/Title.md
---


Project configuration:

{{< code-toggle file=hugo >}}
title = 'My Documentation Site'
{{< /code-toggle >}}

Template:

```go-html-template
{{ .Site.Title }} → My Documentation Site
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/site/Version.md
---


{{< new-in 0.153.0 />}}

## Overview

The `Version` method on a `Site` object returns the `Version` object for the given site, derived from the version definition in your project configuration.

## Methods

Use these methods on the `Version` object.

`IsDefault`
: (`bool`) Reports whether this is the [default version](g).

  ```go-html-template
  {{ .Site.Version.IsDefault }} → true
  ```

`Name`
: (`string`) Returns the version name. This is the lowercased key from your project configuration.

  ```go-html-template
  {{ .Site.Version.Name }} → v1.0.0
  ```

