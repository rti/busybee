
---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/templates/404.md
---


To render a 404 error page in the root of your site, create a 404 template in the root of the `layouts` directory. For example:

```go-html-template {file="layouts/404.html"}
{{ define "main" }}
  <h1>404 Not Found</h1>
  <p>The page you requested cannot be found.</p>
  <p>
    <a href="{{ .Site.Home.RelPermalink }}">
      Return to the home page
    </a>
  </p>
{{ end }}
```

For multilingual projects, add the language key to the file name:

```tree
layouts/
├── 404.de.html
├── 404.en.html
└── 404.fr.html
```

Your production server redirects the browser to the 404 page when a page is not found. Capabilities and configuration vary by host.

Host|Capabilities and configuration
:--|:--
Amazon CloudFront|See [details](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/GeneratingCustomErrorResponses.html).
Amazon S3|See [details](https://docs.aws.amazon.com/AmazonS3/latest/userguide/CustomErrorDocSupport.html).
Apache|See [details](https://httpd.apache.org/docs/2.4/custom-error.html).
Azure Static Web Apps|See [details](https://learn.microsoft.com/en-us/azure/static-web-apps/configuration#response-overrides).
Azure Storage|See [details](https://learn.microsoft.com/en-us/azure/storage/blobs/storage-blob-static-website#setting-up-a-static-website).
Caddy|See [details](https://caddyserver.com/docs/caddyfile/directives/handle_errors).
Codeberg Pages|See [details](https://docs.codeberg.org/codeberg-pages/advanced-usage/#custom-error-page-for-404s).
Cloudflare Pages|See [details](https://developers.cloudflare.com/pages/configuration/serving-pages/#not-found-behavior).
DigitalOcean App Platform|See [details](https://docs.digitalocean.com/products/app-platform/how-to/manage-static-sites/#configure-a-static-site).
Firebase|See [details](https://firebase.google.com/docs/hosting/full-config#404).
GitHub Pages|Redirection to is automatic and not configurable.
GitLab Pages|See [details](https://docs.gitlab.com/ee/user/project/pages/introduction.html#custom-error-codes-pages).
NGINX|See [details](https://nginx.org/en/docs/http/ngx_http_core_module.html#error_page).
Netlify|See [details](https://docs.netlify.com/routing/redirects/redirect-options/).


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/templates/embedded.md
---


## Disqus

> [!NOTE]
> To override Hugo's embedded Disqus template, copy the [source code](<{{% eturl disqus %}}>) to a file with the same name in the `layouts/_partials` directory, then call it from your templates using the [`partial`][] function:
>
> `{{ partial "disqus.html" . }}`

Hugo includes an embedded template for [Disqus][], a commenting system for both static and dynamic websites. To use this template, you must first obtain a Disqus shortname by [signing up][] for the free service.

To include the embedded template:

```go-html-template
{{ partial "disqus.html" . }}
```

### Configuration {#configuration-disqus}

To use Hugo's Disqus template, first set up a single configuration value:

{{< code-toggle file=hugo >}}
[services.disqus]
shortname = 'your-disqus-shortname'
{{</ code-toggle >}}

You can also set the following in the [front matter][] for a given page:

`disqus_identifier`
: (`string`) A unique identifier for the page's discussion thread. Set this to preserve comment threads across URL changes.

`disqus_title`
: (`string`) The title of the discussion thread.

`disqus_url`
: (`string`) The canonical URL for the discussion thread. Use this to override the URL Disqus uses to identify the thread, for example when the same content is served at multiple URLs.

{{< code-toggle file=content/blog/my-post.md fm=true >}}
[params]
disqus_identifier = 'unique-identifier'
disqus_title = 'Post title'
disqus_url = 'https://example.org/blog/my-post/'
{{</ code-toggle >}}

> [!NOTE]
> When previewing your site locally, Hugo replaces the Disqus widget with the message "Disqus comments not available by default when the website is previewed locally."

### Privacy {#privacy-disqus}

Adjust the relevant privacy settings in your project configuration.

{{< code-toggle config=privacy.disqus />}}

`disable`
: (`bool`) Whether to disable the template. Default is `false`.

## Google Analytics

> [!NOTE]
> To override Hugo's embedded Google Analytics template, copy the [source code](<{{% eturl google_analytics %}}>) to a file with the same name in the `layouts/_partials` directory, then call it from your templates using the [`partial`][] function:
>
> `{{ partial "google_analytics.html" . }}`

Hugo includes an embedded template for [Google Analytics 4][].

To include the embedded template:

```go-html-template
{{ partial "google_analytics.html" . }}
```

### Configuration {#configuration-google-analytics}

Provide your tracking ID in your configuration file:

{{< code-toggle file=hugo >}}
[services.googleAnalytics]
id = 'G-MEASUREMENT_ID'
{{</ code-toggle >}}

> [!NOTE]
> If the configured ID begins with `ua-` (case-insensitive), Hugo logs a warning and renders nothing. Google Universal Analytics (UA) was replaced by Google Analytics 4 (GA4) effective 1 July 2023. Create a GA4 property and data stream, then update your project configuration with the new measurement ID.

### Privacy {#privacy-google-analytics}

Adjust the relevant privacy settings in your project configuration.

{{< code-toggle config=privacy.googleAnalytics />}}

`disable`
: (`bool`) Whether to disable the template. Default is `false`.

`respectDoNotTrack`
: (`bool`) Whether to respect the browser's "do not track" setting. Default is `true`.

## Open Graph

> [!NOTE]
> To override Hugo's embedded Open Graph template, copy the [source code](<{{% eturl opengraph %}}>) to a file with the same name in the `layouts/_partials` directory, then call it from your templates using the [`partial`][] function:
>
> `{{ partial "opengraph.html" . }}`

Hugo includes an embedded template for the [Open Graph protocol][]. This metadata transforms your pages into rich objects when shared across major social media and messaging platforms.

To include the embedded template:

```go-html-template
{{ partial "opengraph.html" . }}
```

### Configuration {#configuration-open-graph}

Hugo's Open Graph template is configured using a mix of configuration settings and [front matter][] values on individual pages.

{{< code-toggle file=hugo >}}
title = 'My cool site'
[params]
  description = 'Text about my cool site'
  images = ['site-feature-image.jpg']
  [params.social]
  facebook_app_id = '12345678'
[taxonomies]
  series = 'series'
{{</ code-toggle >}}

{{< code-toggle file=content/blog/my-post.md fm=true >}}
title = 'Post title'
description = 'Text about this post'
date = 2024-03-08T08:18:11-08:00
images = ["post-cover.png"]
audio = []
videos = []
series = []
tags = []
locale = 'en-US'
{{</ code-toggle >}}

### Metadata {#metadata-open-graph}

Hugo emits the following metadata:

`og:url`
: The page permalink.

`og:site_name`
: The site title, falling back to the site configuration's `params.title` value.

`og:title`
: The page title, falling back to the site title, then the site configuration's `params.title` value.

`og:description`
: The page description, falling back to the page summary, then the site configuration's `params.description` value.

`og:locale`
: The `locale` front matter value, falling back to the site language's `locale`; hyphens are replaced with underscores (e.g. `en-US` → `en_US`).

`og:type`
: The value is `article` for pages and `website` for list and home pages.

For article pages, Hugo also emits:

`article:section`
: The page's top-level section.

`article:published_time`
: The page's publish date.

`article:modified_time`
: The page's last modified date.

`article:tag`
: The first 6 tags.

For image metadata, Hugo emits up to 6 `og:image` tags.

{{% include "/_common/embedded-get-page-images.md" %}}

`audio` and `videos` are `[]string` front matter parameters. Hugo emits up to 6 `og:audio` and `og:video` tags, passing each value through `absURL`, which converts relative paths to absolute URLs. Unlike `images`, Hugo does not search page resources or global resources for these values.

The `series` taxonomy is used to populate `og:see_also` metadata. Hugo emits up to 7 `og:see_also` tags using the first 7 pages in the same series as the current page, excluding the current page itself.

For Facebook metadata, if the site configuration's `params.social.facebook_app_id` value is set, Hugo emits `fb:app_id`. Otherwise, if the site configuration's `params.social.facebook_admin` value is set, Hugo emits `fb:admins`.

## Pagination

> [!NOTE]
> To override Hugo's embedded pagination template, copy the [source code](<{{% eturl pagination %}}>) to a file with the same name in the `layouts/_partials` directory, then call it from your templates using the [`partial`][] function:
>
> `{{ partial "pagination.html" . }}`

Hugo includes an embedded template for rendering navigation links between pagers. To include the embedded template:

```go-html-template
{{ partial "pagination.html" . }}
```

The embedded pagination template has two formats: `default` and `terse`. The `terse` format has fewer controls and page slots, consuming less space when styled as a horizontal list. See [pagination][] for details.

## Schema

> [!NOTE]
> To override Hugo's embedded Schema template, copy the [source code](<{{% eturl schema %}}>) to a file with the same name in the `layouts/_partials` directory, then call it from your templates using the [`partial`][] function:
>
> `{{ partial "schema.html" . }}`

Hugo includes an embedded template to render [microdata][] `meta` elements within the `head` element of your templates.

To include the embedded template:

```go-html-template
{{ partial "schema.html" . }}
```

### Configuration {#configuration-schema}

Hugo's Schema template uses a mix of page data and [front matter][] values on individual pages.

{{< code-toggle file=hugo >}}
title = 'My cool site'
[params]
  description = 'Text about my cool site'
{{</ code-toggle >}}

{{< code-toggle file=content/blog/my-post.md fm=true >}}
title = 'Post title'
description = 'Text about this post'
date = 2024-03-08T08:18:11-08:00
lastmod = 2024-03-09T12:00:00-08:00
images = ['post-cover.png']
keywords = ['ssg', 'hugo']
{{</ code-toggle >}}

### Metadata {#metadata-schema}

Hugo emits the following microdata:

`name`
: The page title, falling back to the site title.

`description`
: The page description, falling back to the page summary, then the site configuration's `params.description` value.

`datePublished`
: The page's publish date.

`dateModified`
: The page's last modified date.

`wordCount`
: The page's word count.

For image metadata, Hugo emits up to 6 `image` tags.

{{% include "/_common/embedded-get-page-images.md" %}}

For keyword metadata, Hugo uses the following order of precedence:

1. Titles of `keywords` taxonomy terms, if `keywords` is defined as a taxonomy
1. The `keywords` front matter value, if `keywords` is not a taxonomy
1. Titles of `tags` taxonomy terms
1. Titles of all taxonomy terms

## X (Twitter) Cards

> [!NOTE]
> To override Hugo's embedded Twitter Cards template, copy the [source code](<{{% eturl twitter_cards %}}>) to a file with the same name in the `layouts/_partials` directory, then call it from your templates using the [`partial`][] function:
>
> `{{ partial "twitter_cards.html" . }}`

Hugo includes an embedded template for [X (Twitter) Cards][], metadata used to attach rich media to Tweets linking to your site.

To include the embedded template:

```go-html-template
{{ partial "twitter_cards.html" . }}
```

### Configuration {#configuration-x-cards}

Hugo's X (Twitter) Card template is configured using a mix of configuration settings and [front matter][] values on individual pages.

{{< code-toggle file=hugo >}}
[params]
  description = 'Text about my cool site'
  images = ["site-feature-image.jpg"]
  [params.social]
  twitter = 'GoHugoIO'
{{</ code-toggle >}}

{{< code-toggle file=content/blog/my-post.md fm=true >}}
title = 'Post title'
description = 'Text about this post'
images = ["post-cover.png"]
{{</ code-toggle >}}

### Metadata {#metadata-x-cards}

If an image is found, Hugo sets `twitter:card` to `summary_large_image` and emits a `twitter:image` tag using the first image found. If no image is found, Hugo sets `twitter:card` to `summary` and omits the image tag.

{{% include "/_common/embedded-get-page-images.md" %}}

Hugo also emits the following metadata:

`twitter:title`
: The page title, falling back to the site title, then the site configuration's `params.title` value.

`twitter:description`
: The page description, falling back to the page summary, then the site configuration's `params.description` value.

`twitter:site`
: The site configuration's `params.social.twitter` value. The `@` prefix is added automatically if not already present. For example, with `twitter = 'GoHugoIO'` in your configuration, Hugo renders:

  ```html
  <meta name="twitter:site" content="@GoHugoIO"/>
  ```

[Disqus]: https://disqus.com
[Google Analytics 4]: https://support.google.com/analytics/answer/10089681
[Open Graph protocol]: https://ogp.me/
[X (Twitter) Cards]: https://developer.x.com/en/docs/twitter-for-websites/cards/overview/abouts-cards
[`partial`]: /functions/partials/include/
[front matter]: /content-management/front-matter/
[microdata]: https://html.spec.whatwg.org/multipage/microdata.html#microdata
[pagination]: /templates/pagination/
[signing up]: https://disqus.com/profile/signup/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/templates/introduction.md
---


{{< newtemplatesystem >}}

{{% glossary-term template %}}

Templates use [variables](#variables), [functions][], and [methods][] to transform your content, resources, and data into a published page.

> [!NOTE]
> Hugo uses Go's [`text/template`][] and [`html/template`][] packages.
>
> The `text/template` package implements data-driven templates for generating textual output, while the `html/template` package implements data-driven templates for generating HTML output safe against code injection.
>
> By default, Hugo uses the `html/template` package when rendering HTML files.

For example, this HTML template initializes the `$v1` and `$v2` variables, then displays them and their product within an HTML paragraph.

```go-html-template
{{ $v1 := 6 }}
{{ $v2 := 7 }}
<p>The product of {{ $v1 }} and {{ $v2 }} is {{ mul $v1 $v2 }}.</p>
```

While HTML templates are the most common, you can create templates for any [output format](g) including CSV, JSON, RSS, and plain text.

## Context

The most important concept to understand before creating a template is _context_, the data passed into each template. The data may be a simple value, or more commonly [objects](g) and associated [methods](g).

For example, a _page_ template receives a `Page` object, and the `Page` object provides methods to return values or perform actions.

### Current context

Within a template, the dot (`.`) represents the current context.

```go-html-template {file="layouts/page.html"}
<h2>{{ .Title }}</h2>
```

In the example above the dot represents the `Page` object, and we call its [`Title`][] method to return the title as defined in [front matter][].

The current context may change within a template. For example, at the top of a template the context might be a `Page` object, but we rebind the context to another value or object within [`range`][] or [`with`][] blocks.

```go-html-template {file="layouts/page.html"}
<h2>{{ .Title }}</h2>

{{ range slice "foo" "bar" }}
  <p>{{ . }}</p>
{{ end }}

{{ with "baz" }}
  <p>{{ . }}</p>
{{ end }}
```

In the example above, the context changes as we `range` through the [slice](g) of values. In the first iteration the context is "foo", and in the second iteration the context is "bar". Inside of the `with` block the context is "baz". Hugo renders the above to:

```html
<h2>My Page Title</h2>
<p>foo</p>
<p>bar</p>
<p>baz</p>
```

### Template context

Within a `range` or `with` block you can access the context passed into the template by prepending a dollar sign (`$`) to the dot:

```go-html-template {file="layouts/page.html"}
{{ with "foo" }}
  <p>{{ $.Title }} - {{ . }}</p>
{{ end }}
```

Hugo renders this to:

```html
<p>My Page Title - foo</p>
```

> [!NOTE]
> Make sure that you thoroughly understand the concept of _context_ before you continue reading. The most common templating errors made by new users relate to context.

## Actions

In the examples above, the paired opening and closing braces represent the beginning and end of a template action, a data evaluation or control structure within a template.

A template action may contain literal values ([boolean](g), [string](g), [integer](g), and [float](g)), the [current context](#current-context), [variables](#variables), [functions](#functions), [methods](#methods), and the [`nil`](#nil) keyword.

```go-html-template {file="layouts/page.html"}
{{ $convertToLower := true }}
{{ if $convertToLower }}
  <h2>{{ strings.ToLower .Title }}</h2>
{{ end }}
```

In the example above:

- `$convertToLower` is a variable
- `true` is a literal boolean value
- `if` is the beginning of a control structure
- `strings.ToLower` is a function that converts all characters to lowercase
- `Title` is a method on a the `Page` object
- `end` is the end of a control structure

Hugo renders the above to:

```html {trim=false}

    <h2>my page title</h2>

```

### Whitespace

Notice the blank lines and indentation in the previous example? Although irrelevant in production when you typically minify the output, you can remove the adjacent whitespace by using template action delimiters with hyphens:

```go-html-template {file="layouts/page.html"}
{{- $convertToLower := true -}}
{{- if $convertToLower -}}
  <h2>{{ strings.ToLower .Title }}</h2>
{{- end -}}
```

Hugo renders this to:

```html
<h2>my page title</h2>
```

Whitespace includes spaces, horizontal tabs, carriage returns, and newlines.

### Quote characters

Hugo templates use different quote characters to define how text and characters are processed.

Use double quotes for [interpreted string literals](g). These interpret backslashes as special instructions:

```go-html-template
{{ print "Hello world\u0021" }} → Hello world!
```

Use backticks for [raw string literals](g). These ignore backslashes and treat every character literally:

```go-html-template
{{ print `Hello world\u0021` }} → Hello world\u0021
```

Use single quotes for [rune literals](g). Unlike strings, these represent a single character as its numerical Unicode value:

```go-html-template
{{ print '!' }} → 33
```

In practical terms, you will rarely, if ever, use rune literals in your template code. They are most commonly used in low-level programming; in a Hugo template, you will almost always want a string instead.

### Pipes

Within a template action you may [pipe](g) a value to a function or method. The piped value becomes the final argument to the function or method. For example, these are equivalent:

```go-html-template
{{ strings.ToLower "Hugo" }} → hugo
{{ "Hugo" | strings.ToLower }} → hugo
```

You can pipe the result of one function or method into another. For example, these are equivalent:

```go-html-template
{{ strings.TrimSuffix "o" (strings.ToLower "Hugo") }} → hug
{{ "Hugo" | strings.ToLower | strings.TrimSuffix "o" }} → hug
```

These are also equivalent:

```go-html-template
{{ mul 6 (add 2 5) }} → 42
{{ 5 | add 2 | mul 6 }} → 42
```

> [!NOTE]
> Remember that the piped value becomes the final argument to the function or method to which you are piping.

### Line splitting

You can split a template action over two or more lines. For example, these are equivalent:

```go-html-template
{{ $v := or $arg1 $arg2 }}

{{ $v := or
  $arg1
  $arg2
}}
```

You can also split [raw string literals](g) over two or more lines. For example, these are equivalent:

```go-html-template
{{ $msg := "This is line one.\nThis is line two." }}

{{ $msg := `This is line one.
This is line two.`
}}
```

### Nil

Other than using the `nil` keyword in comparisons, you may not use it as an argument to any function or method, nor may you assign it to a variable. For example, these are valid uses of the `nil` keyword:

```go-html-template
{{ if gt 42 nil }}
  <p>42 is greater than nil</p>
{{ end }}

{{ $pages := where .Site.RegularPages "Params.color" "ne" nil }}
```

These, on the other hand, are invalid:

```go-html-template
{{ $a := nil }}
{{ add 3 nil }}
{{ nil | print}}
```

The actions above throw an error.

## Variables

A variable is a user-defined [identifier](g) prepended with a dollar sign (`$`), representing a value of any data type, initialized or assigned within a template action. For example, `$foo` and `$bar` are variables.

Variables may contain [scalars](g), [slices](g), [maps](g), or [objects](g).

Use `:=` to initialize a variable, and use `=` to assign a value to a variable that has been previously initialized. For example:

```go-html-template
{{ $total := 3 }}
{{ range slice 7 11 21 }}
  {{ $total = add $total . }}
{{ end }}
{{ $total }} → 42
```

Variables initialized inside of an `if`, `range`, or `with` block are scoped to the block. Variables initialized outside of these blocks are scoped to the template.

With variables that represent a slice or map, use the [`index`][] function to return the desired value.

```go-html-template
{{ $slice := slice "foo" "bar" "baz" }}
{{ index $slice 2 }} → baz

{{ $map := dict "a" "foo" "b" "bar" "c" "baz" }}
{{ index $map "c" }} → baz
```

> [!NOTE]
> Slices and arrays are zero-based; element 0 is the first element.

With variables that represent a map or object, [chain](g) identifiers to return the desired value or to access the desired method.

```go-html-template
{{ $map := dict "a" "foo" "b" "bar" "c" "baz" }}
{{ $map.c }} → baz

{{ $homePage := .Site.Home }}
{{ $homePage.Title }} → My Homepage
```

> [!NOTE]
> As seen above, object and method names are capitalized. Although not required, to avoid confusion we recommend beginning variable and map key names with a lowercase letter or underscore.

## Functions

Used within a template action, a function takes one or more arguments and returns a value. Unlike methods, functions are not associated with an object.

Go's `text/template` and `html/template` packages provide a small set of functions, operators, and statements for general use. See the [go-templates][] section of the function documentation for details.

Hugo provides hundreds of custom [functions][] categorized by namespace. For example, the `strings` namespace includes these and other functions:

Function|Alias
:--|:--
[`strings.ToLower`][]|`lower`
[`strings.ToUpper`][]|`upper`
[`strings.Replace`][]|`replace`

As shown above, frequently used functions have an alias. Use aliases in your templates to reduce code length.

When calling a function, separate the arguments from the function, and from each other, with a space. For example:

```go-html-template
{{ $total := add 1 2 3 4 }}
```

## Methods

Used within a template action and associated with an object, a method takes zero or more arguments and either returns a value or performs an action.

The most commonly accessed objects are the [`Page`][] and [`Site`][] objects. This is a small sampling of the [methods][] available to each object.

Object|Method|Description
:--|:--|:--
`Page`|[`Date`](methods/page/date/)|Returns the date of the given page.
`Page`|[`Params`](methods/page/params/)|Returns a map of custom parameters as defined in the front matter of the given page.
`Page`|[`Title`](methods/page/title/)|Returns the title of the given page.
`Site`|[`Data`](methods/site/data/)|Returns a data structure composed from the files in the `data` directory.
`Site`|[`Params`](methods/site/params/)|Returns a map of custom parameters as defined in your project configuration.
`Site`|[`Title`](methods/site/title/)|Returns the title as defined in the your project configuration.

Chain the method to its object with a dot (`.`) as shown below, remembering that the leading dot represents the [current context](#current-context).

```go-html-template {file="layouts/page.html"}
{{ .Site.Title }} → My Site Title
{{ .Page.Title }} → My Page Title
```

The context passed into most templates is a `Page` object, so this is equivalent to the previous example:

```go-html-template {file="layouts/page.html"}
{{ .Site.Title }} → My Site Title
{{ .Title }} → My Page Title
```

Some methods take an argument. Separate the argument from the method with a space. For example:

```go-html-template {file="layouts/page.html"}
{{ $page := .Page.GetPage "/books/les-miserables" }}
{{ $page.Title }} → Les Misérables
```

## Comments

> [!NOTE]
> Do not attempt to use HTML comment delimiters to comment out template code.
>
> Hugo strips HTML comments when rendering a page, but first evaluates any template code within the HTML comment delimiters. Depending on the template code within the HTML comment delimiters, this could cause unexpected results or fail the build.

Template comments are similar to template actions. Paired opening and closing braces represent the beginning and end of a comment. For example:

```go-html-template
{{/* This is an inline comment. */}}
{{- /* This is an inline comment with adjacent whitespace removed. */ -}}
```

Code within a comment is not parsed, executed, or displayed. Comments may be inline, as shown above, or in block form:

```go-html-template
{{/*
This is a block comment.
*/}}

{{- /*
This is a block comment with
adjacent whitespace removed.
*/ -}}
```

You may not nest one comment inside of another.

To render an HTML comment, pass a string through the [`safe.HTML`][] function. For example:

```go-html-template
{{ "<!-- I am an HTML comment. -->" | safeHTML }}
{{ printf "<!-- This is the %s site. -->" .Site.Title | safeHTML }}
```

## Include

Use the [`template`][] function to include one or more of Hugo's [embedded templates][]:

```go-html-template
{{ partial "google_analytics.html" . }}
{{ partial "opengraph" . }}
{{ partial "pagination.html" . }}
{{ partial "schema.html" . }}
{{ partial "twitter_cards.html" . }}
```

Use the [`partial`][] or [`partialCached`][] function to include one or more [partial templates][]:

```go-html-template
{{ partial "breadcrumbs.html" . }}
{{ partialCached "css.html" . }}
```

Create your _partial_ templates in the `layouts/_partials` directory.

> [!NOTE]
> In the examples above, note that we are passing the current context (the dot) to each of the templates.

## Examples

This limited set of contrived examples demonstrates some of concepts described above. Please see the [functions][], [methods][], and [templates][] documentation for specific examples.

### Conditional blocks

See documentation for [`if`][], [`else`][], and [`end`][].

```go-html-template
{{ $var := 42 }}
{{ if eq $var 6 }}
  {{ print "var is 6" }}
{{ else if eq $var 7 }}
  {{ print "var is 7" }}
{{ else if eq $var 42 }}
  {{ print "var is 42" }}
{{ else }}
  {{ print "var is something else" }}
{{ end }}
```

### Logical operators

See documentation for [`and`][] and [`or`][].

```go-html-template
{{ $v1 := true }}
{{ $v2 := false }}
{{ $v3 := false }}
{{ $result := false }}

{{ if and $v1 $v2 $v3 }}
  {{ $result = true }}
{{ end }}
{{ $result }} → false

{{ if or $v1 $v2 $v3 }}
  {{ $result = true }}
{{ end }}
{{ $result }} → true
```

### Loops

See documentation for [`range`][], [`else`][], and [`end`][].

```go-html-template
{{ $s := slice "foo" "bar" "baz" }}
{{ range $s }}
  <p>{{ . }}</p>
{{ else }}
  <p>The collection is empty</p>
{{ end }}
```

To loop a specified number of times:

```go-html-template
{{ $s := slice }}
{{ range 3 }}
  {{ $s = $s | append . }}
{{ end }}
{{ $s }} → [0 1 2]
```

### Rebind context

See documentation for [`with`][], [`else`][], and [`end`][].

```go-html-template
{{ $var := "foo" }}
{{ with $var }}
  {{ . }} → foo
{{ else }}
  {{ print "var is falsy" }}
{{ end }}
```

To test multiple conditions:

```go-html-template
{{ $v1 := 0 }}
{{ $v2 := 42 }}
{{ with $v1 }}
  {{ . }}
{{ else with $v2 }}
  {{ . }} → 42
{{ else }}
  {{ print "v1 and v2 are falsy" }}
{{ end }}
```

### Access site parameters

See documentation for the [`Params`][params_site] method on a `Site` object.

With this project configuration:

{{< code-toggle file=hugo >}}
title = 'ABC Widgets'
baseURL = 'https://example.org'
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

Access the custom site parameters by chaining the identifiers:

```go-html-template
{{ .Site.Params.subtitle }} → The Best Widgets on Earth
{{ .Site.Params.author.name }} → John Smith

{{ $layout := .Site.Params.layouts.rfc_1123 }}
{{ .Site.Lastmod.Format $layout }} → Tue, 17 Oct 2023 13:21:02 PDT
```

### Access page parameters

See documentation for the [`Params`][params_page] method on a `Page` object.

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

[`Page`]: /methods/page/
[`Site`]: /methods/site/
[`Title`]: /methods/page/title/
[`and`]: /functions/go-template/and/
[`else`]: /functions/go-template/else/
[`end`]: /functions/go-template/end/
[`html/template`]: https://pkg.go.dev/html/template
[`if`]: /functions/go-template/if/
[`index`]: /functions/collections/indexfunction/
[`or`]: /functions/go-template/or/
[`partialCached`]: /functions/partials/includecached/
[`partial`]: /functions/partials/include/
[`range`]: /functions/go-template/range/
[`safe.HTML`]: /functions/safe/html/
[`strings.Replace`]: /functions/strings/replace/
[`strings.ToLower`]: /functions/strings/tolower/
[`strings.ToUpper`]: /functions/strings/toupper/
[`template`]: /functions/go-template/template/
[`text/template`]: https://pkg.go.dev/text/template
[`with`]: /functions/go-template/with/
[embedded templates]: /templates/embedded/
[front matter fields]: /content-management/front-matter/#fields
[front matter]: /content-management/front-matter/
[functions]: /functions/
[go-templates]: /functions/go-template/
[methods]: /methods/
[params_page]: /methods/page/params/
[params_site]: /methods/site/params/
[partial templates]: /templates/types/#partial
[templates]: /templates/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/templates/lookup-order.md
---


{{< newtemplatesystem >}}

## Lookup rules

Hugo takes the parameters listed below into consideration when choosing a template for a given page. The templates are ordered by specificity. This should feel natural, but look at the table below for concrete examples of the different parameter variations.

Kind
: The page `Kind` (the home page is one). See the example tables below per kind. This also determines if it is a **single page** (i.e. a regular content page. We then look for a template in `_default/single.html` for HTML) or a **list page** (section listings, home page, taxonomy lists, taxonomy terms. We then look for a template in `_default/list.html` for HTML).

Layout
: Can be set in front matter.

Output Format
: See [configure output formats](/configuration/output-formats/). An output format has both a `name` (e.g. `rss`, `amp`, `html`) and a `suffix` (e.g. `xml`, `html`). We prefer matches with both (e.g. `index.amp.html`), but look for less specific templates.

Note that if the output format's Media Type has more than one suffix defined, only the first is considered.

Language
: We will consider a language tag in the template name. If the site language is `fr`, `index.fr.amp.html` will win over `index.amp.html`, but `index.amp.html` will be chosen before `index.fr.html`.

Type
: Is value of `type` if set in front matter, else it is the name of the root section (e.g. "blog"). It will always have a value, so if not set, the value is "page".

Section
: Is relevant for `section`, `taxonomy` and `term` types.

> [!NOTE]
> Templates can live in either the project's or the themes' `layout` directories, and the most specific templates will be chosen. Hugo will interleave the lookups listed below, finding the most specific one either in the project or themes.

## Target a template

You cannot change the lookup order to target a content page, but you can change a content page to target a template. Specify `type`, `layout`, or both in front matter.

Consider this content structure:

```tree
content/
├── about.md
└── contact.md
```

Files in the root of the `content` directory have a [content type](g) of `page`. To render these pages with a unique template, create a matching subdirectory:

```tree
layouts/
└── page/
    └── single.html
```

The contact page, however, probably has a form and requires a different template. In the front matter specify `layout`:

{{< code-toggle file=content/contact.md fm=true >}}
title = 'Contact'
layout = 'contact'
{{< /code-toggle >}}

Then create the template for the contact page:

```tree
layouts/
└── page/
    └── contact.html  <-- renders contact.md
    └── single.html   <-- renders about.md
```

As a content type, the word `page` is vague. Perhaps `miscellaneous` would be better. Add `type` to the front matter of each page:

{{< code-toggle file=content/about.md fm=true >}}
title = 'About'
type = 'miscellaneous'
{{< /code-toggle >}}

{{< code-toggle file=content/contact.md fm=true >}}
title = 'Contact'
type = 'miscellaneous'
layout = 'contact'
{{< /code-toggle >}}

Now place the layouts in the corresponding directory:

```tree
layouts/
└── miscellaneous/
    └── contact.html  <-- renders contact.md
    └── single.html   <-- renders about.md
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/templates/menu.md
---


## Overview

After [defining menu entries][], use [menu methods][] to render a menu.

Three factors determine how to render a menu:

1. The method used to define the menu entries: [automatic][], in [front matter][], or in your [project configuration][]
1. The menu structure: flat or nested
1. The method used to [localize the menu entries][]: project configuration or translation tables

The example below handles every combination.

## Example

This _partial_ template recursively "walks" a menu structure, rendering a localized, accessible nested list.

```go-html-template {file="layouts/_partials/menu.html" copy=true}
{{- $page := .page }}
{{- $menuID := .menuID }}

{{- with index site.Menus $menuID }}
  <nav>
    <ul>
      {{- partial "inline/menu/walk.html" (dict "page" $page "menuEntries" .) }}
    </ul>
  </nav>
{{- end }}

{{- define "_partials/inline/menu/walk.html" }}
  {{- $page := .page }}
  {{- range .menuEntries }}
    {{- $attrs := dict "href" .URL }}
    {{- if $page.IsMenuCurrent .Menu . }}
      {{- $attrs = merge $attrs (dict "class" "active" "aria-current" "page") }}
    {{- else if $page.HasMenuCurrent .Menu .}}
      {{- $attrs = merge $attrs (dict "class" "ancestor" "aria-current" "true") }}
    {{- end }}
    {{- $name := .Name }}
    {{- with .Identifier }}
      {{- with T . }}
        {{- $name = . }}
      {{- end }}
    {{- end }}
    <li>
      <a
        {{- range $k, $v := $attrs }}
          {{- with $v }}
            {{- printf " %s=%q" $k $v | safeHTMLAttr }}
          {{- end }}
        {{- end -}}
      >{{ $name }}</a>
      {{- with .Children }}
        <ul>
          {{- partial "inline/menu/walk.html" (dict "page" $page "menuEntries" .) }}
        </ul>
      {{- end }}
    </li>
  {{- end }}
{{- end }}
```

Call the partial above, passing a menu ID and the current page in context.

```go-html-template {file="layouts/page.html"}
{{ partial "menu.html" (dict "menuID" "main" "page" .) }}
{{ partial "menu.html" (dict "menuID" "footer" "page" .) }}
```

## Page references

Regardless of how you [define menu entries][], an entry associated with a page has access to page context.

This simplistic example renders a page parameter named `version` next to each entry's `name`. Code defensively using `with` or `if` to handle entries where (a) the entry points to an external resource, or (b) the `version` parameter is not defined.

```go-html-template {file="layouts/page.html"}
{{- range site.Menus.main }}
  <a href="{{ .URL }}">
    {{ .Name }}
    {{- with .Page }}
      {{- with .Params.version -}}
        ({{ . }})
      {{- end }}
    {{- end }}
  </a>
{{- end }}
```

## Menu entry parameters

When you define menu entries in your [project configuration][] or in [front matter][], you can include a `params` key as shown in these examples:

- [Menu entry defined in your project configuration][]
- [Menu entry defined in front matter][]

This simplistic example renders a `class` attribute for each anchor element. Code defensively using `with` or `if` to handle entries where `params.class` is not defined.

```go-html-template {file="layouts/_partials/menu.html"}
{{- range site.Menus.main }}
  <a {{ with .Params.class -}} class="{{ . }}" {{ end -}} href="{{ .URL }}">
    {{ .Name }}
  </a>
{{- end }}
```

## Localize

Hugo provides two methods to localize your menu entries. See [multilingual][].

[Menu entry defined in front matter]: /content-management/menus/#example
[Menu entry defined in your project configuration]: /configuration/menus/
[automatic]: /content-management/menus/#define-automatically
[define menu entries]: /content-management/menus/
[defining menu entries]: /content-management/menus/
[front matter]: /content-management/menus/#define-in-front-matter
[localize the menu entries]: /content-management/multilingual/#menus
[menu methods]: /methods/menu/
[multilingual]: /content-management/multilingual/#menus
[project configuration]: /content-management/menus/#define-in-project-configuration


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/templates/new-templatesystem-overview.md
---


In [Hugo v0.146.0][], we performed a full re-implementation of how Go templates are handled in Hugo. This includes structural changes to the `layouts` folder and a new, more powerful template lookup system.

We have aimed to maintain as much backward compatibility as possible by mapping "old to new," but some reported breakages have occurred. We're working on a full overhaul of the documentation on this topic – until then, this is a one-pager with the most important changes.

## Changes to the `layouts` folder

| Description                                                                                                                                                                                                                                                                                                                                                                                                             | Action required                                                                                                                                                   |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| The `_default` folder is removed.                                                                                                                                                                                                                                                                                                                                                                                       | Move all files in `layouts/_default` up to the `layouts/` root.                                                                                                   |
| The `layouts/partials` folder is renamed to `layouts/_partials`.                                                                                                                                                                                                                                                                                                                                                        | Rename the folder.                                                                                                                                                |
| The `layouts/shortcodes` folder is renamed to `layouts/_shortcodes`.                                                                                                                                                                                                                                                                                                                                                    | Rename the folder.                                                                                                                                                |
| Any folder in `layouts` that does not start with `_` represents the root of a [Page path][]. In [Hugo v0.146.0][], this can be nested as deeply as needed, and `_shortcodes` and `_markup` folders can be placed at any level in the tree.                                                                                                                                                                              | No action required.                                                                                                                                               |
| The above also means that there's no top-level `layouts/taxonomy` or `layouts/section` folders anymore, unless it represents a [Page path][].                                                                                                                                                                                                                                                                           | Move them up to `layouts/` with one of the [Page kinds][] `section`, `taxonomy` or `term` as the base name, or place the layouts into the taxonomy [Page path][]. |
| A template named `taxonomy.html` used to be a candidate for both Page kind `term` and `taxonomy`, now it's only considered for `taxonomy`.                                                                                                                                                                                                                                                                              | Create both `taxonomy.html` and `term.html` or create a more general layout, e.g. `list.html`.                                                                    |
| For base templates (e.g., `baseof.html`), in previous Hugo versions, you could prepend one identifier (layout, type, or kind) with a hyphen in front of the baseof keyword.                                                                                                                                                                                                                                             | Move that identifier after the first "dot," e.g., rename`list-baseof.html` to `baseof.list.html`.                                                                 |
| We have added a new `all` "catch-all" layout. This means that if you have, e.g., `layouts/all.html` and that is the only template, that layout will be used for all HTML page rendering.                                                                                                                                                                                                                                |                                                                                                                                                                   |
| We have removed the concept of `_internal` Hugo templates.[^internal]                                                                                                                                                                                                                                                                                                                                                   | Replace constructs similar to `{{ template "_internal/opengraph.html" . }}` with `{{ partial "opengraph.html" . }}`.                                              |
| The identifiers that can be used in a template filename are one of the [Page kinds][] (`home`, `page`, `section`, `taxonomy`, or `term`), one of the standard layouts (`list`, `single`, or `all`), a custom layout (as defined in the `layout` front matter field), a language (e.g., `en`), an output format (e.g., `html`, `rss`), and a suffix representing the media type. E.g., `all.en.html` and `home.rss.xml`. |                                                                                                                                                                   |
| The above means that there's no such thing as an `index.html` template for the home page anymore.                                                                                                                                                                                                                                                                                                                       | Rename `index.html` to `home.html`.                                                                                                                               |

Also, see the [Example folder structure](#example-folder-structure) below for a more concrete example of the new layout system.

## Changes to template lookup order

We have consolidated the template lookup so it works the same across all [template types][]. The previous setup was difficult to understand and had a massive number of variants. The new setup aims to feel natural with few surprises.

The identifiers used in the template weighting, in order of importance, are:

| Identifier         | Description                                           |
|--------------------|-------------------------------------------------------|
| Layout custom      | The custom `layout` set in front matter.              |
| [Page kinds][]     | One of `home`, `section`, `taxonomy`, `term`, `page`. |
| Layouts standard 1 | `list` or `single`.                                   |
| Output format      | The output format (e.g., `html`, `rss`).              |
| Layouts standard 2 | `all`.                                                |
| Language           | The language (e.g., `en`).                            |
| Media type         | The media type (e.g., `text/html`).                   |
| [Page path][]      | The page path (e.g., `/blog/mypost`).                 |
| Type               | `type` set in front matter.[^type]                    |

For templates placed in a `layouts` folder partly or completely matching a [Page path][], a closer match upwards will be considered _better_. In the [Example folder structure](#example-folder-structure) below, this means that:

- `layouts/docs/api/_markup/render-link.html` will be used to render links from the Page path `/docs/api` and below.
- `layouts/docs/baseof.html` will be used as the base template for the Page path `/docs` and below.
- `layouts/tags/term.html` will be used for all `term` rendering in the `tags` taxonomy, except for the `blue` term, which will use `layouts/tags/blue/list.html`.

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

## Terminology

paginate
: To split a [list page](g) into two or more subsets.

pagination
: The process of paginating a list page.

pager
: Created during pagination, a pager contains a subset of a list page and navigation links to other pagers.

paginator
: A collection of pagers.

## Configuration

See [configure pagination][].

## Methods

To paginate a `home`, `section`, `taxonomy`, or `term` page, invoke either of these methods on the `Page` object in the corresponding template:

- [`Paginate`][]
- [`Paginator`][]

The `Paginate` method is more flexible, allowing you to:

- Paginate any page collection
- Filter, sort, and group the page collection
- Override the number of pages per pager as defined in your project configuration

By comparison, the `Paginator` method paginates the page collection passed into the template, and you cannot override the number of pages per pager.

## Examples

To paginate a list page using the `Paginate` method:

```go-html-template
{{ $pages := where site.RegularPages "Type" "posts" }}
{{ $paginator := .Paginate $pages.ByTitle 7 }}

{{ range $paginator.Pages }}
  <h2><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></h2>
{{ end }}

{{ partial "pagination.html" . }}
```

In the example above, we:

1. Build a page collection
1. Sort the page collection by title
1. Paginate the page collection, with 7 pages per pager
1. Range over the paginated page collection, rendering a link to each page
1. Call the embedded pagination template to create navigation links between pagers

To paginate a list page using the `Paginator` method:

```go-html-template
{{ range .Paginator.Pages }}
  <h2><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></h2>
{{ end }}

{{ partial "pagination.html" . }}
```

In the example above, we:

1. Paginate the page collection passed into the template, with the default number of pages per pager
1. Range over the paginated page collection, rendering a link to each page
1. Call the embedded pagination template to create navigation links between pagers

## Caching

> [!NOTE]
> The most common templating mistake related to pagination is invoking pagination more than once for a given list page.

Regardless of pagination method, the initial invocation is cached and cannot be changed. If you invoke pagination more than once for a given list page, subsequent invocations use the cached result. This means that subsequent invocations will not behave as written.

When paginating conditionally, do not use the `compare.Conditional` function due to its eager evaluation of arguments. Use an `if-else` construct instead.

## Grouping

Use pagination with any of the [grouping methods][]. For example:

```go-html-template
{{ $pages := where site.RegularPages "Type" "posts" }}
{{ $paginator := .Paginate ($pages.GroupByDate "Jan 2006") }}

{{ range $paginator.PageGroups }}
  <h2>{{ .Key }}</h2>
  {{ range .Pages }}
    <h3><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></h3>
  {{ end }}
{{ end }}

{{ partial "pagination.html" . }}
```

## Navigation

As shown in the examples above, the easiest way to add navigation between pagers is with Hugo's embedded pagination template:

```go-html-template
{{ partial "pagination.html" . }}
```

The embedded pagination template has two formats: `default` and `terse`. The above is equivalent to:

```go-html-template
{{ partial "pagination.html" (dict "page" . "format" "default") }}
```

The `terse` format has fewer controls and page slots, consuming less space when styled as a horizontal list. To use the `terse` format:

```go-html-template
{{ partial "pagination.html" (dict "page" . "format" "terse") }}
```

> [!NOTE]
> To override Hugo's embedded pagination template, copy the [source code][] to a file with the same name in the `layouts/_partials` directory, then call it from your templates using the [`partial`][] function:
>
> `{{ partial "pagination.html" . }}`

Create custom navigation components using any of the `Pager` methods:

{{% render-list-of-pages-in-section path=/methods/pager %}}

## Structure

The example below depicts the published site structure when paginating a list page.

With this content:

```tree
content/
├── posts/
│   ├── _index.md
│   ├── post-1.md
│   ├── post-2.md
│   ├── post-3.md
│   └── post-4.md
└── _index.md
```

And this project configuration:

{{< code-toggle file=hugo >}}
[pagination]
  disableAliases = false
  pagerSize = 2
  path = 'page'
{{< /code-toggle >}}

And this _section_ template:

```go-html-template {file="layouts/section.html"}
{{ range (.Paginate .Pages).Pages }}
  <h2><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></h2>
{{ end }}

{{ partial "pagination.html" . }}
```

The published site has this structure:

```tree
public/
├── posts/
│   ├── page/
│   │   ├── 1/
│   │   │   └── index.html  <-- alias to public/posts/index.html
│   │   └── 2/
│   │       └── index.html
│   ├── post-1/
│   │   └── index.html
│   ├── post-2/
│   │   └── index.html
│   ├── post-3/
│   │   └── index.html
│   ├── post-4/
│   │   └── index.html
│   └── index.html
└── index.html
```

To disable alias generation for the first pager, change your project configuration:

{{< code-toggle file=hugo >}}
[pagination]
  disableAliases = true
  pagerSize = 2
  path = 'page'
{{< /code-toggle >}}

Now the published site will have this structure:

```tree
public/
├── posts/
│   ├── page/
│   │   └── 2/
│   │       └── index.html
│   ├── post-1/
│   │   └── index.html
│   ├── post-2/
│   │   └── index.html
│   ├── post-3/
│   │   └── index.html
│   ├── post-4/
│   │   └── index.html
│   └── index.html
└── index.html
```

[`Paginate`]: /methods/page/paginate/
[`Paginator`]: /methods/page/paginator/
[`partial`]: /functions/partials/include/
[configure pagination]: /configuration/pagination/
[grouping methods]: /quick-reference/page-collections/#group
[source code]: <{{% eturl pagination %}}>


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/templates/partial-decorators.md
---


{{< new-in 0.154.0 />}}

## Overview

{{% glossary-term "partial decorator" %}}

This approach creates a connection between two files. The calling template provides a block of code and the partial decorator determines where that code appears. This allows the partial to wrap around content without needing to know the specific markup or internal logic of the enclosed block.

## Implementation

To use a partial decorator, use a block-style call in your templates. The [`with`][] statement is required to initiate the partial and create a container for the content. This block can include any valid template code including page methods and functions.

```go-html-template {file="layouts/home.html" copy=true}
{{ with partial "components/wrapper.html" . }}
  <p>Everything in this block will be wrapped.</p>
  <p>{{ .Content | transform.Plainify | strings.Truncate 200 }}</p>
{{ end }}
```

Inside the partial template, place the `templates.Inner` function call where the wrapped content should appear.

```go-html-template {file="layouts/_partials/components/wrapper.html" copy=true}
<div class="wrapper-styling">
  {{ templates.Inner . }}
</div>
```

The `with` statement creates a new [scope](g). Variables defined outside of the `with` block are not available inside it. To use external data within the wrapped content, you must ensure it is part of the [context](g) passed in the partial call.

A key feature of the `templates.Inner` function is its ability to accept a context argument. By passing a context to the function, you define what the dot (`.`) represents inside the wrapped block. This ensures that the injected content has access to the correct data even when nested inside multiple layers of wrappers.

## Benefits of composition

Using partial decorators to build wrapper components provides several advantages:

- It eliminates the need to use separate partials for opening and closing tags when encapsulating a block of code.
- It prevents parameter bloat because a standard partial no longer requires an extensive list of arguments to account for every possible variation of the content inside it.
- It enables clean composition where the wrapped block can execute any template logic without the wrapper needing to receive or process that data.

This approach separates container logic from content logic. The wrapper handles structural requirements like specific class hierarchies or CSS grid containers. The calling template retains control over the inner markup and how data is displayed.

## Example

The following templates illustrate how to nest three wrapper components including a section, a column, and a card while passing context through each layer.

The _home_ template initiates the structure by calling the section, column, and card partials as decorators:

```go-html-template {file="layouts/home.html" copy=true}
{{ $ctx := dict
  "page" .
  "label" "Recent Posts"
  "pageCollection" ((site.GetPage "/posts").RegularPages)
}}

{{ with partial "components/section.html" $ctx }}
  <div class="grid-wrapper">
    {{ range .pageCollection }}
      {{ with partial "components/column.html" (dict "page" . "class" "col-half") }}
        {{ with partial "components/card.html" (dict "page" .page "url" .page.RelPermalink "title" .page.LinkTitle) }}
          <p>
            {{ .page.Content | plainify | strings.Truncate 240 }}
          </p>
        {{ end }}
      {{ end }}
    {{ end }}
  </div>
{{ end }}
```

The section component provides a semantic container and an optional heading:

```go-html-template {file="layouts/_partials/components/section.html" copy=true}
<section class="content-section">
  {{ with .label }}
    <h2 class="section-label">{{ . }}</h2>
  {{ end }}
  <div class="section-content">
    {{ templates.Inner . }}
  </div>
</section>
```

The column component manages layout width by applying a CSS class:

```go-html-template {file="layouts/_partials/components/column.html" copy=true}
<div class="{{ .class | default `column-default` }}">
  {{ templates.Inner . }}
</div>
```

The card component defines the visual boundary for the content:

```go-html-template {file="layouts/_partials/components/card.html" copy=true}
<div class="card">
  {{ with .title }}
    <h2 class="card-title">
      {{ if $.url }}
        <a href="{{ $.url }}">{{ . }}</a>
      {{ else }}
        {{ . }}
      {{ end }}
    </h2>
  {{ end }}

  <div class="card-body">
    {{ templates.Inner . }}
  </div>

  {{ with .url }}
    <div class="card-footer">
      <a href="{{ . }}">Read more</a>
    </div>
  {{ end }}
</div>
```

[`with`]: /functions/go-template/with/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/templates/robots.md
---


To generate a robots.txt file from a template, change your project configuration:

{{< code-toggle file=hugo >}}
enableRobotsTXT = true
{{< /code-toggle >}}

By default, Hugo generates robots.txt using an [embedded template][].

```text
User-agent: *
```

Search engines that honor the Robots Exclusion Protocol will interpret this as permission to crawl everything on the site.

## robots.txt template lookup order

You may overwrite the internal template with a custom template. Hugo selects the template using this lookup order:

1. `/layouts/robots.txt`
1. `/themes/<THEME>/layouts/robots.txt`

## robots.txt template example

```text {file="layouts/robots.txt"}
User-agent: *
{{ range .Pages }}
Disallow: {{ .RelPermalink }}
{{ end }}
```

This template creates a robots.txt file with a `Disallow` directive for each page on the site. Search engines that honor the Robots Exclusion Protocol will not crawl any page on the site.

> [!NOTE]
> To create a robots.txt file without using a template:
>
> 1. Set `enableRobotsTXT` to `false` in your project configuration.
> 1. Create a robots.txt file in the `static` directory.
>
> Remember that Hugo copies everything in the static director to the root of `publishDir` (typically `public`) when you build your project.

[embedded template]: <{{% eturl robots %}}>


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/templates/rss.md
---


## Configuration

By default, when you build your project, Hugo generates RSS feeds for home, section, taxonomy, and term pages. Control feed generation in your project configuration. For example, to generate feeds for home and section pages, but not for taxonomy and term pages:

{{< code-toggle file=hugo >}}
[outputs]
home = ['html', 'rss']
section = ['html', 'rss']
taxonomy = ['html']
term = ['html']
{{< /code-toggle >}}

To disable feed generation for all [page kinds](g):

{{< code-toggle file=hugo >}}
disableKinds = ['rss']
{{< /code-toggle >}}

By default, the number of items in each feed is unlimited. Change this as needed in your project configuration:

{{< code-toggle file=hugo >}}
[services.rss]
limit = 42
{{< /code-toggle >}}

Set `limit` to `-1` to generate an unlimited number of items per feed.

The built-in RSS template will render the following values, if present, from your project configuration:

{{< code-toggle file=hugo >}}
copyright = '© 2023 ABC Widgets, Inc.'
[params.author]
name = 'John Doe'
email = 'jdoe@example.org'
{{< /code-toggle >}}

## Include feed reference

To include a feed reference in the `head` element of your rendered pages, place this within the `head` element of your templates:

```go-html-template
{{ with .OutputFormats.Get "rss" }}
  {{ printf `<link rel=%q type=%q href=%q title=%q>` .Rel .MediaType.Type .Permalink site.Title | safeHTML }}
{{ end }}
```

Hugo will render this to:

```html
<link rel="alternate" type="application/rss+xml" href="https://example.org/index.xml" title="ABC Widgets">
```

## Custom templates

Override Hugo's [embedded RSS template][] by creating one or more of your own. For example, to use different templates for home, section, taxonomy, and term pages:

```tree
layouts/
  ├── home.rss.xml
  ├── section.rss.xml
  ├── taxonomy.rss.xml
  └── term.rss.xml
```

RSS templates receive the `.Page` and `.Site` objects in context.

[embedded RSS template]: <{{% eturl rss %}}>


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/templates/shortcode.md
---


{{< newtemplatesystem >}}

> [!NOTE]
> Before creating custom shortcodes, please review the [shortcodes][] page in the [content management][] section. Understanding the usage details will help you design and create better templates.

## Introduction

Hugo provides [embedded shortcodes][] for many common tasks, but you'll likely need to create your own for more specific needs. Some examples of custom shortcodes you might develop include:

- Audio players
- Video players
- Image galleries
- Diagrams
- Maps
- Tables
- And many other custom elements

## Directory structure

Create _shortcode_ templates within the `layouts/_shortcodes` directory, either at its root or organized into subdirectories.

```tree
layouts/
└── _shortcodes/
    ├── diagrams/
    │   ├── kroki.html
    │   └── plotly.html
    ├── media/
    │   ├── audio.html
    │   ├── gallery.html
    │   └── video.html
    ├── capture.html
    ├── column.html
    ├── include.html
    └── row.html
```

When calling a shortcode in a subdirectory, specify its path relative to the `_shortcode` directory, excluding the file extension.

```md
{{</* media/audio path=/audio/podcast/episode-42.mp3 */>}}
```

## Lookup order

Hugo selects _shortcode_ templates based on the shortcode name, the current output format, and the current language. The examples below are sorted by specificity in descending order. The least specific path is at the bottom of the list.

Shortcode name|Output format|Language|Template path
:--|:--|:--|:--
foo|html|en|`layouts/_shortcodes/foo.en.html`
foo|html|en|`layouts/_shortcodes/foo.html.html`
foo|html|en|`layouts/_shortcodes/foo.html`
foo|html|en|`layouts/_shortcodes/foo.html.en.html`

Shortcode name|Output format|Language|Template path
:--|:--|:--|:--
foo|rss|en|`layouts/_shortcodes/foo.en.rss.xml`
foo|rss|en|`layouts/_shortcodes/foo.rss.xml`
foo|rss|en|`layouts/_shortcodes/foo.en.xml`
foo|rss|en|`layouts/_shortcodes/foo.xml`

## Methods

Use these methods in your _shortcode_ templates. Refer to each method's documentation for details and examples.

{{% render-list-of-pages-in-section path=/methods/shortcode %}}

## Examples

These examples range in complexity from simple to moderately advanced, with some simplified for clarity.

### Insert year

Create a shortcode to insert the current year:

```go-html-template {file="layouts/_shortcodes/year.html"}
{{- now.Format "2006" -}}
```

Then call the shortcode from within your markup:

```md {file="content/example.md"}
This is {{</* year */>}}, and look at how far we've come.
```

This shortcode can be used inline or as a block on its own line. If a shortcode might be used inline, remove the surrounding [whitespace][] by using [template action](g) delimiters with hyphens.

### Insert image

This example assumes the following content structure, where `content/example/index.md` is a [page bundle](g) containing one or more [page resources](g).

```tree
content/
├── example/
│   ├── a.jpg
│   └── index.md
└── _index.md
```

Create a shortcode to capture an image as a page resource, resize it to the given width, convert it to the WebP format, and add an `alt` attribute:

```go-html-template {file="layouts/_shortcodes/image.html"}
{{- with .Page.Resources.Get (.Get "path") }}
  {{- with .Process (printf "resize %dx wepb" ($.Get "width")) -}}
    <img src="{{ .RelPermalink }}" width="{{ .Width }}" height="{{ .Height }}" alt="{{ $.Get "alt" }}">
  {{- end }}
{{- end -}}
```

Then call the shortcode from within your markup:

```md {file="content/example/index.md"}
{{</* image path=a.jpg width=300 alt="A white kitten" */>}}
```

The example above uses:

- The [`with`][] statement to rebind the [context](g) after each successful operation
- The [`Get`][] method to retrieve arguments by name
- The `$` to access the template context

> [!NOTE]
> Make sure that you thoroughly understand the concept of context. The most common templating errors made by new users relate to context.
>
> Read more about context in the [introduction to templating][].

### Insert image with error handling

The previous example, while functional, silently fails if the image is missing, and does not gracefully exit if a required argument is missing. We'll add error handling to address these issues:

```go-html-template {file="layouts/_shortcodes/image.html"}
{{- with .Get "path" }}
  {{- with $r := $.Page.Resources.Get ($.Get "path") }}
    {{- with $.Get "width" }}
      {{- with $r.Process (printf "resize %dx wepb" ($.Get "width" )) }}
        {{- $alt := or ($.Get "alt") "" -}}
        <img src="{{ .RelPermalink }}" width="{{ .Width }}" height="{{ .Height }}" alt="{{ $alt }}">
      {{- end }}
    {{- else }}
      {{- errorf "The %q shortcode requires a 'width' argument: see %s" $.Name $.Position }}
    {{- end }}
  {{- else }}
    {{- warnf "The %q shortcode was unable to find %s: see %s" $.Name ($.Get "path") $.Position }}
  {{- end }}
{{- else }}
  {{- errorf "The %q shortcode requires a 'path' argument: see %s" .Name .Position }}
{{- end -}}
```

This template throws an error and gracefully fails the build if the author neglected to provide a `path` or `width` argument, and it emits a warning if it cannot find the image at the specified path. If the author does not provide an `alt` argument, the `alt` attribute is set to an empty string.

The [`Name`][] and [`Position`][] methods provide helpful context for errors and warnings. For example, a missing `width` argument causes the shortcode to throw this error:

```text
ERROR The "image" shortcode requires a 'width' argument: see "/home/user/project/content/example/index.md:7:1"
```

### Positional arguments

Shortcode arguments can be [named or positional][]. We used named arguments previously; let's explore positional arguments. Here's the named argument version of our example:

```md {file="content/example/index.md"}
{{</* image path=a.jpg width=300 alt="A white kitten" */>}}
```

Here's how to call it with positional arguments:

```md {file="content/example/index.md"}
{{</* image a.jpg 300 "A white kitten" */>}}
```

Using the `Get` method with zero-indexed keys, we'll initialize variables with descriptive names in our template:

```go-html-template {file="layouts/_shortcodes/image.html"}
{{ $path := .Get 0 }}
{{ $width := .Get 1 }}
{{ $alt := .Get 2 }}
```

> [!NOTE]
> Positional arguments work well for frequently used shortcodes with one or two arguments. Since you'll use them often, the argument order will be easy to remember. For less frequently used shortcodes, or those with more than two arguments, named arguments improve readability and reduce the chance of errors.

### Named and positional arguments

You can create a shortcode that will accept both named and positional arguments, but not at the same time. Use the [`IsNamedParams`][] method to determine whether the shortcode call used named or positional arguments:

```go-html-template {file="layouts/_shortcodes/image.html"}
{{ $path := cond (.IsNamedParams) (.Get "path") (.Get 0) }}
{{ $width := cond (.IsNamedParams) (.Get "width") (.Get 1) }}
{{ $alt := cond (.IsNamedParams) (.Get "alt") (.Get 2) }}
```

This example uses the `cond` alias for the [`compare.Conditional`][] function to get the argument by name if `IsNamedParams` returns `true`, otherwise get the argument by position.

### Argument collection

Use the [`Params`][] method to access the arguments as a collection.

When using named arguments, the `Params` method returns a map:

```md {file="content/example/index.md"}
{{</* image path=a.jpg width=300 alt="A white kitten" */>}}
```

```go-html-template {file="layouts/_shortcodes/image.html"}
{{ .Params.path }} → a.jpg
{{ .Params.width }} → 300
{{ .Params.alt }} → A white kitten
```

 When using positional arguments, the `Params` method returns a slice:

```md {file="content/example/index.md"}
{{</* image a.jpg 300 "A white kitten" */>}}
```

```go-html-template {file="layouts/_shortcodes/image.html"}
{{ index .Params 0 }} → a.jpg
{{ index .Params 1 }} → 300
{{ index .Params 1 }} → A white kitten
```

Combine the `Params` method with the [`collections.IsSet`][] function to determine if a parameter is set, even if its value is falsy.

### Inner content

Extract the content enclosed within shortcode tags using the [`Inner`][] method. This example demonstrates how to pass both content and a title to a shortcode. The shortcode then generates a `div` element containing an `h2` element (displaying the title) and the provided content.

```md {file="content/example.md"}
{{</* contrived title="A Contrived Example" */>}}
This is a **bold** word, and this is an _emphasized_ word.
{{</* /contrived  */>}}
```

```go-html-template {file="layouts/_shortcodes/contrived.html"}
<div class="contrived">
  <h2>{{ .Get "title" }}</h2>
  {{ .Inner | .Page.RenderString }}
</div>
```

The preceding example called the shortcode using [standard notation][], requiring us to process the inner content with the [`RenderString`][] method to convert the Markdown to HTML. This conversion is unnecessary when calling a shortcode using [Markdown notation][].

### Nesting

The  [`Parent`][] method provides access to the parent shortcode context when the shortcode in question is called within the context of a parent shortcode. This provides an inheritance model.

The following example is contrived but demonstrates the concept. Assume you have a `gallery` shortcode that expects one named `class` argument:

```go-html-template {file="layouts/_shortcodes/gallery.html"}
<div class="{{ .Get "class" }}">
  {{ .Inner }}
</div>
```

You also have an `img` shortcode with a single named `src` argument that you want to call inside of `gallery` and other shortcodes, so that the parent defines the context of each `img`:

```go-html-template {file="layouts/_shortcodes/img.html"}
{{ $src := .Get "src" }}
{{ with .Parent }}
  <img src="{{ $src }}" class="{{ .Get "class" }}-image">
{{ else }}
  <img src="{{ $src }}">
{{ end }}
```

You can then call your shortcode in your content as follows:

```md {file="content/example.md"}
{{</* gallery class="content-gallery" */>}}
  {{</* img src="/images/one.jpg" */>}}
  {{</* img src="/images/two.jpg" */>}}
{{</* /gallery */>}}
{{</* img src="/images/three.jpg" */>}}
```

This will output the following HTML. Note how the first two `img` shortcodes inherit the `class` value of `content-gallery` set with the call to the parent `gallery`, whereas the third `img` only uses `src`:

```html
<div class="content-gallery">
  <img src="/images/one.jpg" class="content-gallery-image">
  <img src="/images/two.jpg" class="content-gallery-image">
</div>
<img src="/images/three.jpg">
```

### Other examples

For guidance, consider examining Hugo's embedded shortcodes. The source code, available on [GitHub][], can provide a useful model.

## Detection

The [`HasShortcode`][] method allows you to check if a specific shortcode has been called on a page. For example, consider a custom audio shortcode:

```md {file="content/example.md"}
{{</* audio src=/audio/test.mp3 */>}}
```

You can use the `HasShortcode` method in your base template to conditionally load CSS if the audio shortcode was used on the page:

```go-html-template {file="layouts/baseof.html"}
<head>
  ...
  {{ if .HasShortcode "audio" }}
    <link rel="stylesheet" src="/css/audio.css">
  {{ end }}
  ...
</head>
```

[GitHub]: https://github.com/gohugoio/hugo/tree/master/tpl/tplimpl/embedded/templates/_shortcodes
[Markdown notation]: /content-management/shortcodes/#markdown-notation
[`Get`]: /methods/shortcode/get/
[`HasShortcode`]: /methods/page/hasshortcode/
[`Inner`]: /methods/shortcode/inner/
[`IsNamedParams`]: /methods/shortcode/isnamedparams/
[`Name`]: /methods/shortcode/name/
[`Params`]: /methods/shortcode/params/
[`Parent`]: /methods/shortcode/parent/
[`Position`]: /methods/shortcode/position/
[`RenderString`]: /methods/page/renderstring/
[`collections.IsSet`]: /functions/collections/isset/
[`compare.Conditional`]: /functions/compare/conditional/
[`with`]: /functions/go-template/with/
[content management]: /content-management/shortcodes/
[embedded shortcodes]: /shortcodes/
[introduction to templating]: /templates/introduction/
[named or positional]: /content-management/shortcodes/#arguments
[shortcodes]: /content-management/shortcodes/
[standard notation]: /content-management/shortcodes/#standard-notation
[whitespace]: /templates/introduction/#whitespace


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/templates/sitemap.md
---


## Overview

Hugo's embedded sitemap templates conform to v0.9 of the [sitemap protocol][].

With a monolingual project, Hugo generates a sitemap.xml file in the root of the [`publishDir`][] using the [embedded sitemap template][].

With a multilingual project, Hugo generates:

- A sitemap.xml file in the root of each site (language) using the [embedded sitemap template][]
- A sitemap.xml file in the root of the [`publishDir`][] using the [embedded sitemapindex template][]

## Configuration

See [configure sitemap][].

## Override default values

Override the default values for a given page in front matter.

{{< code-toggle file=news.md fm=true >}}
title = 'News'
[sitemap]
  changefreq = 'weekly'
  disable = true
  priority = 0.8
{{</ code-toggle >}}

## Override built-in templates

To override the built-in sitemap.xml template, create a new `layouts/sitemap.xml` file. When ranging through the page collection, access the _change frequency_ and _priority_ with `.Sitemap.ChangeFreq` and `.Sitemap.Priority` respectively.

To override the built-in sitemapindex.xml template, create a new `layouts/sitemapindex.xml` file.

## Disable sitemap generation

You may disable sitemap generation in your project configuration:

{{< code-toggle file=hugo >}}
disableKinds = ['sitemap']
{{</ code-toggle >}}

[`publishDir`]: /configuration/all/#publishdir
[configure sitemap]: /configuration/sitemap/
[embedded sitemap template]: <{{% eturl sitemap %}}>
[embedded sitemapindex template]: <{{% eturl sitemapindex %}}>
[sitemap protocol]: https://www.sitemaps.org/protocol.html


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/templates/types.md
---


## Structure

Create templates in the `layouts` directory in the root of your project.

Although your site may not require each of these templates, the example below is typical for a site of medium complexity.

```tree
layouts/
├── _markup/
│   ├── render-image.html   <-- render hook
│   └── render-link.html    <-- render hook
├── _partials/
│   ├── footer.html
│   └── header.html
├── _shortcodes/
│   ├── audio.html
│   └── video.html
├── books/
│   ├── page.html
│   └── section.html
├── films/
│   ├── view_card.html      <-- content view
│   ├── view_li.html        <-- content view
│   ├── page.html
│   └── section.html
├── baseof.html
├── home.html
├── page.html
├── section.html
├── taxonomy.html
└── term.html
```

Hugo's [template lookup order][] determines the template path, allowing you to create unique templates for any page.

> [!NOTE]
> You must have thorough understanding of the template lookup order when creating templates. Template selection is based on template type, page kind, content type, section, language, and output format.

The purpose of each template type is described below.

## Base

A _base_ template serves as a foundational layout that other templates can build upon. It typically defines the common structural components of your HTML, such as the `html`, `head`, and `body` elements. It also often includes recurring features like headers, footers, navigation, and script inclusions that appear across multiple pages of your site. By defining these common aspects once in a _base_ template, you avoid redundancy, ensure consistency, and simplify the maintenance of your website.

Hugo can apply a _base_ template to the following template types: [home](#home), [page](#page), [section](#section), [taxonomy](#taxonomy), [term](#term), [single](#single), [list](#list), and [all](#all). When Hugo parses any of these template types, it will apply a _base_ template only if the template being parsed meets these specific conditions:

- It must include at least one [`define`][] [action](g).
- It can only contain `define` actions, whitespace, and [template comments][]. No other content is allowed.

> [!NOTE]
> If a template doesn't meet all these criteria, Hugo executes it exactly as provided, without applying a _base_ template.

When Hugo applies a _base_ template, it replaces its [`block`][] actions with content from the corresponding `define` actions found in the template to which the base template is applied.

For example, the _base_ template below calls the [`partial`][] function to include `head`, `header`, and `footer` elements. The `block` action acts as a placeholder, and its content will be replaced by a matching `define` action  from the template to which it is applied.

```go-html-template {file="layouts/baseof.html"}
<!DOCTYPE html>
<html lang="{{ site.Language.Locale }}" dir="{{ or site.Language.Direction `ltr` }}">
<head>
  {{ partial "head.html" . }}
</head>
<body>
  <header>
    {{ partial "header.html" . }}
  </header>
  <main>
    {{ block "main" . }}
      This will be replaced with content from the
      corresponding "define" action found in the template
      to which this base template is applied.
    {{ end }}
  </main>
  <footer>
    {{ partial "footer.html" . }}
  </footer>
</body>
</html>
```

```go-html-template {file="layouts/home.html"}
{{ define "main" }}
  This will replace the content of the "block" action
  found in the base template.
{{ end }}
```

## Home

A _home_ template renders your site's home page.

For example, Hugo applies a _base_ template to the _home_ template below, then renders the page content and a list of the site's regular pages.

```go-html-template {file="layouts/home.html"}
{{ define "main" }}
  {{ .Content }}
  {{ range .Site.RegularPages }}
    <h2><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></h2>
  {{ end }}
{{ end }}
```

{{% include "/_common/filter-sort-group.md" %}}

## Page

A _page_ template renders a regular page.

For example, Hugo applies a _base_ template to the _page_ template below, then renders the page title and page content.

```go-html-template {file="layouts/page.html"}
{{ define "main" }}
  <h1>{{ .Title }}</h1>
  {{ .Content }}
{{ end }}
```

## Section

A _section_ template renders a list of pages within a [section](g).

For example, Hugo applies a _base_ template to the _section_ template below, then renders the page title, page content, and a list of pages in the current section.

```go-html-template {file="layouts/section.html"}
{{ define "main" }}
  <h1>{{ .Title }}</h1>
  {{ .Content }}
  {{ range .Pages }}
    <h2><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></h2>
  {{ end }}
{{ end }}
```

{{% include "/_common/filter-sort-group.md" %}}

## Taxonomy

A _taxonomy_ template renders a list of terms in a [taxonomy](g).

For example, Hugo applies a _base_ template to the _taxonomy_ template below, then renders the page title, page content, and a list of [terms](g) in the current taxonomy.

```go-html-template {file="layouts/taxonomy.html"}
{{ define "main" }}
  <h1>{{ .Title }}</h1>
  {{ .Content }}
  {{ range .Pages }}
    <h2><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></h2>
  {{ end }}
{{ end }}
```

{{% include "/_common/filter-sort-group.md" %}}

Within a _taxonomy_ template, the [`Data`][] object provides these taxonomy-specific methods:

- [`Singular`][taxonomy-singular]
- [`Plural`][taxonomy-plural]
- [`Terms`][]

The `Terms` method returns a [taxonomy object](g), allowing you to call any of its methods including [`Alphabetical`][] and [`ByCount`][]. For example, use the `ByCount` method to render a list of terms sorted by the number of pages associated with each term:

```go-html-template {file="layouts/taxonomy.html"}
{{ define "main" }}
  <h1>{{ .Title }}</h1>
  {{ .Content }}
  {{ range .Data.Terms.ByCount }}
    <h2><a href="{{ .Page.RelPermalink }}">{{ .Page.LinkTitle }}</a> ({{ .Count }})</h2>
  {{ end }}
{{ end }}
```

## Term

A _term_ template renders a list of pages associated with a [term](g).

For example, Hugo applies a _base_ template to the _term_ template below, then renders the page title, page content, and a list of pages associated with the current term.

```go-html-template {file="layouts/term.html"}
{{ define "main" }}
  <h1>{{ .Title }}</h1>
  {{ .Content }}
  {{ range .Pages }}
    <h2><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></h2>
  {{ end }}
{{ end }}
```

{{% include "/_common/filter-sort-group.md" %}}

Within a _term_ template, the [`Data`][] object provides these term-specific methods:

- [`Singular`][term-singular]
- [`Plural`][term-plural]
- [`Term`][]

## Single

A _single_ template is a fallback for a _page_ template. If a _page_ template does not exist, Hugo will look for a _single_ template instead.

For example, Hugo applies a _base_ template to the _single_ template below, then renders the page title and page content.

```go-html-template {file="layouts/single.html"}
{{ define "main" }}
  <h1>{{ .Title }}</h1>
  {{ .Content }}
{{ end }}
```

## List

A _list_ template is a fallback for [home](#home), [section](#section), [taxonomy](#taxonomy), and [term](#term) templates. If one of these template types does not exist, Hugo will look for a _list_ template instead.

For example, Hugo applies a _base_ template to the _list_ template below, then renders the page title, page content, and a list of pages.

```go-html-template {file="layouts/list.html"}
{{ define "main" }}
  <h1>{{ .Title }}</h1>
  {{ .Content }}
  {{ range .Pages }}
    <h2><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></h2>
  {{ end }}
{{ end }}
```

## All

An _all_ template is a fallback for [home](#home), [page](#page), [section](#section), [taxonomy](#taxonomy), [term](#term), [single](#single), and [list](#list) templates. If one of these template types does not exist, Hugo will look for an _all_ template instead.

For example, Hugo applies a _base_ template to the _all_ template below, then conditionally renders a page based on its page kind.

```go-html-template {file="layouts/all.html"}
{{ define "main" }}
  {{ if eq .Kind "home" }}
    {{ .Content }}
    {{ range .Site.RegularPages }}
      <h2><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></h2>
    {{ end }}
  {{ else if eq .Kind "page" }}
    <h1>{{ .Title }}</h1>
    {{ .Content }}
  {{ else if in (slice "section" "taxonomy" "term") .Kind }}
    <h1>{{ .Title }}</h1>
    {{ .Content }}
    {{ range .Pages }}
      <h2><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></h2>
    {{ end }}
  {{ else }}
    {{ errorf "Unsupported page kind: %s" .Kind }}
  {{ end }}
{{ end }}
```

## Partial

A _partial_ template is typically used to render a component of your site, though you may also create _partial_ templates that return values.

For example, the _partial_ template below renders copyright information:

```go-html-template {file="layouts/_partials/footer.html"}
<p>Copyright {{ now.Year }}. All rights reserved.</p>
```

Execute the _partial_ template by calling the [`partial`][] or [`partialCached`][] function, optionally passing context as the second argument:

```go-html-template {file="layouts/baseof.html"}
{{ partial "footer.html" . }}
```

<!-- https://github.com/gohugoio/hugo/pull/13614#issuecomment-2805977008 -->
Unlike other template types, Hugo does not consider the current page kind, content type, logical path, language, or output format when searching for a matching _partial_ template. However, it _does_ apply the same _name_ matching logic it uses for other template types. This means it tries to find the most specific match first, then progressively looks for more general versions if the specific one isn't found.

For example, with this call:

```go-html-template {file="layouts/baseof.html"}
{{ partial "footer.section.de.html" . }}
```

Hugo uses this lookup order to find a matching template:

1. `layouts/_partials/footer.section.de.html`
1. `layouts/_partials/footer.section.html`
1. `layouts/_partials/footer.de.html`
1. `layouts/_partials/footer.html`

A _partial_ template can also be defined inline within another template. However, it's important to note that the template namespace is global; ensuring unique names for these _partial_ templates is necessary to prevent conflicts.

```go-html-template
Value: {{ partial "my-inline-partial.html" . }}

{{ define "_partials/my-inline-partial.html" }}
  {{ $value := 32 }}
  {{ return $value }}
{{ end }}
```

## Content view

A _content view_ template is similar to a _partial_ template, invoked by calling the [`Render`][] method on a `Page` object. Unlike _partial_ templates, _content view_ templates:

- Inherit the context of the current page
- Can target any page kind, content type, logical path, language, or output format
- Can reside at any level within the `layouts` directory

For example, Hugo applies a _base_ template to the _home_ template below, then renders the page content and a card component for each page within the `films` section of your site.

```go-html-template {file="layouts/home.html"}
{{ define "main" }}
  {{ .Content }}
  <ul>
    {{ range where site.RegularPages "Section" "films" }}
      {{ .Render "view_card" }}
    {{ end }}
  </ul>
{{ end }}
```

```go-html-template {file="layouts/films/view_card.html"}
<div class="card">
  <h2><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></h2>
  {{ .Summary }}
</div>
```

In the example above, the content view template's name starts with `view_`. While not strictly required, this naming convention helps distinguish content view templates from other templates within the same directory, improving organization and clarity.

## Render hook

A _render hook_ template overrides the conversion of Markdown to HTML.

For example, the _render hook_ template below adds an anchor link to the right of each heading.

```go-html-template {file="layouts/_markup/render-heading.html"}
<h{{ .Level }} id="{{ .Anchor }}" {{- with .Attributes.class }} class="{{ . }}" {{- end }}>
  {{ .Text }}
  <a href="#{{ .Anchor }}">#</a>
</h{{ .Level }}>
```

Learn more about [render hook templates][].

## Shortcode

A _shortcode_ template is used to render a component of your site. Unlike _partial_ or _content view_ templates, _shortcode_ templates are called from content pages.

For example, the _shortcode_ template below renders an audio element from a [global resource](g).

```go-html-template {file="layouts/_shortcodes/audio.html"}
{{ with resources.Get (.Get "src") }}
  <audio controls preload="auto" src="{{ .RelPermalink }}"></audio>
{{ end }}
```

Then call the shortcode from within markup:

```md {file="content/example.md"}
{{</* audio src=/audio/test.mp3 */>}}
```

Learn more about [shortcode templates][].

## Other

Use other specialized templates to create:

- [Sitemaps][]
- [RSS feeds][]
- [404 error pages][]
- [robots.txt files][]

[404 error pages]: /templates/404/
[RSS feeds]: /templates/rss/
[Sitemaps]: /templates/sitemap/
[`Alphabetical`]: /methods/taxonomy/alphabetical/
[`ByCount`]: /methods/taxonomy/bycount/
[`Data`]: /methods/page/data/
[`Render`]: /methods/page/render/
[`Term`]: /methods/page/data/#term
[`Terms`]: /methods/page/data/#terms
[`block`]: /functions/go-template/block/
[`define`]: /functions/go-template/define/
[`partialCached`]: /functions/partials/includeCached/
[`partial`]: /functions/partials/include/
[render hook templates]: /render-hooks/
[robots.txt files]: /templates/robots/
[shortcode templates]: /templates/shortcode/
[taxonomy-plural]: /methods/page/data/#plural
[taxonomy-singular]: /methods/page/data/#singular
[template comments]: /templates/introduction/#comments
[template lookup order]: /templates/lookup-order/
[term-plural]: /methods/page/data/#plural-1
[term-singular]: /methods/page/data/#singular-1

