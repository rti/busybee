## Overview

Hugo provides several methods to add syntax highlighting to code examples:

- Use the [`transform.Highlight`][] function within your templates
- Use the [`highlight`][] shortcode with any [content format](g)
- Use [fenced code blocks][] with the Markdown content format

Regardless of method, use any of the syntax highlighting styles below.

Set the default syntax highlighting style in your project configuration:

{{< code-toggle file=hugo >}}
[markup.highlight]
style = 'monokai'
{{< /code-toggle >}}

See [configure Markup][].

