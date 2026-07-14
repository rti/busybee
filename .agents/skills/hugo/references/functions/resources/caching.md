## Caching

Resources returned from `resources.GetRemote` are cached to disk. See [configure file caches][] for details.

By default, Hugo derives the cache key from the arguments passed to the function. Override the cache key by setting a `key` in the options map. Use this approach to have more control over how often Hugo fetches a remote resource.

```go-html-template
{{ $url := "https://example.org/images/a.jpg" }}
{{ $cacheKey := print $url (now.Format "2006-01-02") }}
{{ $opts := dict "key" $cacheKey }}
{{ $resource := resources.GetRemote $url $opts }}
```

