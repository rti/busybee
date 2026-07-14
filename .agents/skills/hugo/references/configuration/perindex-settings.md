## Per-index settings

`applyFilter`
: (`string`) Apply a `type` specific filter to the result of a search. This is only used for the `fragments` type.

`cardinalityThreshold`
: (`int`) If between `1` and `100`, this is a percentage. All keywords that are used in more than this percentage of documents are removed. For example, setting this to `60` will remove all keywords that are used in more than 60% of the documents in the index. If `0`, no keyword is removed from the index. Default is `0`.

`name`
: (`string`) The index name. This value maps directly to a page parameter. Hugo supports string values (`author` in the example) and lists (`tags`, `keywords` etc.) and time and date objects.

`pattern`
: (`string`) This is currently only relevant for dates. When listing related content, we may want to list content that is also close in time. Setting "2006" (default value for date indexes) as the pattern for a date index will add weight to pages published in the same year. For busier blogs, "200601" (year and month) may be a better default.

`toLower`
: (`bool`) Whether to transform keywords in both the indexes and the queries to lower case. This may give more accurate results at a slight performance penalty. Default is `false`.

`type`
: (`string`) One of `basic` or `fragments`. Default is `basic`.

`weight`
: (`int`) An integer weight that indicates how important this parameter is relative to the other parameters. It can be `0`, which has the effect of turning this index off, or even negative. Test with different values to see what fits your content best. Default is `0`.

