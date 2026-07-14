
---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/resources/ByType.md
---


The [media type][] is typically one of `image`, `text`, `audio`, `video`, or `application`.

```go-html-template
{{ range resources.ByType "image" }}
  <img src="{{ .RelPermalink }}" width="{{ .Width }}" height="{{ .Height }}" alt="">
{{ end }}
```

> [!NOTE]
> This function operates on global resources. A global resource is a file within the `assets` directory, or within any directory mounted to the `assets` directory.
>
> For page resources, use the [`Resources.ByType`][] method on a `Page` object.

[`Resources.ByType`]: /methods/page/resources/
[media type]: https://en.wikipedia.org/wiki/Media_type


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/resources/Concat.md
---


The `resources.Concat` function returns a concatenated slice of resources, caching the result using the target path as its cache key. Each resource must have the same [media type](g).

Hugo publishes the resource to the target path when you call its [`Publish`][], [`Permalink`][], or [`RelPermalink`][] method.

```go-html-template
{{ $plugins := resources.Get "js/plugins.js" }}
{{ $global := resources.Get "js/global.js" }}
{{ $js := slice $plugins $global | resources.Concat "js/bundle.js" }}
```

[`Permalink`]: /methods/resource/permalink/
[`Publish`]: /methods/resource/publish/
[`RelPermalink`]: /methods/resource/relpermalink/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/resources/Copy.md
---


```go-html-template
{{ with resources.Get "images/a.jpg" }}
  {{ with resources.Copy "img/new-image-name.jpg" . }}
    <img src="{{ .RelPermalink }}" width="{{ .Width }}" height="{{ .Height }}" alt="">
  {{ end }}
{{ end }}
```

The `TARGETPATH` is relative to the server root. A leading slash is optional and has no effect.

> [!NOTE]
> Use the `resources.Copy` function with global, page, and remote resources.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/resources/ExecuteAsTemplate.md
---


The `resources.ExecuteAsTemplate` function returns a resource created from a Go template, parsed and executed with the given context, caching the result using the target path as its cache key.

Hugo publishes the resource to the target path when you call its [`Publish`][], [`Permalink`][], or [`RelPermalink`][] methods.

Let's say you have a CSS file that you wish to populate with values from your project configuration:

```go-html-template {file="assets/css/template.css"}
body {
  background-color: {{ site.Params.style.bg_color }};
  color: {{ site.Params.style.text_color }};
}
```

And your project configuration contains:

{{< code-toggle file=hugo >}}
[params.style]
bg_color = '#fefefe'
text_color = '#222'
{{< /code-toggle >}}

Place this in your baseof.html template:

```go-html-template
{{ with resources.Get "css/template.css" }}
  {{ with resources.ExecuteAsTemplate "css/main.css" $ . }}
    <link rel="stylesheet" href="{{ .RelPermalink }}">
  {{ end }}
{{ end }}
```

The example above:

1. Captures the template as a resource
1. Executes the resource as a template, passing the current page in context
1. Publishes the resource to css/main.css

The result is:

```css {file="public/css/main.css"}
body {
  background-color: #fefefe;
  color: #222;
}
```

[`Permalink`]: /methods/resource/permalink/
[`Publish`]: /methods/resource/publish/
[`RelPermalink`]: /methods/resource/relpermalink/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/resources/Fingerprint.md
---


```go-html-template
{{ with resources.Get "js/main.js" }}
  {{ with . | fingerprint "sha256" }}
    <script src="{{ .RelPermalink }}" integrity="{{ .Data.Integrity }}" crossorigin="anonymous"></script>
  {{ end }}
{{ end }}
```

Hugo renders this to something like:

```html
<script src="/js/main.62e...df1.js" integrity="sha256-Yuh...rfE=" crossorigin="anonymous"></script>
```

Although most commonly used with CSS and JavaScript resources, you can use the `resources.Fingerprint` function with any resource type.

The hash algorithm may be one of `md5`, `sha256` (default), `sha384`, or `sha512`.

After cryptographically hashing the resource content:

1. The values returned by the `.Permalink` and `.RelPermalink` methods include the hash sum
1. The resource's `.Data.Integrity` method returns a [Subresource Integrity][] (SRI) value consisting of the name of the hash algorithm, one hyphen, and the base64-encoded hash sum

