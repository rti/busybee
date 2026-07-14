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

