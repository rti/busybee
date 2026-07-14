## Options

The `RenderString` method on a `Page` object accepts an options map.

`display`
: (`string`) Specify either `inline` or `block`. If `inline`, removes surrounding `p` tags from short snippets. Default is `inline`.

`markup`
: (`string`) Specify a [markup identifier][] for the provided markup. Default is the `markup` front matter value, falling back to the value derived from the page's file extension.

