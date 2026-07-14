## Cache directory

Hugo's file cache directory is configurable via the [`cacheDir`](#cachedir) setting or the `HUGO_CACHEDIR` environment variable. If neither is set, Hugo will use, in order of preference:

1. If running on Netlify: `/opt/build/cache/hugo_cache/`. This means that if you run your builds on Netlify, all caches configured with `:cacheDir` will be saved and restored on the next build. For other [CI/CD](g) platforms, please read their documentation. For a CircleCI example, see [this configuration][].
1. In a `hugo_cache` directory below the OS user cache directory as defined by Go's [`os.UserCacheDir`][] function. On Unix systems, per the [XDG base directory specification][], this is `$XDG_CACHE_HOME` if non-empty, else `$HOME/.cache`. On MacOS, this is `$HOME/Library/Caches`. On Windows, this is`%LocalAppData%`. On Plan 9, this is `$home/lib/cache`.
1. In a  `hugo_cache_$USER` directory below the OS temp dir.

To determine the current `cacheDir`:

```sh
hugo config | grep cachedir
```

