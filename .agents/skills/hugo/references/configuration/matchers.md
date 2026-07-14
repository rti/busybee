## Matchers

A Matcher represents a configuration to be applied to files whose paths match
the specified pattern.

`cacheControl`
: (`string`) The caching attributes to use when serving the blob. See [details][cacheControl].

`contentEncoding`
: (`string`) The encoding used for the blob's content, if any. See [details][contentEncoding].

`contentType`
: (`string`) The media type of the blob being written. See [details][contentType].

`force`
: (`bool`) Whether matching files should be re-uploaded. Useful when other route-determined metadata (e.g., `contentType`) has changed. Default is `false`.

`gzip`
: (`bool`) Whether the file should be gzipped before upload. If so, the `ContentEncoding` field will automatically be set to `gzip`. Default is `false`.

`pattern`
: (`string`) A [regular expression](g) used to match paths. Paths are converted to use forward slashes (`/`) before matching.

