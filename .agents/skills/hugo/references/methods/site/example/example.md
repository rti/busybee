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

