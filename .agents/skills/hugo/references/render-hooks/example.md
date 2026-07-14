## Example

In its default configuration, Hugo renders Markdown tables according to the [GitHub Flavored Markdown specification][]. To create a render hook that does the same thing:

```go-html-template {file="layouts/_markup/render-table.html" copy=true}
<table
  {{- range $k, $v := .Attributes }}
    {{- if $v }}
      {{- printf " %s=%q" $k $v | safeHTMLAttr }}
    {{- end }}
  {{- end }}>
  <thead>
    {{- range .THead }}
      <tr>
        {{- range . }}
          <th
            {{- with .Alignment }}
              {{- printf " style=%q" (printf "text-align: %s" .) | safeHTMLAttr }}
            {{- end -}}
          >
            {{- .Text -}}
          </th>
        {{- end }}
      </tr>
    {{- end }}
  </thead>
  <tbody>
    {{- range .TBody }}
      <tr>
        {{- range . }}
          <td
            {{- with .Alignment }}
              {{- printf " style=%q" (printf "text-align: %s" .) | safeHTMLAttr }}
            {{- end -}}
          >
            {{- .Text -}}
          </td>
        {{- end }}
      </tr>
    {{- end }}
  </tbody>
</table>
```

{{% include "/_common/render-hooks/pageinner.md" %}}

[GitHub Flavored Markdown specification]: https://github.github.com/gfm/#tables-extension-
[Markdown attributes]: /content-management/markdown-attributes/
[`RenderShortcodes`]: /methods/page/rendershortcodes/

