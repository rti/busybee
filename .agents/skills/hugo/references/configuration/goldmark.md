## Goldmark

This is the default configuration for the Goldmark Markdown renderer:

{{< code-toggle config=markup.goldmark />}}

### Extensions

The extensions below, excluding Extras and Passthrough, are enabled by default.

Extension        | Documentation                                 |      Enabled
:----------------|:----------------------------------------------|:-----------------:
`cjk`            | [Goldmark Extensions: CJK][]                  | :heavy_check_mark:
`definitionList` | [PHP Markdown Extra: Definition lists][]      | :heavy_check_mark:
`extras`         | [Hugo Goldmark Extensions: Extras][]          |       &nbsp;
`footnote`       | [PHP Markdown Extra: Footnotes][]             | :heavy_check_mark:
`linkify`        | [GitHub Flavored Markdown: Autolinks][]       | :heavy_check_mark:
`passthrough`    | [Hugo Goldmark Extensions: Passthrough][]     |       &nbsp;
`strikethrough`  | [GitHub Flavored Markdown: Strikethrough][]   | :heavy_check_mark:
`table`          | [GitHub Flavored Markdown: Tables][]          | :heavy_check_mark:
`taskList`       | [GitHub Flavored Markdown: Task list items][] | :heavy_check_mark:
`typographer`    | [Goldmark Extensions: Typographer][]          | :heavy_check_mark:

#### Extras

Enable [deleted text][], [inserted text][], [mark text][], [subscript][], and [superscript][] elements in Markdown.

Element       | Markdown  | Rendered
:-------------|:----------|:------------------
Deleted text  | `~~foo~~` | `<del>foo</del>`
Inserted text | `++bar++` | `<ins>bar</ins>`
Mark text     | `==baz==` | `<mark>baz</mark>`
Subscript     | `H~2~O`   | `H<sub>2</sub>O`
Superscript   | `1^st^`   | `1<sup>st</sup>`

To avoid a conflict[^1], if you enable the "subscript" feature of the Extras extension, you must disable the Strikethrough extension:

{{< code-toggle file=hugo >}}
[markup.goldmark.extensions]
strikethrough = false

[markup.goldmark.extensions.extras.subscript]
enable = true
{{< /code-toggle >}}

If you still need to show deleted text after disabling the Strikethrough extension, enable the "deleted text" feature of the Extras extension:

{{< code-toggle file=hugo >}}
[markup.goldmark.extensions]
strikethrough = false

[markup.goldmark.extensions.extras.delete]
enable = true
{{< /code-toggle >}}

With this configuration, to format text as deleted, wrap it with double-tildes.

#### Footnote

Enabled by default, the Footnote extension enables inclusion of footnotes in Markdown.

`enable`
: {{< new-in 0.151.0 />}}
: (`bool`) Whether to enable the Footnotes extension. Default is `true`.

`backlinkHTML`
: {{< new-in 0.151.0 />}}
: (`string`) The HTML to be displayed at the end of a footnote that links the user back to the corresponding reference in the main text. The default is &#x21a9;&#xfe0e; (a return arrow symbol).

`enableAutoIDPrefix`
: {{< new-in 0.151.0 />}}
: (`bool`) Whether to prepend a unique prefix to footnote IDs, preventing clashes when multiple documents are rendered together. This prefix is unique to each logical path, which means that the prefix is not unique across content dimensions such as language. Default is `false`.

#### Passthrough

Enable the Passthrough extension to include mathematical equations and expressions in Markdown using LaTeX markup. See [mathematics in Markdown][] for details.

#### Typographer

The Typographer extension replaces certain character combinations with HTML entities as specified below:

Markdown|Replaced by|Description
:--|:--|:--
`...`|`&hellip;`|horizontal ellipsis
`'`|`&rsquo;`|apostrophe
`--`|`&ndash;`|en dash
`---`|`&mdash;`|em dash
`«`|`&laquo;`|left angle quote
`“`|`&ldquo;`|left double quote
`‘`|`&lsquo;`|left single quote
`»`|`&raquo;`|right angle quote
`”`|`&rdquo;`|right double quote
`’`|`&rsquo;`|right single quote

