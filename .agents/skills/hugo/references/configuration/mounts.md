## Mounts

{{% glossary-term mount %}}

> [!IMPORTANT]
> If you define one or more mounts to map a file system path to a component path, do not use these legacy configuration settings: [`archetypeDir`][], [`assetDir`][], [`contentDir`][], [`dataDir`][], [`i18nDir`][], [`layoutDir`][], or [`staticDir`][].

### Default mounts

Defining a mount for a component within a project configuration removes the default mount for that component.

Defining a mount for a component within a module configuration removes all default mounts for that module.

If you still need any of the default mounts, you must explicitly add them along with the new mount.

These are the default mounts:

{{< code-toggle config=module.mounts />}}

`source`
: (`string`) The source directory of the mount. For the main project, this can be either project-relative or absolute. For other modules it must be project-relative.

`target`
: (`string`) Where the mount will reside within Hugo's [unified file system](g). It must begin with one of Hugo's [component](g) directories: archetypes, assets, content, data, i18n, layouts, or static. For example, content/blog.

`disableWatch`
: (`bool`) Whether to disable watching in watch mode for this mount. Default is `false`.

`excludeFiles`
: {{< deprecated-in 0.153.0 />}}
: Use the [`files`](#files) setting instead.

`files`
: {{< new-in 0.153.0 />}}
: (`[]string`) A [glob slice](g) defining the files to include or exclude.

`includeFiles`
: {{< deprecated-in 0.153.0 />}}
: Use the [`files`](#files) setting instead.

`lang`
: {{< deprecated-in 0.153.0 />}}
: Use the [`sites`](#sites) setting instead.

`sites`
: {{< new-in 0.153.0 />}}
: (`map`) A map to define [sites matrix](g) and [sites complements](g) for the mount. Relevant for `content` and `layouts` mounts, and `static` mounts when in multihost mode. For `static` and `layouts`, only the `matrix` keyword is supported.

### Example

{{< code-toggle file=hugo >}}
[module]
[[module.mounts]]
source = 'content'
target = 'content'
files = ['! docs/*']
[[module.mounts]]
source = 'node_modules'
target = 'assets'
[[module.mounts]]
source = 'assets'
target = 'assets'
{{< /code-toggle >}}

[Dart Sass]: /functions/css/sass/#dart-sass
[`archetypeDir`]: /configuration/all/#archetypedir
[`assetDir`]: /configuration/all/#assetdir
[`contentDir`]: /configuration/all/#contentdir
[`dataDir`]: /configuration/all/#datadir
[`i18nDir`]: /configuration/all/#i18ndir
[`layoutDir`]: /configuration/all/#layoutdir
[`staticDir`]: /configuration/all/#staticdir
[`themesDir`]: /configuration/all/#themesdir
[this issue]: https://github.com/gohugoio/hugo/pull/13966
[version query]: https://go.dev/ref/mod#version-queries


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/configuration/output-formats.md
---


{{% glossary-term "output format" %}}

You can output a page in as many formats as you want. Define an infinite number of output formats, provided they each resolve to a unique file system path.

This is the default output format configuration in tabular form:

{{< datatable
  "config"
  "outputFormats"
  "_key"
  "mediaType"
  "weight"
  "baseName"
  "isHTML"
  "isPlainText"
  "noUgly"
  "notAlternative"
  "path"
  "permalinkable"
  "protocol"
  "rel"
  "root"
  "ugly"
>}}

