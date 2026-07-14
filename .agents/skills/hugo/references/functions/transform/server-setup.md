## Server setup

Unfortunately, Sanity's API does not support [RFC 7234][] and their output changes even if the data has not. A recommended setup is therefore to use their cached `apicdn` endpoint (see above) and then set up a reasonable polling and file cache strategy in your Hugo configuration, e.g:

<!-- markdownlint-disable MD049 -->
{{< code-toggle file=hugo >}}
[HTTPCache]
  [[HTTPCache.polls]]
    disable = false
    low = '30s'
    high = '3m'
    [HTTPCache.polls.for]
      includes = ['https://*.*.sanity.io/**']

[caches.getresource]
    dir    = ':cacheDir/:project'
    maxAge = "5m"
{{< /code-toggle >}}
<!-- markdownlint-enable MD049 -->

The polling above will be used when running the server/watch mode and rebuilds when you push new content to Sanity.

See [Caching in resources.GetRemote][] for more fine-grained control.

[Caching in resources.GetRemote]: /functions/resources/getremote/#caching
[Portable Text]: https://www.portabletext.org/
[RFC 7234]: https://tools.ietf.org/html/rfc7234
[Sanity]: https://www.sanity.io/
[code-input]: https://www.sanity.io/plugins/code-input
[content adapter]: /content-management/content-adapters/
[image render hook]: /render-hooks/images/
[render hooks]: /render-hooks/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/transform/Remarshal.md
---


The format must be one of `json`, `toml`, `yaml`, or `xml`. If the input is a string of serialized data, it must be valid JSON, TOML, YAML, or XML.

> [!NOTE]
> This function is primarily a helper for Hugo's documentation, used to convert configuration and front matter examples to JSON, TOML, and YAML.
>
> This is not a general purpose converter, and may change without notice if required for Hugo's documentation site.

Example 1
: Convert a string of TOML to JSON.

```go-html-template
{{ $s := `
  baseURL = 'https://example.org/'
  locale = 'en-US'
  title = 'ABC Widgets'
`}}
<pre>{{ transform.Remarshal "json" $s }}</pre>
```

Resulting HTML:

```html
<pre>{
   &#34;baseURL&#34;: &#34;https://example.org/&#34;,
   &#34;locale&#34;: &#34;en-US&#34;,
   &#34;title&#34;: &#34;ABC Widgets&#34;
}
</pre>
```

Rendered in browser:

```text
{
   "baseURL": "https://example.org/",
   "locale": "en-US",
   "title": "ABC Widgets"
}
```

Example 2
: Convert a map to YAML.

```go-html-template
{{ $m := dict
  "a" "Hugo rocks!"
  "b" (dict "question" "What is 6x7?" "answer" 42)
  "c" (slice "foo" "bar")
}}
<pre>{{ transform.Remarshal "yaml" $m }}</pre>
```

Resulting HTML:

```html
<pre>a: Hugo rocks!
b:
  answer: 42
  question: What is 6x7?
c:
- foo
- bar
</pre>
```

Rendered in browser:

```text
a: Hugo rocks!
b:
  answer: 42
  question: What is 6x7?
c:
- foo
- bar
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/transform/ToMath.md
---


Hugo uses an embedded instance of the [KaTeX][] display engine to render mathematical markup to HTML. You do not need to install the KaTeX display engine.

```go-html-template
{{ transform.ToMath "c = \\pm\\sqrt{a^2 + b^2}" }}
```

> [!NOTE]
> By default, Hugo renders mathematical markup to [MathML][], and does not require any CSS to display the result.
>
> To optimize rendering quality and accessibility, use the `htmlAndMathml` output option as described below. This approach requires an external stylesheet.

```go-html-template
{{ $opts := dict "output" "htmlAndMathml" }}
{{ transform.ToMath "c = \\pm\\sqrt{a^2 + b^2}" $opts }}
```

