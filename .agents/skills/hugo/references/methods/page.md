
---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/Aliases.md
---


The `Aliases` method on a `Page` object returns the values defined in the [`aliases`][] front matter field as server-relative URLs, resolved according to the current [content dimension](g).

The `Aliases` method is useful for generating a `_redirects` file, which contains a source URL, a target URL, and an HTTP status code for each alias. You can use a `_redirects` file with hosting services such as Cloudflare, GitLab Pages, and Netlify.

## Redirects

By default, Hugo handles aliases by creating individual HTML files for each alias path. These files contain a `meta http-equiv="refresh"` tag to redirect the visitor via the browser.

While functional, generating a single `_redirects` file allows your hosting provider to handle redirects at the server level. This is more efficient than client-side redirection and improves performance by eliminating the need to load a middle-man HTML page.

> [!TIP]
> You can use the same general approach to generate an `.htaccess` file.

## Example

The following example demonstrates how to configure your site and create a template to automate the generation of a `_redirects` file.

### Content structure

The content structure for this multilingual example looks like this:

```tree
content/
├── examples/
│   ├── a.de.md   aliases = ['a-old']
│   ├── a.en.md   aliases = ['a-old', 'a-older']
│   ├── b.de.md   aliases = ['b-old']
│   └── b.en.md   aliases = ['b-old', 'b-older']
└── _index.md
```

In the example above, the aliases are [page-relative](g). To specify a [site-relative](g) path, preface the entry with a slash (`/`). Both forms are resolved to [server-relative](g) paths.

Page-relative paths can also include directory traversal:

| Path type | File path | Alias | Server-relative path |
| :--- | :--- | :--- | :--- |
| page-relative | `content/examples/a.en.md` | `a-old` | `/en/examples/a-old/` |
| page-relative | `content/examples/a.en.md` | `../a-old` | `/en/a-old/` |
| site-relative | `content/examples/a.en.md` | `/a-old` | `/en/a-old/` |

### Project configuration

To implement this, you must update your project configuration to:

1. Disable the generation of default HTML redirect files by setting `disableAliases` to `true`.
1. Define a [media type][] named `text/redirects` to handle the file format.
1. Define a custom [output format][] named `redirects` to set the filename to `_redirects` and place it at the root of the published site.
1. Configure the home page [outputs][] to include the `redirects` format in addition to `html`.

{{< code-toggle file=hugo >}}
baseURL = 'https://example.org/'
disableAliases = true

defaultContentLanguage         = 'en'
defaultContentLanguageInSubdir = true

[languages.en]
 locale      = 'en-US'
 direction = 'ltr'
 name      = 'English'
  weight            = 1
  title             = 'My Site in English'

[languages.de]
 locale      = 'de-DE'
 direction = 'ltr'
 name      = 'Deutsch'
  weight            = 2
  title             = 'My Site in German'

[mediaTypes]
  [mediaTypes.'text/redirects']
    delimiter = ''

[outputFormats]
  [outputFormats.redirects]
    baseName    = '_redirects'
    isPlainText = true
    mediaType   = 'text/redirects'
    root        = true

[outputs]
  home = ['html', 'redirects']
{{< /code-toggle >}}

### Template implementation

Next, create a home page template specifically for the `redirects` output format. The following template iterates through every page in every language and extracts its aliases.

To ensure the resulting `_redirects` file is valid, the template uses the [`strings.FindRE`][] function to check for whitespace such as tabs or newlines within the alias string. If whitespace is detected, Hugo will throw an error and fail the build to prevent generating an invalid file.

```go-html-template {file="layouts/home.redirects" copy=true}
{{- if site.IsDefault -}}
  {{- range hugo.Sites -}}
    {{- range $p := .Pages -}}
      {{- range .Aliases -}}
        {{- if findRE `\s` . -}}
          {{- errorf "One of the front matter aliases in %q contains whitespace" $p.String -}}
        {{- end -}}
        {{- printf "%s %s 301\n" . $p.RelPermalink -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
```

### Generated output

Once Hugo processes the template, it produces a clean list of redirect rules. Each line follows the required format: the source URL, the destination URL, and the HTTP status code.

The resulting `_redirects` file looks like this:

```text
/de/examples/a-old /de/examples/a/ 301
/de/examples/b-old /de/examples/b/ 301
/en/examples/b-old /en/examples/b/ 301
/en/examples/b-older /en/examples/b/ 301
/en/examples/a-old /en/examples/a/ 301
/en/examples/a-older /en/examples/a/ 301
```

[`aliases`]: /content-management/front-matter/#aliases
[`strings.FindRE`]: /functions/strings/findre/
[media type]: /configuration/media-types/
[output format]: /configuration/output-formats/
[outputs]: /configuration/outputs/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/AllTranslations.md
---


With this project configuration:

{{< code-toggle file=hugo >}}
defaultContentLanguage = 'en'

[languages.en]
contentDir = 'content/en'
label = 'English'
locale = 'en-US'
weight = 1

[languages.de]
contentDir = 'content/de'
label = 'Deutsch'
locale = 'de-DE'
weight = 2

[languages.fr]
contentDir = 'content/fr'
label = 'Français'
locale = 'fr-FR'
weight = 3
{{< /code-toggle >}}

And this content:

```tree
content/
├── de/
│   ├── books/
│   │   ├── book-1.md
│   │   └── book-2.md
│   └── _index.md
├── en/
│   ├── books/
│   │   ├── book-1.md
│   │   └── book-2.md
│   └── _index.md
├── fr/
│   ├── books/
│   │   └── book-1.md
│   └── _index.md
└── _index.md
```

And this template:

```go-html-template
{{ with .AllTranslations }}
  <ul>
    {{ range . }}
      <li>
        <a href="{{ .RelPermalink }}" hreflang="{{ .Language.Locale }}">{{ .LinkTitle }} ({{ or .Language.Label .Language.Name }})</a>
      </li>
    {{ end }}
  </ul>
{{ end }}
```

Hugo will render this list on the `book-1` page of each site:

```html
<ul>
  <li><a href="/books/book-1/" hreflang="en-US">Book 1 (English)</a></li>
  <li><a href="/de/books/book-1/" hreflang="de-DE">Book 1 (Deutsch)</a></li>
  <li><a href="/fr/books/book-1/" hreflang="fr-FR">Book 1 (Français)</a></li>
</ul>
```

On the `book-2` page of the English and German sites, Hugo will render this:

```html
<ul>
  <li><a href="/books/book-1/" hreflang="en-US">Book 1 (English)</a></li>
  <li><a href="/de/books/book-1/" hreflang="de-DE">Book 1 (Deutsch)</a></li>
</ul>
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/AlternativeOutputFormats.md
---


{{% glossary-term "output format" %}}

The `AlternativeOutputFormats` method on a `Page` object returns a slice of `OutputFormat` objects, excluding the current output format, each representing one of the output formats enabled for the given page. See [details][].

For example, to generate a `link` element for each of the alternative output formats:

```go-html-template
{{ range .AlternativeOutputFormats }}
  {{ printf "<link rel=%q type=%q href=%q>" .Rel .MediaType.Type .Permalink | safeHTML }}
{{ end }}
```

Hugo renders this to something like:

```html
<link rel="alternate" type="application/rss+xml" href="https://example.org/index.xml">
<link rel="alternate" type="application/json" href="https://example.org/index.json">
```

[details]: /configuration/output-formats/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/Ancestors.md
---


With this content structure:

```tree
content/
├── auctions/
│   ├── 2023-11/
│   │   ├── _index.md     <-- front matter: weight = 202311
│   │   ├── auction-1.md
│   │   └── auction-2.md
│   ├── 2023-12/
│   │   ├── _index.md     <-- front matter: weight = 202312
│   │   ├── auction-3.md
│   │   └── auction-4.md
│   ├── _index.md         <-- front matter: weight = 30
│   ├── bidding.md
│   └── payment.md
├── books/
│   ├── _index.md         <-- front matter: weight = 10
│   ├── book-1.md
│   └── book-2.md
├── films/
│   ├── _index.md         <-- front matter: weight = 20
│   ├── film-1.md
│   └── film-2.md
└── _index.md
```

And this template:

```go-html-template
{{ range .Ancestors }}
  <a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a>
{{ end }}
```

On the November 2023 auctions page, Hugo renders:

```html
<a href="/auctions/2023-11/">Auctions in November 2023</a>
<a href="/auctions/">Auctions</a>
<a href="/">Home</a>
```

In the example above, notice that Hugo orders the ancestors from closest to furthest. This makes breadcrumb navigation simple:

```go-html-template
<nav aria-label="breadcrumb" class="breadcrumb">
  <ol>
    {{ range .Ancestors.Reverse }}
      <li>
        <a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a>
      </li>
    {{ end }}
    <li class="active">
      <a aria-current="page" href="{{ .RelPermalink }}">{{ .LinkTitle }}</a>
    </li>
  </ol>
</nav>
```

With some CSS, the code above renders something like this, where each breadcrumb links to its page:

```text
Home > Auctions > Auctions in November 2023 > Auction 1
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/BundleType.md
---


A page bundle is a directory that encapsulates both content and associated [resources](g). There are two types of page bundles: [leaf bundles](g) and [branch bundles](g). See [details][].

The `BundleType` method on a `Page` object returns `branch` for branch bundles, `leaf` for leaf bundles, and an empty string if the page is not a page bundle.

```tree
content/
├── films/
│   ├── film-1/
│   │   ├── a.jpg
│   │   └── index.md  <-- leaf bundle
│   ├── _index.md     <-- branch bundle
│   ├── b.jpg
│   ├── film-2.md
│   └── film-3.md
└── _index.md         <-- branch bundle
```

To get the value within a template:

```go-html-template
{{ .BundleType }}
```

[details]: /content-management/page-bundles/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/CodeOwners.md
---


GitHub and GitLab support CODEOWNERS files. This file specifies the users responsible for developing and maintaining software and documentation. This definition can apply to the entire repository, specific directories, or to individual files. To learn more:

- [GitHub CODEOWNERS documentation][]
- [GitLab CODEOWNERS documentation][]

Use the `CodeOwners` method on a `Page` object to determine the code owners for the given page.

To use the `CodeOwners` method you must enable access to your local Git repository:

{{< code-toggle file=hugo >}}
enableGitInfo = true
{{< /code-toggle >}}

Consider this project structure:

```tree
my-project/
├── content/
│   ├── books/
│   │   └── les-miserables.md
│   └── films/
│       └── the-hunchback-of-notre-dame.md
└── CODEOWNERS
```

And this CODEOWNERS file:

```text
* @jdoe
/content/books/ @tjones
/content/films/ @mrichards @rsmith
```

The table below shows the slice of code owners returned for each file:

Path|Code owners
:--|:--
`books/les-miserables.md`|`[@tjones]`
`films/the-hunchback-of-notre-dame.md`|`[@mrichards @rsmith]`

Render the code owners for each content page:

```go-html-template
{{ range .CodeOwners }}
  {{ . }}
{{ end }}
```

Combine this method with [`resources.GetRemote`][] to retrieve names and avatars from your Git provider by querying their API.

[GitHub CODEOWNERS documentation]: https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-code-owners
[GitLab CODEOWNERS documentation]: https://docs.gitlab.com/ee/user/project/code_owners.html
[`resources.GetRemote`]: /functions/resources/getremote/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/Content.md
---


The `Content` method on a `Page` object renders Markdown and shortcodes to HTML.

```go-html-template
{{ .Content }}
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/ContentWithoutSummary.md
---


{{< new-in 0.134.0 />}}

Applicable when using manual or automatic [content summaries][], the `ContentWithoutSummary` method on a `Page` object renders Markdown and shortcodes to HTML, excluding the content summary from the result.

```go-html-template
{{ .ContentWithoutSummary }}
```

The `ContentWithoutSummary` method returns the same as `Content` if you define the content summary in front matter.

[content summaries]: /content-management/summaries/#manual-summary


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/CurrentSection.md
---


{{% glossary-term section %}}

> [!NOTE]
> The current section of a [section page](g), [taxonomy page](g), [term page](g), or the home page, is itself.

Consider this content structure:

```tree
content/
├── auctions/
│   ├── 2023-11/
│   │   ├── _index.md     <-- current section: 2023-11
│   │   ├── auction-1.md
│   │   └── auction-2.md  <-- current section: 2023-11
│   ├── 2023-12/
│   │   ├── _index.md
│   │   ├── auction-3.md
│   │   └── auction-4.md
│   ├── _index.md         <-- current section: auctions
│   ├── bidding.md
│   └── payment.md        <-- current section: auctions
├── books/
│   ├── _index.md         <-- current section: books
│   ├── book-1.md
│   └── book-2.md         <-- current section: books
├── films/
│   ├── _index.md         <-- current section: films
│   ├── film-1.md
│   └── film-2.md         <-- current section: films
└── _index.md             <-- current section: home
```

To create a link to the current section page:

```go-html-template
<a href="{{ .CurrentSection.RelPermalink }}">{{ .CurrentSection.LinkTitle }}</a>
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/Data.md
---