### Goldmark settings explained

Most of the Goldmark settings above are self-explanatory, but some require explanation.

`duplicateResourceFiles`
: (`bool`) Whether to duplicate shared page resources for each language on multilingual single-host projects. See [multilingual page resources][] for details. Default is `false`.

  > [!NOTE]
  > With multilingual single-host projects, setting this parameter to `false` will enable Hugo's [embedded link render hook][] and [embedded image render hook][]. This is the default configuration for multilingual single-host projects.

`parser.wrapStandAloneImageWithinParagraph`
: (`bool`) Whether to wrap image elements without adjacent content within a `p` element when rendered. This is the default Markdown behavior. Set to `false` when using an [image render hook][] to render standalone images as `figure` elements. Default is `true`.

`parser.autoDefinitionTermID`
: {{< new-in 0.144.0 />}}
: (`bool`) Whether to automatically add `id` attributes to description list terms (i.e., `dt` elements). When `true`, the `id` attribute of each `dt` element is accessible through the [`Fragments.Identifiers`][] method on a `Page` object.

`parser.autoHeadingID`
: (`bool`) Whether to automatically add `id` attributes to headings (i.e., `h1`, `h2`, `h3`, `h4`, `h5`, and `h6` elements).

`parser.autoIDType`
: (`string`) The strategy used to automatically generate `id` attributes, one of `github`, `github-ascii` or `blackfriday`. Default is `github`.

  - `github`: Generate GitHub-compatible `id` attributes
  - `github-ascii`: Drop any non-ASCII characters after accent normalization
  - `blackfriday`: Generate `id` attributes compatible with the Blackfriday Markdown renderer

  This is also the strategy used by the [`urls.Anchorize`][] function.

`parser.attribute.block`
: (`bool`) Whether to enable [Markdown attributes][] for block elements. Default is `false`.

`parser.attribute.title`
: (`bool`) Whether to enable [Markdown attributes][] for headings. Default is `true`.

`renderHooks.image.enableDefault`
: {{< deprecated-in 0.148.0 />}}
: Use the `renderHooks.image.useEmbedded` setting instead.

`renderHooks.image.useEmbedded`
: {{< new-in 0.148.0 />}}
: (`string`) When to use the [embedded image render hook][]. One of `auto`, `never`, `always`, or `fallback`. Default is `auto`.

  - `auto`: Use the embedded image render hook only for multilingual single-host projects where the [duplication of shared page resources][] feature is disabled. If custom image render hooks are defined by your project, modules, or themes, these will be used instead.
  - `never`: Never use the embedded image render hook. If custom image render hooks are defined by your project, modules, or themes, these will be used instead.
  - `always`: Always use the embedded image render hook, even if custom image render hooks are provided by your project, modules, or themes.
  - `fallback`: Use the embedded image render hook only if custom image render hooks are not provided by your project, modules, or themes. If custom image render hooks exist, these will be used instead.

`renderHooks.link.enableDefault`
: {{< deprecated-in 0.148.0 />}}
: Use the `renderHooks.link.useEmbedded` setting instead.

`renderHooks.link.useEmbedded`
: (`string`) When to use the [embedded link render hook][]. One of `auto`, `never`, `always`, or `fallback`. Default is `auto`.

  - `auto`: Use the embedded link render hook only for multilingual single-host projects where the [duplication of shared page resources][] feature is disabled. If custom link render hooks are defined by your project, modules, or themes, these will be used instead.
  - `never`: Never use the embedded link render hook. If custom link render hooks are defined by your project, modules, or themes, these will be used instead.
  - `always`: Always use the embedded link render hook, even if custom link render hooks are provided by your project, modules, or themes.
  - `fallback`: Use the embedded link render hook only if custom link render hooks are not provided by your project, modules, or themes. If custom link render hooks exist, these will be used instead.

`renderer.hardWraps`
: (`bool`) Whether to replace newline characters within a paragraph with `br` elements. Default is `false`.

`renderer.unsafe`
: (`bool`) Whether to render raw HTML mixed within Markdown. This is unsafe unless the content is under your control. Default is `false`.

