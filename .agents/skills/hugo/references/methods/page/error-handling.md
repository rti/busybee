## Error handling

{{% include "_common/ref-and-relref-error-handling.md" %}}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/Render.md
---


Typically used when ranging over a page collection, the `Render` method on a `Page` object renders the given template, passing the given page as context.

```go-html-template
{{ range site.RegularPages }}
  <h2><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></h2>
  {{ .Render "summary" }}
{{ end }}
```

In the example above, note that the template ("summary") is identified by its file name without directory or extension.

Although similar to the [`partial`][] function, there are key differences.

`Render` method|`partial` function
:--|:--
The `Page` object is automatically passed to the given template. You cannot pass additional context.|You must specify the context, allowing you to pass a combination of objects, slices, maps, and scalars.
The path to the template is determined by the [content type](g).|You must specify the path to the template, relative to the `layouts/_partials` directory.

Consider this layout structure:

```tree
layouts/
├── books/
│   └── li.html   <-- used when content type is "books"
├── baseof.html
├── home.html
├── li.html       <-- used for other content types
├── page.html
├── section.html
├── taxonomy.html
└── term.html
```

And this template:

```go-html-template
<ul>
  {{ range site.RegularPages.ByDate }}
    {{ .Render "li" }}
  {{ end }}
</ul>
```

When rendering content of type "books" the `Render` method calls:

```text
layouts/books/li.html
```

For all other content types the `Render` methods calls:

```text
layouts/li.html
```

See [content views][] for more examples.

[`partial`]: /functions/partials/include/
[content views]: /templates/types/#content-view


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/page/RenderShortcodes.md
---


Use this method in _shortcode_ templates to compose a page from multiple content files, while preserving a global context for footnotes and the table of contents.

For example:

```go-html-template {file="layouts/_shortcodes/include.html" copy=true}
{{ with .Get 0 }}
  {{ with $.Page.GetPage . }}
    {{- .RenderShortcodes }}
  {{ else }}
    {{ errorf "The %q shortcode was unable to find %q. See %s" $.Name . $.Position }}
  {{ end }}
{{ else }}
  {{ errorf "The %q shortcode requires a positional parameter indicating the logical path of the file to include. See %s" .Name .Position }}
{{ end }}
```

Then call the shortcode in your Markdown:

```md {file="content/about.md"}
{{%/* include "/snippets/services" */%}}
{{%/* include "/snippets/values" */%}}
{{%/* include "/snippets/leadership" */%}}
```

Each of the included Markdown files can contain calls to other shortcodes.