The `Data` method on a `Page` object returns a unique data object for each [page kind](g).

> [!NOTE]
> The `Data` method is only useful within [taxonomy](g) and [term](g) templates.
>
> Themes that are not actively maintained may still use `.Data.Pages` in their templates. Although that syntax remains functional, use one of these methods instead: [`Pages`][], [`RegularPages`][], or [`RegularPagesRecursive`][]

The examples that follow are based on this project configuration:

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

## In a taxonomy template

Use these methods on the `Data` object within a _taxonomy_ template.

`Singular`
: (`string`) Returns the singular name of the taxonomy.

```go-html-template
{{ .Data.Singular }} → genre
```

`Plural`
: (`string`) Returns the plural name of the taxonomy.

```go-html-template
{{ .Data.Plural }} → genres
```

`Terms`
: (`page.Taxonomy`) Returns the `Taxonomy` object, consisting of a map of terms and the [weighted pages](g) associated with each term.

```go-html-template
{{ $taxonomyObject := .Data.Terms }}
```

> [!NOTE]
> Once you have captured the `Taxonomy` object, use any of the [taxonomy methods][] to sort, count, or capture a subset of its weighted pages.

Learn more about [taxonomy templates][].

## In a term template

Use these methods on the `Data` object within a _term_ template.

`Singular`
: (`string`) Returns the singular name of the taxonomy.

```go-html-template
{{ .Data.Singular }} → genre
```

`Plural`
: (`string`) Returns the plural name of the taxonomy.

```go-html-template
{{ .Data.Plural }} → genres
```

`Term`
: (`string`) Returns the name of the term.

```go-html-template
{{ .Data.Term }} → suspense
```

Learn more about [term templates][].

[`Pages`]: /methods/page/pages/
[`RegularPagesRecursive`]: /methods/page/regularpagesrecursive/
[`RegularPages`]: /methods/page/regularpages/
[taxonomy methods]: /methods/taxonomy/
[taxonomy templates]: /templates/types/#taxonomy
[term templates]: /templates/types/#term


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/Date.md
---


Set the date in front matter:

{{< code-toggle file=content/news/article-1.md fm=true >}}
title = 'Article 1'
date = 2023-10-19T00:40:04-07:00
{{< /code-toggle >}}

> [!NOTE]
> The date field in front matter is often considered to be the creation date, You can change its meaning, and its effect on your project, in your project configuration. See [details][].

The date is a [time.Time][] value. Format and localize the value with the [`time.Format`][] function, or use it with any of the [time methods][].

```go-html-template
{{ .Date | time.Format ":date_medium" }} → Oct 19, 2023
```

In the example above we explicitly set the date in front matter. With Hugo's default configuration, the `Date` method returns the front matter value. This behavior is configurable, allowing you to set fallback values if the date is not defined in front matter. See [details][].

[`time.Format`]: /functions/time/format/
[details]: /configuration/front-matter/#dates
[time methods]: /methods/time/
[time.Time]: https://pkg.go.dev/time#Time


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/Description.md
---


Conceptually different from a [content summary][], a page description is typically used in metadata about the page.

{{< code-toggle file=content/recipes/sushi.md fm=true >}}
title = 'How to make spicy tuna hand rolls'
description = 'Instructions for making spicy tuna hand rolls.'
{{< /code-toggle >}}

```go-html-template {file="layouts/baseof.html"}
<head>
  ...
  <meta name="description" content="{{ .Description }}">
  ...
</head>
```

[content summary]: /content-management/summaries/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/Draft.md
---


By default, Hugo does not publish draft pages when you build your project. To include draft pages when you build your project, use the `--buildDrafts` command line flag.

{{< code-toggle file=content/posts/post-1.md fm=true >}}
title = 'Post 1'
draft = true
{{< /code-toggle >}}

```go-html-template
{{ .Draft }} → true
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/Eq.md
---


In this contrived example we list all pages in the current section except for the current page.

```go-html-template {file="layouts/page.html"}
{{ $currentPage := . }}
{{ range .CurrentSection.Pages }}
  {{ if not (.Eq $currentPage) }}
    <a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a>
  {{ end }}
{{ end }}
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/ExpiryDate.md
---


By default, Hugo excludes expired pages when building your project. To include expired pages, use the `--buildExpired` command line flag.

Set the expiry date in front matter:

{{< code-toggle file=content/news/article-1.md fm=true >}}
title = 'Article 1'
expiryDate = 2024-10-19T00:32:13-07:00
{{< /code-toggle >}}

The expiry date is a [time.Time][] value. Format and localize the value with the [`time.Format`][] function, or use it with any of the [time methods][].

```go-html-template
{{ .ExpiryDate | time.Format ":date_medium" }} → Oct 19, 2024
```

In the example above we explicitly set the expiry date in front matter. With Hugo's default configuration, the `ExpiryDate` method returns the front matter value. This behavior is configurable, allowing you to set fallback values if the expiry date is not defined in front matter. See [details][].

[`time.Format`]: /functions/time/format/
[details]: /configuration/front-matter/#dates
[time methods]: /methods/time/
[time.Time]: https://pkg.go.dev/time#Time


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/File.md
---


By default, not all pages are backed by a file, including top-level [section pages](g), [taxonomy pages](g), and [term pages](g). By definition, you cannot retrieve file information when the file does not exist.

To back one of the pages above with a file, create an&nbsp;`_index.md`&nbsp;file in the corresponding directory. For example:

```tree
content/
└── books/
    ├── _index.md  <-- the top-slevel section page
    ├── book-1.md
    └── book-2.md
```

> [!NOTE]
> Code defensively by verifying file existence as shown in the examples below.

## Methods

Use these methods on the `File` object.

> [!NOTE]
> The path separators (slash or backslash) in `Path`, `Dir`, and `Filename` depend on the operating system.

`BaseFileName`
: (`string`) The file name, excluding the extension.

  ```go-html-template
  {{ with .File }}
    {{ .BaseFileName }}
  {{ end }}
  ```

`ContentBaseName`
: (`string`) If the page is a branch or leaf bundle, the name of the containing directory, else the `TranslationBaseName`.

  ```go-html-template
  {{ with .File }}
    {{ .ContentBaseName }}
  {{ end }}
  ```

`Dir`
: (`string`) The file path, excluding the file name, relative to the `content` directory.

  ```go-html-template
  {{ with .File }}
    {{ .Dir }}
  {{ end }}
  ```

`Ext`
: (`string`) The file extension.

  ```go-html-template
  {{ with .File }}
    {{ .Ext }}
  {{ end }}
  ```

`Filename`
: (`string`) The absolute file path.

  ```go-html-template
  {{ with .File }}
    {{ .Filename }}
  {{ end }}
  ```

`IsContentAdapter`
: (`bool`) Reports whether the file is a [content adapter][].

  ```go-html-template
  {{ with .File }}
    {{ .IsContentAdapter }}
  {{ end }}
  ```

`LogicalName`
: (`string`) The file name.

  ```go-html-template
  {{ with .File }}
    {{ .LogicalName }}
  {{ end }}
  ```

`Path`
: (`string`) The file path, relative to the `content` directory.

  ```go-html-template
  {{ with .File }}
    {{ .Path }}
  {{ end }}
  ```

`Section`
: (`string`) The name of the top-level section in which the file resides.

  ```go-html-template
  {{ with .File }}
    {{ .Section }}
  {{ end }}
  ```

`TranslationBaseName`
: (`string`) The file name, excluding the extension and language identifier.

  ```go-html-template
  {{ with .File }}
    {{ .TranslationBaseName }}
  {{ end }}
  ```

`UniqueID`
: (`string`) The MD5 hash of `.File.Path`.

  ```go-html-template
  {{ with .File }}
    {{ .UniqueID }}
  {{ end }}
  ```

## Examples

Consider this content structure in a multilingual project:

```tree
content/
├── news/
│   ├── b/
│   │   ├── index.de.md   <-- leaf bundle
│   │   └── index.en.md   <-- leaf bundle
│   ├── a.de.md           <-- regular content
│   ├── a.en.md           <-- regular content
│   ├── _index.de.md      <-- branch bundle
│   └── _index.en.md      <-- branch bundle
├── _index.de.md
└── _index.en.md
```

With the English language site:

&nbsp;|regular content|leaf bundle|branch bundle
:--|:--|:--|:--
BaseFileName|a.en|index.en|_index.en
ContentBaseName|a|b|news
Dir|news/|news/b/|news/
Ext|md|md|md
Filename|/home/user/...|/home/user/...|/home/user/...
IsContentAdapter|false|false|false
LogicalName|a.en.md|index.en.md|_index.en.md
Path|news/a.en.md|news/b/index.en.md|news/_index.en.md
Section|news|news|news
TranslationBaseName|a|index|_index
UniqueID|15be14b...|186868f...|7d9159d...

## Defensive coding

Some of the pages on a site may not be backed by a file. For example:

- Top-level section pages
- Taxonomy pages
- Term pages

Without a backing file, Hugo will throw an error if you attempt to access a `.File` property. To code defensively, first check for file existence:

```go-html-template
{{ with .File }}
  {{ .ContentBaseName }}
{{ end }}
```

[content adapter]: /content-management/content-adapters/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/FirstSection.md
---


{{% glossary-term section %}}

> [!NOTE]
> When called on the home page, the `FirstSection` method returns the `Page` object of the home page itself.

Consider this content structure:

```tree
content/
├── auctions/
│   ├── 2023-11/
│   │   ├── _index.md     <-- first section: auctions
│   │   ├── auction-1.md
│   │   └── auction-2.md  <-- first section: auctions
│   ├── 2023-12/
│   │   ├── _index.md
│   │   ├── auction-3.md
│   │   └── auction-4.md
│   ├── _index.md         <-- first section: auctions
│   ├── bidding.md
│   └── payment.md        <-- first section: auctions
├── books/
│   ├── _index.md         <-- first section: books
│   ├── book-1.md
│   └── book-2.md         <-- first section: books
├── films/
│   ├── _index.md         <-- first section: films
│   ├── film-1.md
│   └── film-2.md         <-- first section: films
└── _index.md             <-- first section: home
```

To link to the top-level section of which the current page is a descendant:

```go-html-template
<a href="{{ .FirstSection.RelPermalink }}">{{ .FirstSection.LinkTitle }}</a>
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/Fragments.md
---


In a URL, whether absolute or relative, the [fragment](g) links to an `id` attribute of an HTML element on the page.

```text
/articles/article-1#section-2
------------------- ---------
       path         fragment
```

Hugo assigns an `id` attribute to each Markdown [ATX][] and [setext][] heading within the page content. You can override the `id` with a [Markdown attribute](g) as needed. This creates the relationship between an entry in the [table of contents][] (TOC) and a heading on the page.

Use the `Fragments` method on a `Page` object to create a table of contents with the `Fragments.ToHTML` method, or by [walking](g) the `Fragments.Map` data structure. Use the methods below to inspect, validate, and render page fragments.

## Methods

Use these methods on the `Fragments` object.

`Headings`
: (`slice`) A slice of maps of all headings on the page, with first-level keys for each heading. Each map contains the following keys: `ID`, `Level`, `Title` and `Headings`. To inspect the data structure:

  ```go-html-template
  <pre>{{ debug.Dump .Fragments.Headings }}</pre>
  ```

`HeadingsMap`
: (`map`) A nested map of all headings on the page. Each map contains the following keys: `ID`, `Level`, `Title` and `Headings`. To inspect the data structure:

  ```go-html-template
  <pre>{{ debug.Dump .Fragments.HeadingsMap }}</pre>
  ```

`Identifiers`
: (`slice`) A slice containing the `id` attribute of each heading on the page. If so configured, will also contain the `id` attribute of each description term (i.e., `dt` element) on the page.

  See [configure Markup][].

  To inspect the data structure:

  ```go-html-template
  <pre>{{ debug.Dump .Fragments.Identifiers }}</pre>
  ```

`Identifiers.Contains ID`
: (`bool`) Reports whether one or more headings on the page has the given `id` attribute, useful for validating fragments within a link [render hook](g).

  ```go-html-template
  {{ .Fragments.Identifiers.Contains "section-2" }} → true
  ```

`Identifiers.Count ID`
: (`int`) The number of headings on a page with the given `id` attribute, useful for detecting duplicates.

  ```go-html-template
  {{ .Fragments.Identifiers.Count "section-2" }} → 1
  ```

`ToHTML`
: (`template.HTML`) Returns a TOC as a nested list, either ordered or unordered, identical to the HTML returned by the [`TableOfContents`][] method. This method take three arguments: the start level&nbsp;(`int`), the end level&nbsp;(`int`), and a boolean (`true` to return an ordered list, `false` to return an unordered list).

  Use this method when you want to control the start level, end level, or list type independently from the table of contents settings in your project configuration.

  ```go-html-template
  {{ $startLevel := 2 }}
  {{ $endLevel := 3 }}
  {{ $ordered := true }}
  {{ .Fragments.ToHTML $startLevel $endLevel $ordered }}
  ```

  Hugo renders this to:

  ```html
  <nav id="TableOfContents">
    <ol>
      <li><a href="#section-1">Section 1</a>
        <ol>
          <li><a href="#section-11">Section 1.1</a></li>
          <li><a href="#section-12">Section 1.2</a></li>
        </ol>
      </li>
      <li><a href="#section-2">Section 2</a></li>
    </ol>
  </nav>
  ```

## Notes

> [!NOTE]
> It is safe to use the `Fragments` methods within a render hook, even for the current page.
>
> When using the `Fragments` methods within a shortcode, call the shortcode using [standard notation][]. If you use [Markdown notation][] the rendered shortcode is included in the creation of the fragments map, resulting in a circular loop.

[ATX]: https://spec.commonmark.org/current/#atx-headings
[Markdown notation]: /content-management/shortcodes/#notation
[`TableOfContents`]: /methods/page/tableofcontents/
[configure Markup]: /configuration/markup/#parserautodefinitiontermid
[setext]: https://spec.commonmark.org/current/#setext-headings
[standard notation]: /content-management/shortcodes/#notation
[table of contents]: /methods/page/tableofcontents/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/FuzzyWordCount.md
---


```go-html-template
{{ .FuzzyWordCount }} → 200
```

To get the exact word count, use the [`WordCount`][] method.

[`WordCount`]: /methods/page/wordcount/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/GetPage.md
---


The `GetPage` method is also available on a `Site` object. See [details][].

When using the `GetPage` method on the `Page` object, specify a path relative to the current directory or relative to the `content` directory.

If Hugo cannot resolve the path to a page, the method returns nil. If the path is ambiguous, Hugo throws an error and fails the build.

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

The examples below depict the result of rendering `works/paintings/the-mona-lisa.md`:

```go-html-template {file="layouts/works/page.html"}
{{ with .GetPage "starry-night" }}
  {{ .Title }} → Starry Night
{{ end }}

