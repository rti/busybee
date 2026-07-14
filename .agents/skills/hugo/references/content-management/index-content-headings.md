## Index content headings

Hugo can index the headings in your content and use this to find related content. You can enable this by adding a index of type `fragments` to your `related` configuration:

{{< code-toggle file=hugo >}}
[related]
threshold    = 20
includeNewer = true
toLower      = false
[[related.indices]]
name        = 'fragmentrefs'
type        = 'fragments'
applyFilter = true
weight      = 80
{{< /code-toggle >}}

- The `name` maps to a optional front matter slice attribute that can be used to link from the page level down to the fragment/heading level.
- If `applyFilter` is enabled, the `.HeadingsFiltered` on each page in the result will reflect the filtered headings. This is useful if you want to show the headings in the related content listing:

```go-html-template
{{ $related := .Site.RegularPages.Related . | first 5 }}
{{ with $related }}
  <h2>See Also</h2>
  <ul>
    {{ range $i, $p := . }}
      <li>
        <a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a>
        {{ with .HeadingsFiltered }}
          <ul>
            {{ range . }}
              {{ $link := printf "%s#%s" $p.RelPermalink .ID | safeURL }}
              <li>
                <a href="{{ $link }}">{{ .Title }}</a>
              </li>
            {{ end }}
          </ul>
        {{ end }}
      </li>
    {{ end }}
  </ul>
{{ end }}
```

