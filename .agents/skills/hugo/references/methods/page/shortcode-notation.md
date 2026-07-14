## Shortcode notation

In the example above it's important to understand the difference between the two delimiters used when calling a shortcode:

- `{{</* myshortcode */>}}` tells Hugo that the rendered shortcode does not need further processing. For example, the shortcode content is HTML.
- `{{%/* myshortcode */%}}` tells Hugo that the rendered shortcode needs further processing. For example, the shortcode content is Markdown.

Use the latter for the "include" shortcode described above.