{{ with .GetPage "./starry-night" }}
  {{ .Title }} → Starry Night
{{ end }}

{{ with .GetPage "../paintings/starry-night" }}
  {{ .Title }} → Starry Night
{{ end }}

{{ with .GetPage "/works/paintings/starry-night" }}
  {{ .Title }} → Starry Night
{{ end }}

{{ with .GetPage "../sculptures/david" }}
  {{ .Title }} → David
{{ end }}

{{ with .GetPage "/works/sculptures/david" }}
  {{ .Title }} → David
{{ end }}
```

[details]: /methods/site/getpage/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/GetTerms.md
---


Given this front matter:

{{< code-toggle file=content/books/les-miserables.md fm=true >}}
title = 'Les Misérables'
tags = ['historical','classic','fiction']
{{< /code-toggle >}}

This template code:

```go-html-template
{{ with .GetTerms "tags" }}
  <p>Tags</p>
  <ul>
    {{ range . }}
      <li><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></li>
    {{ end }}
  </ul>
{{ end }}
```

Is rendered to:

```html
<p>Tags</p>
<ul>
  <li><a href="/tags/historical/">historical</a></li>
  <li><a href="/tags/classic/">classic</a></li>
  <li><a href="/tags/fiction/">fiction</a></li>
</ul>
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/GitInfo.md
---


The `GitInfo` method on a `Page` object provides access to commit metadata from your Git history, such as the author's name, the commit hash, and the commit message.

> [!NOTE]
> Hugo's Git integration is performant, but may increase build times for large projects.

## Prerequisites

Install Git, create a repository, and commit your project files.

You must also allow Hugo to access your repository by adding this to your project configuration:

{{< code-toggle file=hugo >}}
enableGitInfo = true
{{< /code-toggle >}}

> [!NOTE]
> When you set [`enableGitInfo`][] to `true`, the last modification date for each content page will automatically be the Author Date of the last commit for that file.
>
> This is configurable. See [details][].

## Scope

Commit metadata is available for content stored in your local repository and for content provided by [modules](g).

### Local content

Hugo retrieves commit metadata for files tracked within your project's local repository. This includes all content files managed by Git in your main project directory.

### Module content

{{< new-in 0.157.0 />}}

Hugo also retrieves commit metadata for content provided by modules. This allows you to display commit data for remote repositories that are mounted as content directories, such as when aggregating documentation from multiple sources.

> [!NOTE]
> The `GitInfo` method returns nil for module content in these cases:
>
> - The module is vendored via `hugo mod vendor`
> - A [module replacement][] is configured via a `replace` directive in `go.mod` or the [`replacements`][] configuration parameter

## Methods

Use these methods on the `GitInfo` object.

`AbbreviatedHash`
: (`string`) Returns the seven-character shortened version of the commit hash.

  ```go-html-template
  {{ with .GitInfo }}
    {{ .AbbreviatedHash }} → aab9ec0
  {{ end }}
  ```

`AuthorDate`
: (`time.Time`) Returns the date the author originally created the commit.

  ```go-html-template
  {{ with .GitInfo }}
    {{ .AuthorDate.Format "2006-01-02" }} → 2023-10-09
  {{ end }}
  ```

`AuthorEmail`
: (`string`) Returns the author's email address, respecting [gitmailmap][].

  ```go-html-template
  {{ with .GitInfo }}
    {{ .AuthorEmail }} → jsmith@example.org
  {{ end }}
  ```

`AuthorName`
: (`string`) Returns the author's name, respecting [gitmailmap][].

  ```go-html-template
  {{ with .GitInfo }}
    {{ .AuthorName }} → John Smith
  {{ end }}
  ```

`CommitDate`
: (`time.Time`) Returns the date the commit was applied to the branch.

  ```go-html-template
  {{ with .GitInfo }}
    {{ .CommitDate.Format "2006-01-02" }} → 2023-10-09
  {{ end }}
  ```

`Hash`
: (`string`) Returns the full SHA-1 commit hash.

  ```go-html-template
  {{ with .GitInfo }}
    {{ .Hash }} → aab9ec0b31ebac916a1468c4c9c305f2bebf78d4
  {{ end }}
  ```

`Subject`
: (`string`) Returns the first line of the commit message (the summary).

  ```go-html-template
  {{ with .GitInfo }}
    {{ .Subject }} → Add tutorials
  {{ end }}
  ```

`Body`
: (`string`) Returns the full content of the commit message, excluding the subject line.

  ```go-html-template
  {{ with .GitInfo }}
    {{ .Body }} → Two new pages added.
  {{ end }}
  ```

`Ancestors`
: (`gitmap.GitInfos`) Returns a list of previous commits for this specific file, ordered from most recent to oldest.

  For example, to list the last 5 commits:

  ```go-html-template
  {{ with .GitInfo }}
    {{ range .Ancestors | first 5 }}
      {{ .CommitDate.Format "2006-01-02" }}: {{ .Subject }}
    {{ end }}
  {{ end }}
  ```

  To reverse the order:

  ```go-html-template
  {{ with .GitInfo }}
    {{ range .Ancestors.Reverse | first 5 }}
      {{ .CommitDate.Format "2006-01-02" }}: {{ .Subject }}
    {{ end }}
  {{ end }}
  ```

`Parent`
: (`*gitmap.GitInfo`) Returns the most recent ancestor commit for the file, if any.

## Last modified date

By default, when `enableGitInfo` is `true`, the `Lastmod` method on a `Page` object returns the Git AuthorDate of the last commit that included the file.

You can change this behavior in your [project configuration][].

## Hosting considerations

On a [CI/CD](g) platform, the step that clones your project repository must perform a deep clone. If the clone is shallow, the Git information for a given file may be inaccurate. It might incorrectly reflect the most recent repository commit, rather than the commit that actually modified the file.

While some providers perform a deep clone by default, others require you to configure the depth yourself.

Hosting service|Default clone depth|Configurable
:--|:--|:--
AWS Amplify|Deep|N/A
Cloudflare|Shallow|Yes [^1]
DigitalOcean App Platform|Deep|N/A
GitHub Pages|Shallow|Yes [^2]
GitLab Pages|Shallow|Yes [^3]
Netlify|Deep|N/A
Render|Shallow|Yes [^1]
Vercel|Shallow|Yes [^1]

[^1]: To perform a deep clone when hosting on Cloudflare, Render, or Vercel, include this code in the build script after the repository has been cloned:

    ```sh
    if [ "$(git rev-parse --is-shallow-repository)" = "true" ]; then
      git fetch --unshallow
    fi
    ```

[^2]: To perform a deep clone when hosting on GitHub Pages, set `fetch-depth: 0` in the `checkout` step of the GitHub Action.

[^3]: To perform a deep clone when hosting on GitLab Pages, set the `GIT_DEPTH` environment variable to `0` in the workflow file.

[`enableGitInfo`]: /configuration/all/#enablegitinfo
[`replacements`]: /configuration/module/#replacements
[details]: /configuration/front-matter/#dates
[gitmailmap]: https://git-scm.com/docs/gitmailmap
[module replacement]: /hugo-modules/use-modules/#replace
[project configuration]: /configuration/front-matter/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/HasMenuCurrent.md
---


If the `Page` object associated with the menu entry is a section, this method also returns `true` for any descendant of that section.

```go-html-template
{{ $currentPage := . }}
{{ range site.Menus.main }}
  {{ if $currentPage.IsMenuCurrent .Menu . }}
    <a class="active" aria-current="page" href="{{ .URL }}">{{ .Name }}</a>
  {{ else if $currentPage.HasMenuCurrent .Menu . }}
    <a class="ancestor" aria-current="true" href="{{ .URL }}">{{ .Name }}</a>
  {{ else }}
    <a href="{{ .URL }}">{{ .Name }}</a>
  {{ end }}
{{ end }}
```

See [menu templates][] for a complete example.

> [!NOTE]
> When using this method you must either define the menu entry in front matter, or specify a `pageRef` property when defining the menu entry in your project configuration.

[menu templates]: /templates/menu/#example


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/HasShortcode.md
---


By example, let's use [Plotly][] to render a chart:

```md {file="content/example.md"}
{{</* plotly */>}}
{
  "data": [
    {
      "x": ["giraffes", "orangutans", "monkeys"],
      "y": [20, 14, 23],
      "type": "bar"
    }
  ],
}
{{</* /plotly */>}}
```

The shortcode is simple:

```go-html-template {file="layouts/_shortcodes/plotly.html"}
{{ $id := printf "plotly-%02d" .Ordinal }}
<div id="{{ $id }}"></div>
<script>
  Plotly.newPlot(document.getElementById({{ $id }}), {{ .Inner | safeJS }});
</script>
```

Now we can selectively load the required JavaScript on pages that call the "plotly" shortcode:

```go-html-template {file="layouts/baseof.html"}
<head>
  ...
  {{ if .HasShortcode "plotly" }}
    <script src="https://cdn.plot.ly/plotly-2.28.0.min.js"></script>
  {{ end }}
  ...
</head>
```

[Plotly]: https://plotly.com/javascript/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/HeadingsFiltered.md
---


Use in conjunction with the [`Related`][] method on a [`Pages`][] object. See [details][].

[`Pages`]: /methods/pages/
[`Related`]: /methods/pages/related/
[details]: /content-management/related-content/#index-content-headings


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/InSection.md
---


{{% glossary-term section %}}

The `InSection` method on a `Page` object reports whether the given page is in the given section. Note that the method returns `true` when comparing a page to a sibling.

With this content structure:

```tree
content/
├── auctions/
│   ├── 2023-11/
│   │   ├── _index.md
│   │   ├── auction-1.md
│   │   └── auction-2.md
│   ├── 2023-12/
│   │   ├── _index.md
│   │   ├── auction-3.md
│   │   └── auction-4.md
│   ├── _index.md
│   ├── bidding.md
│   └── payment.md
└── _index.md
```

When rendering the `auction-1` page:

```go-html-template
{{ with .Site.GetPage "/" }}
  {{ $.InSection . }} → false
{{ end }}

{{ with .Site.GetPage "/auctions" }}
  {{ $.InSection . }} → false
{{ end }}

{{ with .Site.GetPage "/auctions/2023-11" }}
  {{ $.InSection . }} → true
{{ end }}

{{ with .Site.GetPage "/auctions/2023-11/auction-2" }}
  {{ $.InSection . }} → true
{{ end }}
```

In the examples above we are coding defensively using the [`with`][] statement, returning nothing if the page does not exist. By adding an [`else`][] clause we can do some error reporting:

```go-html-template
{{ $path := "/auctions/2023-11" }}
{{ with .Site.GetPage $path }}
  {{ $.InSection . }} → true
{{ else }}
  {{ errorf "Unable to find the section with path %s" $path }}
{{ end }}
  ```

## Understanding context

Inside of the `with` block, the [context](g) (the dot) is the section `Page` object, not the `Page` object passed into the template. If we were to use this syntax:

```go-html-template
{{ with .Site.GetPage "/auctions" }}
  {{ .InSection . }} → true
{{ end }}
```

The result would be wrong when rendering the `auction-1` page because we are comparing the section page to itself.

> [!NOTE]
> Use the `$` to get the context passed into the template.

