## Fields

The most common front matter fields are `date`, `draft`, `title`, and `weight`, but you can specify metadata using any of fields below.

> [!NOTE]
> The field names below are reserved. For example, you cannot create a custom field named `type`. Create custom fields under the `params` key. See the [parameters](#parameters) section for details.

`aliases`
: (`[]string`) An array of one or more [page-relative](g) or [site-relative](g) paths that should redirect to the current page. Hugo resolves these to [server-relative](g) URLs during the build process. Access these values from a template using the [`Aliases`][] method on a `Page` object. See the [aliases][] section for details.

`build`
: (`map`) A map of [build options][].

`cascade`
: (`map`) A map (or array of maps) of front matter keys whose values are passed down to the page's descendants unless overwritten by self or a closer ancestor's cascade. See the [cascade](#cascade-1) section for details.

`date`
: (`string`) The date associated with the page, typically the creation date. Note that the TOML format also supports unquoted date/time values. See the [dates](#dates) section for examples. Access this value from a template using the [`Date`][] method on a `Page` object.

`description`
: (`string`) Conceptually different than the page `summary`, the description is typically rendered within a `meta` element within the `head` element of the published HTML file. Access this value from a template using the [`Description`][] method on a `Page` object.

`draft`
: (`bool`) Whether to disable rendering unless you pass the `--buildDrafts` flag to the `hugo` command. Access this value from a template using the [`Draft`][] method on a `Page` object.

`expiryDate`
: (`string`) The page expiration date. On or after the expiration date, the page will not be rendered unless you pass the `--buildExpired` flag to the `hugo` command. Note that the TOML format also supports unquoted date/time values. See the [dates](#dates) section for examples. Access this value from a template using the [`ExpiryDate`][] method on a `Page` object.

`headless`
: (`bool`) Applicable to [leaf bundles][], whether to set the `render` and `list` [build options][] to `never`, creating a headless bundle of [page resources][].

`isCJKLanguage`
: (`bool`) Whether the content language is in the [CJK](g) family. This value determines how Hugo calculates word count, and affects the values returned by the [`WordCount`][], [`FuzzyWordCount`][], [`ReadingTime`][], and [`Summary`][] methods on a `Page` object.

`keywords`
: (`[]string`) An array of keywords, typically rendered within a `meta` element within the `head` element of the published HTML file, or used as a [taxonomy](g) to classify content. Access these values from a template using the [`Keywords`][] method on a `Page` object.

`lastmod`
: (`string`) The date that the page was last modified. Note that the TOML format also supports unquoted date/time values. See the [dates](#dates) section for examples. Access this value from a template using the [`Lastmod`][] method on a `Page` object.

`layout`
: (`string`) Provide a template name to [target a specific template][],  overriding the default [template lookup order][]. Set the value to the base file name of the template, excluding its extension. Access this value from a template using the [`Layout`][] method on a `Page` object.

`linkTitle`
: (`string`) Typically a shorter version of the `title`. Access this value from a template using the [`LinkTitle`][] method on a `Page` object.

`markup`
: (`string`) An identifier corresponding to one of the supported [content formats][]. If not provided, Hugo determines the content renderer based on the file extension.

`menus`
: (`string`, `[]string`, or `map`) If set, Hugo adds the page to the given menu or menus. See the [menus][] page for details.

`modified`
: Alias to [lastmod](#lastmod).

`outputs`
: (`[]string`) The [output formats][] to render. See [configure outputs][] for more information.

`params`
: (`map`) A map of custom [page parameters](#parameters).

`pubdate`
: Alias to [publishDate](#publishdate).

`publishDate`
: (`string`) The page publication date. Before the publication date, the page will not be rendered unless you pass the `--buildFuture` flag to the `hugo` command. Note that the TOML format also supports unquoted date/time values. See the [dates](#dates) section for examples. Access this value from a template using the [`PublishDate`][] method on a `Page` object.

`published`
: Alias to [publishDate](#publishdate).

`resources`
: (`map array`) An array of maps to provide metadata for [page resources][]. Each element supports the `src`, `name`, `title`, and `params` keys.

`sitemap`
: (`map`) A map of sitemap options. See the [sitemap templates][] page for details. Access these values from a template using the [`Sitemap`][] method on a `Page` object.

`sites`
: {{< new-in 0.153.0 />}}
: (`map`) A map to define [sites matrix](g) and [sites complements](g) for the page.

  <!-- markdownlint-disable MD049 -->

  {{< code-toggle file=content/_index.md fm=true >}}
  title = 'Home'
  [sites.matrix]
  languages = ["en","fr"]
  versions = ["v1.2.*","v2.*.*"]
  roles = ["**"]
  [sites.complements]
  versions = ["v3.*.*"]
  {{< /code-toggle >}}

  <!-- markdownlint-enable MD049 -->

`slug`
: (`string`) Overrides the last segment of the URL path. Not applicable to `home`, `section`, `taxonomy`, or `term` pages. See the [URL management][] page for details. Access this value from a template using the [`Slug`][] method on a `Page` object.

`summary`
: (`string`) Conceptually different than the page `description`, the summary either summarizes the content or serves as a teaser to encourage readers to visit the page. Access this value from a template using the [`Summary`][] method on a `Page` object.

`title`
: (`string`) The page title. Access this value from a template using the [`Title`][] method on a `Page` object.

`translationKey`
: (`string`) An arbitrary value used to relate two or more translations of the same page, useful when the translated pages do not share a common path. Access this value from a template using the [`TranslationKey`][] method on a `Page` object.

`type`
: (`string`) The [content type](g), overriding the value derived from the top-level section in which the page resides. Access this value from a template using the [`Type`][] method on a `Page` object.

`unpublishdate`
: Alias to [expirydate](#expirydate).

`url`
: (`string`) Overrides the entire URL path. Applicable to regular pages and section pages. See the [URL management][] page for details.

`weight`
: (`int`) The page [weight](g), used to order the page within a [page collection](g). Access this value from a template using the [`Weight`][] method on a `Page` object.

