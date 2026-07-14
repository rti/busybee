## Calling

Shortcode calls involve three syntactical elements: tags, arguments, and notation.

### Tags

Some shortcodes expect content between opening and closing tags. For example, the embedded [`details`][] shortcode requires an opening and closing tag:

```md
{{</* details summary="See the details" */>}}
This is a **bold** word.
{{</* /details */>}}
```

Some shortcodes do not accept content. For example, the embedded [`instagram`][] shortcode requires a single _positional_ argument:

```md
{{</* instagram CxOWiQNP2MO */>}}
```

Some shortcodes optionally accept content. For example, you can call the embedded [`qr`][] shortcode with content:

```md
{{</* qr */>}}
https://gohugo.io
{{</* /qr */>}}
```

Or use the self-closing syntax with a trailing slash to pass the text as an argument:

```md
{{</* qr text=https://gohugo.io /*/>}}
```

Refer to each shortcode's documentation for specific usage instructions and available arguments.

### Arguments

Shortcode arguments can be either _named_ or _positional_.

Named arguments are passed as case-sensitive key-value pairs, as seen in this example with the embedded [`figure`][] shortcode. The `src` argument, for instance, is required.

```md
{{</* figure src=/images/kitten.jpg */>}}
```

Positional arguments, on the other hand, are determined by their position. The embedded `instagram` shortcode, for example, expects the first argument to be the Instagram post ID.

```md
{{</* instagram CxOWiQNP2MO */>}}
```

Shortcode arguments are space-delimited, and arguments with internal spaces must be quoted.

```md
{{</* figure src=/images/kitten.jpg alt="A white kitten" */>}}
```

Shortcodes accept [scalar](g) arguments, one of [string](g), [integer](g), [floating point](g), or [boolean](g).

```md
{{</* my-shortcode name="John Smith" age=24 married=false */>}}
```

You can optionally use multiple lines when providing several arguments to a shortcode for better readability:

```md
{{</* figure
  src=/images/kitten.jpg
  alt="A white kitten"
  caption="This is a white kitten"
  loading=lazy
*/>}}
```

Use a [raw string literal](g) if you need to pass a multiline string:

```md
{{</* myshortcode `This is some <b>HTML</b>,
and a new line with a "quoted string".` */>}}
```

Shortcodes can accept named arguments, positional arguments, or both, but you must use either named or positional arguments exclusively within a single shortcode call; mixing them is not allowed.

Refer to each shortcode's documentation for specific usage instructions and available arguments.

### Notation

Shortcodes can be called using two different notations, distinguished by their tag delimiters.

Notation|Example
:--|:--
Markdown|`{{%/* foo */%}} ## Section 1 {{%/* /foo */%}}`
Standard|`{{</* foo */>}} ## Section 2 {{</* /foo */>}}`

#### Markdown notation

Hugo processes the shortcode before the page content is rendered by the Markdown renderer. This means, for instance, that Markdown headings inside a Markdown-notation shortcode will be included when invoking the [`TableOfContents`][] method on the `Page` object.

#### Standard notation

With standard notation, Hugo processes the shortcode separately, merging the output into the page content after Markdown rendering. This means, for instance, that Markdown headings inside a standard-notation shortcode will be excluded when invoking the `TableOfContents` method on the `Page` object.

By way of example, with this _shortcode_ template:

```go-html-template {file="layouts/_shortcodes/foo.html"}
{{ .Inner }}
```

And this markdown:

```md {file="content/example.md"}
{{%/* foo */%}} ## Section 1 {{%/* /foo */%}}

{{</* foo */>}} ## Section 2 {{</* /foo */>}}
```

Hugo renders this HTML:

```html
<h2 id="heading">Section 1</h2>