```go-html-template
{{ with .Site.GetPage "/auctions" }}
  {{ $.InSection . }} → true
{{ end }}
```

> [!NOTE]
> Gaining a thorough understanding of context is critical for anyone writing template code.

[`else`]: /functions/go-template/else/
[`with`]: /functions/go-template/with/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/IsAncestor.md
---


With this content structure:

```tree
content/
├── auctions/
│   ├── 2023-11/
│   │   ├── _index.md
│   │   ├── auction-1.md
│   │   └── auction-2.md
│   ├── 2023-12/
│   │   ├── _index.md
│   │   ├── auction-3.md
│   │   └── auction-4.md
│   ├── _index.md
│   ├── bidding.md
│   └── payment.md
└── _index.md
```

When rendering the `auctions` page:

```go-html-template
{{ with .Site.GetPage "/" }}
  {{ $.IsAncestor . }} → false
{{ end }}

{{ with .Site.GetPage "/auctions" }}
  {{ $.IsAncestor . }} → false
{{ end }}

{{ with .Site.GetPage "/auctions/2023-11" }}
  {{ $.IsAncestor . }} → true
{{ end }}

{{ with .Site.GetPage "/auctions/2023-11/auction-2" }}
  {{ $.IsAncestor . }} → true
{{ end }}
```

In the examples above we are coding defensively using the [`with`][] statement, returning nothing if the page does not exist. By adding an [`else`][] clause we can do some error reporting:

```go-html-template
{{ $path := "/auctions/2023-11" }}
{{ with .Site.GetPage $path }}
  {{ $.IsAncestor . }} → true
{{ else }}
  {{ errorf "Unable to find the section with path %s" $path }}
{{ end }}
  ```

## Understanding context

Inside of the `with` block, the [context](g) (the dot) is the section `Page` object, not the `Page` object passed into the template. If we were to use this syntax:

```go-html-template
{{ with .Site.GetPage "/auctions" }}
  {{ .IsAncestor . }} → true
{{ end }}
```

The result would be wrong when rendering the `auction-1` page because we are comparing the section page to itself.

> [!NOTE]
> Use the `$` to get the context passed into the template.

```go-html-template
{{ with .Site.GetPage "/auctions" }}
  {{ $.IsAncestor . }} → true
{{ end }}
```

> [!NOTE]
> Gaining a thorough understanding of context is critical for anyone writing template code.

[`else`]: /functions/go-template/else/
[`with`]: /functions/go-template/with/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/IsBranch.md
---


{{< new-in 0.163.0 />}}

{{% glossary-term branch %}}

```tree
content/
├── books/
│   ├── book-1/
│   │   └── index.md    <-- kind = page      IsBranch = false
│   ├── book-2.md       <-- kind = page      IsBranch = false
│   └── _index.md       <-- kind = section   IsBranch = true
├── tags
│   ├── fiction
│   │   └── _index.md   <-- kind = term      IsBranch = true
│   └── _index.md       <-- kind = taxonomy  IsBranch = true
└── _index.md           <-- kind = home      IsBranch = true
```

```go-html-template
{{ .IsBranch }}
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/IsDescendant.md
---


With this content structure:

```tree
content/
├── auctions/
│   ├── 2023-11/
│   │   ├── _index.md
│   │   ├── auction-1.md
│   │   └── auction-2.md
│   ├── 2023-12/
│   │   ├── _index.md
│   │   ├── auction-3.md
│   │   └── auction-4.md
│   ├── _index.md
│   ├── bidding.md
│   └── payment.md
└── _index.md
```

When rendering the `auctions` page:

```go-html-template
{{ with .Site.GetPage "/" }}
  {{ $.IsDescendant . }} → true
{{ end }}

{{ with .Site.GetPage "/auctions" }}
  {{ $.IsDescendant . }} → false
{{ end }}

{{ with .Site.GetPage "/auctions/2023-11" }}
  {{ $.IsDescendant . }} → false
{{ end }}

{{ with .Site.GetPage "/auctions/2023-11/auction-2" }}
  {{ $.IsDescendant . }} → false
{{ end }}
```

In the examples above we are coding defensively using the [`with`][] statement, returning nothing if the page does not exist. By adding an [`else`][] clause we can do some error reporting:

```go-html-template
{{ $path := "/auctions/2023-11" }}
{{ with .Site.GetPage $path }}
  {{ $.IsDescendant . }} → true
{{ else }}
  {{ errorf "Unable to find the section with path %s" $path }}
{{ end }}
  ```

## Understanding context

Inside of the `with` block, the [context](g) (the dot) is the section `Page` object, not the `Page` object passed into the template. If we were to use this syntax:

```go-html-template
{{ with .Site.GetPage "/auctions" }}
  {{ .IsDescendant . }} → true
{{ end }}
```

The result would be wrong when rendering the `auction-1` page because we are comparing the section page to itself.

> [!NOTE]
> Use the `$` to get the context passed into the template.

```go-html-template
{{ with .Site.GetPage "/auctions" }}
  {{ $.IsDescendant . }} → true
{{ end }}
```

> [!NOTE]
> Gaining a thorough understanding of context is critical for anyone writing template code.

[`else`]: /functions/go-template/else/
[`with`]: /functions/go-template/with/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/IsHome.md
---


The `IsHome` method on a `Page` object returns `true` if the [page kind](g) is `home`.

```tree
content/
├── books/
│   ├── book-1/
│   │   └── index.md  <-- kind = page
│   ├── book-2.md     <-- kind = page
│   └── _index.md     <-- kind = section
└── _index.md         <-- kind = home
```

```go-html-template
{{ .IsHome }}
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/IsMenuCurrent.md
---


```go-html-template
{{ $currentPage := . }}
{{ range site.Menus.main }}
  {{ if $currentPage.IsMenuCurrent .Menu . }}
    <a class="active" aria-current="page" href="{{ .URL }}">{{ .Name }}</a>
  {{ else if $currentPage.HasMenuCurrent .Menu . }}
    <a class="ancestor" aria-current="true" href="{{ .URL }}">{{ .Name }}</a>
  {{ else }}
    <a href="{{ .URL }}">{{ .Name }}</a>
  {{ end }}
{{ end }}
```

See [menu templates][] for a complete example.

> [!NOTE]
> When using this method you must either define the menu entry in front matter, or specify a `pageRef` property when defining the menu entry in your project configuration.

[menu templates]: /templates/menu/#example


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/IsNode.md
---


{{< deprecated-in 0.163.0 >}}
Use the [`IsBranch`](/methods/page/isbranch/) method instead.
{{< /deprecated-in >}}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/IsPage.md
---


The `IsPage` method on a `Page` object returns `true` if the [page kind](g) is `page`.

```tree
content/
├── books/
│   ├── book-1/
│   │   └── index.md  <-- kind = page
│   ├── book-2.md     <-- kind = page
│   └── _index.md     <-- kind = section
└── _index.md         <-- kind = home
```

```go-html-template
{{ .IsPage }}
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/IsSection.md
---


The `IsSection` method on a `Page` object returns `true` if the [page kind](g) is `section`.

```tree
content/
├── books/
│   ├── book-1/
│   │   └── index.md  <-- kind = page
│   ├── book-2.md     <-- kind = page
│   └── _index.md     <-- kind = section
└── _index.md         <-- kind = home
```

```go-html-template
{{ .IsSection }}
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/IsTranslated.md
---


With this project configuration:

{{< code-toggle file=hugo >}}
defaultContentLanguage = 'en'

[languages.en]
contentDir = 'content/en'
label = 'English'
locale = 'en-US'
weight = 1

[languages.de]
contentDir = 'content/de'
label = 'Deutsch'
locale = 'de-DE'
weight = 2
{{< /code-toggle >}}

And this content:

```tree
content/
├── de/
│   ├── books/
│   │   └── book-1.md
│   └── _index.md
├── en/
│   ├── books/
│   │   ├── book-1.md
│   │   └── book-2.md
│   └── _index.md
└── _index.md
```

When rendering `content/en/books/book-1.md`:

```go-html-template
{{ .IsTranslated }} → true
```

When rendering `content/en/books/book-2.md`:

```go-html-template
{{ .IsTranslated }} → false
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/Keywords.md
---


By default, Hugo evaluates the keywords when creating collections of [related content][].

{{< code-toggle file=content/recipes/sushi.md fm=true >}}
title = 'How to make spicy tuna hand rolls'
keywords = ['tuna','sriracha','nori','rice']
{{< /code-toggle >}}

To list the keywords within a template:

```go-html-template
{{ range .Keywords }}
  {{ . }}
{{ end }}
```

Or use the [`delimit`][] function:

```go-html-template
{{ delimit .Keywords ", " ", and " }} → tuna, sriracha, nori, and rice
```

Keywords are also a useful [taxonomy][]:

{{< code-toggle file=hugo >}}
[taxonomies]
tag = 'tags'
keyword = 'keywords'
category = 'categories'
{{< /code-toggle >}}

[`delimit`]: /functions/collections/delimit/
[related content]: /content-management/related-content/
[taxonomy]: /content-management/taxonomies/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/Kind.md
---


The [page kind](g) is one of `home`, `page`, `section`, `taxonomy`, or `term`.

```tree
content/
├── books/
│   ├── book-1/
│   │   └── index.md    <-- kind = page
│   ├── book-2.md       <-- kind = page
│   └── _index.md       <-- kind = section
├── tags/
│   ├── fiction/
│   │   └── _index.md   <-- kind = term
│   └── _index.md       <-- kind = taxonomy
└── _index.md           <-- kind = home
```

To get the value within a template:

```go-html-template
{{ .Kind }}
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/Language.md
---


The `Language` method on a `Page` object returns the `Language` object for the given page, derived from the language definition in your project configuration.

You can also use the `Language` method on a `Site` object. See [details][].

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
  {{ .Language.Direction }} → ltr
  ```

`IsDefault`
: {{< new-in 0.153.0 />}}
: (`bool`) Reports whether this is the [default language](g).

  ```go-html-template
  {{ .Language.IsDefault }} → true
  ```

`Label`
: {{< new-in 0.158.0 />}}
: (`string`) Returns the [`label`][] from the language definition.

  ```go-html-template
  {{ .Language.Label }} → Deutsch
  ```

`Lang`
: {{<deprecated-in 0.158.0 />}}
: Use [`Name`](#name) instead.

`LanguageCode`
: {{<deprecated-in 0.158.0 />}}
: Use [`Locale`](#locale) instead.

`LanguageDirection`
: {{<deprecated-in 0.158.0 />}}

Use [`Direction`](#direction) instead.
`LanguageName`
: {{<deprecated-in 0.158.0 />}}
: Use [`Label`](#label) instead.

`Locale`
: {{< new-in 0.158.0 />}}
: (`string`) Returns the [`locale`][] from the language definition, falling back to [`Name`](#name).

  ```go-html-template
  {{ .Language.Locale }} → de-DE
  ```

`Name`
: {{< new-in 0.153.0 />}}
: (`string`) Returns the language tag as defined by [RFC 5646][]. This is the lowercased key from the language definition.

  ```go-html-template
  {{ .Language.Name }} → de
  ```

`Weight`
: {{<deprecated-in 0.158.0 />}}

## Example

Use the code below to create a language selector, allowing users to navigate between the different translated versions of the current page.

```go-html-template {file="layouts/_partials/language-selector.html" copy=true}
{{ with .Rotate "language" }}
  <nav class="language-selector">
    <ul>
      {{ range . }}
        {{ if eq .Language $.Language }}
          <li class="active">
            <a aria-current="page" href="{{ .Permalink }}" hreflang="{{ .Language.Locale }}">{{ .Language.Label }}</a>
          </li>
        {{ else }}
          <li>
            <a href="{{ .Permalink }}" hreflang="{{ .Language.Locale }}">{{ .Language.Label }}</a>
          </li>
        {{ end }}
      {{ end }}
    </ul>
  </nav>
{{ end }}
```

[RFC 5646]: https://datatracker.ietf.org/doc/html/rfc5646
[`direction`]: /configuration/languages/#direction
[`label`]: /configuration/languages/#label
[`locale`]: /configuration/languages/#locale
[details]: /methods/site/language/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/Lastmod.md
---


Set the last modification date in front matter:

{{< code-toggle file=content/news/article-1.md fm=true >}}
title = 'Article 1'
lastmod = 2023-10-19T00:40:04-07:00
{{< /code-toggle >}}

The last modification date is a [`time.Time`][] value. Format and localize the value with the [`time.Format`][] function, or use it with any of the [time methods][].

```go-html-template
{{ .Lastmod | time.Format ":date_medium" }} → Oct 19, 2023
```

In the example above we explicitly set the last modification date in front matter. With Hugo's default configuration, the `Lastmod` method returns the front matter value. This behavior is configurable, allowing you to:

- Set the last modification date to the Author Date of the last Git commit for that file. See [`GitInfo`][] for details.
- Set fallback values if the last modification date is not defined in front matter.

Learn more about [date configuration][].

[`GitInfo`]: /methods/page/gitinfo/
[`time.Format`]: /functions/time/format/
[date configuration]: /configuration/front-matter/#dates
[time methods]: /methods/time/
[`time.Time`]: https://pkg.go.dev/time#Time


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/Layout.md
---


Specify the `layout` field in front matter to target a particular template. See [details][].

{{< code-toggle file=content/contact.md fm=true >}}
title = 'Contact'
layout = 'contact'
{{< /code-toggle >}}

Hugo will render the page using contact.html.

```tree
layouts/
├── baseof.html
├── contact.html
├── home.html
├── page.html
├── section.html
├── taxonomy.html
└── term.html
```

Although rarely used within a template, you can access the value with:

```go-html-template
{{ .Layout }}
```

The `Layout` method returns an empty string if the `layout` field in front matter is not defined.

[details]: /templates/lookup-order/#target-a-template


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/Len.md
---


```go-html-template
{{ .Len }} → 42
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/LinkTitle.md
---


