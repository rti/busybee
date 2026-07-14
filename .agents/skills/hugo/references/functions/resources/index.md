# resources


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


## Sections

- [`options`](references/functions/resources/options.md) — Options
- [`options-examples`](references/functions/resources/options-examples.md) — Options Examples
- [`remote-data`](references/functions/resources/remote-data.md) — Remote Data
- [`error-handling`](references/functions/resources/error-handling.md) — Error Handling
- [`http-response`](references/functions/resources/http-response.md) — HTTP Response
- [`caching`](references/functions/resources/caching.md) — Caching
- [`security`](references/functions/resources/security.md) — Security
- [`example`](references/functions/resources/example.md) — Example
- [`environment-variables`](references/functions/resources/environment-variables.md) — Environment Variables
- [`limitations`](references/functions/resources/limitations.md) — Limitations

