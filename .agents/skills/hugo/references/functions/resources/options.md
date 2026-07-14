## Options

The `resources.GetRemote` function accepts an options map.

`body`
: (`string`) The data you want to transmit to the server.

`headers`
: (`map[string][]string`) The collection of key-value pairs that provide additional information about the request.

`key`
: (`string`) The cache key. Hugo derives the default value from the URL and options map. See [caching](#caching).

`method`
: (`string`) The action to perform on the requested resource, typically one of `GET`, `POST`, or `HEAD`.

`responseHeaders`
: {{< new-in 0.143.0 />}}
: (`[]string`) The headers to extract from the server's response, accessible through the resource's [`Data.Headers`][] method. Header name matching is case-insensitive.

`timeout`
: {{< new-in 0.157.0 />}}
: (`string`) The duration after which the request is cancelled if it does not complete, expressed as a [duration](g). If not specified, the request will timeout after 2 minutes.