The `LinkTitle` method returns the `linkTitle` field as defined in front matter, falling back to the value returned by the [`Title`][] method.

{{< code-toggle file=content/articles/healthy-desserts.md fm=true >}}
title = 'Seventeen delightful recipes for healthy desserts'
linkTitle = 'Dessert recipes'
{{< /code-toggle >}}

```go-html-template
{{ .LinkTitle }} → Dessert recipes
```

As demonstrated above, defining a link title in front matter is advantageous when the page title is long. Use it when generating anchor elements in your templates:

```go-html-template
<a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a>
```

[`Title`]: /methods/page/title/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/Next.md
---


{{% include "/_common/methods/page/next-and-prev.md" %}}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/NextInSection.md
---


{{% include "/_common/methods/page/nextinsection-and-previnsection.md" %}}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/OutputFormats.md
---


{{% glossary-term "output format" %}}

The `OutputFormats` method on a `Page` object returns a slice of `OutputFormat` objects, each representing one of the output formats enabled for the given page. See [details][].

## Methods

Use these methods on the `OutputFormats` object.

`Canonical`
: {{< new-in 0.154.4 />}}
: (`page.OutputFormat`) Returns the [canonical output format](g) for the current page, if defined. Once you have captured the object, use any of its [associated methods][].

  ```go-html-template
  {{ with .Site.Home.OutputFormats.Canonical }}
    {{ .MediaType.Type }} → text/html
    {{ .MediaType.MainType }} → text
    {{ .MediaType.SubType }} → html
    {{ .Name }} → html
    {{ .Permalink }} → https://example.org/
    {{ .Rel }} → canonical
    {{ .RelPermalink }} → /
  {{ end }}
  ```

`Get`
: (`page.OutputFormat`) Returns the `OutputFormat` object with the given identifier. Once you have captured the object, use any of its [associated methods][].

  ```go-html-template
  {{ with .Site.Home.OutputFormats.Get "rss" }}
    {{ .MediaType.Type }} → application/rss+xml
    {{ .MediaType.MainType }} → application
    {{ .MediaType.SubType }} → rss
    {{ .Name }} → rss
    {{ .Permalink }} → https://example.org/index.xml
    {{ .Rel }} → alternate
    {{ .RelPermalink }} → /index.xml
  {{ end }}
  ```

## Examples

To render a `link` element pointing to the [canonical output format](g) for the current page:

```go-html-template
{{ with .OutputFormats.Canonical }}
  {{ printf "<link rel=%q type=%q href=%q>" .Rel .MediaType.Type .Permalink | safeHTML }}
{{ end }}
```

To render an anchor element pointing to the `rss` output format for the current page:

```go-html-template
{{ with .OutputFormats.Get "rss" }}
  <a href="{{ .RelPermalink }}">RSS Feed</a>
{{ end }}
```

Please see the [link to output formats][] section to understand the importance of the construct above.

[associated methods]: /methods/output-format/
[details]: /configuration/output-formats/
[link to output formats]: /configuration/output-formats/#link-to-output-formats


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/Page.md
---


This is a convenience method, useful within _partial_ templates that are called from both _shortcode_ and other template types.

```go-html-template {file="layouts/_shortcodes/foo.html"}
{{ partial "my-partial.html" . }}
```

When the _shortcode_ template calls the _partial_ template, it passes the current [context](g) (the dot). The context includes identifiers such as `Page`, `Params`, `Inner`, and `Name`.

```go-html-template {file="layouts/page.html"}
{{ partial "my-partial.html" . }}
```

When the _page_ template calls the _partial_ template, it also passes the current context (the dot). But in this case, the dot _is_ the `Page` object.

```go-html-template {file="layouts/_partials/my-partial.html"}
The page title is: {{ .Page.Title }}
```

To handle both scenarios, the _partial_ template must be able to access the `Page` object with `Page.Page`.

> [!NOTE]
> And yes, that means you can do `.Page.Page.Page.Page.Title` too.
>
> But don't.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/Pages.md
---


The `Pages` method on a `Page` object is available to these [page kinds](g): `home`, `section`, `taxonomy`, and `term`. The templates for these page kinds receive a page [collection](g) in [context](g), in the [default sort order](g).

Range through the page collection in your template:

```go-html-template
{{ range .Pages.ByTitle }}
  <h2><a href="{{ .RelPermalink }}">{{ .Title }}</a></h2>
{{ end }}
```

Consider this content structure:

```tree
content/
├── lessons/
│   ├── lesson-1/
│   │   ├── _index.md
│   │   ├── part-1.md
│   │   └── part-2.md
│   ├── lesson-2/
│   │   ├── resources/
│   │   │   ├── task-list.md
│   │   │   └── worksheet.md
│   │   ├── _index.md
│   │   ├── part-1.md
│   │   └── part-2.md
│   ├── _index.md
│   ├── grading-policy.md
│   └── lesson-plan.md
├── _index.md
├── contact.md
└── legal.md
```

When rendering the home page, the `Pages` method returns:

    contact.md
    legal.md
    lessons/_index.md

When rendering the lessons page, the `Pages` method returns:

    lessons/grading-policy.md
    lessons/lesson-plan.md
    lessons/lesson-1/_index.md
    lessons/lesson-2/_index.md

When rendering lesson-1, the `Pages` method returns:

    lessons/lesson-1/part-1.md
    lessons/lesson-1/part-2.md

When rendering lesson-2, the `Pages` method returns:

    lessons/lesson-2/part-1.md
    lessons/lesson-2/part-2.md
    lessons/lesson-2/resources/task-list.md
    lessons/lesson-2/resources/worksheet.md

In the last example, the collection includes pages in the resources subdirectory. That directory is not a [section](g)---it does not contain an&nbsp;`_index.md`&nbsp;file. Its contents are part of the lesson-2 section.

> [!NOTE]
> When used with a `Site` object, the `Pages` method recursively returns all pages within the site. See [details][].

```go-html-template
{{ range .Site.Pages.ByTitle }}
  <h2><a href="{{ .RelPermalink }}">{{ .Title }}</a></h2>
{{ end }}
```

[details]: /methods/site/pages/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/Paginate.md
---


Pagination is the process of splitting a list page into two or more pagers, where each pager contains a subset of the page collection and navigation links to other pagers.

By default, the number of elements on each pager is determined by your [project configuration][]. The default is `10`. Override that value by providing a second argument, an integer, when calling the `Paginate` method.

> [!NOTE]
> There is also a `Paginator` method on `Page` objects, but it can neither filter nor sort the page collection.
>
> The `Paginate` method is more flexible.

You can invoke pagination in [home][], [section][], [taxonomy][], and [term][] templates.

```go-html-template {file="layouts/section.html"}
{{ $pages := where .Site.RegularPages "Section" "articles" }}
{{ $pages = $pages.ByTitle }}
{{ range (.Paginate $pages 7).Pages }}
  <h2><a href="{{ .RelPermalink }}">{{ .Title }}</a></h2>
{{ end }}
{{ partial "pagination.html" . }}
```

In the example above, we:

1. Build a page collection
1. Sort the collection by title
1. Paginate the collection, with 7 elements per pager
1. Range over the paginated page collection, rendering a link to each page
1. Call the embedded pagination template to create navigation links between pagers

> [!NOTE]
> Please note that the results of pagination are cached. Once you have invoked either the `Paginator` or `Paginate` method, the paginated collection is immutable. Additional invocations of these methods will have no effect.

[home]: /templates/types/#home
[project configuration]: /configuration/pagination/
[section]: /templates/types/#section
[taxonomy]: /templates/types/#taxonomy
[term]: /templates/types/#term


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/Paginator.md
---


Pagination is the process of splitting a list page into two or more pagers, where each pager contains a subset of the page collection and navigation links to other pagers.

The number of elements on each pager is determined by your [project configuration][]. The default is `10`.

You can invoke pagination in [home][], [section][], [taxonomy][], and [term][] templates. Each of these receives a collection of regular pages in [context](g). When you invoke the `Paginator` method, it paginates the page collection received in context.

```go-html-template {file="layouts/section.html"}
{{ range .Paginator.Pages }}
  <h2><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></h2>
{{ end }}
{{ partial "pagination.html" . }}
```

In the example above, the embedded pagination template creates navigation links between pagers.

> [!NOTE]
> Although simple to invoke, with the `Paginator` method you can neither filter nor sort the page collection. It acts upon the page collection received in context.
>
> The [`Paginate`][] method is more flexible, and strongly recommended.

> [!NOTE]
> Please note that the results of pagination are cached. Once you have invoked either the `Paginator` or `Paginate` method, the paginated collection is immutable. Additional invocations of these methods will have no effect.

[`Paginate`]: /methods/page/paginate/
[home]: /templates/types/#home
[project configuration]: /configuration/pagination/
[section]: /templates/types/#section
[taxonomy]: /templates/types/#taxonomy
[term]: /templates/types/#term


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/Param.md
---


The `Param` method on a `Page` object looks for the given `KEY` in page parameters, and returns the corresponding value. If it cannot find the `KEY` in page parameters, it looks for the `KEY` in site parameters. If it cannot find the `KEY` in either location, the `Param` method returns `nil`.

Site and theme developers commonly set parameters at the site level, allowing content authors to override those parameters at the page level.

For example, to show a table of contents on every page, but allow authors to hide the table of contents as needed:

Configuration:

{{< code-toggle file=hugo >}}
[params]
display_toc = true
{{< /code-toggle >}}

Content:

{{< code-toggle file=content/example.md fm=true >}}
title = 'Example'
date = 2023-01-01
draft = false
[params]
display_toc = false
{{< /code-toggle >}}

Template:

```go-html-template
{{ if .Param "display_toc" }}
  {{ .TableOfContents }}
{{ end }}
```

The `Param` method returns the value associated with the given `KEY`, regardless of whether the value is truthy or falsy. If you need to ignore falsy values, use this construct instead:

```go-html-template
{{ or .Params.foo site.Params.foo }}
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/Params.md
---


By way of example, consider this front matter:

{{< code-toggle file=content/annual-conference.md fm=true >}}
title = 'Annual conference'
date = 2023-10-17T15:11:37-07:00
[params]
display_related = true
key-with-hyphens = 'must use index function'
[params.author]
  email = 'jsmith@example.org'
  name = 'John Smith'
{{< /code-toggle >}}

The `title` and `date` fields are standard [front matter fields][], while the other fields are user-defined.

Access the custom fields by [chaining](g) the [identifiers](g) when needed:

```go-html-template
{{ .Params.display_related }} → true
{{ .Params.author.email }} → jsmith@example.org
{{ .Params.author.name }} → John Smith
```

In the template example above, each of the keys is a valid identifier. For example, none of the keys contains a hyphen. To access a key that is not a valid identifier, use the [`index`][] function:

```go-html-template
{{ index .Params "key-with-hyphens" }} → must use index function
```

[`index`]: /functions/collections/indexfunction/
[front matter fields]: /content-management/front-matter/#fields


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/Parent.md
---


{{% glossary-term section %}}

> [!NOTE]
> The parent section of a regular page is the [current section][].

Consider this content structure:

```tree
content/
├── auctions/
│   ├── 2023-11/
│   │   ├── _index.md     <-- parent: auctions
│   │   ├── auction-1.md
│   │   └── auction-2.md  <-- parent: 2023-11
│   ├── 2023-12/
│   │   ├── _index.md
│   │   ├── auction-3.md
│   │   └── auction-4.md
│   ├── _index.md         <-- parent: home
│   ├── bidding.md
│   └── payment.md        <-- parent: auctions
├── books/
│   ├── _index.md         <-- parent: home
│   ├── book-1.md
│   └── book-2.md         <-- parent: books
├── films/
│   ├── _index.md         <-- parent: home
│   ├── film-1.md
│   └── film-2.md         <-- parent: films
└── _index.md             <-- parent: nil
```

In the example above, note the parent section of the home page is nil. Code defensively by verifying existence of the parent section before calling methods on its `Page` object. To create a link to the parent section page of the current page:

```go-html-template
{{ with .Parent }}
  <a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a>
{{ end }}
```

[current section]: /methods/page/currentsection/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/Path.md
---


The `Path` method on a `Page` object returns the logical path of the given page, regardless of whether the page is backed by a file.

{{% glossary-term "logical path" %}}

```go-html-template
{{ .Path }} → /posts/post-1
```

The value returned by the `Path` method on a `Page` object is independent of content format, language, and URL modifiers such as the `slug` and `url` front matter fields.

## Examples

### Monolingual project

Note that the logical path is independent of content format and URL modifiers.

File path|Front matter slug|Logical path
:--|:--|:--
`content/_index.md`||`/`
`content/posts/_index.md`||`/posts`
`content/posts/post-1.md`|`foo`|`/posts/post-1`
`content/posts/post-2.html`|`bar`|`/posts/post-2`

### Multilingual site

Note that the logical path is independent of content format, language identifiers, and URL modifiers.

File path|Front matter slug|Logical path
:--|:--|:--
`content/_index.en.md`||`/`
`content/_index.de.md`||`/`
`content/posts/_index.en.md`||`/posts`
`content/posts/_index.de.md`||`/posts`
`content/posts/posts-1.en.md`|`foo`|`/posts/post-1`
`content/posts/posts-1.de.md`|`foo`|`/posts/post-1`
`content/posts/posts-2.en.html`|`bar`|`/posts/post-2`
`content/posts/posts-2.de.html`|`bar`|`/posts/post-2`

### Pages not backed by a file

The `Path` method on a `Page` object returns a value regardless of whether the page is backed by a file.

```tree
content/
└── posts/
    └── post-1.md  <-- front matter: tags = ['hugo']
