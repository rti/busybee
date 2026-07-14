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

