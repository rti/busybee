## Alternative

Instead of calling the `Summary` method on a `Page` object, use the [`strings.Truncate`][] function for granular control of the summary length. For example:

```go-html-template
{{ range site.RegularPages }}
  <h2><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></h2>
  <div class="summary">
    {{ .Content | strings.Truncate 42 }}
  </div>
{{ end }}
```

[#14044]: https://github.com/gohugoio/hugo/issues/14044
[`Summary`]: /methods/page/summary/
[`strings.Truncate`]: /functions/strings/truncate/
[`summaryLength`]: /configuration/all/#summarylength
[content format]: /content-management/formats/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/content-management/syntax-highlighting.md
---


Hugo provides several methods to add syntax highlighting to code examples:

- Use the [`transform.Highlight`][] function within your templates
- Use the [`highlight`][] shortcode with any [content format](g)
- Use fenced code blocks with the Markdown content format

