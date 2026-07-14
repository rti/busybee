## Imports

{{< code-toggle file=hugo >}}
[[module.imports]]
disable = false
ignoreConfig = false
ignoreImports = false
path = 'github.com/gohugoio/hugoTestModules1_linux/modh1_2_1v'
[[module.imports]]
path = 'my-shortcodes'
{{< /code-toggle >}}

`disable`
: (`bool`) Whether to disable the module but keep version information in the `go.*` files. Default is `false`.

`ignoreConfig`
: (`bool`) Whether to ignore module configuration files, for example, `hugo.toml`. This will also prevent loading of any transitive module dependencies. Default is `false`.

`ignoreImports`
: (`bool`) Whether to ignore module imports. Default is `false`.

`noMounts`
: (`bool`) Whether to disable directory mounting for this import. Default is `false`.

`noVendor`
: (`bool`) Whether to disable vendoring for this import. This setting is restricted to the main project. Default is `false`.

`usePackageJSON`
: {{< new-in 0.159.0 />}}
: (`string`) Whether to use the import's npm dependencies in [hugo mod npm pack](commands/hugo_mod_npm_pack/). One of `auto` (default), `always` or `never`. When set to `auto`, Hugo will enable this if either there is a Hugo config file (e.g. `hugo.toml`) or a `package.hugo.json` file in the module root.

`path`
: (`string`) The module path, either a valid Go module path (e.g., `github.com/gohugoio/myShortcodes`) or the directory name if stored in the [`themesDir`][].

`version`
: {{< new-in 0.150.0 />}}
: (`string`) If set to a [version query][], this import becomes a direct dependency, in contrast to dependencies managed by Go modules. See [this issue][] for more information.

