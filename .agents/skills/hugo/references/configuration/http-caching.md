## HTTP caching

The HTTP cache behavior is defined for a configured set of resources. Stale resources will be refreshed from the file cache, even if their configured Time-To-Live (TTL) has not expired. If HTTP caching is disabled for a resource, Hugo will bypass the cache and access the file directly.

This is the default configuration for HTTP caching:

{{< code-toggle config=HTTPCache />}}

`respectCacheControlNoStoreInRequest`
: {{< new-in 0.151.0 />}}
: (`bool`) Whether to respect the `no-store` directive in the server's `Cache-Control` request header when fetching remote resources via the [`resources.GetRemote`][] function. Default is `true`.

`respectCacheControlNoStoreInResponse`
: {{< new-in 0.151.0 />}}
: (`bool`) Whether to respect the `no-store` directive in the server's `Cache-Control` response header when fetching remote resources via the [`resources.GetRemote`][] function. Default is `false`.

`cache.for.excludes`
: (`[]string`) A slice of [glob patterns](g) to exclude from caching. In its default configuration HTTP caching excludes all files.

`cache.for.includes`
: (`[]string`) A slice of [glob patterns](g) to cache.

`polls`
: (`[]PollConfig`) A slice of polling configurations.

`polls.disable`
: (`bool`) Whether to disable polling for this configuration. Default is `true`.

`polls.high`
: (`string`) The maximum polling interval expressed as a [duration](g). This is used when the resource is considered stable. Default is `0s`.

`polls.low`
: (`string`) The minimum polling interval expressed as a [duration](g). This is used after a recent change and gradually increases towards `polls.high`. Default is `0s`.

`polls.for.excludes`
: (`[]string`) A slice of [glob patterns](g) to exclude from polling for this configuration.

`polls.for.includes`
: (`[]string`) A slice of [glob patterns](g) to include in polling for this configuration.

