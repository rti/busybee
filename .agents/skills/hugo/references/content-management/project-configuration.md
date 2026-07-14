## Project configuration

### Permalinks

See [configure permalinks][].

### Appearance

See [configure ugly URLs](/configuration/ugly-urls/).

### Post-processing

Hugo provides two mutually exclusive configuration settings to alter URLs _after_ it renders a page.

#### Canonical URLs

> [!CAUTION]
> This is a legacy configuration setting, superseded by template functions and Markdown render hooks, and will likely be [removed in a future release][].
{class="!mt-6"}

If enabled, Hugo performs a search and replace _after_ it renders the page. It searches for site-relative URLs (those with a leading slash) associated with `action`, `href`, `src`, `srcset`, and `url` attributes. It then prepends the `baseURL` to create absolute URLs.

```html
<a href="/about"> → <a href="https://example.org/about/">
<img src="/a.gif"> → <img src="https://example.org/a.gif">
```

This is an imperfect, brute force approach that can affect content as well as HTML attributes. As noted above, this is a legacy configuration setting that will likely be removed in a future release.

To enable:

{{< code-toggle file=hugo >}}
canonifyURLs = true
{{< /code-toggle >}}

#### Relative URLs

> [!CAUTION]
> Do not enable this option unless you are creating a serverless site, navigable via the file system.
{class="!mt-6"}

If enabled, Hugo performs a search and replace _after_ it renders the page. It searches for site-relative URLs (those with a leading slash) associated with `action`, `href`, `src`, `srcset`, and `url` attributes. It then transforms the URL to be relative to the current page.

For example, when rendering `content/posts/post-1`:

```html
<a href="/about"> → <a href="../../about">
<img src="/a.gif"> → <img src="../../a.gif">
```

This is an imperfect, brute force approach that can affect content as well as HTML attributes. As noted above, do not enable this option unless you are creating a serverless site.

To enable:

{{< code-toggle file=hugo >}}
relativeURLs = true
{{< /code-toggle >}}

