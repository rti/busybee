# transform


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/transform/CanHighlight.md
---


```go-html-template
{{ transform.CanHighlight "go" }} → true
{{ transform.CanHighlight "klingon" }} → false
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/transform/Emojify.md
---


`emojify` runs a passed string through the Emoji emoticons processor.

See the list of [emoji shortcodes][] for available emoticons.

The `emojify` function can be called in your templates but not directly in your content files by default. For emojis in content files, set [`enableEmoji`][] to `true` in your project configuration. Then you can write emoji shorthand directly into your content files;

```md
I :heart: Hugo!
```

I :heart: Hugo!

[`enableEmoji`]: /configuration/all/#enableemoji
[emoji shortcodes]: /quick-reference/emojis/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/transform/HTMLEscape.md
---


The `transform.HTMLEscape` function escapes five special characters by replacing them with [HTML entities][]:

- `&` → `&amp;`
- `<` → `&lt;`
- `>` → `&gt;`
- `'` → `&#39;`
- `"` → `&#34;`

For example:

```go-html-template
{{ htmlEscape "Lilo & Stitch" }} → Lilo &amp; Stitch
{{ htmlEscape "7 > 6" }} → 7 &gt; 6
```

[HTML entities]: https://developer.mozilla.org/en-US/docs/Glossary/Entity


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/transform/HTMLUnescape.md
---


The `transform.HTMLUnescape` function replaces [HTML entities][] with their corresponding characters.

```go-html-template
{{ htmlUnescape "Lilo &amp; Stitch" }} → Lilo & Stitch
{{ htmlUnescape "7 &gt; 6" }} → 7 > 6
```

In most contexts Go's [`html/template`][] package will escape special characters. To bypass this behavior, pass the unescaped string through the [`safe.HTML`][] function.

```go-html-template
{{ htmlUnescape "Lilo &amp; Stitch" | safeHTML }}
```

[HTML entities]: https://developer.mozilla.org/en-US/docs/Glossary/Entity
[`html/template`]: https://pkg.go.dev/html/template
[`safe.HTML`]: /functions/safe/html/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/transform/HTMLtoMarkdown.md
---


{{< new-in 0.151.0 />}}

> [!NOTE]
> This function is experimental and its API may change in the future.

The `transform.HTMLToMarkdown` function converts HTML to Markdown by utilizing the [`html-to-markdown`][] Go package.


## Sections

- [`usage`](references/functions/transform/usage.md) — Usage
- [`plugins`](references/functions/transform/plugins.md) — Plugins
- [`arguments`](references/functions/transform/arguments.md) — Arguments
- [`examples`](references/functions/transform/examples.md) — Examples
- [`options`](references/functions/transform/options.md) — Options
- [`arguments`](references/functions/transform/arguments.md) — Arguments
- [`return-value`](references/functions/transform/return-value.md) — Return Value
- [`examples`](references/functions/transform/examples.md) — Examples
- [`options`](references/functions/transform/options.md) — Options
- [`types-supported`](references/functions/transform/types-supported.md) — Types Supported
- [`example`](references/functions/transform/example.md) — Example
- [`server-setup`](references/functions/transform/server-setup.md) — Server Setup
- [`options`](references/functions/transform/options.md) — Options
- [`error-handling`](references/functions/transform/error-handling.md) — Error Handling
- [`example`](references/functions/transform/example.md) — Example
- [`chemistry`](references/functions/transform/chemistry.md) — Chemistry
- [`options`](references/functions/transform/options.md) — Options
- [`unmarshal-a-string`](references/functions/transform/unmarshal-a-string.md) — Unmarshal A String
- [`unmarshal-a-resource`](references/functions/transform/unmarshal-a-resource.md) — Unmarshal A Resource
- [`working-with-csv`](references/functions/transform/working-with-csv.md) — Working With CSV
- [`working-with-xml`](references/functions/transform/working-with-xml.md) — Working With XML

