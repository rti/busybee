
---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/configuration/all.md
---


## Settings

`archetypeDir`
: (`string`) The designated directory for [archetypes](g). Default is `archetypes`. {{% module-mounts-note %}}

`assetDir`
: (`string`) The designated directory for [global resources](g). Default is `assets`. {{% module-mounts-note %}}

`baseURL`
: (`string`) The absolute URL of your published site including the protocol, host, path, and a trailing slash.

`build`
: See [configure build][].

`buildDrafts`
: (`bool`) Whether to include draft content when building a site. Default is `false`.

`buildExpired`
: (`bool`) Whether to include expired content when building a site. Default is `false`.

`buildFuture`
: (`bool`) Whether to include future content when building a site. Default is `false`.

`cacheDir`
: (`string`) The designated cache directory. See [details](#cache-directory).

`caches`
: See [configure file caches][].

`canonifyURLs`
: (`bool`) See [details][canonical-urls] before enabling this feature. Default is `false`.

`capitalizeListTitles`
: (`bool`) Whether to capitalize automatic list titles. Applicable to section, taxonomy, and term pages. Use the [`titleCaseStyle`](#titlecasestyle) setting to configure capitalization rules. Default is `true`.

`cascade`
: See [configure cascade][].

`cleanDestinationDir`
: (`bool`) Whether to remove files from the [`publishDir`](#publishdir) that do not exist in the [`staticDir`](#staticdir) when building the site. This setting will not take effect if the `staticDir` does not exist. Note that `.gitignore` and `.gitattributes` files, along with directories named `.git`, are always preserved in the `publishDir`. Default is `false`.

`contentDir`
: (`string`) The designated directory for content files. Default is `content`. {{% module-mounts-note %}}

`copyright`
: (`string`) The copyright notice for a site, typically displayed in the footer.

`dataDir`
: (`string`) The designated directory for data files. Default is `data`. {{% module-mounts-note %}}

`defaultContentLanguage`
: (`string`) The projects's [default language](g), conforming to the syntax described in [RFC 5646][].

`defaultContentLanguageInSubdir`
: (`bool`) Whether to publish the default content language to a subdirectory matching the [`defaultContentLanguage`](#defaultcontentlanguage). Default is `false`.

`defaultContentRole`
: {{< new-in 0.153.0 />}}
: (`string`) The project's [default role](g).

`defaultContentRoleInSubdir`
: {{< new-in 0.153.0 />}}
: (`bool`) Whether to publish the default content [role](g) to a subdirectory matching the [`defaultContentRole`](#defaultcontentrole). Default is `false`.

`defaultContentVersion`
: {{< new-in 0.153.0 />}}
: (`string`) The project's [default version](g).

`defaultContentVersionInSubdir`
: {{< new-in 0.153.0 />}}
: (`bool`) Whether to publish the default content version to a subdirectory matching the [`defaultContentVersion`](#defaultcontentversion). Default is `false`.

`defaultOutputFormat`
: (`string`) The default output format for the site. If unspecified, the first available format in the defined order (by weight, then alphabetically) will be used.

`deployment`
: See [configure deployment][].

`disableAliases`
: (`bool`) Whether to disable the generation of HTML redirect files for each path defined in the [`aliases`][aliases_front_matter] front matter field. When `true`, Hugo will not create physical files for [client-side redirection][], but the alias data remains available via the [`Aliases`][aliases_page_method] method on a `Page` object. Default is `false`.

`disableDefaultLanguageRedirect`
: {{< new-in 0.140.0 />}}
: (`bool`) Whether to disable generation of the alias redirect for the default content language. When [`defaultContentLanguageInSubdir`](#defaultcontentlanguageinsubdir) is `true`, this setting prevents the root directory from redirecting to the language subdirectory. Conversely, when `defaultContentLanguageInSubdir` is `false`, this setting prevents the language subdirectory from redirecting to the root directory. This is superseded by the more general [`disableDefaultSiteRedirect`](#disabledefaultsiteredirect) setting. Default is `false`.

`disableDefaultSiteRedirect`
: {{< new-in 0.154.5 />}}
: (`bool`) Whether to disable generation of the alias redirect to the [default site](g). When [`defaultContentLanguageInSubdir`](#defaultcontentlanguageinsubdir), [`defaultContentRoleInSubdir`](#defaultcontentroleinsubdir), or [`defaultContentVersionInSubdir`](#defaultcontentversioninsubdir) is `true`, this prevents the root directory from redirecting to the default site's subdirectory. Conversely, when these are `false`, it prevents the subdirectories from redirecting back to the root. Default is `false`.

`disableHugoGeneratorInject`
: (`bool`) Whether to disable injection of a `<meta name="generator">` tag into the home page. Default is `false`.

`disableKinds`
: (`[]string`) A slice of page [kinds](g) to disable during the build process, any of `404`, `home`, `page`, `robotstxt`, `rss`, `section`, `sitemap`, `taxonomy`, or `term`.

`disableLanguages`
: (`[]string`) A slice of language keys representing the languages to disable during the build process. Although this is functional, consider using the [`disabled`][] key under each language instead.

`disableLiveReload`
: (`bool`) Whether to disable automatic live reloading of the browser window. Default is `false`.

`disablePathToLower`
: (`bool`) Whether to disable transformation of page URLs to lower case. Default is `false`.

`enableEmoji`
: (`bool`) Whether to allow emoji in Markdown. Default is `false`.

`enableGitInfo`
: (`bool`) Whether to retrieve commit metadata from the Git history of your local project and any [modules](g). This enables the [`GitInfo`][] method on a `Page` object. With the default front matter configuration, the [`Lastmod`][] method on a `Page` object returns the Git author date of the last commit for that file. Default is `false`.

`enableMissingTranslationPlaceholders`
: (`bool`) Whether to show a placeholder instead of the default value or an empty string if a translation is missing. Default is `false`.

`enableRobotsTXT`
: (`bool`) Whether to enable generation of a `robots.txt` file. Default is `false`.

`frontmatter`
: See [configure front matter][].

`hasCJKLanguage`
: (`bool`) Whether to automatically detect [CJK](g) languages in content. Affects the values returned by the [`WordCount`][] and [`FuzzyWordCount`][] methods. Default is `false`.

`HTTPCache`
: See [configure HTTP cache][].

`i18nDir`
: (`string`) The designated directory for translation tables. Default is `i18n`. {{% module-mounts-note %}}

`ignoreCache`
: (`bool`) Whether to ignore the configured file caches. Default is `false`.

`ignoreFiles`
: (`[]string`) A slice of [regular expressions](g) used to exclude specific files from a build. These expressions are matched against the absolute file path and apply to files within the `content`, `data`, and `i18n` directories. For more advanced file exclusion options, see the section on [module mounts][].

`ignoreLogs`
: (`[]string`) A slice of message identifiers corresponding to warnings and errors you wish to suppress. See [`erroridf`][] and [`warnidf`][].

`ignoreVendorPaths`
: (`string`) A [glob pattern](g) matching the module paths to exclude from the `_vendor` directory.

`imaging`
: See [configure imaging][].

`languageCode`
: {{<deprecated-in 0.158.0 />}}
: Use [`locale`](#locale) instead.

`languages`
: See [configure languages][].

`layoutDir`
: (`string`) The designated directory for templates. Default is `layouts`. {{% module-mounts-note %}}

{{% include "/_common/configuration/locale.md" %}}

  For a multilingual project, specify this value independently for each language key. See [configure languages][].

`mainSections`
: (`string` or `[]string`) The main sections of a site. If set, the [`MainSections`][] method on the `Site` object returns the given sections, otherwise it returns the section with the most pages.

`markup`
: See [configure markup][].

`mediaTypes`
: See [configure media types][].

`menus`
: See [configure menus][].

`minify`
: See [configure minify][].

`module`
: See [configure modules][].

`newContentEditor`
: (`string`) The editor to use when creating new content.

`noBuildLock`
: (`bool`) Whether to disable creation of the `.hugo_build.lock` file. Default is `false`.

`noChmod`
: (`bool`) Whether to disable synchronization of file permission modes. Default is `false`.

`noTimes`
: (`bool`) Whether to disable synchronization of file modification times. Default is `false`.

`outputFormats`
: See [configure output formats][].

`outputs`
: See [configure outputs][].

`page`
: See [configure page][].

`pagination`
: See [configure pagination][].

`panicOnWarning`
: (`bool`) Whether to panic on the first WARNING. Default is `false`.

`params`
: See [configure params][].

`permalinks`
: See [configure permalinks][].

`pluralizeListTitles`
: (`bool`) Whether to pluralize automatic list titles. Applicable to section pages. Default is `true`.

`printI18nWarnings`
: (`bool`) Whether to log WARNINGs for each missing translation. Default is `false`.

`printPathWarnings`
: (`bool`) Whether to log WARNINGs when Hugo publishes two or more files to the same path. Default is `false`.

`printUnusedTemplates`
: (`bool`) Whether to log WARNINGs for each unused template. Default is `false`.

`privacy`
: See [configure privacy][].

`publishDir`
: (`string`) The designated directory for publishing the site. Default is `public`.

`refLinksErrorLevel`
: (`string`) The logging error level to use when the `ref` and `relref` functions, methods, and shortcodes are unable to resolve a reference to a page. Either `ERROR` or `WARNING`. Any `ERROR` will fail the build. Default is `ERROR`.

`refLinksNotFoundURL`
: (`string`) The URL to return when the `ref` and `relref` functions, methods, and shortcodes are unable to resolve a reference to a page.

`related`
: See [configure related content][].

`relativeURLs`
: (`bool`) See [details][relative-urls] before enabling this feature. Default is `false`.

`removePathAccents`
: (`bool`) Whether to remove [non-spacing marks][] from [composite characters][] in content paths. Default is `false`.

`renderSegments`
: (`[]string`) A slice of [segments](g) to render. If omitted, all segments are rendered. This option is typically set via a command-line flag, such as `hugo build --renderSegments segment1,segment2`. The provided segment names must correspond to those defined in the [`segments`][] configuration.

`resourceDir`
: (`string`) The designated directory for caching output from [asset pipelines](g). Default is `resources`.

`roles`
: See [configure roles][].

`security`
: See [configure security][].

`sectionPagesMenu`
: (`string`) When set, each top-level section will be added to the menu identified by the provided value. See [details][define-automatically].

`segments`
: See [configure segments][].

`server`
: See [configure server][].

`services`
: See [configure services][].

`sitemap`
: See [configure sitemap][].

`staticDir`
: (`string`) The designated directory for static files. Default is `static`. {{% module-mounts-note %}}

`summaryLength`
: (`int`) Applicable to [automatic summaries][], the minimum number of words returned by the [`Summary`][] method on a `Page` object. The `Summary` method will return content truncated at the paragraph boundary closest to the specified `summaryLength`, but at least this minimum number of words. Default is `70`.

`taxonomies`
: See [configure taxonomies][].

`templateMetrics`
: (`bool`) Whether to print template execution metrics to the console. Default is `false`. See [details][template-metrics].

`templateMetricsHints`
: (`bool`) Whether to print template execution improvement hints to the console. Applicable when `templateMetrics` is `true`. Default is `false`. See [details][template-metrics].

`theme`
: (`string` or `[]string`) The [theme](g) to use. Multiple themes can be listed, with precedence given from left to right. See [details][].

`themesDir`
: (`string`) The designated directory for themes. Default is `themes`.

`timeout`
: (`string`) The timeout for generating page content, either as a [duration][] or in seconds. This timeout is used to prevent infinite recursion during content generation. You may need to increase this value if your pages take a long time to generate, for example, due to extensive image processing or reliance on remote content. Default is `60s`.

`timeZone`
: (`string`) The time zone used to parse dates without time zone offsets, including front matter date fields and values passed to the [`time.AsTime`][] and [`time.Format`][] functions. The list of valid values may be system dependent, but should include `UTC`, `Local`, and any location in the [IANA Time Zone Database][]. For example, `America/Los_Angeles` and `Europe/Oslo` are valid time zones.

`title`
: (`string`) The site title.

`titleCaseStyle`
: (`string`) The capitalization rules to follow when Hugo automatically generates a section title, or when using the [`strings.Title`][] function. One of `ap`, `chicago`, `go`, `firstupper`, or `none`. Default is `ap`. See [details](#title-case-style).

`uglyurls`
: See [configure ugly URLs][].

`versions`
: See [configure versions][].

## Cache directory

Hugo's file cache directory is configurable via the [`cacheDir`](#cachedir) setting or the `HUGO_CACHEDIR` environment variable. If neither is set, Hugo will use, in order of preference:

1. If running on Netlify: `/opt/build/cache/hugo_cache/`. This means that if you run your builds on Netlify, all caches configured with `:cacheDir` will be saved and restored on the next build. For other [CI/CD](g) platforms, please read their documentation. For a CircleCI example, see [this configuration][].
1. In a `hugo_cache` directory below the OS user cache directory as defined by Go's [`os.UserCacheDir`][] function. On Unix systems, per the [XDG base directory specification][], this is `$XDG_CACHE_HOME` if non-empty, else `$HOME/.cache`. On MacOS, this is `$HOME/Library/Caches`. On Windows, this is`%LocalAppData%`. On Plan 9, this is `$home/lib/cache`.
1. In a  `hugo_cache_$USER` directory below the OS temp dir.

To determine the current `cacheDir`:

```sh
hugo config | grep cachedir
```

## Title case style

Hugo's [`titleCaseStyle`](#titlecasestyle) setting governs capitalization for automatically generated section titles and the [`strings.Title`][] function. By default, it follows the capitalization rules published in the Associated Press Stylebook. Change this setting to use other capitalization rules.

`ap`
: Use the capitalization rules published in the [Associated Press Stylebook][]. This is the default.

`chicago`
: Use the capitalization rules published in the [Chicago Manual of Style][].

`go`
: Capitalize the first letter of every word.

`firstupper`
: Capitalize the first letter of the first word.

`none`
: Disable transformation of automatic section titles, and disable the transformation performed by the `strings.Title` function. This is useful if you would prefer to manually capitalize section titles as needed, and to bypass opinionated theme usage of the `strings.Title` function.

## Localized settings

Some configuration settings, such as menus and custom parameters, can be defined separately for each language. See [configure languages][].

[Associated Press Stylebook]: https://www.apstylebook.com/
[Chicago Manual of Style]: https://www.chicagomanualofstyle.org/home.html
[IANA Time Zone Database]: https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
[RFC 5646]: https://datatracker.ietf.org/doc/html/rfc5646#section-2.1
[XDG base directory specification]: https://specifications.freedesktop.org/basedir-spec/latest/
[`FuzzyWordCount`]: /methods/page/fuzzywordcount/
[`GitInfo`]: /methods/page/gitinfo/
[`Lastmod`]: /methods/page/lastmod/
[`MainSections`]: /methods/site/mainsections/
[`Summary`]: /methods/page/summary/
[`WordCount`]: /methods/page/wordcount/
[`disabled`]: /configuration/languages/#disabled
[`erroridf`]: /functions/fmt/erroridf/
[`os.UserCacheDir`]: https://pkg.go.dev/os#UserCacheDir
[`segments`]: /configuration/segments/
[`strings.Title`]: /functions/strings/title/
[`time.AsTime`]: /functions/time/astime/
[`time.Format`]: /functions/time/format/
[`warnidf`]: /functions/fmt/warnidf/
[aliases_front_matter]: /content-management/front-matter/#aliases
[aliases_page_method]: /methods/page/aliases/
[automatic summaries]: /content-management/summaries/#automatic-summary
[canonical-urls]: /content-management/urls/#canonical-urls
[client-side redirection]: /content-management/urls/#client-side-redirection
[composite characters]: https://en.wikipedia.org/wiki/Precomposed_character
[configure HTTP cache]: /configuration/http-cache/
[configure build]: /configuration/build/
[configure cascade]: /configuration/cascade/
[configure deployment]: /configuration/deployment/
[configure file caches]: /configuration/caches/
[configure front matter]: /configuration/front-matter/
[configure imaging]: /configuration/imaging/
[configure languages]: /configuration/languages/
[configure markup]: /configuration/markup/
[configure media types]: /configuration/media-types/
[configure menus]: /configuration/menus/
[configure minify]: /configuration/minify/
[configure modules]: /configuration/module/
[configure output formats]: /configuration/output-formats/
[configure outputs]: /configuration/outputs/
[configure page]: /configuration/page/
[configure pagination]: /configuration/pagination/
[configure params]: /configuration/params/
[configure permalinks]: /configuration/permalinks/
[configure privacy]: /configuration/privacy/
[configure related content]: /configuration/related-content/
[configure roles]: /configuration/roles/
[configure security]: /configuration/security/
[configure segments]: /configuration/segments/
[configure server]: /configuration/server/
[configure services]: /configuration/services/
[configure sitemap]: /configuration/sitemap/
[configure taxonomies]: /configuration/taxonomies/
[configure ugly URLs]: /configuration/ugly-urls/
[configure versions]: /configuration/versions/
[define-automatically]: /content-management/menus/#define-automatically
[details]: /hugo-modules/theme-components/
[duration]: https://pkg.go.dev/time#Duration
[module mounts]: /configuration/module/#mounts
[non-spacing marks]: https://www.compart.com/en/unicode/category/Mn
[relative-urls]: /content-management/urls/#relative-urls
[template-metrics]: /troubleshooting/performance/#template-metrics
[this configuration]: https://github.com/bep/hugo-sass-test/blob/6c3960a8f4b90e8938228688bc49bdcdd6b2d99e/.circleci/config.yml


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/configuration/build.md
---


This is the default configuration:

{{< code-toggle config=build />}}

`buildStats`
: See the [build stats](#build-stats) section below.

`cachebusters`
: See the [cache busters](#cache-busters) section below.

`noJSConfigInAssets`
: (`bool`) Whether to disable writing a `jsconfig.json` in your `assets` directory with mapping of imports from running [js.Build][]. This file is intended to help with intellisense/navigation inside code editors such as [VS Code][]. Note that if you do not use `js.Build`, no file will be written.

`useResourceCacheWhen`
: (`string`) When to use the resource file cache, one of `never`, `fallback`, or `always`. Applicable when transpiling Sass to CSS. Default is `fallback`.

## Cache busters

The `build.cachebusters` setting was added to support development using Tailwind 3.x's JIT compiler where a `build` configuration may look like this:

<!-- markdownlint-disable MD049 -->
{{< code-toggle file=hugo >}}
[build]
  [build.buildStats]
    enable = true
  [[build.cachebusters]]
    source = 'assets/watching/hugo_stats\.json'
    target = 'styles\.css'
  [[build.cachebusters]]
    source = '(postcss|tailwind)\.config\.js'
    target = 'css'
  [[build.cachebusters]]
    source = 'assets/.*\.(js|ts|jsx|tsx)'
    target = 'js'
  [[build.cachebusters]]
    source = 'assets/.*\.(.*)$'
    target = '$1'
{{< /code-toggle >}}
<!-- markdownlint-enable MD049 -->

When `buildStats` is enabled, Hugo writes a `hugo_stats.json` file on each build with HTML classes etc. that's used in the rendered output. Changes to this file will trigger a rebuild of the `styles.css` file. You also need to add `hugo_stats.json` to Hugo's server watcher. See [Hugo Starter Tailwind Basic][] for a running example.

`source`
: (`string`) A [regular expression](g) matching file(s) relative to one of the virtual component directories in Hugo, typically `assets/...`.

`target`
: (`string`) A [regular expression](g) matching the keys in the resource cache that should be expired when `source` changes. You can use the matching regexp groups from `source` in the expression, e.g. `$1`.

## Build stats

{{< code-toggle config=build.buildStats />}}

`enable`
: (`bool`) Whether to create a `hugo_stats.json` file in the root of your project. This file contains arrays of the `class` attributes, `id` attributes, and tags of every HTML element within your published site. Use this file as data source when [removing unused CSS][] from your site. This process is also known as pruning, purging, or tree shaking. Default is `false`.

`disableIDs`
: (`bool`) Whether to exclude `id` attributes. Default is `false`.

`disableTags`
: (`bool`) Whether to exclude element tags. Default is `false`.

`disableClasses`
: (`bool`) Whether to exclude `class` attributes. Default is `false`.

> [!NOTE]
> Given that CSS purging is typically limited to production builds, place the `buildStats` object below [`config/production`][].
>
> Built for speed, there may be "false positive" detections (e.g., HTML elements that are not HTML elements) while parsing the published site. These "false positives" are infrequent and inconsequential.

Due to the nature of partial server builds, new HTML entities are added while the server is running, but old values will not be removed until you restart the server or run `hugo build`.

[Hugo Starter Tailwind Basic]: https://github.com/bep/hugo-starter-tailwind-basic
[VS Code]: https://code.visualstudio.com/
[`config/production`]: /configuration/introduction/#configuration-directory
[js.Build]: /functions/js/build/
[removing unused CSS]: /functions/resources/postprocess/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/configuration/caches.md
---


This is the default configuration:

{{< code-toggle config=caches />}}

## Purpose

Hugo uses file caches to store data on disk, avoiding repeated operations within the same build and persisting data from one build to the next.

`assets`
: Caches processed CSS and Sass resources.

`getresource`
: Caches files fetched from remote URLs via the [`resources.GetRemote`][] function.

`images`
: Caches processed images.

`misc`
: Caches miscellaneous data.

`modulegitinfo`
: Caches Git information for modules.

`modulequeries`
: Caches the results of module resolution queries.

`modules`
: Caches downloaded modules.

## Keys

`dir`
: (`string`) The absolute file system path where Hugo stores the cached files. You can begin the path with the `:cacheDir` or `:resourceDir` [tokens](#tokens) to anchor the cache to specific system or project locations.

`maxAge`
: (`string`) The duration a cached entry remains valid before being evicted, expressed as a [duration](g). A value of `0` disables the cache for that key, and a value of `-1` means the cache entry never expires. Default is `-1`.

## Tokens

`:cacheDir`
: (`string`) The designated cache directory. See [details][cachedir].

`:project`
: (`string`) The base directory name of the current Hugo project. This ensures isolated file caches for each project, preventing the `hugo build --gc` command from affecting other projects on the same machine.

`:resourceDir`
: (`string`) The designated directory for caching output from [asset pipelines](g). See [details][resourcedir].

## Garbage collection

As you modify your site or change your configuration, cached files from previous builds may remain on disk, consuming unnecessary space. Use the `hugo build --gc` command to remove these expired or unused entries from the file cache.

[`resources.GetRemote`]: /functions/resources/getremote/
[cachedir]: /configuration/all/#cachedir
[resourcedir]: /configuration/all/#resourcedir


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/configuration/cascade.md
---


You can configure your site to cascade front matter values to the home page and any of its descendants. However, this cascading will be prevented if the descendant already defines the field, or if a closer ancestor [branch](g) has already cascaded a value for the same field through its front matter's `cascade` key.

> [!NOTE]
> You can also configure cascading behavior within a page's front matter. See [details][].

For example, to cascade the `color` page parameter to all pages:

{{< code-toggle file=hugo >}}
[cascade.params]
color = 'red'
{{< /code-toggle >}}

## Target

<!-- TODO
We deprecated the `_target` front matter key in favor of `target` in v0.156.0 on 2026-02-17. Remove footnote #1 somewhere after v0.171.0, 15 minor releases
after deprecation.
-->

The `target` key accepts a [page matcher](g) to limit cascaded values to a subset of pages.[^1] If a target is omitted, values cascade to all pages.

{{% include "/_common/configuration/page-matcher.md" %}}

For example, to cascade the `color` page parameter to the `articles` section and its descendants, but only for the English (`en`) and German (`de`) language sites:

{{< code-toggle file=hugo >}}
[cascade.params]
color = 'red'
[cascade.target]
path = '{/articles,/articles/**}'
[cascade.target.sites.matrix]
languages = '{en,de}'
{{< /code-toggle >}}

## Array

Define an array of cascade maps to apply different values to different targets. For example:

{{< code-toggle file=hugo >}}
[[cascade]]
[cascade.params]
color = 'red'
[cascade.target]
path = '{/articles,/articles/**}'
[[cascade]]
[cascade.params]
color = 'blue'
[cascade.target]
path = '{/tutorials,/tutorials/**}'
{{< /code-toggle >}}

[^1]: The `_target` alias for `target` is deprecated and will be removed in a future release.

[details]: /content-management/front-matter/#cascade-1


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/configuration/content-types.md
---


{{< new-in 0.144.0 />}}

Hugo supports six [content formats](g):

{{% include "/_common/content-format-table.md" %}}

These can be used as either page content or [page resources](g). When used as page resources, their [resource type](g) is `page`.

Consider this example of a [page bundle](g):

```tree
content/
└── example/
    ├── index.md  <-- content
    ├── a.adoc    <-- resource (resource type: page)
    ├── b.html    <-- resource (resource type: page)
    ├── c.md      <-- resource (resource type: page)
    ├── d.org     <-- resource (resource type: page)
    ├── e.pdc     <-- resource (resource type: page)
    ├── f.rst     <-- resource (resource type: page)
    ├── g.jpg     <-- resource (resource type: image)
    └── h.png     <-- resource (resource type: image)
```

The `index.md` file is the page's content, while the other files are page resources. Files `a` through `f` are of resource type `page`, while `g` and `h` are of resource type `image`.

When you build a site, Hugo does not publish page resources having a resource type of `page`. For example, this is the result of building the site above:

```tree
public/
├── example/
│   ├── g.jpg
│   ├── h.png
│   └── index.html
└── index.html
```

The default behavior is appropriate in most cases. Given that page resources containing markup are typically intended for inclusion in the main content, publishing them independently is generally undesirable.

The default behavior is determined by the `contentTypes` configuration:

{{< code-toggle config=contentTypes />}}

In this default configuration, page resources with those media types will have a resource type of `page`, and will not be automatically published. To change the resource type assignment from `page` to `text` for a given media type, remove the corresponding entry from the list.

For example, to set the resource type of `text/html` files to `text`, thereby enabling automatic publication, remove the `text/html` entry:

{{< code-toggle file=hugo >}}
contentTypes:
  text/asciidoc: {}
  text/markdown: {}
  text/org: {}
  text/pandoc: {}
  text/rst: {}
{{< /code-toggle >}}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/configuration/deployment.md
---


> [!NOTE]
> This configuration is only relevant when running `hugo deploy`. See [details][hugo deploy].

## Top-level settings

These settings control the overall behavior of the deployment process. This is the default configuration:

{{< code-toggle file=hugo config=deployment />}}

`confirm`
: (`bool`) Whether to prompt for confirmation before deploying. Default is `false`.

`dryRun`
: (`bool`) Whether to simulate the deployment without any remote changes. Default is `false`.

`force`
: (`bool`) Whether to re-upload all files. Default is `false`.

`invalidateCDN`
: (`bool`) Whether to invalidate the CDN cache listed in the deployment target. Default is `true`.

`maxDeletes`
: (`int`) The maximum number of files to delete, or `-1` to disable. Default is `256`.

`matchers`
: (`[]*Matcher`) A slice of [matchers](#matchers-1).

`order`
: (`[]string`) An ordered slice of [regular expressions](g) that determines upload priority (left to right). Files not matching any expression are uploaded last in an arbitrary order.

`target`
: (`string`) The target deployment [`name`](#name). Defaults to the first target.

`targets`
: (`[]*Target`) A slice of [targets](#targets-1).

`workers`
: (`int`) The number of concurrent workers to use when uploading files. Default is `10`.

## Targets

A target represents a deployment target such as "staging" or "production".

`cloudFrontDistributionID`
: (`string`) The CloudFront Distribution ID, applicable if you are using the Amazon Web Services CloudFront CDN. Hugo will invalidate the CDN when deploying this target.

`exclude`
: (`string`) A [glob pattern](g) matching files to exclude when deploying to this target. Local files failing the include/exclude filters are not uploaded, and remote files failing these filters are not deleted.

`googleCloudCDNOrigin`
: (`string`) The Google Cloud project and CDN origin to invalidate when deploying this target, specified as `<project>/<origin>`.

`include`
: (`string`) A [glob pattern](g) matching files to include when deploying to this target. Local files failing the include/exclude filters are not uploaded, and remote files failing these filters are not deleted.

`name`
: (`string`) An arbitrary name for this target.

`stripIndexHTML`
: (`bool`) Whether to map files named `<dir>/index.html` to `<dir>` on the remote (except for the root `index.html`). This is useful for key-value cloud storage (e.g., Amazon S3, Google Cloud Storage, Azure Blob Storage) to align canonical URLs with object keys. Default is `false`.

`url`
: (`string`) The [destination URL](#destination-urls) for deployment.

## Matchers

A Matcher represents a configuration to be applied to files whose paths match
the specified pattern.

`cacheControl`
: (`string`) The caching attributes to use when serving the blob. See [details][cacheControl].

`contentEncoding`
: (`string`) The encoding used for the blob's content, if any. See [details][contentEncoding].

`contentType`
: (`string`) The media type of the blob being written. See [details][contentType].

`force`
: (`bool`) Whether matching files should be re-uploaded. Useful when other route-determined metadata (e.g., `contentType`) has changed. Default is `false`.

`gzip`
: (`bool`) Whether the file should be gzipped before upload. If so, the `ContentEncoding` field will automatically be set to `gzip`. Default is `false`.

`pattern`
: (`string`) A [regular expression](g) used to match paths. Paths are converted to use forward slashes (`/`) before matching.

## Destination URLs

Service|URL example
:--|:--
Amazon Simple Storage Service (S3)|`s3://my-bucket?region=us-west-1`
Azure Blob Storage|`azblob://my-container`
Google Cloud Storage (GCS)|`gs://my-bucket`

With Google Cloud Storage you can target a subdirectory:

```text
gs://my-bucket?prefix=a/subdirectory
```

You can also to deploy to storage servers compatible with Amazon S3 such as:

- [Ceph][]
- [MinIO][]
- [SeaweedFS][]

For example, the `url` for a MinIO deployment target might resemble this:

```text
s3://my-bucket?endpoint=https://my.minio.instance&awssdk=v2&use_path_style=true&disable_https=false
```

## Example

{{< code-toggle file=hugo >}}
[deployment]
  order = ['.jpg$', '.gif$']
  [[deployment.matchers]]
    cacheControl = 'max-age=31536000, no-transform, public'
    gzip = true
    pattern = '^.+\.(js|css|svg|ttf)$'
  [[deployment.matchers]]
    cacheControl = 'max-age=31536000, no-transform, public'
    gzip = false
    pattern = '^.+\.(png|jpg)$'
  [[deployment.matchers]]
    contentType = 'application/xml'
    gzip = true
    pattern = '^sitemap\.xml$'
  [[deployment.matchers]]
    gzip = true
    pattern = '^.+\.(html|xml|json)$'
  [[deployment.targets]]
    url = 's3://my_production_bucket?region=us-west-1'
    cloudFrontDistributionID = 'E1234567890ABCDEF0'
    exclude = '**.{heic,psd}'
    name = 'production'
  [[deployment.targets]]
    url = 's3://my_staging_bucket?region=us-west-1'
    exclude = '**.{heic,psd}'
    name = 'staging'
{{< /code-toggle >}}

[Ceph]: https://ceph.com/
[MinIO]: https://www.minio.io/
[SeaweedFS]: https://github.com/chrislusf/seaweedfs
[cacheControl]: https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Cache-Control
[contentEncoding]: https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Encoding
[contentType]: https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Type
[hugo deploy]: /host-and-deploy/deploy-with-hugo-deploy/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/configuration/front-matter.md
---


## Dates

There are four methods on a `Page` object that return a date.

Method|Description
:--|:--
[`Date`][]|Returns the date of the given page.
[`ExpiryDate`][]|Returns the expiry date of the given page.
[`Lastmod`][]|Returns the last modification date of the given page.
[`PublishDate`][]|Returns the publish date of the given page.

Hugo determines the values to return based on this configuration:

{{< code-toggle config=frontmatter />}}

The `ExpiryDate` method, for example, returns the `expirydate` value if it exists, otherwise it returns `unpublishdate`.

You can also use custom date parameters:

{{< code-toggle file=hugo >}}
[frontmatter]
date = ["myDate", "date"]
{{< /code-toggle >}}

In the example above, the `Date` method returns the `myDate` value if it exists, otherwise it returns `date`.

To fall back to the default sequence of dates, use the `:default` token:

{{< code-toggle file=hugo >}}
[frontmatter]
date = ["myDate", ":default"]
{{< /code-toggle >}}

In the example above, the `Date` method returns the `myDate` value if it exists, otherwise it returns the first valid date from `date`, `publishdate`, `pubdate`, `published`, `lastmod`, and `modified`.

## Aliases

Some of the front matter fields have aliases.

Front matter field|Aliases
:--|:--
`expiryDate`|`unpublishdate`
`lastmod`|`modified`
`publishDate`|`pubdate`, `published`

The default front matter configuration includes these aliases.

## Tokens

Hugo provides the following [tokens](g) to help you configure your front matter:

`:default`
: The default ordered sequence of date fields.

`:fileModTime`
: The file's last modification timestamp.

`:filename`
: Extracts the date from the file name, provided the file name begins with a date in one of the following formats:

  - `YYYY-MM-DD`
  - `YYYY-MM-DD-HH-MM-SS` {{< new-in 0.148.0 />}}

  Within the `YYYY-MM-DD-HH-MM-SS` format, the date and time values may be separated by any character including a space (e.g., `2025-02-01T14-30-00`).

  Hugo resolves the extracted date to the [`timeZone`][] defined in your project configuration, falling back to the system time zone. Hugo also derives the page [`slug`][] from the remaining file name, unless the page already defines a `slug` in its front matter.

  Slug inference only occurs when `:filename` is the winning date source. If an earlier entry in the list provides a valid date, Hugo skips `:filename` entirely. For example, with `date = ["date", ":filename"]`, a page that defines `date` in its front matter will use that value, and the slug will not be inferred from the file name.

  For example, if you name your file `2025-02-01-article.md`, Hugo will set the date to `2025-02-01` and the slug to `article`.

`:git`
: The Git author date for the file's last revision. To enable access to the Git author date, set [`enableGitInfo`][] to `true`.

## Example

Consider this project configuration:

{{< code-toggle file=hugo >}}
[frontmatter]
date = [':filename', ':default']
publishDate = [':filename', ':default']
lastmod = ['lastmod', ':fileModTime']
{{< /code-toggle >}}

To determine `date` and `publishDate`, Hugo tries to extract the value from the file name, falling back to the default ordered sequence of date fields.

To determine `lastmod`, Hugo looks for a `lastmod` field in front matter, falling back to the file's last modification timestamp.

[`Date`]: /methods/page/date/
[`ExpiryDate`]: /methods/page/expirydate/
[`Lastmod`]: /methods/page/lastmod/
[`PublishDate`]: /methods/page/publishdate/
[`enableGitInfo`]: /configuration/all/#enablegitinfo
[`slug`]: /content-management/front-matter/#slug
[`timeZone`]: /configuration/all/#timezone


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/configuration/http-cache.md
---


> [!NOTE]
> This configuration is only relevant when using the [`resources.GetRemote`][] function.

## Layered caching

Hugo employs a layered caching system.

```goat {.w-40}
 .-----------.
|  dynacache  |
 '-----+-----'
       |
       v
 .----------.
| HTTP cache |
 '-----+----'
       |
       v
 .----------.
| file cache |
 '-----+----'
```

Dynacache
: An in-memory cache employing a Least Recently Used (LRU) eviction policy. Entries are removed from the cache when changes occur, when they match [cache-busting][] patterns, or under low-memory conditions.

HTTP Cache
: An HTTP cache for remote resources as specified in [RFC 9111][]. Optimal performance is achieved when resources include appropriate HTTP cache headers. The HTTP cache utilizes the file cache for storage and retrieval of cached resources.

File cache
: See [configure file caches][].

The HTTP cache involves two key aspects: determining which content to cache (the caching process itself) and defining the frequency with which to check for updates (the polling strategy).

## HTTP caching

The HTTP cache behavior is defined for a configured set of resources. Stale resources will be refreshed from the file cache, even if their configured Time-To-Live (TTL) has not expired. If HTTP caching is disabled for a resource, Hugo will bypass the cache and access the file directly.

This is the default configuration for HTTP caching:

{{< code-toggle config=HTTPCache />}}

`respectCacheControlNoStoreInRequest`
: {{< new-in 0.151.0 />}}
: (`bool`) Whether to respect the `no-store` directive in the server's `Cache-Control` request header when fetching remote resources via the [`resources.GetRemote`][] function. Default is `true`.

`respectCacheControlNoStoreInResponse`
: {{< new-in 0.151.0 />}}
: (`bool`) Whether to respect the `no-store` directive in the server's `Cache-Control` response header when fetching remote resources via the [`resources.GetRemote`][] function. Default is `false`.

`cache.for.excludes`
: (`[]string`) A slice of [glob patterns](g) to exclude from caching. In its default configuration HTTP caching excludes all files.

`cache.for.includes`
: (`[]string`) A slice of [glob patterns](g) to cache.

`polls`
: (`[]PollConfig`) A slice of polling configurations.

`polls.disable`
: (`bool`) Whether to disable polling for this configuration. Default is `true`.

`polls.high`
: (`string`) The maximum polling interval expressed as a [duration](g). This is used when the resource is considered stable. Default is `0s`.

`polls.low`
: (`string`) The minimum polling interval expressed as a [duration](g). This is used after a recent change and gradually increases towards `polls.high`. Default is `0s`.

`polls.for.excludes`
: (`[]string`) A slice of [glob patterns](g) to exclude from polling for this configuration.

`polls.for.includes`
: (`[]string`) A slice of [glob patterns](g) to include in polling for this configuration.

## HTTP polling

Polling is used in watch mode (e.g., `hugo server`) to detect changes in remote resources. Polling can be enabled even if HTTP caching is disabled. Detected changes trigger a rebuild of pages using the affected resource. Polling can be disabled for specific resources, typically those known to be static.

The default configuration disables everything:

{{< code-toggle file=hugo >}}
[[HTTPCache.polls]]
disable = true
high = '0s'
low = '0s'
[HTTPCache.polls.for]
includes = ['**']
excludes = []
{{< /code-toggle >}}

`polls`
: (`[]PollConfig`) A slice of polling configurations.

`polls.disable`
: (`bool`) Whether to disable polling for this configuration. Default is `true`.

`polls.high`
: (`string`) The maximum polling interval expressed as a [duration](g). This is used when the resource is considered stable. Default is `0s`.

`polls.low`
: (`string`) The minimum polling interval expressed as a [duration](g). This is used after a recent change and gradually increases towards `polls.high`. Default is `0s`.

`polls.for.excludes`
: (`[]string`) A list of [glob patterns](g) to exclude from polling for this configuration.

`polls.for.includes`
: (`[]string`) A list of [glob patterns](g) to include in polling for this configuration.

## Behavior

Polling and HTTP caching interact as follows:

- With polling enabled, rebuilds are triggered only by actual changes, detected via `eTag` changes (Hugo generates an MD5 hash if the server doesn't provide one).
- If polling is enabled but HTTP caching is disabled, the remote is checked for changes only after the file cache's TTL expires (e.g., a `maxAge` of `10h` with a `1s` polling interval is inefficient).
- If both polling and HTTP caching are enabled, changes are checked for even before the file cache's TTL expires. Cached `eTag` and `last-modified` values are sent in `if-none-match` and `if-modified-since` headers, respectively, and a cached response is returned on HTTP [304][].

[304]: https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/304
[RFC 9111]: https://datatracker.ietf.org/doc/html/rfc9111
[`resources.GetRemote`]: /functions/resources/getremote/
[cache-busting]: /configuration/build/#cache-busters
[configure file caches]: /configuration/caches/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/configuration/imaging.md
---


These are the default settings for processing images:

{{< code-toggle config=imaging />}}

## Top-level settings

These settings apply to all image formats.

`anchor`
: (`string`) The focal point used when cropping or filling an image. Valid case-insensitive options include `TopLeft`, `Top`, `TopRight`, `Left`, `Center`, `Right`, `BottomLeft`, `Bottom`, `BottomRight`, or `Smart`. The `Smart` option utilizes the [`muesli/smartcrop`][] package to identify the most interesting area of the image. Default is `smart`.

`bgColor`
: (`string`) The background color used when converting transparent images to formats that do not support transparency, such as PNG to JPEG. This color also fills the empty space created when rotating an image by a non-orthogonal angle if the space is not transparent and a background color is not specified in the processing specification. The value must be an RGB [hexadecimal color][]. Default is `#ffffff`.

`compression`
: {{< deprecated-in 0.163.0 />}}
: Use the format-specific `compression` setting instead, applicable to [AVIF](#avif) and [WebP](#webp) images.

`hint`
: {{< deprecated-in 0.163.0 />}}
: Use the format-specific `hint` setting instead, applicable to [AVIF](#avif) and [WebP](#webp) images.

`quality`
: {{< deprecated-in 0.163.0 />}}
: Use the format-specific `quality` setting instead, applicable to [AVIF](#avif), [JPEG](#jpeg), and [WebP](#webp) images.

`resampleFilter`
: (`string`) The algorithm used to calculate new pixels when resizing, fitting, or filling an image. Common case-insensitive options include `box`, `lanczos`, `catmullRom`, `mitchellNetravali`, `linear`, or `nearestNeighbor`. Default is `box`.

  Filter|Description
  :--|:--
  `box`|Simple and fast averaging filter appropriate for downscaling
  `lanczos`|High-quality resampling filter for photographic images yielding sharp results
  `catmullRom`|Sharp cubic filter that is faster than the Lanczos filter while providing similar results
  `mitchellNetravali`|Cubic filter that produces smoother results with less ringing artifacts than CatmullRom
  `linear`|Bilinear resampling filter, produces smooth output, faster than cubic filters
  `nearestNeighbor`|Fastest resampling filter, no antialiasing

  Refer to the [source documentation][] for a complete list of available resampling filters. If you wish to improve image quality at the expense of performance, you may wish to experiment with the alternative filters.

## AVIF

{{< new-in 0.162.0 />}}

These settings apply when encoding AVIF images.

> [!NOTE]
> When exporting HDR AVIF images from Lightroom, in the Export dialog under File Settings, uncheck Maximize Compatibility to improve Hugo's AVIF decoding speed.

> [!NOTE]
> Encoding animated images to AVIF produces a single-frame (static) image. Converting an animated AVIF to another format such as GIF works as expected.

{{< code-toggle config=imaging.avif />}}

`compression`
: {{< new-in 0.163.0 />}}
: (`string`) The encoding strategy. Options are `lossy` or `lossless`. Default is `lossy`.

`encoderSpeed`
: (`int`) The encoder speed. Expressed as a whole number from `1` to `10`, inclusive, equivalent to the `-s` flag for the [`avifenc`][] CLI. Lower numbers reduce file size at the cost of build time. At typical web image sizes, quality is indistinguishable across settings. Values below `5` may cause significantly longer build times. Default is `10`.

`hint`
: {{< new-in 0.163.0 />}}
: (`string`) The content hint. Valid options include `drawing`, `icon`, `photo`, `picture`, or `text`. Hugo uses the `4:2:0` chroma subsampling format with `photo` and `picture`, and `4:4:4` with the remaining options. Default is `photo`.

  Value|Example
  :--|:--
  `drawing`|Hand or line drawing with high-contrast details
  `icon`|Small colorful image
  `photo`|Outdoor photograph with natural lighting
  `picture`|Indoor photograph such as a portrait
  `text`|Image that is primarily text

`quality`
: {{< new-in 0.163.0 />}}
: (`int`) The visual fidelity when using `lossy` compression. Expressed as a whole number from `1` to `100`, inclusive. Lower numbers prioritize smaller file size, while higher numbers prioritize visual clarity. Default is `60`. Quality values are encoder-specific and not directly comparable across formats; a value of `60` for AVIF is perceptually similar to `75` for JPEG.

## JPEG

{{< new-in 0.163.0 />}}

These settings apply when encoding JPEG images.

{{< code-toggle config=imaging.jpeg />}}

`quality`
: (`int`) The visual fidelity. Expressed as a whole number from `1` to `100`, inclusive. Lower numbers prioritize smaller file size, while higher numbers prioritize visual clarity. Default is `75`.

## WebP

{{< new-in 0.155.0 />}}

These settings apply when encoding WebP images.

{{< code-toggle config=imaging.webp />}}

`compression`
: {{< new-in 0.163.0 />}}
: (`string`) The encoding strategy. Options are `lossy` or `lossless`. Default is `lossy`.

`hint`
: (`string`) The content hint, equivalent to the `-preset` flag for the [`cwebp`][] CLI. Valid options include `drawing`, `icon`, `photo`, `picture`, or `text`. Default is `photo`.

  Value|Example
  :--|:--
  `drawing`|Hand or line drawing with high-contrast details
  `icon`|Small colorful image
  `photo`|Outdoor photograph with natural lighting
  `picture`|Indoor photograph such as a portrait
  `text`|Image that is primarily text

`method`
: (`int`) The effort level of the compression algorithm. Expressed as a whole number from `0` to `6`, inclusive, equivalent to the `-m` flag for the [`cwebp`][] CLI. Lower numbers prioritize processing speed, while higher numbers prioritize compression efficiency and image quality. Default is `2`.

`quality`
: {{< new-in 0.163.0 />}}
: (`int`) The visual fidelity when using `lossy` compression. Expressed as a whole number from `1` to `100`, inclusive. Lower numbers prioritize smaller file size, while higher numbers prioritize visual clarity. Default is `75`.

`useSharpYuv`
: (`bool`) The conversion method used for RGB-to-YUV encoding, equivalent to the `-sharp_yuv` flag for the [`cwebp`][] CLI. Enabling this prioritizes image sharpness at the expense of processing speed. Default is `false`.

## Exif method

{{< deprecated-in 0.155.0 >}}
Use the [`Meta`](#meta-method) method instead.
{{< /deprecated-in >}}

## Meta method

{{< new-in 0.155.0 />}}

The following parameters allow you to control how Hugo extracts and filters metadata when using the [`Meta`][] method, helping you balance data granularity with build performance.

`fields`
: (`[]string`) A [glob slice](g) matching the fields to include when extracting metadata. If empty, a default set excluding technical metadata is used. Set&nbsp;to&nbsp;`['**']`&nbsp;to include all fields.

  > [!NOTE]
  > By default, to improve performance and decrease cache size, Hugo excludes the following fields: `ColorSpace`, `Contrast`, `Exif`, `ExposureBias`, `ExposureMode`, `ExposureProgram`, `Flash`, `GPS`, `JPEG`, `Metering`, `Resolution`, `Saturation`, `Sensing`, `Sharp`, and `WhiteBalance`.

`sources`
: (`[]string`) The metadata sources to include, one or more of `exif`, `iptc`, or `xmp`. Default is `['exif', 'iptc']`. The XMP metadata is excluded by default to improve performance.

[`avifenc`]: https://github.com/aomediacodec/libavif
[`cwebp`]: https://developers.google.com/speed/webp/docs/cwebp
[`muesli/smartcrop`]: https://github.com/muesli/smartcrop
[hexadecimal color]: https://developer.mozilla.org/en-US/docs/Web/CSS/hex-color
[source documentation]: https://github.com/disintegration/imaging#image-resizing


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/configuration/introduction.md
---


## Sensible defaults

Hugo offers many configuration settings, but its defaults are often sufficient. A new project requires only these settings:

{{< code-toggle file=hugo >}}
baseURL = 'https://example.org/'
locale = 'en-us'
title = 'My New Hugo Site'
{{< /code-toggle >}}

Only define settings that deviate from the defaults. A smaller configuration file is easier to read, understand, and debug. Keep your configuration concise.

> [!NOTE]
> The best configuration file is a short configuration file.

## Configuration file

Create a project configuration file in the root of your project directory, naming it `hugo.toml`, `hugo.yaml`, or `hugo.json`, with that order of precedence.

```tree
my-project/
└── hugo.toml
```

A simple example:

{{< code-toggle file=hugo >}}
baseURL = 'https://example.org/'
locale = 'en-us'
title = 'ABC Widgets, Inc.'
[params]
subtitle = 'The Best Widgets on Earth'
[params.contact]
email = 'info@example.org'
phone = '+1 202-555-1212'
{{< /code-toggle >}}

To use a different configuration file when building your project, use the `--config` flag:

```sh
hugo build --config other.toml
```

Combine two or more configuration files, with left-to-right precedence:

```sh
hugo build --config a.toml,b.yaml,c.json
```

> [!NOTE]
> See the specifications for each file format: [TOML][], [YAML][], and [JSON][].

## Configuration directory

Instead of a single project configuration file, split your configuration by [environment](g), root configuration key, and language. For example:

```tree
my-project/
└── config/
    ├── _default/
    │   ├── hugo.toml
    │   ├── menus.en.toml
    │   ├── menus.de.toml
    │   └── params.toml
    └── production/
        └── params.toml
```

The root configuration keys are {{< root-configuration-keys >}}.

### Root key

{{< new-in 0.162.0 />}}

When splitting the configuration by root key, you may omit or include the root key in the component file. For example, these are equivalent:

{{< code-toggle file=config/_default/hugo >}}
[params]
foo = 'bar'
{{< /code-toggle >}}

{{< code-toggle file=config/_default/params >}}
foo = 'bar'
{{< /code-toggle >}}

This also applies to keys whose values are maps of slices, such as `menus`. For example, these are equivalent:

{{< code-toggle file=config/_default/menus >}}
[[main]]
name = 'Home'
pageRef = '/'
weight = 10
{{< /code-toggle >}}

{{< code-toggle file=config/_default/menus >}}
[[menus.main]]
name = 'Home'
pageRef = '/'
weight = 10
{{< /code-toggle >}}

For pure slice-typed keys such as `cascade` and `permalinks`, including the root key is required. For example:

{{< code-toggle file=config/_default/cascade >}}
[[cascade]]
[cascade.params]
color = 'red'
[cascade.target]
path = '/articles/**'
{{< /code-toggle >}}

> [!NOTE]
> Hugo unwraps the root key only when it is the sole top-level key in the file and matches the file's basename.

### Recursive parsing

Hugo parses the `config` directory recursively, allowing you to organize the files into subdirectories. For example:

```tree
my-project/
└── config/
    └── _default/
        ├── navigation/
        │   ├── menus.de.toml
        │   └── menus.en.toml
        └── hugo.toml
```

### Example

```tree
my-project/
└── config/
    ├── _default/
    │   ├── hugo.toml
    │   ├── menus.en.toml
    │   ├── menus.de.toml
    │   └── params.toml
    ├── production/
    │   ├── hugo.toml
    │   └── params.toml
    └── staging/
        ├── hugo.toml
        └── params.toml
```

Considering the structure above, when running `hugo build --environment staging`, Hugo will use every setting from `config/_default` and merge `staging`'s on top of those.

Let's take an example to understand this better. Let's say you are using Google Analytics for your website. This requires you to specify a [Google tag ID][] in your project configuration:

{{< code-toggle file=hugo >}}
[services.googleAnalytics]
ID = 'G-XXXXXXXXX'
{{< /code-toggle >}}

Now consider the following scenario:

1. You don't want to load the analytics code when running `hugo server`.
1. You want to use different Google tag IDs for your production and staging environments. For example:
    - `G-PPPPPPPPP` for production
    - `G-SSSSSSSSS` for staging

To satisfy these requirements, configure your site as follows:

1. `config/_default/hugo.toml`
    - Exclude the `services.googleAnalytics` section. This will prevent loading of the analytics code when you run `hugo server`.
    - By default, Hugo sets its `environment` to `development` when running `hugo server`. In the absence of a `config/development` directory, Hugo uses the `config/_default` directory.
1. `config/production/hugo.toml`
    - Include this section only:

      {{< code-toggle file=hugo >}}
      [services.googleAnalytics]
      ID = 'G-PPPPPPPPP'
      {{< /code-toggle >}}

    - You do not need to include other parameters in this file. Include only those parameters that are specific to your production environment. Hugo will merge these parameters with the default configuration.
    - By default, Hugo sets its `environment` to `production` when running `hugo build`. The analytics code will use the `G-PPPPPPPPP` tag ID.

1. `config/staging/hugo.toml`

    - Include this section only:

      {{< code-toggle file=hugo >}}
      [services.googleAnalytics]
      ID = 'G-SSSSSSSSS'
      {{< /code-toggle >}}

    - You do not need to include other parameters in this file. Include only those parameters that are specific to your staging environment. Hugo will merge these parameters with the default configuration.
    - To build your staging site, run `hugo build --environment staging`. The analytics code will use the `G-SSSSSSSSS` tag ID.

## Merge configuration settings

Hugo merges configuration settings from themes and modules, prioritizing the project's own settings. Given this simplified project structure with two themes:

```tree
project/
├── themes/
│   ├── theme-a/
│   │   └── hugo.toml
│   └── theme-b/
│       └── hugo.toml
└── hugo.toml
```

and this project-level configuration:

{{< code-toggle file=hugo >}}
baseURL = 'https://example.org/'
locale = 'en-us'
title = 'My New Hugo Site'
theme = ['theme-a','theme-b']
{{< /code-toggle >}}

Hugo merges settings in this order:

1. Project configuration (`hugo.toml` in the project root)
1. `theme-a` configuration
1. `theme-b` configuration

The `_merge` setting within each top-level configuration key controls _which_ settings are merged and _how_ they are merged.

The value for `_merge` can be one of:

`none`
: No merge.

`shallow`
: Only add values for new keys.

`deep`
: Add values for new keys, merge existing.

Note that you don't need to be so verbose as in the default setup below; a `_merge` value higher up will be inherited if not set.

{{< code-toggle file=hugo dataKey="config_helpers.mergeStrategy" skipHeader=true />}}

> [!NOTE]
> Hugo can merge map configuration values from modules and themes into the project configuration, but cannot merge slice values. This applies to top-level slice keys such as `menus`, as well as to map keys whose values are slices, such as the per-kind format lists in `outputs`.

## Environment variables

You can also configure settings using operating system environment variables:

```sh
export HUGO_BASEURL=https://example.org/
export HUGO_ENABLEGITINFO=true
hugo
```

The above configures the [`baseURL`][] and [`enableGitInfo`][] settings and then builds your site.

> [!NOTE]
> An environment variable takes precedence over the values set in the configuration file. This means that if you set a configuration value with both an environment variable and in the configuration file, the value in the environment variable will be used.

Environment variables simplify configuration for [CI/CD](g) platforms by allowing you to set values directly within their respective configuration and workflow files.

> [!NOTE]
> Environment variable names must be prefixed with `HUGO_`.
>
> To set custom site parameters, prefix the name with `HUGO_PARAMS_`.

For snake_case variable names, the standard `HUGO_` prefix won't work. Hugo infers the delimiter from the first character following `HUGO`. This allows for variations like `HUGOxPARAMSxAPI_KEY=abcdefgh` using any [permitted delimiter][].

In addition to configuring standard settings, environment variables may be used to override default values for certain internal settings:

`DART_SASS_BINARY`
: (`string`) The absolute path to the Dart Sass executable. By default, Hugo searches for the executable in each of the paths in the `PATH` environment variable.

`HUGO_ENVIRONMENT`
: (`string`) The build environment. Default is `production` when running `hugo build` and `development` when running `hugo server`.

`HUGO_FILE_LOG_FORMAT`
: (`string`) A format string for the file path, line number, and column number displayed when reporting errors, or when calling the `Position` method from a shortcode or Markdown render hook. Valid tokens are `:file`, `:line`, and `:col`. Default is `:file::line::col`.

`HUGO_MEMORYLIMIT`
: (`int`) The maximum amount of system memory, in gigabytes, that Hugo can use while rendering your site. Default is 25% of total system memory. Note that `HUGO_MEMORYLIMIT` is a "best effort" setting. Don't expect Hugo to build a million pages with only 1 GB of memory. You can get more information about how this behaves during the build by running `hugo build --logLevel info` and look for the `dynacache` label.

`HUGO_NUMWORKERMULTIPLIER`
: (`int`) The number of workers used in parallel processing. Default is the number of logical CPUs.

## Current configuration

Display the complete project configuration with:

```sh
hugo config
```

Display a specific configuration setting with:

```sh
hugo config | grep [key]
```

Display the configured file mounts with:

```sh
hugo config mounts
```

[Google tag ID]: https://support.google.com/tagmanager/answer/12326985?hl=en
[JSON]: https://datatracker.ietf.org/doc/html/rfc7159
[TOML]: https://toml.io/en/latest
[YAML]: https://yaml.org/spec/
[`baseURL`]: /configuration/all#baseurl
[`enableGitInfo`]: /configuration/all#enablegitinfo
[permitted delimiter]: https://pubs.opengroup.org/onlinepubs/000095399/basedefs/xbd_chap08.html


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/configuration/languages.md
---


## Base settings

Configure the following base settings:

{{< code-toggle file=hugo >}}
defaultContentLanguage = 'en'
defaultContentLanguageInSubdir = false
disableDefaultLanguageRedirect = false
disableLanguages = []
{{< /code-toggle >}}

`defaultContentLanguage`
: (`string`) The projects's default content language, conforming to the syntax described in [RFC 5646][]. This value must match one of the defined [language keys][]. Default is `en`.

`defaultContentLanguageInSubdir`
: (`bool`) Whether to publish the default content language to a subdirectory matching the [`defaultContentLanguage`](#defaultcontentlanguage). Default is `false`.

`disableDefaultLanguageRedirect`
: {{< new-in 0.140.0 />}}
: (`bool`) Whether to disable generation of the alias redirect for the default content language. When [`defaultContentLanguageInSubdir`](#defaultcontentlanguageinsubdir) is `true`, this setting prevents the root directory from redirecting to the language subdirectory. Conversely, when `defaultContentLanguageInSubdir` is `false`, this setting prevents the language subdirectory from redirecting to the root directory. This is superseded by the more general [`disableDefaultSiteRedirect`][] setting. Default is `false`.

`disableLanguages`
: (`[]string]`) A slice of language keys representing the languages to disable during the build process. Although this is functional, consider using the [`disabled`](#disabled) key under each language instead.

## Language settings

Configure each language under the `languages` key:

{{< code-toggle config=languages />}}

In the above, `en` is the [language key](#language-keys).

`direction`
: (`string`) The language direction, either left-to-right (`ltr`) or right-to-left (`rtl`). Use this value in your templates with the global [`dir`][] HTML attribute. Access this value from a template using the [`Language.Direction`][] method on a `Site` or `Page` object. Default is `ltr`.

`disabled`
: (`bool`) Whether to disable this language when building the site. Default is `false`.

`label`
: (`string`) The language name, typically used when rendering a language switcher. Access this value from a template using the [`Language.Label`][] method on a `Site` or `Page` object.

`languageCode`
: {{<deprecated-in 0.158.0 />}}
: Use [`locale`](#locale) instead.

`languageDirection`
: {{<deprecated-in 0.158.0 />}}
: Use [`direction`](#direction) instead.

`languageName`
: {{<deprecated-in 0.158.0 />}}
: Use [`label`](#label) instead.

{{% include "/_common/configuration/locale.md" %}}

`title`
: (`string`) The site title for this language. Access this value from a template using the [`Title`][] method on a `Site` object.

`weight`
: (`int`) The language [weight](g). When set to a non-zero value, this is the primary sort criteria for this language.

## Sort order

Hugo sorts languages by weight in ascending order, then lexicographically in ascending order. This affects build order and complement selection.

## Localized settings

Some configuration settings can be defined separately for each language. For example:

{{< code-toggle file=hugo >}}
[languages.en]
label = 'English'
locale = 'en-US'
timeZone = 'America/New_York'
title = 'Project Documentation'
weight = 1
[languages.en.pagination]
path = 'page'
[languages.en.params]
subtitle = 'Reference, Tutorials, and Explanations'
{{< /code-toggle >}}

The following configuration keys can be defined separately for each language:

{{< per-lang-config-keys >}}

Any key not defined in a `languages` object will fall back to the global value in the root of your project configuration.

## Language keys

Language keys must conform to the syntax described in [RFC 5646][]. For example:

{{< code-toggle file=hugo >}}
defaultContentLanguage = 'de'
[languages.de]
weight = 1
[languages.en-US]
weight = 2
[languages.pt-BR]
weight = 3
{{< /code-toggle >}}

Artificial languages with private use subtags as defined in [RFC 5646 § 2.2.7][] are also supported. Omit the `art-x-` prefix from the language key. For example:

{{< code-toggle file=hugo >}}
defaultContentLanguage = 'en'
[languages.en]
weight = 1
[languages.hugolang]
weight = 2
{{< /code-toggle >}}

> [!NOTE]
> Private use subtags must not exceed 8 alphanumeric characters.

## Example

{{< code-toggle file=hugo >}}
defaultContentLanguage = 'de'
defaultContentLanguageInSubdir = true
disableDefaultLanguageRedirect = false

[languages.de]
contentDir = 'content/de'
direction = 'ltr'
disabled = false
label = 'Deutsch'
locale = 'de-DE'
title = 'Projekt Dokumentation'
weight = 1

[languages.de.params]
subtitle = 'Referenz, Tutorials und Erklärungen'

[languages.en]
contentDir = 'content/en'
direction = 'ltr'
disabled = false
label = 'English'
locale = 'en-US'
title = 'Project Documentation'
weight = 2

[languages.en.params]
subtitle = 'Reference, Tutorials, and Explanations'
{{< /code-toggle >}}

> [!NOTE]
> In the example above, omit `contentDir` if [translating by file name][].

## Multihost

Hugo supports multiple languages in a multihost configuration. This means you can configure a `baseURL` per `language`.

> [!NOTE]
> If you define a `baseURL` for one language, you must define a unique `baseURL` for all languages.

For example:

{{< code-toggle file=hugo >}}
defaultContentLanguage = 'fr'
[languages.en]
baseURL = 'https://en.example.org/'
label = 'English'
title = 'In English'
weight = 2
[languages.fr]
baseURL = 'https://fr.example.org'
label = 'Français'
title = 'En Français'
weight = 1
{{</ code-toggle >}}

With the above, Hugo publishes two sites, each with their own root:

```tree
public
├── en
└── fr
```

[RFC 5646 § 2.2.7]: https://datatracker.ietf.org/doc/html/rfc5646#section-2.2.7
[RFC 5646]: https://datatracker.ietf.org/doc/html/rfc5646#section-2.1
[`Language.Direction`]: /methods/site/language/#direction
[`Language.Label`]: /methods/site/language/#label
[`Title`]: /methods/site/title/
[`dir`]: https://developer.mozilla.org/en-US/docs/Web/HTML/Global_attributes/dir
[`disableDefaultSiteRedirect`]: /configuration/all/#disabledefaultsiteredirect
[language keys]: /configuration/languages/#language-keys
[translating by file name]: /content-management/multilingual/#translation-by-file-name


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/configuration/markup.md
---


## Default handler

In its default configuration, Hugo uses [Goldmark][] to render Markdown to HTML.

{{< code-toggle file=hugo >}}
[markup]
defaultMarkdownHandler = 'goldmark'
{{< /code-toggle >}}

Files with ending with `.md`, `.mdown`, or `.markdown` are processed as Markdown, unless you've explicitly set a different format using the `markup` field in your front matter.

To use a different renderer for Markdown files, specify one of `asciidocext`, `org`, `pandoc`, or `rst` in your project configuration.

`defaultMarkdownHandler` | Renderer
:------------------------|:--------------------
`asciidocext`            | [AsciiDoc][]
`goldmark`               | [Goldmark][]
`org`                    | [Emacs Org Mode][]
`pandoc`                 | [Pandoc][]
`rst`                    | [reStructuredText][]

To use AsciiDoc, Pandoc, or reStructuredText you must install the relevant renderer and update your [security policy][].

> [!NOTE]
> Unless you need a unique capability provided by one of the alternative Markdown handlers, we strongly recommend that you use the default setting. Goldmark is fast, well maintained, conforms to the [CommonMark][] specification, and is compatible with [GitHub Flavored Markdown][] (GFM).

## Goldmark

This is the default configuration for the Goldmark Markdown renderer:

{{< code-toggle config=markup.goldmark />}}

### Extensions

The extensions below, excluding Extras and Passthrough, are enabled by default.

Extension        | Documentation                                 |      Enabled
:----------------|:----------------------------------------------|:-----------------:
`cjk`            | [Goldmark Extensions: CJK][]                  | :heavy_check_mark:
`definitionList` | [PHP Markdown Extra: Definition lists][]      | :heavy_check_mark:
`extras`         | [Hugo Goldmark Extensions: Extras][]          |       &nbsp;
`footnote`       | [PHP Markdown Extra: Footnotes][]             | :heavy_check_mark:
`linkify`        | [GitHub Flavored Markdown: Autolinks][]       | :heavy_check_mark:
`passthrough`    | [Hugo Goldmark Extensions: Passthrough][]     |       &nbsp;
`strikethrough`  | [GitHub Flavored Markdown: Strikethrough][]   | :heavy_check_mark:
`table`          | [GitHub Flavored Markdown: Tables][]          | :heavy_check_mark:
`taskList`       | [GitHub Flavored Markdown: Task list items][] | :heavy_check_mark:
`typographer`    | [Goldmark Extensions: Typographer][]          | :heavy_check_mark:

#### Extras

Enable [deleted text][], [inserted text][], [mark text][], [subscript][], and [superscript][] elements in Markdown.

Element       | Markdown  | Rendered
:-------------|:----------|:------------------
Deleted text  | `~~foo~~` | `<del>foo</del>`
Inserted text | `++bar++` | `<ins>bar</ins>`
Mark text     | `==baz==` | `<mark>baz</mark>`
Subscript     | `H~2~O`   | `H<sub>2</sub>O`
Superscript   | `1^st^`   | `1<sup>st</sup>`

To avoid a conflict[^1], if you enable the "subscript" feature of the Extras extension, you must disable the Strikethrough extension:

{{< code-toggle file=hugo >}}
[markup.goldmark.extensions]
strikethrough = false

[markup.goldmark.extensions.extras.subscript]
enable = true
{{< /code-toggle >}}

If you still need to show deleted text after disabling the Strikethrough extension, enable the "deleted text" feature of the Extras extension:

{{< code-toggle file=hugo >}}
[markup.goldmark.extensions]
strikethrough = false

[markup.goldmark.extensions.extras.delete]
enable = true
{{< /code-toggle >}}

With this configuration, to format text as deleted, wrap it with double-tildes.

#### Footnote

Enabled by default, the Footnote extension enables inclusion of footnotes in Markdown.

`enable`
: {{< new-in 0.151.0 />}}
: (`bool`) Whether to enable the Footnotes extension. Default is `true`.

`backlinkHTML`
: {{< new-in 0.151.0 />}}
: (`string`) The HTML to be displayed at the end of a footnote that links the user back to the corresponding reference in the main text. The default is &#x21a9;&#xfe0e; (a return arrow symbol).

`enableAutoIDPrefix`
: {{< new-in 0.151.0 />}}
: (`bool`) Whether to prepend a unique prefix to footnote IDs, preventing clashes when multiple documents are rendered together. This prefix is unique to each logical path, which means that the prefix is not unique across content dimensions such as language. Default is `false`.

#### Passthrough

Enable the Passthrough extension to include mathematical equations and expressions in Markdown using LaTeX markup. See [mathematics in Markdown][] for details.

#### Typographer

The Typographer extension replaces certain character combinations with HTML entities as specified below:

Markdown|Replaced by|Description
:--|:--|:--
`...`|`&hellip;`|horizontal ellipsis
`'`|`&rsquo;`|apostrophe
`--`|`&ndash;`|en dash
`---`|`&mdash;`|em dash
`«`|`&laquo;`|left angle quote
`“`|`&ldquo;`|left double quote
`‘`|`&lsquo;`|left single quote
`»`|`&raquo;`|right angle quote
`”`|`&rdquo;`|right double quote
`’`|`&rsquo;`|right single quote

### Goldmark settings explained

Most of the Goldmark settings above are self-explanatory, but some require explanation.

`duplicateResourceFiles`
: (`bool`) Whether to duplicate shared page resources for each language on multilingual single-host projects. See [multilingual page resources][] for details. Default is `false`.

  > [!NOTE]
  > With multilingual single-host projects, setting this parameter to `false` will enable Hugo's [embedded link render hook][] and [embedded image render hook][]. This is the default configuration for multilingual single-host projects.

`parser.wrapStandAloneImageWithinParagraph`
: (`bool`) Whether to wrap image elements without adjacent content within a `p` element when rendered. This is the default Markdown behavior. Set to `false` when using an [image render hook][] to render standalone images as `figure` elements. Default is `true`.

`parser.autoDefinitionTermID`
: {{< new-in 0.144.0 />}}
: (`bool`) Whether to automatically add `id` attributes to description list terms (i.e., `dt` elements). When `true`, the `id` attribute of each `dt` element is accessible through the [`Fragments.Identifiers`][] method on a `Page` object.

`parser.autoHeadingID`
: (`bool`) Whether to automatically add `id` attributes to headings (i.e., `h1`, `h2`, `h3`, `h4`, `h5`, and `h6` elements).

`parser.autoIDType`
: (`string`) The strategy used to automatically generate `id` attributes, one of `github`, `github-ascii` or `blackfriday`. Default is `github`.

  - `github`: Generate GitHub-compatible `id` attributes
  - `github-ascii`: Drop any non-ASCII characters after accent normalization
  - `blackfriday`: Generate `id` attributes compatible with the Blackfriday Markdown renderer

  This is also the strategy used by the [`urls.Anchorize`][] function.

`parser.attribute.block`
: (`bool`) Whether to enable [Markdown attributes][] for block elements. Default is `false`.

`parser.attribute.title`
: (`bool`) Whether to enable [Markdown attributes][] for headings. Default is `true`.

`renderHooks.image.enableDefault`
: {{< deprecated-in 0.148.0 />}}
: Use the `renderHooks.image.useEmbedded` setting instead.

`renderHooks.image.useEmbedded`
: {{< new-in 0.148.0 />}}
: (`string`) When to use the [embedded image render hook][]. One of `auto`, `never`, `always`, or `fallback`. Default is `auto`.

  - `auto`: Use the embedded image render hook only for multilingual single-host projects where the [duplication of shared page resources][] feature is disabled. If custom image render hooks are defined by your project, modules, or themes, these will be used instead.
  - `never`: Never use the embedded image render hook. If custom image render hooks are defined by your project, modules, or themes, these will be used instead.
  - `always`: Always use the embedded image render hook, even if custom image render hooks are provided by your project, modules, or themes.
  - `fallback`: Use the embedded image render hook only if custom image render hooks are not provided by your project, modules, or themes. If custom image render hooks exist, these will be used instead.

`renderHooks.link.enableDefault`
: {{< deprecated-in 0.148.0 />}}
: Use the `renderHooks.link.useEmbedded` setting instead.

`renderHooks.link.useEmbedded`
: (`string`) When to use the [embedded link render hook][]. One of `auto`, `never`, `always`, or `fallback`. Default is `auto`.

  - `auto`: Use the embedded link render hook only for multilingual single-host projects where the [duplication of shared page resources][] feature is disabled. If custom link render hooks are defined by your project, modules, or themes, these will be used instead.
  - `never`: Never use the embedded link render hook. If custom link render hooks are defined by your project, modules, or themes, these will be used instead.
  - `always`: Always use the embedded link render hook, even if custom link render hooks are provided by your project, modules, or themes.
  - `fallback`: Use the embedded link render hook only if custom link render hooks are not provided by your project, modules, or themes. If custom link render hooks exist, these will be used instead.

`renderer.hardWraps`
: (`bool`) Whether to replace newline characters within a paragraph with `br` elements. Default is `false`.

`renderer.unsafe`
: (`bool`) Whether to render raw HTML mixed within Markdown. This is unsafe unless the content is under your control. Default is `false`.

## AsciiDoc

This is the default configuration for the AsciiDoc renderer:

{{< code-toggle config=markup.asciidocExt />}}

### AsciiDoc settings explained

`attributes`
: (`map`) A map of key-value pairs, each a document attribute. See Asciidoctor's [attributes][].

`backend`
: (`string`) The backend output file format. Default is `html5`.

`extensions`
: (`[]string`) An array of enabled extensions, such as `asciidoctor-html5s`, `asciidoctor-bibtex`, or `asciidoctor-diagram`.

  > [!NOTE]
  > To mitigate security risks, entries in the extension array may not contain forward slashes (`/`), backslashes (`\`), or periods. Due to this restriction, extensions must be in Ruby's `$LOAD_PATH`.

`failureLevel`
: (`string`) The minimum logging level that triggers a non-zero exit code (failure). Default is `fatal`.

`noHeaderOrFooter`
: (`bool`) Whether to output an embeddable document, which excludes the header, the footer, and everything outside the body of the document. Default is `true`.

`preserveTOC`
: (`bool`) Whether to preserve the table of contents (TOC) rendered by Asciidoctor. By default, to make the TOC compatible with existing themes, Hugo removes the TOC rendered by Asciidoctor. To render the TOC, use the [`TableOfContents`][] method on a `Page` object in your templates. Default is `false`.

`safeMode`
: (`string`) The safe mode level, one of `unsafe`, `safe`, `server`, or `secure`. Default is `unsafe`.

`sectionNumbers`
: (`bool`) Whether to number each section title. Default is `false`.

`trace`
: (`bool`) Whether to include backtrace information on errors. Default is `false`.

`verbose`
: (`bool`) Whether to verbosely print processing information and configuration file checks to stderr. Default is `false`.

`workingFolderCurrent`
: (`bool`) Whether to set the working directory to be the same as that of the AsciiDoc file being processed, allowing [includes][] to work with relative paths. Set to `true` to render diagrams with the [asciidoctor-diagram][] extension. Default is `false`.

### Configuration example

{{< code-toggle file=hugo >}}
[markup.asciidocExt]
extensions = ['asciidoctor-html5s','asciidoctor-diagram']
workingFolderCurrent = true
[markup.asciidocExt.attributes]
my-base-url = 'https://example.com/'
my-attribute-name = 'my value'
{{< /code-toggle >}}

### Syntax highlighting

Follow the steps below to enable syntax highlighting.

Step 1
: Set the `source-highlighter` attribute in your project configuration. For example:

  {{< code-toggle file=hugo >}}
  [markup.asciidocExt.attributes]
  source-highlighter = 'rouge'
  {{< /code-toggle >}}

Step 2
: Generate the highlighter CSS. For example:

  ```sh
  rougify style monokai.sublime > assets/css/syntax.css
  ```

Step 3
: In your base template add a link to the CSS file:

  ```go-html-template {file="layouts/baseof.html"}
  <head>
    ...
    {{ with resources.Get "css/syntax.css" }}
      <link rel="stylesheet" href="{{ .RelPermalink }}" integrity="{{ .Data.Integrity }}" crossorigin="anonymous">
    {{ end }}
    ...
  </head>
  ```

Step 4
: Add the code to be highlighted to your markup:

  ```text
  [#hello,ruby]
  ----
  require 'sinatra'

  get '/hi' do
    "Hello World!"
  end
  ----
  ```

### Troubleshooting

Run `hugo build --logLevel debug` to examine Hugo's call to the Asciidoctor executable:

```txt
INFO 2019/12/22 09:08:48 Rendering book-as-pdf.adoc with C:\Ruby26-x64\bin\asciidoctor.bat using asciidoc args [--no-header-footer -r asciidoctor-html5s -b html5s -r asciidoctor-diagram --base-dir D:\prototypes\hugo_asciidoc_ddd\docs -a outdir=D:\prototypes\hugo_asciidoc_ddd\build -] ...
```

## Highlight

This is the default configuration.

{{< code-toggle config=markup.highlight />}}

{{% include "/_common/syntax-highlighting-options.md" %}}

## Table of contents

This is the default configuration for the table of contents, applicable to Goldmark and Asciidoctor:

{{< code-toggle config=markup.tableOfContents />}}

`startLevel`
: (`int`) Heading levels less than this value will be excluded from the table of contents. For example, to exclude `h1` elements from the table of contents, set this value to `2`. Default is `2`.

`endLevel`
: (`int`) Heading levels greater than this value will be excluded from the table of contents. For example, to exclude `h4`, `h5`, and `h6` elements from the table of contents, set this value to `3`. Default is `3`.

`ordered`
: (`bool`) Whether to generates an ordered list instead of an unordered list. Default is `false`.

[^1]: See [details](https://github.com/gohugoio/hugo-goldmark-extensions/commit/4d4fcd022fe45a9b51483df001c9e5f4e632d5a9).

[AsciiDoc]: https://asciidoc.org/
[CommonMark]: https://spec.commonmark.org/current/
[Emacs Org Mode]: https://orgmode.org/
[GitHub Flavored Markdown: Autolinks]: https://github.github.com/gfm/#autolinks-extension-
[GitHub Flavored Markdown: Strikethrough]: https://github.github.com/gfm/#strikethrough-extension-
[GitHub Flavored Markdown: Tables]: https://github.github.com/gfm/#tables-extension-
[GitHub Flavored Markdown: Task list items]: https://github.github.com/gfm/#task-list-items-extension-
[GitHub Flavored Markdown]: https://github.github.com/gfm/
[Goldmark Extensions: CJK]: https://github.com/yuin/goldmark?tab=readme-ov-file#cjk-extension
[Goldmark Extensions: Typographer]: https://github.com/yuin/goldmark?tab=readme-ov-file#typographer-extension
[Goldmark]: https://github.com/yuin/goldmark/
[Hugo Goldmark Extensions: Extras]: https://github.com/gohugoio/hugo-goldmark-extensions?tab=readme-ov-file#extras-extension
[Hugo Goldmark Extensions: Passthrough]: https://github.com/gohugoio/hugo-goldmark-extensions?tab=readme-ov-file#passthrough-extension
[Markdown attributes]: /content-management/markdown-attributes/
[PHP Markdown Extra: Definition lists]: https://michelf.ca/projects/php-markdown/extra/#def-list
[PHP Markdown Extra: Footnotes]: https://michelf.ca/projects/php-markdown/extra/#footnotes
[Pandoc]: https://pandoc.org/
[`Fragments.Identifiers`]: /methods/page/fragments/#identifiers
[`TableOfContents`]: /methods/page/tableofcontents/
[`urls.Anchorize`]: /functions/urls/anchorize/
[asciidoctor-diagram]: https://asciidoctor.org/docs/asciidoctor-diagram/
[attributes]: https://asciidoctor.org/docs/asciidoc-syntax-quick-reference/#attributes-and-substitutions
[deleted text]: https://developer.mozilla.org/en-US/docs/Web/HTML/Element/del
[duplication of shared page resources]: /configuration/markup/#duplicateresourcefiles
[embedded image render hook]: /render-hooks/images/#embedded
[embedded link render hook]: /render-hooks/links/#embedded
[image render hook]: /render-hooks/images/
[includes]: https://docs.asciidoctor.org/asciidoc/latest/syntax-quick-reference/#includes
[inserted text]: https://developer.mozilla.org/en-US/docs/Web/HTML/Element/ins
[mark text]: https://developer.mozilla.org/en-US/docs/Web/HTML/Element/mark
[mathematics in Markdown]: /content-management/mathematics/
[multilingual page resources]: /content-management/page-resources/#multilingual
[reStructuredText]: https://docutils.sourceforge.io/rst.html
[security policy]: /configuration/security/
[subscript]: https://developer.mozilla.org/en-US/docs/Web/HTML/Element/sub
[superscript]: https://developer.mozilla.org/en-US/docs/Web/HTML/Element/sup


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/configuration/media-types.md
---


{{% glossary-term "media type" %}}

Configured media types serve multiple purposes in Hugo, including the definition of [output formats](g). This is the default media type configuration in tabular form:

{{< datatable "config" "mediaTypes" "_key" "suffixes" >}}

The `suffixes` column in the table above shows the suffixes associated with each media type. For example, Hugo associates `.html` and `.htm` files with the `text/html` media type.

> [!NOTE]
> The first suffix is the primary suffix. Use the primary suffix when naming template files. For example, when creating a template for an RSS feed, use the `xml` suffix.

## Default configuration

The following is the default configuration that matches the table above:

{{< code-toggle file=hugo config=mediaTypes />}}

`delimiter`
: (`string`) The delimiter between the file name and the suffix. The delimiter, in conjunction with the suffix, forms the file extension. Default is `"."`.

`suffixes`
: (`[]string`) The suffixes associated with this media type. The first suffix is the primary suffix.

## Modify a media type

You can modify any of the default media types. For example, to switch the primary suffix for `text/html` from `html` to `htm`:

{{< code-toggle file=hugo >}}
[mediaTypes.'text/html']
suffixes = ['htm','html']
{{< /code-toggle >}}

If you alter a default media type, you must also explicitly redefine all output formats that utilize that media type. For example, to ensure the changes above affect the `html` output format, redefine the `html` output format:

{{< code-toggle file=hugo >}}
[outputFormats.html]
mediaType = 'text/html'
{{< /code-toggle >}}

## Create a media type

You can create new media types as needed. For example, to create a media type for an Atom feed:

{{< code-toggle file=hugo >}}
[mediaTypes.'application/atom+xml']
suffixes = ['atom']
{{< /code-toggle >}}

## Media types without suffixes

Occasionally, you may need to create a media type without a suffix or delimiter. For example, [Netlify][] recognizes configuration files named `_redirects` and `_headers`, which Hugo can generate using custom [output formats](g).

To support these custom output formats, register a custom media type with no suffix or delimiter:

{{< code-toggle file=hugo >}}
[mediaTypes.'text/netlify']
delimiter = ''
{{< /code-toggle >}}

The custom output format definitions would look something like this:

{{< code-toggle file=hugo >}}
[outputFormats.redir]
baseName    = '_redirects'
isPlainText = true
mediatype   = 'text/netlify'
[outputFormats.headers]
baseName       = '_headers'
isPlainText    = true
mediatype      = 'text/netlify'
notAlternative = true
{{< /code-toggle >}}

[Netlify]: https://www.netlify.com/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/configuration/menus.md
---


> [!NOTE]
> To understand Hugo's menu system, please refer to the [menus][] page.

There are three ways to define menu entries:

1. [Automatically][]
1. In [front matter][]
1. In your project configuration

This page covers the project configuration method.

## Example

To define entries for a "main" menu:

{{< code-toggle file=hugo >}}
[[menus.main]]
name = 'Home'
pageRef = '/'
weight = 10

[[menus.main]]
name = 'Products'
pageRef = '/products'
weight = 20

[[menus.main]]
name = 'Services'
pageRef = '/services'
weight = 30
{{< /code-toggle >}}

This creates a menu structure that you can access with [`Menus`][] method on a `Site` object:

```go-html-template
{{ range .Site.Menus.main }}
  ...
{{ end }}
```

See [menu templates][] for a detailed example.

To define entries for a "footer" menu:

{{< code-toggle file=hugo >}}
[[menus.footer]]
name = 'Terms'
pageRef = '/terms'
weight = 10

[[menus.footer]]
name = 'Privacy'
pageRef = '/privacy'
weight = 20
{{< /code-toggle >}}

Access this menu structure in the same way:

```go-html-template
{{ range .Site.Menus.footer }}
  ...
{{ end }}
```

## Properties

Menu entries usually include at least three properties: `name`, `weight`, and either `pageRef` or `url`. Use `pageRef` for internal page destinations and `url` for external destinations.

These are the available menu entry properties:

{{% include "/_common/menu-entry-properties.md" %}}

`pageRef`
: (`string`) The [logical path](g) of the target page. For example:

  page kind|pageRef
  :--|:--
  home|`/`
  page|`/books/book-1`
  section|`/books`
  taxonomy|`/tags`
  term|`/tags/foo`

`url`
: (`string`) The destination URL. Use this for external destinations only.

## Nested menu

This nested menu demonstrates some of the available properties:

<!-- markdownlint-disable MD033 -->
{{< code-toggle file=hugo >}}
[[menus.main]]
name = 'Products'
pageRef = '/products'
weight = 10

[[menus.main]]
name = 'Hardware'
pageRef = '/products/hardware'
parent = 'Products'
weight = 1

[[menus.main]]
name = 'Software'
pageRef = '/products/software'
parent = 'Products'
weight = 2

[[menus.main]]
name = 'Services'
pageRef = '/services'
weight = 20

[[menus.main]]
name = 'Hugo'
pre = '<i class="fa fa-heart"></i>'
url = 'https://gohugo.io/'
weight = 30
[menus.main.params]
rel = 'external'
{{< /code-toggle >}}
<!-- markdownlint-enable MD033 -->

[Automatically]: /content-management/menus/#define-automatically
[`Menus`]: /methods/site/menus/
[front matter]: /content-management/menus/#define-in-front-matter
[menu templates]: /templates/menu/
[menus]: /content-management/menus/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/configuration/minify.md
---


This is the default configuration:

{{< code-toggle config=minify />}}

See the [`tdewolff/minify`][] project page for details, but note the following:

- `css.inline` is for internal use. Changing this setting has no effect.
- `html.keepConditionalComments` has been deprecated. Use `html.keepSpecialComments` instead.

[`tdewolff/minify`]: https://github.com/tdewolff/minify


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/configuration/module.md
---


{{% include "/_common/gomodules-info.md" %}}

## Top-level settings

This is the default configuration:

<!-- markdownlint-disable MD049 -->
{{< code-toggle file=hugo >}}
[module]
noProxy = 'none'
noVendor = ''
private = '*.*'
proxy = 'direct'
vendorClosest = false
workspace = 'off'
{{< /code-toggle >}}
<!-- markdownlint-enable MD049 -->

`auth`
: {{< new-in 0.144.0 />}}
: (`string`) Configures `GOAUTH` when running the Go command for module operations. This is a semicolon-separated list of authentication commands for go-import and HTTPS module mirror interactions. This is useful for private repositories. See `go help goauth` for more information.

`noProxy`
: (`string`) A comma-separated list of [glob patterns](g), matching paths that should not use the [configured proxy server](#proxy).

`noVendor`
: (`string`) A [glob pattern](g) matching module paths to skip when vendoring.

`private`
: (`string`) A comma-separated list of [glob patterns](g), matching paths that should be treated as private.

`proxy`
: (`string`) The proxy server to use to download remote modules. Default is `direct`, which means `git clone` and similar.

`replacements`
: (`string`) Primarily useful for local module development, a comma-separated list of mappings from module paths to directories. Paths may be absolute or relative to the [`themesDir`][].

  {{< code-toggle file=hugo >}}
  [module]
  replacements = 'github.com/bep/my-theme -> ../..,github.com/bep/shortcodes -> /some/path'
  {{< /code-toggle >}}

`vendorClosest`
: (`bool`) Whether to pick the vendored module closest to the module using it. The default behavior is to pick the first. Note that there can still be only one dependency of a given module path, so once it is in use it cannot be redefined. Default is `false`.

`workspace`
: (`string`) The Go workspace file to use, either as an absolute path or a path relative to the current working directory. Enabling this activates Go workspace mode and requires Go 1.18 or later. The default is `off`.

You may also use environment variables to set any of the above. For example:

```sh
export HUGO_MODULE_PROXY="https://proxy.example.org"
export HUGO_MODULE_REPLACEMENTS="github.com/bep/my-theme -> ../.."
export HUGO_MODULE_WORKSPACE="/my/hugo.work"
```

## Hugo version

You can specify a required Hugo version for your module in the `module` section. Users will then receive a warning if their Hugo version is incompatible.

This is the default configuration:

{{< code-toggle config=module.hugoVersion />}}

You can omit any of the settings above.

`extended`
: {{< deprecated-in v0.153.0 />}}
: (`bool`) Whether the extended edition of Hugo is required, satisfied by installing either the extended or extended/deploy edition.

  > [!NOTE]
  > The extended version check is disabled in v0.153.2 and later.
  >
  > Historically, certain features—specifically WebP encoding and LibSass—required the Hugo Extended binary. However, as of v0.153.0:
  >
  > - WebP encoding is now supported in all Hugo editions.
  > - LibSass has been deprecated in favor of [Dart Sass][], which is compatible with any Hugo edition.
  >
  > Because these dependencies no longer require a specialized binary, the internal enforcement check for the extended version has been removed. Site and theme authors are encouraged to use Dart Sass to ensure cross-edition compatibility.

`max`
: (`string`) The maximum Hugo version supported, for example `0.153.0`.

`min`
: (`string`) The minimum Hugo version supported, for example `0.102.0`.

## Imports

{{< code-toggle file=hugo >}}
[[module.imports]]
disable = false
ignoreConfig = false
ignoreImports = false
path = 'github.com/gohugoio/hugoTestModules1_linux/modh1_2_1v'
[[module.imports]]
path = 'my-shortcodes'
{{< /code-toggle >}}

`disable`
: (`bool`) Whether to disable the module but keep version information in the `go.*` files. Default is `false`.

`ignoreConfig`
: (`bool`) Whether to ignore module configuration files, for example, `hugo.toml`. This will also prevent loading of any transitive module dependencies. Default is `false`.

`ignoreImports`
: (`bool`) Whether to ignore module imports. Default is `false`.

`noMounts`
: (`bool`) Whether to disable directory mounting for this import. Default is `false`.

`noVendor`
: (`bool`) Whether to disable vendoring for this import. This setting is restricted to the main project. Default is `false`.

`usePackageJSON`
: {{< new-in 0.159.0 />}}
: (`string`) Whether to use the import's npm dependencies in [hugo mod npm pack](commands/hugo_mod_npm_pack/). One of `auto` (default), `always` or `never`. When set to `auto`, Hugo will enable this if either there is a Hugo config file (e.g. `hugo.toml`) or a `package.hugo.json` file in the module root.

`path`
: (`string`) The module path, either a valid Go module path (e.g., `github.com/gohugoio/myShortcodes`) or the directory name if stored in the [`themesDir`][].

`version`
: {{< new-in 0.150.0 />}}
: (`string`) If set to a [version query][], this import becomes a direct dependency, in contrast to dependencies managed by Go modules. See [this issue][] for more information.

## Mounts

{{% glossary-term mount %}}

> [!IMPORTANT]
> If you define one or more mounts to map a file system path to a component path, do not use these legacy configuration settings: [`archetypeDir`][], [`assetDir`][], [`contentDir`][], [`dataDir`][], [`i18nDir`][], [`layoutDir`][], or [`staticDir`][].

### Default mounts

Defining a mount for a component within a project configuration removes the default mount for that component.

Defining a mount for a component within a module configuration removes all default mounts for that module.

If you still need any of the default mounts, you must explicitly add them along with the new mount.

These are the default mounts:

{{< code-toggle config=module.mounts />}}

`source`
: (`string`) The source directory of the mount. For the main project, this can be either project-relative or absolute. For other modules it must be project-relative.

`target`
: (`string`) Where the mount will reside within Hugo's [unified file system](g). It must begin with one of Hugo's [component](g) directories: archetypes, assets, content, data, i18n, layouts, or static. For example, content/blog.

`disableWatch`
: (`bool`) Whether to disable watching in watch mode for this mount. Default is `false`.

`excludeFiles`
: {{< deprecated-in 0.153.0 />}}
: Use the [`files`](#files) setting instead.

`files`
: {{< new-in 0.153.0 />}}
: (`[]string`) A [glob slice](g) defining the files to include or exclude.

`includeFiles`
: {{< deprecated-in 0.153.0 />}}
: Use the [`files`](#files) setting instead.

`lang`
: {{< deprecated-in 0.153.0 />}}
: Use the [`sites`](#sites) setting instead.

`sites`
: {{< new-in 0.153.0 />}}
: (`map`) A map to define [sites matrix](g) and [sites complements](g) for the mount. Relevant for `content` and `layouts` mounts, and `static` mounts when in multihost mode. For `static` and `layouts`, only the `matrix` keyword is supported.

### Example

{{< code-toggle file=hugo >}}
[module]
[[module.mounts]]
source = 'content'
target = 'content'
files = ['! docs/*']
[[module.mounts]]
source = 'node_modules'
target = 'assets'
[[module.mounts]]
source = 'assets'
target = 'assets'
{{< /code-toggle >}}

[Dart Sass]: /functions/css/sass/#dart-sass
[`archetypeDir`]: /configuration/all/#archetypedir
[`assetDir`]: /configuration/all/#assetdir
[`contentDir`]: /configuration/all/#contentdir
[`dataDir`]: /configuration/all/#datadir
[`i18nDir`]: /configuration/all/#i18ndir
[`layoutDir`]: /configuration/all/#layoutdir
[`staticDir`]: /configuration/all/#staticdir
[`themesDir`]: /configuration/all/#themesdir
[this issue]: https://github.com/gohugoio/hugo/pull/13966
[version query]: https://go.dev/ref/mod#version-queries


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/configuration/output-formats.md
---


{{% glossary-term "output format" %}}

You can output a page in as many formats as you want. Define an infinite number of output formats, provided they each resolve to a unique file system path.

This is the default output format configuration in tabular form:

{{< datatable
  "config"
  "outputFormats"
  "_key"
  "mediaType"
  "weight"
  "baseName"
  "isHTML"
  "isPlainText"
  "noUgly"
  "notAlternative"
  "path"
  "permalinkable"
  "protocol"
  "rel"
  "root"
  "ugly"
>}}

## Default configuration

The following is the default configuration that matches the table above:

{{< code-toggle config=outputFormats />}}

`baseName`
: (`string`) The base name of the published file. Default is `index`.

`isHTML`
: (`bool`) Whether to classify the output format as HTML. This value determines when the LiveReload script is injected and, in conjunction with [`permalinkable`](#permalinkable), whether [alias redirects][] are generated. Default is `false`.

`isPlainText`
: (`bool`) Whether to parse templates for this output format with Go's [`text/template`][] package instead of the [`html/template`][] package. Default is `false`.

`mediaType`
: (`string`) The [media type](g) of the published file. This must match one of the [configured media types][].

`notAlternative`
: (`bool`) Whether to exclude this output format from the values returned by the [`AlternativeOutputFormats`][] method on a `Page` object. Default is `false`.

`noUgly`
: (`bool`) Whether to disable ugly URLs for this output format when [`uglyURLs`][] are enabled in your project configuration. Default is `false`.

`path`
: (`string`) The first segment of the publication path for this output format. This path segment is relative to the root of your [`publishDir`][]. If omitted, Hugo will use the file's original content path for publishing.

`permalinkable`
: (`bool`) Whether to return the rendering output format rather than the main output format when invoking the [`Permalink`][] and [`RelPermalink`][] methods on a `Page` object. Along with [`isHTML`](#ishtml), this must be `true` to create [alias redirects][]. Enabled by default for the `html` and `amp` output formats. Default is `false`.

`protocol`
: (`string`) The protocol (scheme) of the URL for this output format. For example, `https://` or `webcal://`. Default is the scheme of the [`baseURL`][] parameter in your project configuration, typically `https://`.

`rel`
: (`string`) The relationship of the output format to the current page. Hugo uses this property to determine the [canonical output format](g) of the current page. For the predefined `html` output format, the default value is `canonical`; for all other predefined output formats, the default value is `alternate`.

`root`
: (`bool`) Whether to publish files to the root of the publish directory. Default is `false`.

`ugly`
: (`bool`) Whether to enable uglyURLs for this output format when `uglyURLs` is `false` in your project configuration. Default is `false`.

`weight`
: (`int`) When set to a non-zero value, Hugo uses the `weight` as the first criteria when sorting output formats, falling back to the name of the output format. Lighter items float to the top, while heavier items sink to the bottom. Hugo renders output formats sequentially based on the sort order. Default is `0`, except for the `html` output format, which has a default weight of `10`.

## Modify an output format

You can modify any of the default output formats. For example, to prioritize `json` rendering over `html` rendering, when both are generated, adjust the [`weight`](#weight):

{{< code-toggle file=hugo >}}
[outputFormats.json]
weight = 1
[outputFormats.html]
weight = 2
{{< /code-toggle >}}

The example above shows that when you modify a default content format, you only need to define the properties that differ from their default values.

## Create an output format

You can create new output formats as needed. For example, you may wish to create an output format to support Atom feeds.

Step 1
: Output formats require a specified media type. Because Atom feeds use `application/atom+xml`, which is not one of the [default media types][], you must create it first.

  {{< code-toggle file=hugo >}}
  [mediaTypes.'application/atom+xml']
  suffixes = ['atom']
  {{< /code-toggle >}}

  See [configure media types][] for more information.

Step 2
: Create a new output format:

  {{< code-toggle file=hugo >}}
  [outputFormats.atom]
  mediaType = 'application/atom+xml'
  noUgly = true
  {{< /code-toggle >}}

  Note that we use the default settings for all other output format properties.

Step 3
: Specify the page [kinds](g) for which to render this output format:

  {{< code-toggle file=hugo >}}
  [outputs]
  home = ['html', 'rss', 'atom']
  section = ['html', 'rss', 'atom']
  taxonomy = ['html', 'rss', 'atom']
  term = ['html', 'rss', 'atom']
  {{< /code-toggle >}}

  See [configure outputs][] for more information.

Step 4
: Create a template to render the output format. Since Atom feeds are lists, you need to create a list template. Consult the [template lookup order][] to find the correct template path:

  ```text
  layouts/list.atom.atom
  ```

  We leave writing the template code as an exercise for you. Aim for a result similar to the [embedded RSS template][].

## List output formats

To access output formats, each `Page` object provides two methods: [`OutputFormats`][] (for all formats, including the current one) and [`AlternativeOutputFormats`][]. Use `AlternativeOutputFormats` to create a link `rel` list within a `head` element, as shown below:

```go-html-template
{{ range .AlternativeOutputFormats }}
  <link rel="{{ .Rel }}" type="{{ .MediaType.Type }}" href="{{ .Permalink | safeURL }}">
{{ end }}
```

## Link to output formats

By default, a `Page` object's [`Permalink`][] and [`RelPermalink`][] methods return the URL of the [primary output format](g), typically `html`. This behavior remains consistent regardless of the template used.

For example, in `page.json.json`, you'll see:

```go-html-template
{{ .RelPermalink }} → /that-page/
{{ with .OutputFormats.Get "json" }}
  {{ .RelPermalink }} → /that-page/index.json
{{ end }}
```

To make these methods return the URL of the _current_ template's output format, you must set the [`permalinkable`](#permalinkable) setting to `true` for that format.

With `permalinkable` set to true for `json` in the same `page.json.json` template:

```go-html-template
{{ .RelPermalink }} → /that-page/index.json
{{ with .OutputFormats.Get "html" }}
  {{ .RelPermalink }} → /that-page/
{{ end }}
```

## Template lookup order

Each output format requires a template conforming to the [template lookup order][].

For the highest specificity in the template lookup order, include the page kind, output format, and suffix in the file name:

```text
[page kind].[output format].[suffix]
```

For example, for section pages:

Output format|Template path
:--|:--
`html`|`layouts/section.html.html`
`json`|`layouts/section.json.json`
`rss`|`layouts/section.rss.xml`

[`AlternativeOutputFormats`]: /methods/page/alternativeoutputformats/
[`OutputFormats`]: /methods/page/outputformats/
[`Permalink`]: /methods/page/permalink/
[`RelPermalink`]: /methods/page/relpermalink/
[`baseURL`]: /configuration/all/#baseurl
[`html/template`]: https://pkg.go.dev/html/template
[`publishDir`]: /configuration/all/#publishdir
[`text/template`]: https://pkg.go.dev/text/template
[`uglyURLs`]: /configuration/ugly-urls/
[alias redirects]: /content-management/urls/#aliases
[configure media types]: /configuration/media-types/
[configure outputs]: /configuration/outputs/
[configured media types]: /configuration/media-types/
[default media types]: /configuration/media-types/
[embedded RSS template]: <{{% eturl rss %}}>
[template lookup order]: /templates/lookup-order/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/configuration/outputs.md
---


{{% glossary-term "output format" %}}

Learn more about creating and configuring output formats in the [configure output formats][] section.

## Outputs per page kind

The following default configuration determines the output formats generated for each page kind:

{{< code-toggle config=outputs />}}

To render the built-in `json` output format for the `home` page kind, assuming you've already created the necessary template, add the following to your configuration:

{{< code-toggle file=hugo >}}
[outputs]
home = ['html','rss','json']
{{< /code-toggle >}}

Notice in this example that we only specified the `home` page kind. You don't need to include entries for other page kinds unless you intend to modify their default output formats.

> [!NOTE]
> The order of the output formats in the arrays above is important. The first element will be the _primary output format_ for that page kind, and in most cases that should be `html` as shown in the default configuration.
>
> The primary output format for a given page kind determines the value returned by the [`Permalink`][] and [`RelPermalink`][] methods on a `Page` object.
>
> See the [link to output formats][] section for details.

## Outputs per page

Add output formats to a page's rendering using the `outputs` field in its front matter. For example, to include `json` in the output formats rendered for a specific page:

{{< code-toggle file=content/example.md fm=true >}}
title = 'Example'
outputs = ['json']
{{< /code-toggle >}}

In its default configuration, Hugo will render both the `html` and `json` output formats for this page. The `outputs` field appends to, rather than replaces, the project's configured outputs.

[`Permalink`]: /methods/page/permalink/
[`RelPermalink`]: /methods/page/relpermalink/
[configure output formats]: /configuration/output-formats/
[link to output formats]: configuration/output-formats/#link-to-output-formats


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/configuration/page.md
---


{{% glossary-term "default sort order" %}}

Hugo uses the default sort order to determine the _next_ and _previous_ page relative to the current page when calling these methods on a `Page` object:

- [`Next`][] and [`Prev`][]
- [`NextInSection`][] and [`PrevInSection`][]

This is based on this default project configuration:

{{< code-toggle config=page />}}

`nextPrevInSectionSortOrder`
: (`string`) The sort order used to determine the _next_ and _previous_ page within the same section when calling [`NextInSection`][] or [`PrevInSection`][] on a `Page` object. Valid values are `asc` (ascending) or `desc` (descending). Default is `desc`.

`nextPrevSortOrder`
: (`string`) The sort order used to determine the _next_ and _previous_ page when calling [`Next`][] or [`Prev`][] on a `Page` object. Valid values are `asc` (ascending) or `desc` (descending). Default is `desc`.

To reverse the meaning of _next_ and _previous_:

{{< code-toggle file=hugo >}}
[page]
  nextPrevInSectionSortOrder = 'asc'
  nextPrevSortOrder = 'asc'
{{< /code-toggle >}}

> [!NOTE]
> These settings do not apply to the [`Next`][next-pages] or [`Prev`][prev-pages] methods on a `Pages` object.

[`NextInSection`]: /methods/page/nextinsection/
[`Next`]: /methods/page/next/
[`PrevInSection`]: /methods/page/previnsection/
[`Prev`]: /methods/page/prev/
[next-pages]: /methods/pages/next/
[prev-pages]: /methods/pages/prev/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/configuration/pagination.md
---


This is the default configuration:

{{< code-toggle config=pagination />}}

`disableAliases`
: (`bool`) Whether to disable alias generation for the first pager. Default is `false`.

`pagerSize`
: (`int`) The number of pages per pager. Default is `10`.

`path`
: (`string`) The segment of each pager URL indicating that the target page is a pager. Default is `page`.

With multilingual projects you can define the pagination behavior for each language:

{{< code-toggle file=hugo >}}
[languages.en]
contentDir = 'content/en'
direction = 'ltr'
label = 'English'
locale = 'en-US'
weight = 1
[languages.en.pagination]
disableAliases = true
pagerSize = 10
path = 'page'
[languages.de]
contentDir = 'content/de'
direction = 'ltr'
label = 'Deutsch'
locale = 'de-DE'
weight = 2
[languages.de.pagination]
disableAliases = true
pagerSize = 20
path = 'blatt'
{{< /code-toggle >}}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/configuration/params.md
---


Use the `params` key for custom parameters:

{{< code-toggle file=hugo >}}
baseURL = 'https://example.org/'
locale = 'en-US'
title = 'Project Documentation'
[params]
subtitle = 'Reference, Tutorials, and Explanations'
[params.contact]
email = 'info@example.org'
phone = '+1 206-555-1212'
{{< /code-toggle >}}

Access the custom parameters from your templates using the [`Params`][] method on a `Site` object:

```go-html-template
{{ .Site.Params.subtitle }} → Reference, Tutorials, and Explanations
{{ .Site.Params.contact.email }} → info@example.org
```

Key names should use camelCase or snake_case. While TOML, YAML, and JSON allow kebab-case keys, they are not valid [identifiers](g) and cannot be used when [chaining](g) identifiers.

For example, you can do either of these:

```go-html-template
{{ .Site.params.camelCase.foo }}
{{ .Site.params.snake_case.foo }}
```

But you cannot do this:

```go-html-template
{{ .Site.params.kebab-case.foo }}
```

## Multilingual projects

For multilingual projects, create a `params` key under each language:

{{< code-toggle file=hugo >}}
baseURL = 'https://example.org/'
defaultContentLanguage = 'en'

[languages.de]
direction = 'ltr'
label = 'Deutsch'
locale = 'de-DE'
title = 'Projekt Dokumentation'
weight = 1

[languages.de.params]
subtitle = 'Referenz, Tutorials und Erklärungen'

[languages.de.params.contact]
email = 'info@de.example.org'
phone = '+49 30 1234567'

[languages.en]
direction = 'ltr'
label = 'English'
locale = 'en-US'
title = 'Project Documentation'
weight = 2

[languages.en.params]
subtitle = 'Reference, Tutorials, and Explanations'

[languages.en.params.contact]
email = 'info@example.org'
phone = '+1 206-555-1212'
{{< /code-toggle >}}

## Namespacing

To prevent naming conflicts, module and theme developers should namespace any custom parameters specific to their module or theme.

{{< code-toggle file=hugo >}}
[params.modules.myModule.colors]
background = '#efefef'
font = '#222222'
{{< /code-toggle >}}

To access the module/theme settings:

```go-html-template
{{ $cfg := .Site.Params.module.mymodule }}

{{ $cfg.colors.background }} → #efefef
{{ $cfg.colors.font }} → #222222
```

[`Params`]: /methods/site/params/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/configuration/permalinks.md
---


Use the `permalinks` configuration to define custom URL patterns for your pages. Hugo supports two forms: a map form for simple section-based patterns, and an array form that supports [page matchers](g) for more precise targeting.

> [!NOTE]
> The [`url`][] front matter field overrides any matching permalink pattern.

## Map form

Define URL patterns for each top-level [section](g), keyed by [page kind](g). For example, to configure URL patterns for the `articles` section:

{{< code-toggle file=hugo >}}
[permalinks.page]
articles = '/blog/:year/:month/:slug/'
[permalinks.section]
articles = '/blog/'
{{< /code-toggle >}}

To configure permalinks per language, nest the `permalinks` key under the language key:

{{< code-toggle file=hugo >}}
[languages]
  [languages.de]
    label = 'Deutsch'
    locale = 'de-DE'
    weight = 1
    [languages.de.permalinks]
      [languages.de.permalinks.page]
        articles = '/artikel/:year/:month/:slug/'
      [languages.de.permalinks.section]
        articles = '/artikel/'
  [languages.en]
    label = 'English'
    locale = 'en-US'
    weight = 2
    [languages.en.permalinks]
      [languages.en.permalinks.page]
        articles = '/blog/:year/:month/:slug/'
      [languages.en.permalinks.section]
        articles = '/blog/'
{{< /code-toggle >}}

## Array form

{{< new-in 0.161.0 />}}

Define an array of permalink entries to apply different URL patterns to different subsets of pages. Each entry requires a `pattern` key. Hugo applies the first matching pattern.

The optional `target` key accepts a [page matcher](g). If `target` is omitted, the pattern applies to all pages.

{{% include "/_common/configuration/page-matcher.md" %}}

For example, to apply language-specific URL patterns to the `articles` section page and its leaf pages separately:

{{< code-toggle file=hugo >}}
[[permalinks]]
  pattern = '/artikel/'
  [permalinks.target]
    path = '{/articles}'
    [permalinks.target.sites]
      [permalinks.target.sites.matrix]
        languages = ['de']
[[permalinks]]
  pattern = '/artikel/:year/:month/:slug/'
  [permalinks.target]
    path = '{/articles/**}'
    [permalinks.target.sites]
      [permalinks.target.sites.matrix]
        languages = ['de']
[[permalinks]]
  pattern = '/blog/'
  [permalinks.target]
    path = '{/articles}'
    [permalinks.target.sites]
      [permalinks.target.sites.matrix]
        languages = ['en']
[[permalinks]]
  pattern = '/blog/:year/:month/:slug/'
  [permalinks.target]
    path = '{/articles/**}'
    [permalinks.target.sites]
      [permalinks.target.sites.matrix]
        languages = ['en']
{{< /code-toggle >}}

To define a fallback that matches any page not already matched by a preceding entry, place a pattern without a `target` key at the end:

{{< code-toggle file=hugo >}}
[[permalinks]]
pattern = '/:section/:slug/'
{{< /code-toggle >}}

## Tokens

Use these tokens when defining a URL pattern.

{{% include "/_common/permalink-tokens.md" %}}

[`url`]: /content-management/front-matter/#url


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/configuration/privacy.md
---


## Responsibility

Site authors are responsible for ensuring compliance with regional privacy regulations, including but not limited to:

- GDPR (General Data Protection Regulation): Applies to individuals within the European Union and the European Economic Area.
- CCPA (California Consumer Privacy Act): Applies to California residents.
- CPRA (California Privacy Rights Act): Expands upon the CCPA with stronger consumer privacy protections.
- Virginia Consumer Data Protection Act (CDPA): Applies to businesses that collect, process, or sell the personal data of Virginia residents.

Hugo's privacy settings can assist in compliance efforts.

## Embedded templates

Hugo provides [embedded templates](g) to simplify project and content creation. Some of these templates interact with external services. For example, the `youtube` shortcode connects with YouTube's servers to embed videos.

Some of these templates include settings to enhance privacy.

## Configuration

> [!NOTE]
> These settings affect the behavior of some of Hugo's embedded templates. These settings may or may not affect the behavior of templates provided by third parties in their modules or themes.

These are the default privacy settings for Hugo's embedded templates:

{{< code-toggle config=privacy />}}

See each template's documentation for a description of its privacy settings:

- [Disqus partial][]
- [Google Analytics partial][]
- [Instagram shortcode][]
- [Vimeo shortcode][]
- [X shortcode][]
- [YouTube shortcode][]

[Disqus partial]: /templates/embedded/#privacy-disqus
[Google Analytics partial]: /templates/embedded/#privacy-google-analytics
[Instagram shortcode]: /shortcodes/instagram/#privacy
[Vimeo shortcode]: /shortcodes/vimeo/#privacy
[X shortcode]: /shortcodes/x/#privacy
[YouTube shortcode]: /shortcodes/youtube/#privacy


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/configuration/related-content.md
---


> [!NOTE]
> To understand Hugo's related content identification, please refer to the [related content][] page.

Hugo provides a sensible default configuration for identifying related content, but you can customize it in your project configuration, either globally or per language.

## Default configuration

This is the default configuration:

{{< code-toggle config=related />}}

> [!NOTE]
> Adding a `related` section to your project configuration requires you to provide a full configuration. You cannot override individual default values without specifying all related settings.

## Top-level settings

`threshold`
: (`int`) A value between 0-100, inclusive. A lower value will return more, but maybe not so relevant, matches.

`includeNewer`
: (`bool`) Whether to include pages newer than the current page in the related content listing. This will mean that the output for older posts may change as new related content gets added. Default is `false`.

`toLower`
: (`bool`) Whether to transform keywords in both the indexes and the queries to lower case. This may give more accurate results at a slight performance penalty. Default is `false`.

## Per-index settings

`applyFilter`
: (`string`) Apply a `type` specific filter to the result of a search. This is only used for the `fragments` type.

`cardinalityThreshold`
: (`int`) If between `1` and `100`, this is a percentage. All keywords that are used in more than this percentage of documents are removed. For example, setting this to `60` will remove all keywords that are used in more than 60% of the documents in the index. If `0`, no keyword is removed from the index. Default is `0`.

`name`
: (`string`) The index name. This value maps directly to a page parameter. Hugo supports string values (`author` in the example) and lists (`tags`, `keywords` etc.) and time and date objects.

`pattern`
: (`string`) This is currently only relevant for dates. When listing related content, we may want to list content that is also close in time. Setting "2006" (default value for date indexes) as the pattern for a date index will add weight to pages published in the same year. For busier blogs, "200601" (year and month) may be a better default.

`toLower`
: (`bool`) Whether to transform keywords in both the indexes and the queries to lower case. This may give more accurate results at a slight performance penalty. Default is `false`.

`type`
: (`string`) One of `basic` or `fragments`. Default is `basic`.

`weight`
: (`int`) An integer weight that indicates how important this parameter is relative to the other parameters. It can be `0`, which has the effect of turning this index off, or even negative. Test with different values to see what fits your content best. Default is `0`.

## Example

Imagine we're building a book review site. Our main content will be book reviews, and we'll use genres and authors as taxonomies. When someone views a book review, we want to show a short list of related reviews based on shared authors and genres.

Create the content:

```tree
content/
└── book-reviews/
    ├── book-review-1.md
    ├── book-review-2.md
    ├── book-review-3.md
    ├── book-review-4.md
    └── book-review-5.md
```

Configure the taxonomies:

{{< code-toggle file=hugo >}}
[taxonomies]
author = 'authors'
genre = 'genres'
{{< /code-toggle >}}

Configure the related content identification:

{{< code-toggle file=hugo >}}
[related]
includeNewer = true
threshold = 80
toLower = true
[[related.indices]]
name = 'authors'
weight = 2
[[related.indices]]
name = 'genres'
weight = 1
{{< /code-toggle >}}

We've configured the `authors` index with a weight of `2` and the `genres` index with a weight of `1`. This means Hugo prioritizes shared `authors` as twice as significant as shared `genres`.

Then render a list of 5 related reviews with a _partial_ template like this:

```go-html-template {file="layouts/_partials/related.html" copy=true}
{{ with site.RegularPages.Related . | first 5 }}
  <p>Related content:</p>
  <ul>
    {{ range . }}
      <li><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></li>
    {{ end }}
  </ul>
{{ end }}
```

[related content]: /content-management/related-content/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/configuration/roles.md
---


{{< new-in 0.153.0 />}}

This is the default configuration:

{{< code-toggle config=roles />}}

## Settings

Use the following setting to define how Hugo orders roles.

`weight`
: (`int`) The role [weight](g).

## Sort order

Hugo sorts roles by weight in ascending order, then lexicographically in ascending order. This affects build order and complement selection.

## Example

The following configuration demonstrates how to define multiple roles with specific weights.

{{< code-toggle >}}
[roles.guest]
weight = 20
[roles.member]
weight = 10
{{< /code-toggle >}}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/configuration/security.md
---


Hugo's built-in security policy, which restricts access to `os/exec`, remote communication, and similar operations, is configured via allowlists. By default, access is restricted. If a build attempts to use a feature not included in the allowlist, it will fail, providing a detailed message.

This is the default security configuration:

{{< code-toggle config=security />}}

`allowContent`
: {{< new-in 0.162.0 />}}
: (`[]string`) A slice of [regular expressions](g) matching the [media type](g) of [content formats](g) allowed in the `content` directory. By default, the HTML content format (media type `text/html`) is denied. Hugo emits HTML file content verbatim, which could allow arbitrary JavaScript execution. See the [classification][] table for a mapping of content formats to media types.

`enableInlineShortcodes`
: (`bool`) Whether to enable [inline shortcodes][]. Default is `false`.

`exec.allow`
: (`[]string`) A slice of [regular expressions](g) matching the names of external executables that Hugo is allowed to run.

`exec.osEnv`
: (`[]string`) A slice of [regular expressions](g) matching the names of operating system environment variables that Hugo is allowed to access.

`funcs.getenv`
: (`[]string`) A slice of [regular expressions](g) matching the names of operating system environment variables that Hugo is allowed to access with the [`os.Getenv`][] function.

`http.methods`
: (`[]string`) A slice of [regular expressions](g) matching the HTTP methods that the [`resources.GetRemote`][] function is allowed to use.

`http.mediaTypes`
: (`[]string`) Applicable to the `resources.GetRemote` function, a slice of [regular expressions](g) matching the `Content-Type` in HTTP responses that Hugo trusts, bypassing file content analysis for media type detection.

`http.urls`
: (`[]string`) A slice of [regular expressions](g) matching the URLs that the `resources.GetRemote` function is allowed to access.

`node.permissions.disable`
: {{< new-in 0.161.0 />}}
: (`bool`) Whether to disable the Node.js [permission model][]. When `false`, Hugo runs Node.js tools with the `--permission` flag, restricting their file system and resource access to what is explicitly allowed below. Default is `false`.

`node.permissions.allowAddons`
: {{< new-in 0.161.0 />}}
: (`[]string`) A slice of Node.js tool names permitted to load native addons (`--allow-addons`).

`node.permissions.allowChildProcess`
: {{< new-in 0.161.0 />}}
: (`[]string`) A slice of Node.js tool names permitted to spawn child processes (`--allow-child-process`).

`node.permissions.allowRead`
: {{< new-in 0.161.0 />}}
: (`[]string`) A slice of file system paths that Node.js tools are allowed to read (`--allow-fs-read`). Paths are relative to the working directory; `"."` means the working directory itself. Use `"*"` to allow all paths.

`node.permissions.allowWorker`
: {{< new-in 0.161.0 />}}
: (`[]string`) A slice of Node.js tool names permitted to spawn worker threads (`--allow-worker`).

`node.permissions.allowWrite`
: {{< new-in 0.161.0 />}}
: (`[]string`) A slice of file system paths that Node.js tools are allowed to write (`--allow-fs-write`). Paths are relative to the working directory; `"."` means the working directory itself. Use `"*"` to allow all paths.

## Negation rules

{{< new-in 0.161.0 />}}

Any pattern in an allowlist can be negated by prefixing it with an exclamation mark (`!`) and one space to turn it into a deny rule. Deny rules take precedence over allow rules. An allowlist composed entirely of deny rules implicitly allows everything it does not deny. An empty allowlist rejects everything.

For example, to allow all URLs except those pointing to `evil.example.com`:

```toml
[security.http]
urls = ['.*', '! ^https?://evil\.example\.com']
```

Setting an allowlist to the string `none` will completely disable the associated feature.

## Environment variables

You can also override your project configuration with environment variables. For example, to block `resources.GetRemote` from accessing any URL:

```txt
export HUGO_SECURITY_HTTP_URLS=none
```

Learn more about [using environment variables][] to configure your site.

[`os.Getenv`]: /functions/os/getenv/
[`resources.GetRemote`]: /functions/resources/getremote/
[classification]: /content-management/formats/#classification
[inline shortcodes]: /content-management/shortcodes/#inline
[permission model]: https://nodejs.org/api/permissions.html#permission-model
[using environment variables]: /configuration/introduction/#environment-variables


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/configuration/segments.md
---


> [!NOTE]
> The `segments` configuration applies only to segmented rendering. While it controls when content is rendered, it doesn't restrict access to Hugo's complete object graph (sites and pages), which remains fully available.

Segmented rendering offers several advantages:

- Faster builds: Process large sites more efficiently.
- Rapid development: Render only a subset of your site for quicker iteration.
- Scheduled rebuilds: Rebuild specific sections at different frequencies (e.g., home page and news hourly, full site weekly).
- Targeted output: Generate specific output formats (like JSON for search indexes).

## Segment definition

Each segment is defined by an `includes` key and an `excludes` key, both of which accept an array of filters.

A _filter_ is a collection of one or more conditions, represented as an item in the configuration array. A _condition_ compares a specific page [field](#fields) to a given [glob pattern](g).

### Evaluation rules

The evaluation logic adheres to three rules:

- All conditions within a single filter item must match for that filter to evaluate as true, creating an AND relationship.
- If the `includes` or `excludes` array contains multiple filters, only one filter needs to evaluate as true for the entire array to match, creating an OR relationship.
- The `excludes` array takes absolute precedence. If a page matches any filter in the `excludes` array, Hugo omits it from the segment regardless of whether it matches the `includes` array.

### Performance optimization

Using the `excludes` array to target sites or output formats allows Hugo to skip entire groups of pages during evaluation instead of checking every page. This optimization helps with performance in larger setups.

For example, excluding unwanted output formats is faster:

{{< code-toggle file=hugo >}}
[segments]
  [segments.segment1]
    [[segments.segment1.excludes]]
      output = '! json'
{{< /code-toggle >}}

Including only the desired output format is slower:

{{< code-toggle file=hugo >}}
[segments]
  [segments.segment1]
    [[segments.segment1.includes]]
      output = 'json'
{{< /code-toggle >}}

## Fields

`kind`
: (`string`) A [glob pattern](g) matching the [page kind](g). For example: `{taxonomy,term}`.

`lang`
: {{< deprecated-in 0.153.0 />}}
: Use [`sites`](#sites) instead.

`output`
: (`string`) A [glob pattern](g) matching the [output format](g) of the page. For example: `{html,json}`.

`path`
: (`string`) A [glob pattern](g) matching the page's [logical path](g). For example: `{/books,/books/**}`.

`sites`
: {{< new-in 0.153.0 />}}
: (`map`) A map to define [sites matrix](g).

## Targeting segments

To specify which segments Hugo builds, add the [`renderSegments`][] setting to your project configuration:

{{< code-toggle file=hugo >}}
renderSegments = ['segment1','segment2']
{{< /code-toggle >}}

Alternatively, pass the segment names directly to the `--renderSegments` command-line flag during a build:

```sh
hugo build --renderSegments segment1
```

You can target multiple segments by providing a comma-separated list:

```sh
hugo build --renderSegments segment1,segment2
```

## Example

<!--
To test the example below:

git clone --single-branch -b segmentation-test https://github.com/jmooring/hugo-testing segmentation-test
cd segmentation-test
rm -rf public/ && hugo build --renderSegments segment1 && tree public
-->

Consider a project with this content structure:

```tree
content/
├── books/
│   ├── _index.en.md
│   ├── _index.nb.md
│   ├── _index.nn.md
│   ├── book-1.en.md
│   ├── book-1.nb.md
│   └── book-1.nn.md
├── films/
│   ├── _index.en.md
│   ├── _index.nb.md
│   ├── _index.nn.md
│   ├── film-1.en.md
│   ├── film-1.nb.md
│   └── film-1.nn.md
├── _index.en.md
├── _index.nb.md
└── _index.nn.md
```

And this project configuration:

{{< code-toggle file=hugo >}}
baseURL                        = 'https://example.org/'
title                          = 'Segmentation'
defaultContentLanguage         = 'en'
defaultContentLanguageInSubdir = true

[languages.en]
  direction = 'ltr'
  label     = 'English'
  locale    = 'en-US'
  weight    = 1

[languages.nb]
  locale    = 'nb-NO'
  direction = 'ltr'
  label     = 'Bokmål'
  weight    = 2

[languages.nn]
  locale    = 'nn-NO'
  direction = 'ltr'
  label     = 'Norsk'
  weight    = 3

[segments]
  [segments.segment1]
    [[segments.segment1.excludes]]
      [segments.segment1.excludes.sites.matrix]
        languages = ['n*']
    [[segments.segment1.excludes]]
      output = 'rss'
      [segments.segment1.excludes.sites.matrix]
        languages = ['en']
    [[segments.segment1.includes]]
      kind = '{home,term,taxonomy}'
    [[segments.segment1.includes]]
      path = '{/books,/books/**}'

[taxonomies]
  tag = 'tags'
{{< /code-toggle >}}

When you run this command:

```sh
hugo build --renderSegments segment1
```

The published project has this structure:

```tree
public/
├── en/
│   ├── books/
│   │   ├── book-1/
│   │   │   └── index.html
│   │   └── index.html
│   ├── tags/
│   │   ├── tag-a/
│   │   │   └── index.html
│   │   ├── tag-b/
│   │   │   └── index.html
│   │   └── index.html
│   └── index.html
└── index.html
```

[`renderSegments`]: /configuration/all/#rendersegments


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/configuration/server.md
---


These settings are exclusive to Hugo's development server, so a dedicated [configuration directory][] for development, where the server is configured accordingly, is the recommended approach.

```tree
project/
└── config/
    ├── _default/
    │   └── hugo.toml
    └── development/
        └── server.toml
```

## Default settings

The development server defaults to redirecting to `/404.html` for any requests to URLs that don't exist. See the [404 errors](#404-errors) section below for details.

{{< code-toggle config=server />}}

`force`
: (`bool`) Whether to force a redirect even if there is existing content in the path.

`from`
: (`string`) A [glob pattern](g) matching the requested URL. Either `from` or `fromRE` must be set. If both `from` and `fromRe` are specified, the URL must match both patterns.

`fromHeaders`
: {{< new-in 0.144.0 />}}
: (`map[string][string]`) Headers to match for the redirect. This maps the HTTP header name to a [glob pattern](g) with values to match. If the map is empty, the redirect will always be triggered.

`fromRe`
: {{< new-in 0.144.0 />}}
: (`string`) A [regular expression](g) used to match the requested URL. Either `from` or `fromRE` must be set. If both `from` and `fromRe` are specified, the URL must match both patterns. Capture groups from the regular expression are accessible in the `to` field as `$1`, `$2`, and so on.

`status`
: (`string`) The HTTP status code to use for the redirect. A status code of 200 will trigger a URL rewrite.

`to`
: (`string`) The URL to forward the request to.

## Headers

Include headers in every server response to facilitate testing, particularly for features like [Content Security Policies][].

{{< code-toggle file=config/development/server >}}
[[headers]]
for = '/**'

[headers.values]
X-Frame-Options = 'DENY'
X-XSS-Protection = '1; mode=block'
X-Content-Type-Options = 'nosniff'
Referrer-Policy = 'strict-origin-when-cross-origin'
Content-Security-Policy = 'script-src localhost:1313'
{{< /code-toggle >}}

## Redirects

You can define simple redirect rules.

{{< code-toggle file=config/development/server >}}
[[redirects]]
from = '/myspa/**'
to = '/myspa/'
status = 200
force = false
{{< /code-toggle >}}

The `200` status code in this example triggers a URL rewrite, which is typically the desired behavior for [single-page applications][].

## 404 errors

The development server defaults to redirecting to /404.html for any requests to URLs that don't exist.

{{< code-toggle config=server />}}

If you've already defined other redirects, you must explicitly add the 404 redirect.

{{< code-toggle file=config/development/server >}}
[[redirects]]
force = false
from   = '/**'
to     = '/404.html'
status = 404
{{< /code-toggle >}}

For multilingual projects, ensure the default language 404 redirect is defined last:

{{< code-toggle file=config/development/server >}}
defaultContentLanguage = 'en'
defaultContentLanguageInSubdir = false
[[redirects]]
from = '/fr/**'
to = '/fr/404.html'
status = 404

[[redirects]] # Default language must be last.
from = '/**'
to = '/404.html'
status = 404
{{< /code-toggle >}}

When the default language is served from a subdirectory:

{{< code-toggle file=config/development/server >}}
defaultContentLanguage = 'en'
defaultContentLanguageInSubdir = true
[[redirects]]
from = '/fr/**'
to = '/fr/404.html'
status = 404

[[redirects]] # Default language must be last.
from = '/**'
to = '/en/404.html'
status = 404
{{< /code-toggle >}}

[Content Security Policies]: https://developer.mozilla.org/en-US/docs/Web/HTTP/CSP
[configuration directory]: /configuration/introduction/#configuration-directory
[single-page applications]: https://en.wikipedia.org/wiki/Single-page_application


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/configuration/services.md
---


Hugo provides [embedded templates](g) to simplify site and content creation. Some of these templates are configurable. For example, the embedded Google Analytics template requires a Google tag ID.

This is the default configuration:

{{< code-toggle config=services />}}

`disqus.shortname`
: (`string`) The `shortname` used with the Disqus commenting system. See [details][disqus]. To access this value from a template:

  ```go-html-template
  {{ .Site.Config.Services.Disqus.Shortname }}
  ```

`googleAnalytics.id`
: (`string`) The Google tag ID for Google Analytics 4 properties. See [details][google-analytics]. To access this value from a template:

  ```go-html-template
  {{ .Site.Config.Services.GoogleAnalytics.ID }}
  ```

`rss.limit`
: (`int`) The maximum number of items to include in an RSS feed. Set to `-1` for no limit. Default is `-1`. See [details][rss]. To access this value from a template:

  ```go-html-template
  {{ .Site.Config.Services.RSS.Limit }}
  ```

`x.disableInlineCSS`
: (`bool`) Whether to disable the inline CSS rendered by the embedded `x` shortode. See [details][privacy]. Default is `false`. To access this value from a template:

  ```go-html-template
  {{ .Site.Config.Services.X.DisableInlineCSS }}
  ```

[disqus]: /templates/embedded/#disqus
[google-analytics]: /templates/embedded/#google-analytics
[privacy]: /shortcodes/x/#privacy
[rss]: /templates/rss/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/configuration/sitemap.md
---


These are the default sitemap configuration values. They apply to all pages unless overridden in front matter.

{{< code-toggle config=sitemap />}}

`changefreq`
: (`string`) How frequently a page is likely to change. Valid values are `always`, `hourly`, `daily`, `weekly`, `monthly`, `yearly`, and `never`. With the default value of `""` Hugo will omit this field from the sitemap. See [details][changefreqdef].

`disable`
: (`bool`) Whether to disable page inclusion. Default is `false`. Set to `true` in front matter to exclude the page.

`filename`
: (`string`) The name of the generated file. Default is `sitemap.xml`.

`priority`
: (`float`) The priority of a page relative to any other page on the site. Valid values range from 0.0 to 1.0. With the default value of `-1` Hugo will omit this field from the sitemap. See [details][prioritydef].

[changefreqdef]: https://www.sitemaps.org/protocol.html#changefreqdef
[prioritydef]: https://www.sitemaps.org/protocol.html#prioritydef


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/configuration/taxonomies.md
---


The default configuration defines two [taxonomies](g), `categories` and `tags`.

{{< code-toggle config=taxonomies />}}

When creating a taxonomy:

- Use the singular form for the key (e.g., `category`).
- Use the plural form for the value (e.g., `categories`).

Then use the value as the key in front matter:

<!-- markdownlint-disable MD007 MD032 -->
{{< code-toggle file=content/example.md fm=true >}}
title: Example
categories:
  - vegetarian
  - gluten-free
tags:
  - appetizer
  - main course
{{< /code-toggle >}}
<!-- markdownlint-enable MD007 MD032 -->
If you do not expect to assign more than one [term](g) from a given taxonomy to a content page, you may use the singular form for both key and value:

{{< code-toggle file=hugo >}}
taxonomies:
  author: author
{{< /code-toggle >}}

Then in front matter:

<!-- markdownlint-disable MD007 MD032 -->
{{< code-toggle file=content/example.md fm=true >}}
title: Example
author:
  - Robert Smith
{{< /code-toggle >}}
<!-- markdownlint-enable MD007 MD032 -->

The example above illustrates that even with a single term, the value is still provided as an array.

You must explicitly define the default taxonomies to maintain them when adding a new one:

{{< code-toggle file=hugo >}}
taxonomies:
  author: author
  category: categories
  tag: tags
{{< /code-toggle >}}

To disable the taxonomy system, use the [`disableKinds`][] setting in the root of your project configuration to disable the `taxonomy` and `term` page [kinds](g).

{{< code-toggle file=hugo >}}
disableKinds = ['taxonomy','term']
{{< /code-toggle >}}

See the [taxonomies][] section for more information.

[`disableKinds`]: /configuration/all/#disablekinds
[taxonomies]: /content-management/taxonomies/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/configuration/ugly-urls.md
---


{{% glossary-term "ugly url" %}}&nbsp;For example:

```text
https://example.org/section/article.html
```

In its default configuration, Hugo generates [pretty URLs](g). For example:

```text
https://example.org/section/article/
```

This is the default configuration:

{{< code-toggle config=uglyURLs />}}

To generate ugly URLs for the entire site:

{{< code-toggle file=hugo >}}
uglyURLs = true
{{< /code-toggle >}}

To generate ugly URLs for specific sections of your site:

{{< code-toggle file=hugo >}}
[uglyURLs]
books = true
films = false
{{< /code-toggle >}}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/configuration/versions.md
---


{{< new-in 0.153.0 />}}

This is the default configuration:

{{< code-toggle config=versions />}}

## Settings

Use the following setting to define how Hugo orders versions.

`weight`
: (`int`) The language [weight](g).

## Sort order

Hugo sorts versions by weight in ascending order, then by their [semantic version][] in descending order. This affects build order and complement selection.

## Example

The following configuration demonstrates how to define multiple versions with specific weights.

{{< code-toggle >}}
[versions."v1.0.0"]
weight = 20
[versions."v2.0.0"]
weight = 10
{{< /code-toggle >}}

[semantic version]: https://semver.org/

