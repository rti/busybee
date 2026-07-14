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