```

When you build the site:

```tree
public/
├── posts/
│   ├── post-1/
│   │   └── index.html    .Page.Path = /posts/post-1
│   └── index.html        .Page.Path = /posts
├── tags/
│   ├── hugo/
│   │   └── index.html    .Page.Path = /tags/hugo
│   └── index.html        .Page.Path = /tags
└── index.html            .Page.Path = /
```

## Finding pages

These methods, functions, and shortcodes use the logical path to find the given page:

Methods|Functions|Shortcodes
:--|:--|:--
[`Site.GetPage`][]|[`urls.Ref`][]|[`ref`][]
[`Page.GetPage`][]|[`urls.RelRef`][]|[`relref`][]
[`Page.Ref`][]|&nbsp;|&nbsp;
[`Page.RelRef`][]|&nbsp;|&nbsp;
[`Shortcode.Ref`][]|&nbsp;|&nbsp;
[`Shortcode.RelRef`][]|&nbsp;|&nbsp;

> [!NOTE]
> Specify the logical path when using any of these methods, functions, or shortcodes. If you include a file extension or language identifier, Hugo will strip these values before finding the page in the logical tree.

## Logical tree

Just as file paths form a file tree, logical paths form a logical tree.

A file tree:

```tree
content/
└── s1/
    ├── p1/
    │   └── index.md
    └── p2.md
```

The same content represented as a logical tree:

```tree
content/
└── s1/
    ├── p1
    └── p2
```

A key difference between these trees is the relative path from p1 to p2:

- In the file tree, the relative path from p1 to p2 is `../p2.md`
- In the logical tree, the relative path is `p2`

> [!NOTE]
> Remember to use the logical path when using any of the methods, functions, or shortcodes listed in the previous section. If you include a file extension or language identifier, Hugo will strip these values before finding the page in the logical tree.

[`Page.GetPage`]: /methods/page/getpage/
[`Page.Ref`]: /methods/page/ref/
[`Page.RelRef`]: /methods/page/relref/
[`Shortcode.Ref`]: /methods/shortcode/ref/
[`Shortcode.RelRef`]: /methods/shortcode/relref/
[`Site.GetPage`]: /methods/site/getpage/
[`ref`]: /shortcodes/ref/
[`relref`]: /shortcodes/relref/
[`urls.Ref`]: /functions/urls/ref/
[`urls.RelRef`]: /functions/urls/relref/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/Permalink.md
---


Project configuration:

{{< code-toggle file=hugo >}}
title = 'Documentation'
baseURL = 'https://example.org/docs/'
{{< /code-toggle >}}

Template:

```go-html-template
{{ $page := .Site.GetPage "/about" }}
{{ $page.Permalink }} → https://example.org/docs/about/
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/Plain.md
---


The `Plain` method on a `Page` object renders Markdown and [shortcodes](g) to HTML, then strips the HTML [tags][]. It does not strip HTML [entities][].

To prevent Go's [`html/template`][] package from escaping HTML entities, pass the result through the [`htmlUnescape`][] function.

```go-html-template
{{ .Plain | htmlUnescape }}
```

[`html/template`]: https://pkg.go.dev/html/template
[`htmlUnescape`]: /functions/transform/htmlunescape/
[entities]: https://developer.mozilla.org/en-US/docs/Glossary/Entity
[tags]: https://developer.mozilla.org/en-US/docs/Glossary/Tag


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/PlainWords.md
---


The `PlainWords` method on a `Page` object calls the [`Plain`][] method, then uses Go's [`strings.Fields`][] function to split the result into words.

> [!NOTE]
> `Fields` splits the string `s` around each instance of one or more consecutive whitespace characters, as defined by [`unicode.IsSpace`][], returning a slice of substrings of `s` or an empty slice if `s` contains only whitespace.

As a result, elements within the slice may contain leading or trailing punctuation.

```go-html-template
{{ .PlainWords }}
```

To determine the approximate number of unique words on a page:

```go-html-template
{{ .PlainWords | uniq }} → 42
```

[`Plain`]: /methods/page/plain/
[`strings.Fields`]: https://pkg.go.dev/strings#Fields
[`unicode.IsSpace`]: https://pkg.go.dev/unicode#IsSpace


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/Prev.md
---


{{% include "/_common/methods/page/next-and-prev.md" %}}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/PrevInSection.md
---


{{% include "/_common/methods/page/nextinsection-and-previnsection.md" %}}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/PublishDate.md
---


By default, Hugo excludes pages with future publish dates when building your project. To include future pages, use the `--buildFuture` command line flag.

Set the publish date in front matter:

{{< code-toggle file=content/news/article-1.md fm=true >}}
title = 'Article 1'
publishDate = 2023-10-19T00:40:04-07:00
{{< /code-toggle >}}

The publish date is a [time.Time][] value. Format and localize the value with the [`time.Format`][] function, or use it with any of the [time methods][].

```go-html-template
{{ .PublishDate | time.Format ":date_medium" }} → Oct 19, 2023
```

In the example above we explicitly set the publish date in front matter. With Hugo's default configuration, the `PublishDate` method returns the front matter value. This behavior is configurable, allowing you to set fallback values if the publish date is not defined in front matter. See [details][].

[`time.Format`]: /functions/time/format/
[details]: /configuration/front-matter/#dates
[time methods]: /methods/time/
[time.Time]: https://pkg.go.dev/time#Time


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/RawContent.md
---


The `RawContent` method on a `Page` object returns the raw content. The raw content does not include front matter.

```go-html-template
{{ .RawContent }}
```

This is useful when rendering a page in a plain text [output format](g).

> [!NOTE]
> [Shortcodes](g) within the content are not rendered. To get the raw content with shortcodes rendered, use the [`RenderShortcodes`][] method on a `Page` object.

[`RenderShortcodes`]: /methods/page/rendershortcodes/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/ReadingTime.md
---


The estimated reading time is calculated by dividing the number of words in the content by the reading speed.

By default, Hugo assumes a reading speed of 212 words per minute. For CJK languages, it assumes 500 words per minute.

```go-html-template
{{ printf "Estimated reading time: %d minutes" .ReadingTime }}
```

Reading speed varies by language. Create language-specific estimated reading times on your multilingual project using site parameters.

{{< code-toggle file=hugo >}}
[languages]
  [languages.de]
    contentDir = 'content/de'
    label = 'Deutsch'
    locale = 'de-DE'
    weight = 2
    [languages.de.params]
    reading_speed = 179
  [languages.en]
    contentDir = 'content/en'
    label = 'English'
    locale = 'en-US'
    weight = 1
    [languages.en.params]
      reading_speed = 228
{{< /code-toggle >}}

Then in your template:

```go-html-template
{{ $readingTime := div (float .WordCount) .Site.Params.reading_speed }}
{{ $readingTime = math.Ceil $readingTime }}
```

We cast the `.WordCount` to a float to obtain a float when we divide by the reading speed. Then round up to the nearest integer.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/Ref.md
---


## Usage

The `Ref` method requires a single argument: an options map.

## Options

{{% include "_common/ref-and-relref-options.md" %}}

## Examples

The following examples show the rendered output for a page on the English version of the site:

```go-html-template
{{ $opts := dict "path" "/books/book-1" }}
{{ .Ref $opts }} → https://example.org/en/books/book-1/

{{ $opts := dict "path" "/books/book-1" "lang" "de" }}
{{ .Ref $opts }} → https://example.org/de/books/book-1/

{{ $opts := dict "path" "/books/book-1" "lang" "de" "outputFormat" "json" }}
{{ .Ref $opts }} → https://example.org/de/books/book-1/index.json
```

## Error handling

{{% include "_common/ref-and-relref-error-handling.md" %}}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/RegularPages.md
---


The `RegularPages` method on a `Page` object is available to these [page kinds](g): `home`, `section`, `taxonomy`, and `term`. The templates for these page kinds receive a page [collection](g) in [context](g), in the [default sort order](g).

Range through the page collection in your template:

```go-html-template
{{ range .RegularPages.ByTitle }}
  <h2><a href="{{ .RelPermalink }}">{{ .Title }}</a></h2>
{{ end }}
```

Consider this content structure:

```tree
content/
├── lessons/
│   ├── lesson-1/
│   │   ├── _index.md
│   │   ├── part-1.md
│   │   └── part-2.md
│   ├── lesson-2/
│   │   ├── resources/
│   │   │   ├── task-list.md
│   │   │   └── worksheet.md
│   │   ├── _index.md
│   │   ├── part-1.md
│   │   └── part-2.md
│   ├── _index.md
│   ├── grading-policy.md
│   └── lesson-plan.md
├── _index.md
├── contact.md
└── legal.md
```

When rendering the home page, the `RegularPages` method returns:

    contact.md
    legal.md

When rendering the lessons page, the `RegularPages` method returns:

    lessons/grading-policy.md
    lessons/lesson-plan.md

When rendering lesson-1, the `RegularPages` method returns:

    lessons/lesson-1/part-1.md
    lessons/lesson-1/part-2.md

When rendering lesson-2, the `RegularPages` method returns:

    lessons/lesson-2/part-1.md
    lessons/lesson-2/part-2.md
    lessons/lesson-2/resources/task-list.md
    lessons/lesson-2/resources/worksheet.md

In the last example, the collection includes pages in the resources subdirectory. That directory is not a [section](g)---it does not contain an&nbsp;`_index.md`&nbsp;file. Its contents are part of the lesson-2 section.

> [!NOTE]
> When used with the `Site` object, the `RegularPages` method recursively returns all regular pages within the site. See [details][].

```go-html-template
{{ range .Site.RegularPages.ByTitle }}
  <h2><a href="{{ .RelPermalink }}">{{ .Title }}</a></h2>
{{ end }}
```

[details]: /methods/site/regularpages/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/RegularPagesRecursive.md
---


The `RegularPagesRecursive` method on a `Page` object is available to these [page kinds](g): `home`, `section`, `taxonomy`, and `term`. The templates for these page kinds receive a page [collection](g) in [context](g), in the [default sort order](g).

Range through the page collection in your template:

```go-html-template
{{ range .RegularPagesRecursive.ByTitle }}
  <h2><a href="{{ .RelPermalink }}">{{ .Title }}</a></h2>
{{ end }}
```

Consider this content structure:

```tree
content/
├── lessons/
│   ├── lesson-1/
│   │   ├── _index.md
│   │   ├── part-1.md
│   │   └── part-2.md
│   ├── lesson-2/
│   │   ├── resources/
│   │   │   ├── task-list.md
│   │   │   └── worksheet.md
│   │   ├── _index.md
│   │   ├── part-1.md
│   │   └── part-2.md
│   ├── _index.md
│   ├── grading-policy.md
│   └── lesson-plan.md
├── _index.md
├── contact.md
└── legal.md
```

When rendering the home page, the `RegularPagesRecursive` method returns:

    contact.md
    lessons/grading-policy.md
    legal.md
    lessons/lesson-plan.md
    lessons/lesson-2/part-1.md
    lessons/lesson-1/part-1.md
    lessons/lesson-2/part-2.md
    lessons/lesson-1/part-2.md
    lessons/lesson-2/resources/task-list.md
    lessons/lesson-2/resources/worksheet.md

When rendering the lessons page, the `RegularPagesRecursive` method returns:

    lessons/grading-policy.md
    lessons/lesson-plan.md
    lessons/lesson-2/part-1.md
    lessons/lesson-1/part-1.md
    lessons/lesson-2/part-2.md
    lessons/lesson-1/part-2.md
    lessons/lesson-2/resources/task-list.md
    lessons/lesson-2/resources/worksheet.md

