## Keys

`dir`
: (`string`) The absolute file system path where Hugo stores the cached files. You can begin the path with the `:cacheDir` or `:resourceDir` [tokens](#tokens) to anchor the cache to specific system or project locations.

`maxAge`
: (`string`) The duration a cached entry remains valid before being evicted, expressed as a [duration](g). A value of `0` disables the cache for that key, and a value of `-1` means the cache entry never expires. Default is `-1`.

