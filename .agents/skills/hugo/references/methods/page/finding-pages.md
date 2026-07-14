## Finding pages

These methods, functions, and shortcodes use the logical path to find the given page:

Methods|Functions|Shortcodes
:--|:--|:--
[`Site.GetPage`][]|[`urls.Ref`][]|[`ref`][]
[`Page.GetPage`][]|[`urls.RelRef`][]|[`relref`][]
[`Page.Ref`][]|&nbsp;|&nbsp;
[`Page.RelRef`][]|&nbsp;|&nbsp;
[`Shortcode.Ref`][]|&nbsp;|&nbsp;
[`Shortcode.RelRef`][]|&nbsp;|&nbsp;

> [!NOTE]
> Specify the logical path when using any of these methods, functions, or shortcodes. If you include a file extension or language identifier, Hugo will strip these values before finding the page in the logical tree.

