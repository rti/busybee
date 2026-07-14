## Cache busters

The `build.cachebusters` setting was added to support development using Tailwind 3.x's JIT compiler where a `build` configuration may look like this:

<!-- markdownlint-disable MD049 -->
{{< code-toggle file=hugo >}}
[build]
  [build.buildStats]
    enable = true
  [[build.cachebusters]]
    source = 'assets/watching/hugo_stats\.json'
    target = 'styles\.css'
  [[build.cachebusters]]
    source = '(postcss|tailwind)\.config\.js'
    target = 'css'
  [[build.cachebusters]]
    source = 'assets/.*\.(js|ts|jsx|tsx)'
    target = 'js'
  [[build.cachebusters]]
    source = 'assets/.*\.(.*)$'
    target = '$1'
{{< /code-toggle >}}
<!-- markdownlint-enable MD049 -->

When `buildStats` is enabled, Hugo writes a `hugo_stats.json` file on each build with HTML classes etc. that's used in the rendered output. Changes to this file will trigger a rebuild of the `styles.css` file. You also need to add `hugo_stats.json` to Hugo's server watcher. See [Hugo Starter Tailwind Basic][] for a running example.

`source`
: (`string`) A [regular expression](g) matching file(s) relative to one of the virtual component directories in Hugo, typically `assets/...`.

`target`
: (`string`) A [regular expression](g) matching the keys in the resource cache that should be expired when `source` changes. You can use the matching regexp groups from `source` in the expression, e.g. `$1`.