When rendering lesson-1, the `RegularPagesRecursive` method returns:

    lessons/lesson-1/part-1.md
    lessons/lesson-1/part-2.md

When rendering lesson-2, the `RegularPagesRecursive` method returns:

    lessons/lesson-2/part-1.md
    lessons/lesson-2/part-2.md
    lessons/lesson-2/resources/task-list.md
    lessons/lesson-2/resources/worksheet.md

> [!NOTE]
> The `RegularPagesRecursive` method is not available on a `Site` object.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/RelPermalink.md
---


Project configuration:

{{< code-toggle file=hugo >}}
title = 'Documentation'
baseURL = 'https://example.org/docs/'
{{< /code-toggle >}}

Template:

```go-html-template
{{ $page := .Site.GetPage "/about" }}
{{ $page.RelPermalink }} → /docs/about/
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/RelRef.md
---


## Usage

The `RelRef` method requires a single argument: an options map.

## Options

{{% include "_common/ref-and-relref-options.md" %}}

## Examples

The following examples show the rendered output for a page on the English version of the site:

```go-html-template
{{ $opts := dict "path" "/books/book-1" }}
{{ .RelRef $opts }} → /en/books/book-1/

{{ $opts := dict "path" "/books/book-1" "lang" "de" }}
{{ .RelRef $opts }} → /de/books/book-1/

{{ $opts := dict "path" "/books/book-1" "lang" "de" "outputFormat" "json" }}
{{ .RelRef $opts }} → /de/books/book-1/index.json
```

## Error handling

{{% include "_common/ref-and-relref-error-handling.md" %}}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/Render.md
---


Typically used when ranging over a page collection, the `Render` method on a `Page` object renders the given template, passing the given page as context.

```go-html-template
{{ range site.RegularPages }}
  <h2><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></h2>
  {{ .Render "summary" }}
{{ end }}
```

In the example above, note that the template ("summary") is identified by its file name without directory or extension.

Although similar to the [`partial`][] function, there are key differences.

`Render` method|`partial` function
:--|:--
The `Page` object is automatically passed to the given template. You cannot pass additional context.|You must specify the context, allowing you to pass a combination of objects, slices, maps, and scalars.
The path to the template is determined by the [content type](g).|You must specify the path to the template, relative to the `layouts/_partials` directory.

Consider this layout structure:

```tree
layouts/
├── books/
│   └── li.html   <-- used when content type is "books"
├── baseof.html
├── home.html
├── li.html       <-- used for other content types
├── page.html
├── section.html
├── taxonomy.html
└── term.html
```

And this template:

```go-html-template
<ul>
  {{ range site.RegularPages.ByDate }}
    {{ .Render "li" }}
  {{ end }}
</ul>
```

When rendering content of type "books" the `Render` method calls:

```text
layouts/books/li.html
```

For all other content types the `Render` methods calls:

```text
layouts/li.html
```

See [content views][] for more examples.

[`partial`]: /functions/partials/include/
[content views]: /templates/types/#content-view


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/RenderShortcodes.md
---


Use this method in _shortcode_ templates to compose a page from multiple content files, while preserving a global context for footnotes and the table of contents.

For example:

```go-html-template {file="layouts/_shortcodes/include.html" copy=true}
{{ with .Get 0 }}
  {{ with $.Page.GetPage . }}
    {{- .RenderShortcodes }}
  {{ else }}
    {{ errorf "The %q shortcode was unable to find %q. See %s" $.Name . $.Position }}
  {{ end }}
{{ else }}
  {{ errorf "The %q shortcode requires a positional parameter indicating the logical path of the file to include. See %s" .Name .Position }}
{{ end }}
```

Then call the shortcode in your Markdown:

```md {file="content/about.md"}
{{%/* include "/snippets/services" */%}}
{{%/* include "/snippets/values" */%}}
{{%/* include "/snippets/leadership" */%}}
```

Each of the included Markdown files can contain calls to other shortcodes.

## Shortcode notation

In the example above it's important to understand the difference between the two delimiters used when calling a shortcode:

- `{{</* myshortcode */>}}` tells Hugo that the rendered shortcode does not need further processing. For example, the shortcode content is HTML.
- `{{%/* myshortcode */%}}` tells Hugo that the rendered shortcode needs further processing. For example, the shortcode content is Markdown.

Use the latter for the "include" shortcode described above.

## Further explanation

To understand what is returned by the `RenderShortcodes` method, consider this content file

```md {file="content/about.md"}
+++
title = 'About'
date = 2023-10-07T12:28:33-07:00
+++

{{</* ref "privacy" */>}}

An *emphasized* word.
```

With this template code:

```go-html-template
{{ $p := site.GetPage "/about" }}
{{ $p.RenderShortcodes }}
```

Hugo renders this:;

```html
https://example.org/privacy/

An *emphasized* word.
```

Note that the shortcode within the content file was rendered, but the surrounding Markdown was preserved.

## Limitations

The primary use case for `.RenderShortcodes` is inclusion of Markdown content. If you try to use `.RenderShortcodes` inside `HTML` blocks when inside Markdown, you will get a warning similar to this:

```text
WARN .RenderShortcodes detected inside HTML block in "/content/mypost.md"; this may not be what you intended ...
```

The above warning can be turned off is this is what you really want.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/RenderString.md
---


The `RenderString` method on a `Page` object renders markup to HTML.

```go-html-template
{{ $s := "An *emphasized* word" }}
{{ $s | .RenderString }} → An <em>emphasized</em> word
```

## Options

The `RenderString` method on a `Page` object accepts an options map.

`display`
: (`string`) Specify either `inline` or `block`. If `inline`, removes surrounding `p` tags from short snippets. Default is `inline`.

`markup`
: (`string`) Specify a [markup identifier][] for the provided markup. Default is the `markup` front matter value, falling back to the value derived from the page's file extension.

## Examples

Render Markdown content to HTML in block display mode:

```go-html-template
{{ $opts := dict "display" "block" }}
{{ $s | .RenderString $opts }} → <p>An <em>emphasized</em> word</p>
```

Render [Pandoc] content to HTML in block display mode:

```go-html-template
{{ $s := "H~2~O" }}

{{ $opts := dict "markup" "pandoc" "display" "block" }}
{{ $s | .RenderString $opts }} → H<sub>2</sub>O
```

[Pandoc]: /content-management/formats/#pandoc
[markup identifier]: /content-management/formats/#classification


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/Resources.md
---


The `Resources` method on a `Page` object returns a collection of page resources. A page resource is a file within a [page bundle](g).

To work with global or remote resources, see the [`resources`][] functions.

## Methods

Use these methods on the `Resources` object.

`ByType`
: (`resource.Resources`) Returns a collection of page resources of the given [media type][], or nil if none found. The media type is typically one of `image`, `text`, `audio`, `video`, or `application`.

  ```go-html-template
  {{ range .Resources.ByType "image" }}
    <img src="{{ .RelPermalink }}" width="{{ .Width }}" height="{{ .Height }}" alt="">
  {{ end }}
  ```

  When working with global resources instead of page resources, use the [`resources.ByType`][] function.

`Get`
: (`resource.Resource`) Returns a page resource from the given path, or nil if none found.

  ```go-html-template
  {{ with .Resources.Get "images/a.jpg" }}
    <img src="{{ .RelPermalink }}" width="{{ .Width }}" height="{{ .Height }}" alt="">
  {{ end }}
  ```

  When working with global resources instead of page resources, use the [`resources.Get`][] function.

`GetMatch`
: (`resource.Resource`) Returns the first page resource from paths matching the given [glob pattern](g), or nil if none found.

  ```go-html-template
  {{ with .Resources.GetMatch "images/*.jpg" }}
    <img src="{{ .RelPermalink }}" width="{{ .Width }}" height="{{ .Height }}" alt="">
  {{ end }}
  ```

  When working with global resources instead of page resources, use the [`resources.GetMatch`][] function.

`Match`
: (`resource.Resources`) Returns a collection of page resources from paths matching the given [glob pattern](g), or nil if none found.

  ```go-html-template
  {{ range .Resources.Match "images/*.jpg" }}
    <img src="{{ .RelPermalink }}" width="{{ .Width }}" height="{{ .Height }}" alt="">
  {{ end }}
  ```

  When working with global resources instead of page resources, use the [`resources.Match`][] function.

`Mount`
: {{< new-in 0.140.0 />}}
: (`ResourceGetter`) Mounts the given resources from the two arguments base (`string`) to the given target path (`string`) and returns an object that implements [Get](#get). Note that leading slashes in target marks an absolute path. Relative target paths allows you to mount resources relative to another set, e.g. a [Page bundle][]:

  ```go-html-template
  {{ $common := resources.Match "/js/headlessui/*.*" }}
  {{ $importContext := (slice $.Page ($common.Mount "/js/headlessui" ".")) }}
  ```

  This method is currently only useful when using the [`js.Batch`][] function.

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

## Sort order

Use the following rules to understand how Hugo sorts the collection returned by the `Rotate` method.

| Dimension | Primary Sort | Secondary Sort |
| :--- | :--- | :--- |
| Language | Weight ascending | Lexicographical ascending |
| Version | Weight ascending | Semantic version descending |
| Role | Weight ascending | Lexicographical ascending |

## Examples

To render a list of the current page's language variants, including the current page, while sharing its current version and role:

```go-html-template
{{/* Returns languages sorted by weight ascending, then lexicographically ascending */}}
{{ range .Rotate "language" }}
  <h2><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></h2>
{{ end }}
```

To render a list of the current page's version variants, including the current page, while sharing its current language and role:

```go-html-template
{{/* Returns versions sorted by weight ascending, then semantic version descending */}}
{{ range .Rotate "version" }}
  <h2><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></h2>
{{ end }}
```

To render a list of the current page's role variants, including the current page, while sharing its current language and version:

```go-html-template
{{/* Returns roles sorted by weight ascending, then lexicographically ascending */}}
{{ range .Rotate "role" }}
  <h2><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></h2>
{{ end }}
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/Scratch.md
---


{{< deprecated-in 0.138.0 >}}
Use the [`PAGE.Store`](/methods/page/store/) method instead.

This is a soft deprecation. This method will be removed in a future release, but the removal date has not been established. Although Hugo will not emit a warning if you continue to use this method, you should begin using `PAGE.Store` as soon as possible.

Beginning with v0.138.0 the `PAGE.Scratch` method is aliased to `PAGE.Store`.
{{< /deprecated-in >}}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/Section.md
---


{{% glossary-term section %}}

With this content structure:

```tree
content/
├── lessons/
│   ├── math/
│   │   ├── _index.md
│   │   ├── lesson-1.md
│   │   └── lesson-2.md
│   └── _index.md
└── _index.md
```

When rendering lesson-1.md:

```go-html-template
{{ .Section }} → lessons
```

In the example above "lessons" is the top-level section.

The `Section` method is often used with the [`where`][] function to build a page collection.

```go-html-template
{{ range where .Site.RegularPages "Section" "lessons" }}
  <h2><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></h2>
{{ end }}
```

This is similar to using the [`Type`][] method with the `where` function

```go-html-template
{{ range where .Site.RegularPages "Type" "lessons" }}
  <h2><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></h2>
{{ end }}
```

However, if the `type` field in front matter has been defined on one or more pages, the page collection based on `Type` will be different than the page collection based on `Section`.

[`Type`]: /methods/page/type/
[`where`]: /functions/collections/where/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/Sections.md
---


The `Sections` method on a `Page` object is available to these [page kinds](g): `home`, `section`, and `taxonomy`. The templates for these page kinds receive a page [collection](g) in [context](g), in the [default sort order](g).

With this content structure:

```tree
content/
├── auctions/
│   ├── 2023-11/
│   │   ├── _index.md     <-- front matter: weight = 202311
│   │   ├── auction-1.md
│   │   └── auction-2.md
│   ├── 2023-12/
│   │   ├── _index.md     <-- front matter: weight = 202312
│   │   ├── auction-3.md
│   │   └── auction-4.md
│   ├── _index.md         <-- front matter: weight = 30
│   ├── bidding.md
│   └── payment.md
├── books/
│   ├── _index.md         <-- front matter: weight = 20
│   ├── book-1.md
│   └── book-2.md
├── films/
│   ├── _index.md         <-- front matter: weight = 10
│   ├── film-1.md
│   └── film-2.md
└── _index.md
```

And this template:

```go-html-template
{{ range .Sections.ByWeight }}
  <h2><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></h2>
{{ end }}
```

On the home page, Hugo renders:

```html
<h2><a href="/films/">Films</a></h2>
<h2><a href="/books/">Books</a></h2>
<h2><a href="/auctions/">Auctions</a></h2>
```

On the auctions page, Hugo renders:

