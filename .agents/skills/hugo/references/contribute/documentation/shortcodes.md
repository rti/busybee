## Shortcodes

These shortcodes are commonly used throughout the documentation. Other shortcodes are available for specialized use.

### code-toggle

Use the `code-toggle` shortcode to display examples of project configuration, front matter, or data files. This shortcode takes these arguments:

`config`
: (`string`) The section of `hugo.Data.docs.config` to render.

`copy`
: (`bool`) Whether to display a copy-to-clipboard button. Default is `false`.

`datakey`
: (`string`) The section of `hugo.Data.docs` to render.

`file`
: (`string`) The file name to display above the rendered code. Omit the file extension for project configuration examples.

`fm`
: (`bool`) Whether to render the code as front matter. Default is `false`.

`skipHeader`
: (`bool`) Whether to omit top-level key(s) when rendering a section of `hugo.Data.docs.config`.

```md {file="content/example.md"}
{{</* code-toggle file=hugo copy=true */>}}
baseURL = 'https://example.org/'
locale = 'en-US'
title = 'My Site'
{{</* /code-toggle */>}}
```

### deprecated-in

Use the `deprecated-in` shortcode to indicate that a feature is deprecated:

```md
{{</* deprecated-in 0.144.0 /*/>}}
```

You can also include details:

```md
{{</* deprecated-in 0.144.0 */>}}
Use the [`hugo.IsServer`](/docs/reference/functions/hugo/isserver/) function instead.
{{</* /deprecated-in */>}}
```

### eturl

Use the embedded template URL (`eturl`) shortcode to insert an absolute URL to the source code for an embedded template. The shortcode takes a single argument, the base file name of the template (omit the file extension).

```md {file="content/example.md"}
This is a link to the [embedded alias template][].

[embedded alias template]: <{{%/* eturl alias */%}}>
```

### glossary-term

Use the `glossary-term` shortcode to insert the definition of the given glossary term.

```md {file="content/example.md"}
{{%/* glossary-term scalar */%}}
```

### include

Use the `include` shortcode to include content from another page.

```md {file="content/example.md"}
{{%/* include "_common/glob-patterns.md" */%}}
```

### new-in

Use the `new-in` shortcode to indicate a new feature:

```md {file="content/example.md"}
{{</* new-in 0.144.0 /*/>}}
```

You can also include details:

```md {file="content/example.md"}
{{</* new-in 0.144.0 */>}}
This is a new feature.
{{</* /new-in */>}}
```

