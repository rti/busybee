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

