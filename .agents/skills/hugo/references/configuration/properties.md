## Properties

Menu entries usually include at least three properties: `name`, `weight`, and either `pageRef` or `url`. Use `pageRef` for internal page destinations and `url` for external destinations.

These are the available menu entry properties:

{{% include "/_common/menu-entry-properties.md" %}}

`pageRef`
: (`string`) The [logical path](g) of the target page. For example:

  page kind|pageRef
  :--|:--
  home|`/`
  page|`/books/book-1`
  section|`/books`
  taxonomy|`/tags`
  term|`/tags/foo`

`url`
: (`string`) The destination URL. Use this for external destinations only.

