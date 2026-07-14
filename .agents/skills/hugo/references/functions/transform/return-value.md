## Return value

`transform.HighlightCodeBlock` returns a `HighlightResult` object with two methods.

`Wrapped`
: (`template.HTML`) Returns highlighted code wrapped in `<div>`, `<pre>`, and `<code>` elements. This is identical to the value returned by the `transform.Highlight` function.

`Inner`
: (`template.HTML`) Returns highlighted code without any wrapping elements, allowing you to create your own wrapper.

