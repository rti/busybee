## Layered caching

Hugo employs a layered caching system.

```goat {.w-40}
 .-----------.
|  dynacache  |
 '-----+-----'
       |
       v
 .----------.
| HTTP cache |
 '-----+----'
       |
       v
 .----------.
| file cache |
 '-----+----'
```

Dynacache
: An in-memory cache employing a Least Recently Used (LRU) eviction policy. Entries are removed from the cache when changes occur, when they match [cache-busting][] patterns, or under low-memory conditions.

HTTP Cache
: An HTTP cache for remote resources as specified in [RFC 9111][]. Optimal performance is achieved when resources include appropriate HTTP cache headers. The HTTP cache utilizes the file cache for storage and retrieval of cached resources.

File cache
: See [configure file caches][].

The HTTP cache involves two key aspects: determining which content to cache (the caching process itself) and defining the frequency with which to check for updates (the polling strategy).

