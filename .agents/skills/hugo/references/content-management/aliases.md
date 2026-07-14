## Aliases

Aliases allow you to redirect old URLs to new URLs. This is essential for preventing broken links and ensuring that existing bookmarks or external links continue to function when you rename or move content.

### Defining aliases

To add redirects to a page, list the previous paths in the [`aliases`][aliases_field] field in your front matter. Hugo resolves these to [server-relative](g) paths during the build process, accounting for the [`baseURL`][] and [content dimension](g) prefixes such as language, version, or role.

{{< code-toggle file=content/examples/example-1.en.md fm=true >}}
title = 'Example 1'
date = 2025-02-02
aliases = ['/old-url', 'old-name', '../old/path']
{{< /code-toggle >}}

As shown in the example above, you can use [site-relative](g) paths or [page-relative](g) paths. Page-relative paths can also include directory traversal. Using the file `content/examples/example-1.en.md` as a reference point, here is how Hugo interprets those different path types:

Path type|Alias|Server-relative path
:--|:--|:--
site-relative|`/old-url`|`/en/old-url/`
page-relative|`old-name`|`/en/examples/old-name/`
page-relative|`../old/path`|`/en/old/path/`

### Redirection methods

There are two ways to implement aliases depending on your hosting environment and preferences: client-side redirection and server-side redirection.

> [!NOTE]
> Alias data is only generated for [output formats](g) where both [`isHTML`][] and [`permalinkable`][] are `true`. This affects both the creation of client-side redirect files and the results returned by the [`Aliases`][aliases_method] method used in server-side redirection.

#### Client-side redirection

By default, Hugo uses client-side redirection, generating a small HTML file for every alias. This file contains a `meta http-equiv="refresh"` tag that instructs the browser to navigate to the new URL. This approach is portable across all hosting providers.

When using this method, Hugo creates a physical directory and an `index.html` file at each alias location. For example, if a page at `content/posts/new.md` has a page-relative alias of `old-path`, a file is generated at `public/posts/old-path/index.html`.

Unless you provide a custom layout, Hugo uses its [embedded alias template][] to generate the redirect files:

```go-html-template
<!DOCTYPE html>
<html lang="{{ site.Language.Locale }}">
  <head>
    <title>{{ .Permalink }}</title>
    {{ with .OutputFormats.Canonical }}<link rel="{{ .Rel }}" href="{{ .Permalink }}">{{ end }}
    <meta charset="utf-8">
    <meta http-equiv="refresh" content="0; url={{ .Permalink }}">
  </head>
</html>
```

To override this, create a file named `alias.html` in your `layouts` directory. This custom template has access to the following context:

`Permalink`
: (`string`) The absolute URL of the destination page.

`Page`
: (`page.Page`) The full `Page` object of the destination.

#### Server-side redirection

Alternatively, you can implement server-side redirection by using the [`Aliases`][aliases_method] method on a `Page` object to generate a single configuration file that the web server processes. This method is more efficient because the redirect happens at the HTTP header level before any page content is processed, whereas a meta refresh requires the browser to download and parse the HTML body before acting. Additionally, server-side redirection improves build and deployment times because Hugo doesn't need to write a physical directory and HTML file for every alias.

To implement this, you typically create a single template to generate the necessary rules for your specific host or server. Common examples include:

- A `_redirects` file for hosting services such as Cloudflare, GitLab Pages, and Netlify.
- An `.htaccess` file for web servers such as Apache and LiteSpeed.

See the [`Aliases`][aliases_method] method page for a complete example of how to iterate through pages to generate these rules.

If you implement server-side redirects, you should disable the generation of individual HTML files by setting [`disableAliases`][] to `true` in your project configuration. This setting only prevents the generation of the physical HTML files; the `Aliases` method on a `Page` object remains available for use in your configuration templates.

[`baseURL`]: /configuration/all/#baseurl
[`disableAliases`]: /configuration/all/#disablealiases
[`isHTML`]: /configuration/output-formats/#ishtml
[`permalinkable`]: /configuration/output-formats/#permalinkable
[aliases_field]: /content-management/front-matter/#aliases
[aliases_method]: /methods/page/aliases/
[configure permalinks]: /configuration/permalinks/
[embedded alias template]: <{{% eturl alias %}}>
[removed in a future release]: https://github.com/gohugoio/hugo/issues/4733
[reserved characters]: https://learn.microsoft.com/en-us/windows/win32/fileio/naming-a-file#naming-conventions

