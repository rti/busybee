## Hosting considerations

On a [CI/CD](g) platform, the step that clones your project repository must perform a deep clone. If the clone is shallow, the Git information for a given file may be inaccurate. It might incorrectly reflect the most recent repository commit, rather than the commit that actually modified the file.

While some providers perform a deep clone by default, others require you to configure the depth yourself.

Hosting service|Default clone depth|Configurable
:--|:--|:--
AWS Amplify|Deep|N/A
Cloudflare|Shallow|Yes [^1]
DigitalOcean App Platform|Deep|N/A
GitHub Pages|Shallow|Yes [^2]
GitLab Pages|Shallow|Yes [^3]
Netlify|Deep|N/A
Render|Shallow|Yes [^1]
Vercel|Shallow|Yes [^1]

[^1]: To perform a deep clone when hosting on Cloudflare, Render, or Vercel, include this code in the build script after the repository has been cloned:

    ```sh
    if [ "$(git rev-parse --is-shallow-repository)" = "true" ]; then
      git fetch --unshallow
    fi
    ```

[^2]: To perform a deep clone when hosting on GitHub Pages, set `fetch-depth: 0` in the `checkout` step of the GitHub Action.

[^3]: To perform a deep clone when hosting on GitLab Pages, set the `GIT_DEPTH` environment variable to `0` in the workflow file.

[`enableGitInfo`]: /configuration/all/#enablegitinfo
[`replacements`]: /configuration/module/#replacements
[details]: /configuration/front-matter/#dates
[gitmailmap]: https://git-scm.com/docs/gitmailmap
[module replacement]: /hugo-modules/use-modules/#replace
[project configuration]: /configuration/front-matter/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/HasMenuCurrent.md
---


If the `Page` object associated with the menu entry is a section, this method also returns `true` for any descendant of that section.

```go-html-template
{{ $currentPage := . }}
{{ range site.Menus.main }}
  {{ if $currentPage.IsMenuCurrent .Menu . }}
    <a class="active" aria-current="page" href="{{ .URL }}">{{ .Name }}</a>
  {{ else if $currentPage.HasMenuCurrent .Menu . }}
    <a class="ancestor" aria-current="true" href="{{ .URL }}">{{ .Name }}</a>
  {{ else }}
    <a href="{{ .URL }}">{{ .Name }}</a>
  {{ end }}
{{ end }}
```

See [menu templates][] for a complete example.

> [!NOTE]
> When using this method you must either define the menu entry in front matter, or specify a `pageRef` property when defining the menu entry in your project configuration.

[menu templates]: /templates/menu/#example


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/HasShortcode.md
---


By example, let's use [Plotly][] to render a chart:

```md {file="content/example.md"}
{{</* plotly */>}}
{
  "data": [
    {
      "x": ["giraffes", "orangutans", "monkeys"],
      "y": [20, 14, 23],
      "type": "bar"
    }
  ],
}
{{</* /plotly */>}}
```

The shortcode is simple:

```go-html-template {file="layouts/_shortcodes/plotly.html"}
{{ $id := printf "plotly-%02d" .Ordinal }}
<div id="{{ $id }}"></div>
<script>
  Plotly.newPlot(document.getElementById({{ $id }}), {{ .Inner | safeJS }});
</script>
```

Now we can selectively load the required JavaScript on pages that call the "plotly" shortcode:

```go-html-template {file="layouts/baseof.html"}
<head>
  ...
  {{ if .HasShortcode "plotly" }}
    <script src="https://cdn.plot.ly/plotly-2.28.0.min.js"></script>
  {{ end }}
  ...
</head>
```

[Plotly]: https://plotly.com/javascript/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/HeadingsFiltered.md
---


Use in conjunction with the [`Related`][] method on a [`Pages`][] object. See [details][].

[`Pages`]: /methods/pages/
[`Related`]: /methods/pages/related/
[details]: /content-management/related-content/#index-content-headings


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/InSection.md
---


{{% glossary-term section %}}

The `InSection` method on a `Page` object reports whether the given page is in the given section. Note that the method returns `true` when comparing a page to a sibling.

With this content structure:

```tree
content/
├── auctions/
│   ├── 2023-11/
│   │   ├── _index.md
│   │   ├── auction-1.md
│   │   └── auction-2.md
│   ├── 2023-12/
│   │   ├── _index.md
│   │   ├── auction-3.md
│   │   └── auction-4.md
│   ├── _index.md
│   ├── bidding.md
│   └── payment.md
└── _index.md
```

When rendering the `auction-1` page:

```go-html-template
{{ with .Site.GetPage "/" }}
  {{ $.InSection . }} → false
{{ end }}

{{ with .Site.GetPage "/auctions" }}
  {{ $.InSection . }} → false
{{ end }}

{{ with .Site.GetPage "/auctions/2023-11" }}
  {{ $.InSection . }} → true
{{ end }}

{{ with .Site.GetPage "/auctions/2023-11/auction-2" }}
  {{ $.InSection . }} → true
{{ end }}
```

In the examples above we are coding defensively using the [`with`][] statement, returning nothing if the page does not exist. By adding an [`else`][] clause we can do some error reporting:

```go-html-template
{{ $path := "/auctions/2023-11" }}
{{ with .Site.GetPage $path }}
  {{ $.InSection . }} → true
{{ else }}
  {{ errorf "Unable to find the section with path %s" $path }}
{{ end }}
  ```

