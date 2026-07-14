## Usage

You may add [global HTML attributes][], or HTML attributes specific to the current element type. Consistent with its content security model, Hugo removes HTML event attributes such as `onclick` and `onmouseover`.

> [!NOTE]
> Within fenced code blocks, Hugo interprets the `style` attribute as a syntax highlighting [option][option] rather than a global HTML attribute.

The attribute list consists of one or more key-value pairs, separated by spaces or commas, wrapped by braces. You must quote string values that contain spaces. Unlike HTML, boolean attributes must have both key and value.

For example:

```md
> This is a blockquote.
{class="foo bar" hidden=hidden}
```

Hugo renders this to:

```html
<blockquote class="foo bar" hidden="hidden">
  <p>This is a blockquote.</p>
</blockquote>
```

In most cases, place the attribute list beneath the markup element. For headings and fenced code blocks, place the attribute list on the right.

Element           | Position of attribute list
:-----------------|:--------------------------
blockquote        | bottom
fenced code block | right
heading           | right
horizontal rule   | bottom
image             | bottom
list              | bottom
paragraph         | bottom
table             | bottom

For example:

````md
