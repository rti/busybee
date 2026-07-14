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

