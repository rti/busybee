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