[Subresource Integrity]: https://developer.mozilla.org/en-US/docs/Web/Security/Subresource_Integrity


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/resources/FromString.md
---


The `resources.FromString` function returns a resource created from a string, caching the result using the target path as its cache key.

Hugo publishes the resource to the target path when you call its [`Publish`][], [`Permalink`][], or [`RelPermalink`][] methods.

Let's say you need to publish a file named "site.json" in the root of your `public` directory, containing the build date, the Hugo version used to build the site, and the date that the content was last modified. For example:

```json
{
  "build_date": "2026-04-04T10:46:21-07:00",
  "hugo_version": "0.163.3",
  "last_modified": "2026-04-04T10:46:26-07:00"
}
```

Place this in your baseof.html template:

```go-html-template
{{ if .IsHome }}
  {{ $rfc3339 := "2006-01-02T15:04:05Z07:00" }}
  {{ $m := dict
    "hugo_version" hugo.Version
    "build_date" (now.Format $rfc3339)
    "last_modified" (site.Lastmod.Format $rfc3339)
  }}
  {{ $json := jsonify $m }}
  {{ $r := resources.FromString "site.json" $json }}
  {{ $r.Publish }}
{{ end }}
```

The example above:

1. Creates a map with the relevant key-value pairs using the [`dict`][] function
1. Encodes the map as a JSON string using the [`jsonify`][] function
1. Creates a resource from the JSON string using the `resources.FromString` function
1. Publishes the file to the root of the `public` directory using the resource's `.Publish` method

Combine `resources.FromString` with [`resources.ExecuteAsTemplate`][] if your string contains template actions. Rewriting the example above:

```go-html-template
{{ if .IsHome }}
  {{ $string := `
    {{ $rfc3339 := "2006-01-02T15:04:05Z07:00" }}
    {{ $m := dict
      "hugo_version" hugo.Version
      "build_date" (now.Format $rfc3339)
      "last_modified" (site.Lastmod.Format $rfc3339)
    }}
    {{ $json := jsonify $m }}
    `
  }}
  {{ $r := resources.FromString "" $string }}
  {{ $r = $r | resources.ExecuteAsTemplate "site.json" . }}
  {{ $r.Publish }}
{{ end }}
```

[`Permalink`]: /methods/resource/permalink/
[`Publish`]: /methods/resource/publish/
[`RelPermalink`]: /methods/resource/relpermalink/
[`dict`]: /functions/collections/dictionary/
[`jsonify`]: /functions/encoding/jsonify/
[`resources.ExecuteAsTemplate`]: /functions/resources/executeastemplate/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/resources/Get.md
---


```go-html-template
{{ with resources.Get "images/a.jpg" }}
  <img src="{{ .RelPermalink }}" width="{{ .Width }}" height="{{ .Height }}" alt="">
{{ end }}
```

> [!NOTE]
> This function operates on global resources. A global resource is a file within the `assets` directory, or within any directory mounted to the `assets` directory.
>
> For page resources, use the [`Resources.Get`][] method on a `Page` object.

[`Resources.Get`]: /methods/page/resources/#get


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/resources/GetMatch.md
---


```go-html-template
{{ with resources.GetMatch "images/*.jpg" }}
  <img src="{{ .RelPermalink }}" width="{{ .Width }}" height="{{ .Height }}" alt="">
{{ end }}
```

> [!NOTE]
> This function operates on global resources. A global resource is a file within the `assets` directory, or within any directory mounted to the `assets` directory.
>
> For page resources, use the [`Resources.GetMatch`][] method on a `Page` object.

Hugo determines a match using a case-insensitive [glob pattern](g).

{{% include "/_common/glob-patterns.md" %}}

[`Resources.GetMatch`]: /methods/page/resources/#getmatch


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/resources/GetRemote.md
---


{{< new-in 0.141.0 >}}
The `Err` method on the returned resource was removed in v0.141.0.

