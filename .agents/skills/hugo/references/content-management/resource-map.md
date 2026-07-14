## Resource map

Construct the map passed to the [`AddResource`](#addresource) method using the fields below.

Key|Description|Required
:--|:--|:-:
`content.mediaType`|The content [media type][].|:heavy_check_mark:
`content.value`|The content value as a string or resource.|:heavy_check_mark:
`name`|The resource name.|&nbsp;
`params`|A map of resource parameters.|&nbsp;
`path`|The resources's [logical path](g) relative to the content adapter. Do not include a leading slash.|:heavy_check_mark:
`title`|The resource title.|&nbsp;

> [!NOTE]
> When `content.value` is a string, Hugo generates a new resource with a publication path relative to the page. However, if `content.value` is already a resource, Hugo directly uses its value and publishes it relative to the site root. This latter method is more efficient.
>
> When setting the `path`, Hugo transforms the given string to a logical path. For example, setting `path` to `A B C/cover.jpg` produces a logical path of `/section/a-b-c/cover.jpg`.

