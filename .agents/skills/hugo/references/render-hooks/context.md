## Context

Table _render hook_ templates receive the following [context](g):

`Attributes`
: (`map`) The [Markdown attributes][], available if you configure your site as follows:

  {{< code-toggle file=hugo >}}
  [markup.goldmark.parser.attribute]
  block = true
  {{< /code-toggle >}}

`Ordinal`
: (`int`) The zero-based ordinal of the table on the page.

`Page`
: (`page`) A reference to the current page.

`PageInner`
: (`page`) A reference to a page nested via the [`RenderShortcodes`][] method. [See details](#pageinner-details).

`Position`
: (`string`) The position of the table within the page content.

`THead`
: (`slice`) A slice of table header rows, where each element is a slice of table cells.

`TBody`
: (`slice`) A slice of table body rows, where each element is a slice of table cells.

