## Page map

Set any [front matter field][] in the map passed to the [`AddPage`](#addpage) method, excluding `markup`. Instead of setting the `markup` field, specify the `content.mediaType` as described below.

This table describes the fields most commonly passed to the `AddPage` method.

Key|Description|Required
:--|:--|:-:
`content.mediaType`|The content [media type][]. Default is `text/markdown`. See [content formats][] for examples.|&nbsp;
`content.value`|The content value as a string.|&nbsp;
`dates.date`|The page creation date as a `time.Time` value.|&nbsp;
`dates.expiryDate`|The page expiry date as a `time.Time` value.|&nbsp;
`dates.lastmod`|The page last modification date as a `time.Time` value.|&nbsp;
`dates.publishDate`|The page publication date as a `time.Time` value.|&nbsp;
`params`|A map of page parameters.|&nbsp;
`path`|The page's [logical path](g) relative to the content adapter. Do not include a leading slash or file extension.|:heavy_check_mark:
`title`|The page title.|&nbsp;

> [!NOTE]
> While `path` is the only required field, we recommend setting `title` as well.
>
> When setting the `path`, Hugo transforms the given string to a logical path. For example, setting `path` to `A B C` produces a logical path of `/section/a-b-c`.

