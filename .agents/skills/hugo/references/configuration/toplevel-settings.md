## Top-level settings

`threshold`
: (`int`) A value between 0-100, inclusive. A lower value will return more, but maybe not so relevant, matches.

`includeNewer`
: (`bool`) Whether to include pages newer than the current page in the related content listing. This will mean that the output for older posts may change as new related content gets added. Default is `false`.

`toLower`
: (`bool`) Whether to transform keywords in both the indexes and the queries to lower case. This may give more accurate results at a slight performance penalty. Default is `false`.

