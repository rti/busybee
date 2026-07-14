## Inline

An inline shortcode is a _shortcode_ template defined within content.

Hugo's security model is based on the premise that template and configuration authors are trusted, but content authors are not. This model enables generation of HTML output safe against code injection.

To conform with this security model, creating _shortcode_ templates within content is disabled by default. If you trust your content authors, you can enable this functionality in your project configuration:

{{< code-toggle file=hugo >}}
[security]
enableInlineShortcodes = true
{{< /code-toggle >}}

For more information see [configure security][].

The following example demonstrates an inline shortcode, `date.inline`, that accepts a single positional argument: a date/time [layout string][].

```md {file="content/example.md"}
Today is
{{</* date.inline ":date_medium" */>}}
  {{- now | time.Format (.Get 0) -}}
{{</* /date.inline */>}}.

Today is {{</* date.inline ":date_full" /*/>}}.
```

In the example above, the inline shortcode is executed twice: once upon definition and again when subsequently called. Hugo renders this to:

```html
<p>Today is Jan 30, 2025.</p>
<p>Today is Thursday, January 30, 2025</p>
```

Inline shortcodes process their inner content within the same context as regular _shortcode_ templates, allowing you to use any available [shortcode method][].

> [!NOTE]
> You cannot [nest](#nesting) inline shortcodes.

Learn more about creating shortcodes in the [shortcode templates][] section.