```html
<h2><a href="/auctions/2023-11/">Auctions in November 2023</a></h2>
<h2><a href="/auctions/2023-12/">Auctions in December 2023</a></h2>
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/Site.md
---


See [Site methods][].

```go-html-template
{{ .Site.Title }}
```

[Site methods]: /methods/site/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/Sitemap.md
---


Access to the `Sitemap` method on a `Page` object is restricted to [sitemap templates][].

## Methods

Use these methods on the `Sitemap` object.

`ChangeFreq`
: (`string`) How frequently a page is likely to change. Valid values are `always`, `hourly`, `daily`, `weekly`, `monthly`, `yearly`, and `never`. With the default value of `""` Hugo will omit this field from the sitemap. See [details][changefreqdef].

  ```go-html-template
  {{ .Sitemap.ChangeFreq }}
  ```

`Disable`
: (`bool`) Whether to disable page inclusion. Default is `false`. Set to `true` in front matter to exclude the page.

  ```go-html-template
  {{ .Sitemap.Disable }}
  ```

`Priority`
: (`float`) The priority of a page relative to any other page on the site. Valid values range from 0.0 to 1.0. With the default value of `-1` Hugo will omit this field from the sitemap. See [details][prioritydef].

  ```go-html-template
  {{ .Sitemap.Priority }}
  ```

## Example

With this project configuration:

{{< code-toggle file=hugo >}}
[sitemap]
changeFreq = 'monthly'
{{< /code-toggle >}}

And this content:

{{< code-toggle file=content/news.md fm=true >}}
title = 'News'
[sitemap]
changeFreq = 'hourly'
{{< /code-toggle >}}

And this simplistic sitemap template:

```xml {file="layouts/sitemap.xml"}
{{ printf "<?xml version=\"1.0\" encoding=\"utf-8\" standalone=\"yes\"?>" | safeHTML }}
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9"
  xmlns:xhtml="http://www.w3.org/1999/xhtml">
  {{ range .Pages }}
    <url>
      <loc>{{ .Permalink }}</loc>
      {{ if not .Lastmod.IsZero }}
        <lastmod>{{ .Lastmod.Format "2006-01-02T15:04:05-07:00" | safeHTML }}</lastmod>
      {{ end }}
      {{ with .Sitemap.ChangeFreq }}
        <changefreq>{{ . }}</changefreq>
      {{ end }}
    </url>
  {{ end }}
</urlset>
```

The change frequency will be `hourly` for the news page, and `monthly` for other pages.

[changefreqdef]: https://www.sitemaps.org/protocol.html#changefreqdef
[prioritydef]: https://www.sitemaps.org/protocol.html#prioritydef
[sitemap templates]: /templates/sitemap/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/Sites.md
---


{{< deprecated-in 0.156.0 >}}
Use the [`hugo.Sites`](/functions/hugo/sites/) function instead.
{{< /deprecated-in >}}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/Slug.md
---


{{< code-toggle file=content/recipes/spicy-tuna-hand-rolls.md fm=true >}}
title = 'How to make spicy tuna hand rolls'
slug = 'sushi'
{{< /code-toggle >}}

This page will be served from:

    https://example.org/recipes/sushi

To get the slug value within a template:

```go-html-template
{{ .Slug }} → sushi
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/Store.md
---


Use the `Store` method on a `Page` object to create a persistent data structure for storing and manipulating keyed values, scoped to the current page. To create a data structure with a different [scope](g), refer to the [scope](#scope) section below.

{{% include "_common/store-methods.md" %}}

{{% include "_common/store-scope.md" %}}

## Determinate values

The `Store` method is often used to set values within a _shortcode_ template, a _partial_ template called by a _shortcode_ template, or by a _render hook_ template. In all three cases, the stored values are indeterminate until Hugo renders the page content.

If you need to access a stored value from a parent template, and the parent template has not yet rendered the page content, you can trigger content rendering by assigning the returned value to a [noop](g) variable:

```go-html-template
{{ $noop := .Content }}
{{ .Store.Get "mykey" }}
```

You can also trigger content rendering with the `ContentWithoutSummary`, `FuzzyWordCount`, `Len`, `Plain`, `PlainWords`, `ReadingTime`, `Summary`, `Truncated`, and `WordCount` methods. For example:

```go-html-template
{{ $noop := .WordCount }}
{{ .Store.Get "mykey" }}
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/Summary.md
---


<!-- Do not remove the manual summary divider below. -->
<!-- If you do, you will break its first literal usage on this page. -->

<!--more-->

You can define a [summary][] manually, in front matter, or automatically. A manual summary takes precedence over a front matter summary, and a front matter summary takes precedence over an automatic summary.

To list the pages in a section with a summary beneath each link:

```go-html-template
{{ range .Pages }}
  <h2><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></h2>
  {{ .Summary }}
{{ end }}
```

> [!WARNING]
> Automatic `.Summary` may cut block tags (e.g., `blockquote`) in the middle, causing the browser to recover the end tag. See [automatic summary][] for details and for ways to avoid this.

Depending on content length and how you define the summary, the summary may be equivalent to the content itself. To determine whether the content length exceeds the summary length, use the [`Truncated`][] method on a `Page` object. This is useful for conditionally rendering a “read more” link:

```go-html-template
{{ range .Pages }}
  <h2><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></h2>
  {{ .Summary }}
  {{ if .Truncated }}
    <a href="{{ .RelPermalink }}">Read more...</a>
  {{ end }}
{{ end }}
```

> [!NOTE]
> The `Truncated` method returns `false` if you define the summary in front matter.

[`Truncated`]: /methods/page/truncated/
[automatic summary]: /content-management/summaries/#automatic-summary
[summary]: /content-management/summaries/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/TableOfContents.md
---


The `TableOfContents` method on a `Page` object returns an ordered or unordered list of the Markdown [ATX][] and [setext][] headings within the page content.

This template code:

```go-html-template
{{ .TableOfContents }}
```

Produces this HTML:

```html
<nav id="TableOfContents">
  <ul>
    <li><a href="#section-1">Section 1</a>
      <ul>
        <li><a href="#section-11">Section 1.1</a></li>
        <li><a href="#section-12">Section 1.2</a></li>
      </ul>
    </li>
    <li><a href="#section-2">Section 2</a></li>
  </ul>
</nav>
```

By default, the `TableOfContents` method returns an unordered list of level 2 and level 3 headings. You can adjust this in your project configuration:

{{< code-toggle file=hugo >}}
[markup.tableOfContents]
endLevel = 3
ordered = false
startLevel = 2
{{< /code-toggle >}}

[ATX]: https://spec.commonmark.org/current/#atx-headings
[setext]: https://spec.commonmark.org/current/#setext-headings


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/Title.md
---


With pages backed by a file, the `Title` method returns the `title` field as defined in front matter:

{{< code-toggle file=content/about.md fm=true >}}
title = 'About us'
{{< /code-toggle >}}

```go-html-template
{{ .Title }} → About us
```

When a page is not backed by a file, the value returned by the `Title` method depends on the page [kind](g).

Page kind|Page title when the page is not backed by a file
:--|:--
home|site title
section|section name (capitalized and pluralized)
taxonomy|taxonomy name (capitalized and pluralized)
term|term name (capitalized and pluralized)

You can disable automatic capitalization and pluralization in your project configuration:

{{< code-toggle file=hugo >}}
capitalizeListTitles = false
pluralizeListTitles = false
{{< /code-toggle >}}

You can change the capitalization style in your project configuration to one of `ap`, `chicago`, `go`, `firstupper`, or `none`. For example:

{{< code-toggle file=hugo >}}
titleCaseStyle = "firstupper"
{{< /code-toggle >}}

See [details][].

[details]: /configuration/all/#title-case-style


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/TranslationKey.md
---


The translation key creates a relationship between all translations of a given page. The translation key is derived from the file path, or from the `translationKey` parameter if defined in front matter.

With this project configuration:

{{< code-toggle file=hugo >}}
defaultContentLanguage = 'en'

[languages.en]
contentDir = 'content/en'
label = 'English'
locale = 'en-US'
weight = 1

[languages.de]
contentDir = 'content/de'
label = 'Deutsch'
locale = 'de-DE'
weight = 2
{{< /code-toggle >}}

And this content:

```tree
content/
├── de/
│   ├── books/
│   │   ├── buch-1.md
│   │   └── book-2.md
│   └── _index.md
├── en/
│   ├── books/
│   │   ├── book-1.md
│   │   └── book-2.md
│   └── _index.md
└── _index.md
```

And this front matter:

{{< code-toggle file=content/en/books/book-1.md fm=true >}}
title = 'Book 1'
translationKey = 'foo'
{{< /code-toggle >}}

{{< code-toggle file=content/de/books/buch-1.md fm=true >}}
title = 'Buch 1'
translationKey = 'foo'
{{< /code-toggle >}}

When rendering either either of the pages above:

```go-html-template
{{ .TranslationKey }} → page/foo
```

If the front matter of Book 2, in both languages, does not include a translation key:

```go-html-template
{{ .TranslationKey }} → page/books/book-2
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/Translations.md
---


With this project configuration:

{{< code-toggle file=hugo >}}
defaultContentLanguage = 'en'

[languages.en]
contentDir = 'content/en'
label = 'English'
locale = 'en-US'
weight = 1

[languages.de]
contentDir = 'content/de'
label = 'Deutsch'
locale = 'de-DE'
weight = 2

[languages.fr]
contentDir = 'content/fr'
label = 'Français'
locale = 'fr-FR'
weight = 3
{{< /code-toggle >}}

And this content:

```tree
content/
├── de/
│   ├── books/
│   │   ├── book-1.md
│   │   └── book-2.md
│   └── _index.md
├── en/
│   ├── books/
│   │   ├── book-1.md
│   │   └── book-2.md
│   └── _index.md
├── fr/
│   ├── books/
│   │   └── book-1.md
│   └── _index.md
└── _index.md
```

And this template:

```go-html-template
{{ with .Translations }}
  <ul>
    {{ range . }}
      <li>
        <a href="{{ .RelPermalink }}" hreflang="{{ .Language.Locale }}">{{ .LinkTitle }} ({{ or .Language.Label .Language.Name }})</a>
      </li>
    {{ end }}
  </ul>
{{ end }}
```

Hugo will render this list on the `book-1` page of the English site:

```html
<ul>
  <li><a href="/de/books/book-1/" hreflang="de-DE">Book 1 (Deutsch)</a></li>
  <li><a href="/fr/books/book-1/" hreflang="fr-FR">Book 1 (Français)</a></li>
</ul>
```

Hugo will render this list on the `book-2` page of the English site:

```html
<ul>
  <li><a href="/de/books/book-1/" hreflang="de-DE">Book 1 (Deutsch)</a></li>
</ul>
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/Truncated.md
---


You can define a [summary][] manually, in front matter, or automatically. A manual summary takes precedence over a front matter summary, and a front matter summary takes precedence over an automatic summary.

The `Truncated` method returns `true` if the content length exceeds the summary length. This is useful for conditionally rendering a "read more" link:

```go-html-template
{{ range .Pages }}
  <h2><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></h2>
  {{ .Summary }}
  {{ if .Truncated }}
    <a href="{{ .RelPermalink }}">Read more...</a>
  {{ end }}
{{ end }}
```

> [!NOTE]
> The `Truncated` method returns `false` if you define the summary in front matter.

[summary]: /content-management/summaries/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/Type.md
---


The `Type` method on a `Page` object returns the [content type](g) of the given page. The content type is defined by the `type` field in front matter, or inferred from the top-level directory name if the `type` field in front matter is not defined.

With this content structure:

```tree
content/
├── auction/
│   ├── _index.md
│   ├── item-1.md
│   └── item-2.md  <-- front matter: type = books
├── books/
│   ├── _index.md
│   ├── book-1.md
│   └── book-2.md
├── films/
│   ├── _index.md
│   ├── film-1.md
│   └── film-2.md
└── _index.md
```

To list the books, regardless of [section](g):

```go-html-template
{{ range where .Site.RegularPages.ByTitle "Type" "books" }}
  <h2><a href="{{ .RelPermalink }}">{{ .Title }}</a></h2>
{{ end }}
```

Hugo renders this to;

```html
<h2><a href="/books/book-1/">Book 1</a></h2>
<h2><a href="/books/book-2/">Book 2</a></h2>
<h2><a href="/auction/item-2/">Item 2</a></h2>
```

The `type` field in front matter is also useful for targeting a template. See [details][].

[details]: /templates/lookup-order/#target-a-template


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/Weight.md
---


The `Weight` method on a `Page` object returns the [weight](g) of the given page as defined in front matter.

{{< code-toggle file=content/recipes/sushi.md fm=true >}}
title = 'How to make spicy tuna hand rolls'
weight = 42
{{< /code-toggle >}}

Page weight controls the position of a page within a collection that is sorted by weight. Assign weights using non-zero integers. Lighter items float to the top, while heavier items sink to the bottom. Unweighted or zero-weighted elements are placed at the end of the collection.

Although rarely used within a template, you can access the value with:

```go-html-template
{{ .Weight }} → 42
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/WordCount.md
---


```go-html-template
{{ .WordCount }} → 103
```

To round up to nearest multiple of 100, use the [`FuzzyWordCount`][] method.

[`FuzzyWordCount`]: /methods/page/fuzzywordcount/

