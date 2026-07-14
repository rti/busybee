## Behavior

Polling and HTTP caching interact as follows:

- With polling enabled, rebuilds are triggered only by actual changes, detected via `eTag` changes (Hugo generates an MD5 hash if the server doesn't provide one).
- If polling is enabled but HTTP caching is disabled, the remote is checked for changes only after the file cache's TTL expires (e.g., a `maxAge` of `10h` with a `1s` polling interval is inefficient).
- If both polling and HTTP caching are enabled, changes are checked for even before the file cache's TTL expires. Cached `eTag` and `last-modified` values are sent in `if-none-match` and `if-modified-since` headers, respectively, and a cached response is returned on HTTP [304][].

[304]: https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/304
[RFC 9111]: https://datatracker.ietf.org/doc/html/rfc9111
[`resources.GetRemote`]: /functions/resources/getremote/
[cache-busting]: /configuration/build/#cache-busters
[configure file caches]: /configuration/caches/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/configuration/imaging.md
---


These are the default settings for processing images:

{{< code-toggle config=imaging />}}