Use the [`try`][] statement instead, as shown in the [error handling](#error-handling) example below.
{{< /new-in >}}

```go-html-template
{{ $url := "https://example.org/images/a.jpg" }}
{{ with try (resources.GetRemote $url) }}
  {{ with .Err }}
    {{ errorf "%s" . }}
  {{ else with .Value }}
    <img src="{{ .RelPermalink }}" width="{{ .Width }}" height="{{ .Height }}" alt="">
  {{ else }}
    {{ errorf "Unable to get remote resource %q" $url }}
  {{ end }}
{{ end }}
```

## Options

The `resources.GetRemote` function accepts an options map.

`body`
: (`string`) The data you want to transmit to the server.

`headers`
: (`map[string][]string`) The collection of key-value pairs that provide additional information about the request.

`key`
: (`string`) The cache key. Hugo derives the default value from the URL and options map. See [caching](#caching).

`method`
: (`string`) The action to perform on the requested resource, typically one of `GET`, `POST`, or `HEAD`.

`responseHeaders`
: {{< new-in 0.143.0 />}}
: (`[]string`) The headers to extract from the server's response, accessible through the resource's [`Data.Headers`][] method. Header name matching is case-insensitive.

`timeout`
: {{< new-in 0.157.0 />}}
: (`string`) The duration after which the request is cancelled if it does not complete, expressed as a [duration](g). If not specified, the request will timeout after 2 minutes.

## Options examples

> [!NOTE]
> For brevity, the examples below do not include [error handling](#error-handling).

To include a header:

```go-html-template
{{ $url := "https://example.org/api" }}
{{ $opts := dict
  "headers" (dict "Authorization" "Bearer abcd")
}}
{{ $resource := resources.GetRemote $url $opts }}
```

To specify more than one value for the same header key, use a slice:

```go-html-template
{{ $url := "https://example.org/api" }}
{{ $opts := dict
  "headers" (dict "X-List" (slice "a" "b" "c"))
}}
{{ $resource := resources.GetRemote $url $opts }}
```

To post data:

```go-html-template
{{ $url := "https://example.org/api" }}
{{ $opts := dict
  "method" "post"
  "body" `{"complete": true}`
  "headers" (dict  "Content-Type" "application/json")
}}
{{ $resource := resources.GetRemote $url $opts }}
```

To override the default cache key:

```go-html-template
{{ $url := "https://example.org/images/a.jpg" }}
{{ $opts := dict
  "key" (print $url (now.Format "2006-01-02"))
}}
{{ $resource := resources.GetRemote $url $opts }}
```

To extract specific headers from the server's response:

```go-html-template
{{ $url := "https://example.org/images/a.jpg" }}
{{ $opts := dict
  "method" "HEAD"
  "responseHeaders" (slice "X-Frame-Options" "Server")
}}
{{ $resource := resources.GetRemote $url $opts }}
```

Use the `timeout` option to prevent slow external requests from stalling the build when fetching multiple remote feeds:

```go-html-template
{{ $url := "https://example.org/feed.rss" }}
{{ $opts := dict "timeout" "10s" }}
{{ with try (resources.GetRemote $url $opts) }}
  {{ with .Err }}
    {{ warnf "Failed to fetch feed: %s" . }}
  {{ else with .Value }}
    {{ $data = . | transform.Unmarshal }}
  {{ end }}
{{ end }}
```

## Remote data

When retrieving remote data, use the [`transform.Unmarshal`][] function to [unmarshal](g) the response.

```go-html-template
{{ $data := dict }}
{{ $url := "https://example.org/books.json" }}
{{ with try (resources.GetRemote $url) }}
  {{ with .Err }}
    {{ errorf "%s" . }}
  {{ else with .Value }}
    {{ $data = . | transform.Unmarshal }}
  {{ else }}
    {{ errorf "Unable to get remote resource %q" $url }}
  {{ end }}
{{ end }}
```

> [!NOTE]
> When retrieving remote data, a misconfigured server may send a response header with an incorrect [Content-Type][]. For example, the server may set the Content-Type header to `application/octet-stream` instead of `application/json`.
>
> In these cases, pass the resource `Content` through the `transform.Unmarshal` function instead of passing the resource itself. For example, in the above, do this instead:
>
> `{{ $data = .Content | transform.Unmarshal }}`

## Error handling

Use the [`try`][] statement to capture HTTP request errors. If you do not handle the error yourself, Hugo will fail the build.

> [!NOTE]
> Hugo does not classify an HTTP response with status code 404 as an error. In this case `resources.GetRemote` returns nil.

```go-html-template
{{ $url := "https://broken-example.org/images/a.jpg" }}
{{ with try (resources.GetRemote $url) }}
  {{ with .Err }}
    {{ errorf "%s" . }}
  {{ else with .Value }}
    <img src="{{ .RelPermalink }}" width="{{ .Width }}" height="{{ .Height }}" alt="">
  {{ else }}
    {{ errorf "Unable to get remote resource %q" $url }}
  {{ end }}
{{ end }}
```

To log an error as a warning instead of an error:

```go-html-template
{{ $url := "https://broken-example.org/images/a.jpg" }}
{{ with try (resources.GetRemote $url) }}
  {{ with .Err }}
    {{ warnf "%s" . }}
  {{ else with .Value }}
    <img src="{{ .RelPermalink }}" width="{{ .Width }}" height="{{ .Height }}" alt="">
  {{ else }}
    {{ warnf "Unable to get remote resource %q" $url }}
  {{ end }}
{{ end }}
```

## HTTP response

The [`Data`][] method on a resource returned by the `resources.GetRemote` function returns information from the HTTP response.

## Caching

Resources returned from `resources.GetRemote` are cached to disk. See [configure file caches][] for details.

By default, Hugo derives the cache key from the arguments passed to the function. Override the cache key by setting a `key` in the options map. Use this approach to have more control over how often Hugo fetches a remote resource.

```go-html-template
{{ $url := "https://example.org/images/a.jpg" }}
{{ $cacheKey := print $url (now.Format "2006-01-02") }}
{{ $opts := dict "key" $cacheKey }}
{{ $resource := resources.GetRemote $url $opts }}
```

## Security

To protect against malicious intent, the `resources.GetRemote` function inspects the server response including:

- The [Content-Type][] in the response header
- The file extension, if any
- The content itself

If Hugo is unable to resolve the media type to an entry in its [allowlist][], the function throws an error:

```text
ERROR error calling resources.GetRemote: failed to resolve media type...
```

For example, you will see the error above if you attempt to download an executable.

Although the allowlist contains entries for common media types, you may encounter situations where Hugo is unable to resolve the media type of a file that you know to be safe. In these situations, edit your project configuration to add the media type to the allowlist. For example:

{{< code-toggle file=hugo >}}
[security.http]
mediaTypes = ['^application/vnd\.api\+json$']
{{< /code-toggle >}}

Note that the entry above is:

- An _addition_ to the allowlist; it does not _replace_ the allowlist
- An array of [regular expressions](g)

[Content-Type]: https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Type
[`Data.Headers`]: /methods/resource/data/#headers
[`Data`]: /methods/resource/data/
[`transform.Unmarshal`]: /functions/transform/unmarshal/
[`try`]: /functions/go-template/try/
[allowlist]: https://en.wikipedia.org/wiki/Whitelist
[configure file caches]: /configuration/caches/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/resources/Match.md
---


```go-html-template
{{ range resources.Match "images/*.jpg" }}
  <img src="{{ .RelPermalink }}" width="{{ .Width }}" height="{{ .Height }}" alt="">
{{ end }}
```

> [!NOTE]
> This function operates on global resources. A global resource is a file within the `assets` directory, or within any directory mounted to the `assets` directory.
>
> For page resources, use the [`Resources.Match`][] method on a `Page` object.

Hugo determines a match using a case-insensitive [glob pattern][].

{{% include "/_common/glob-patterns.md" %}}

[`Resources.Match`]: /methods/page/resources/#match
[glob pattern]: https://github.com/gobwas/glob#example


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/resources/Minify.md
---


```go-html-template
{{ $css := resources.Get "css/main.css" }}
{{ $style := $css | minify }}
```

Any CSS, JS, JSON, HTML, SVG, or XML resource can be minified using resources.Minify which takes for argument the resource object.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/resources/PostProcess.md
---


The `resources.PostProcess` function delays resource transformation steps until the build is complete, primarily for tasks like removing unused CSS rules.

## Example

In this example, after the build is complete, Hugo will:

1. Purge unused CSS using the [PurgeCSS][] plugin for [PostCSS][]
1. Add vendor prefixes to CSS rules using the [Autoprefixer][] plugin for PostCSS
1. [Minify][] the CSS
1. [Fingerprint][] the CSS

Step 1
: Install [Node.js][].

Step 2
: Install the required Node packages in the root of your project:

  ```sh {copy=true}
  npm i -D postcss postcss-cli autoprefixer @fullhuman/postcss-purgecss
  ```

Step 3
: Enable creation of the `hugo_stats.json` file when building the site. If you are only using this for the production build, consider placing it below [`config/production`][].

  {{< code-toggle file=hugo copy=true >}}
  [build.buildStats]
  enable = true
  {{< /code-toggle >}}

  See the [configure build][] documentation for details and options.

Step 4
: Create a PostCSS configuration file in the root of your project.

  ```js {file="postcss.config.mjs" copy=true}
  import autoprefixer from 'autoprefixer';
  import purgeCSSPlugin from '@fullhuman/postcss-purgecss';

  const purgecss = purgeCSSPlugin({
    content: ['./hugo_stats.json'],
    defaultExtractor: content => {
      const els = JSON.parse(content).htmlElements;
      return [
        ...(els.tags || []),
        ...(els.classes || []),
        ...(els.ids || []),
      ];
    },
    // https://purgecss.com/safelisting.html
    safelist: []
  });

  export default {
    plugins: [
      process.env.HUGO_ENVIRONMENT !== 'development' ? purgecss : null,
      autoprefixer,
    ]
  };
  ```

Step 5
: Place your CSS file within the `assets/css` directory.

Step 6
: If the current environment is not `development`, process the resource with PostCSS:

  ```go-html-template {copy=true}
  {{ with resources.Get "css/main.css" }}
    {{ if hugo.IsDevelopment }}
      <link rel="stylesheet" href="{{ .RelPermalink }}">
    {{ else }}
      {{ with . | postCSS | minify | fingerprint | resources.PostProcess }}
        <link rel="stylesheet" href="{{ .RelPermalink }}" integrity="{{ .Data.Integrity }}" crossorigin="anonymous">
      {{ end }}
    {{ end }}
  {{ end }}
  ```

## Environment variables

Hugo passes the environment variables below to PostCSS, allowing you to do something like:

```js
process.env.HUGO_ENVIRONMENT !== 'development' ? purgecss : null,
```

`PWD`
: The absolute path to the project working directory.

`HUGO_ENVIRONMENT`
: The current Hugo environment, set with the `--environment` command line flag.
Default is `production` for `hugo build` and `development` for `hugo server`.

`HUGO_PUBLISHDIR`
: The absolute path to the publish directory, typically `public`. This value points to a directory on disk, even when rendering to memory with the `--renderToMemory` command line flag.

`HUGO_FILE_X`
: Hugo automatically mounts the following files from your project's root directory under `assets/_jsconfig`:

- `babel.config.js`, `babel.config.mjs`, `babel.config.cjs`
- `postcss.config.js`, `postcss.config.mjs`, `postcss.config.cjs`
- `tailwind.config.js`, `tailwind.config.mjs`, `tailwind.config.cjs`

For each file, Hugo creates a corresponding environment variable named `HUGO_FILE_:filename:`, where `:filename:` is the uppercase version of the filename with periods replaced by underscores. This allows you to access these files within your JavaScript, for example:

```js
let tailwindConfig = process.env.HUGO_FILE_TAILWIND_CONFIG_JS || './tailwind.config.js';
```

## Limitations

Do not use `resources.PostProcess` when running Hugo's built-in development server. The examples above specifically prevent this by verifying that the current environment is not `development`.

The `resources.PostProcess` function only works within templates that produce HTML files.

You cannot manipulate the values returned from the resource's methods. For example, the `strings.ToUpper` function in this example will not work as expected:

```go-html-template
{{ $css := resources.Get "css/main.css" }}
{{ $css = $css | css.PostCSS | minify | fingerprint | resources.PostProcess }}
{{ $css.RelPermalink | strings.ToUpper }}
```

[Autoprefixer]: https://github.com/postcss/autoprefixer
[Fingerprint]: /functions/resources/fingerprint/
[Minify]: /functions/resources/minify/
[Node.js]: https://nodejs.org/en
[PostCSS]: https://postcss.org/
[PurgeCSS]: https://github.com/FullHuman/purgecss
[`config/production`]: /configuration/introduction/#configuration-directory
[configure build]: /configuration/build/

