## Alerts

Also known as _callouts_ or _admonitions_, alerts are blockquotes used to emphasize critical information.

### Basic syntax

With the basic Markdown syntax, the first line of each alert is an alert designator consisting of an exclamation point followed by the alert type, wrapped within brackets. For example:

```md {file="content/example.md"}
> [!NOTE]
> Useful information that users should know, even when skimming content.

> [!TIP]
> Helpful advice for doing things better or more easily.

> [!IMPORTANT]
> Key information users need to know to achieve their goal.

> [!WARNING]
> Urgent info that needs immediate user attention to avoid problems.

> [!CAUTION]
> Advises about risks or negative outcomes of certain actions.
```

The basic syntax is compatible with [GitHub][], [Obsidian][], and [Typora][].

### Extended syntax

With the extended Markdown syntax, you may optionally include an alert sign and/or an alert title. The alert sign is one of&nbsp;`+`&nbsp;or&nbsp;`-`, typically used to indicate whether an alert is graphically foldable. For example:

```md {file="content/example.md"}
> [!WARNING]+ Radiation hazard
> Do not approach or handle without protective gear.
```

The extended syntax is compatible with [Obsidian][].

> [!NOTE]
> The extended syntax is not compatible with GitHub or Typora. If you include an alert sign or an alert title, these applications render the Markdown as a blockquote.

### Example

This blockquote render hook renders a multilingual alert if an alert designator is present, otherwise it renders a blockquote according to the CommonMark specification.

```go-html-template {file="layouts/_markup/render-blockquote.html" copy=true}
{{ $emojis := dict
  "caution" ":exclamation:"
  "important" ":information_source:"
  "note" ":information_source:"
  "tip" ":bulb:"
  "warning" ":information_source:"
}}

{{ if eq .Type "alert" }}
  <blockquote class="alert alert-{{ .AlertType }}">
    <p class="alert-heading">
      {{ transform.Emojify (index $emojis .AlertType) }}
      {{ with .AlertTitle }}
        {{ . }}
      {{ else }}
        {{ or (i18n .AlertType) (title .AlertType) }}
      {{ end }}
    </p>
    {{ .Text }}
  </blockquote>
{{ else }}
  <blockquote>
    {{ .Text }}
  </blockquote>
{{ end }}
```

To override the label, create these entries in your i18n files:

{{< code-toggle file=i18n/en.toml >}}
caution = 'Caution'
important = 'Important'
note = 'Note'
tip = 'Tip'
warning = 'Warning'
{{< /code-toggle >}}

Although you can use one template with conditional logic as shown above, you can also create separate templates for each [`Type`](#type) of blockquote:

```tree
layouts/
  └── _markup/
      ├── render-blockquote-alert.html
      └── render-blockquote-regular.html
```

{{% include "/_common/render-hooks/pageinner.md" %}}

[CommonMark]: https://spec.commonmark.org/current/
[GitHub]: https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax#alerts
[Markdown attributes]: /content-management/markdown-attributes/
[Obsidian]: https://help.obsidian.md/Editing+and+formatting/Callouts
[Typora]: https://support.typora.io/Markdown-Reference/#callouts--github-style-alerts
[`RenderShortcodes`]: /methods/page/rendershortcodes/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/render-hooks/code-blocks.md
---


