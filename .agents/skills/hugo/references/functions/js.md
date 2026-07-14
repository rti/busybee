
---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/js/Babel.md
---


The `js.Babel` function transforms JavaScript using [Babel][].

## Setup

Step 1
: Install [Node.js][].

Step 2
: Install the required Node packages in the root of your project. For example, to install Babel's core compiler, its command-line interface, and the preset for transpiling modern JavaScript based on your target environments:

  ```sh
  npm install --save-dev @babel/core @babel/cli @babel/preset-env
  ```

Step 3
: Create a Babel configuration file in the root of your project. For example, to use the environment preset to target Google Chrome version 79 or later:

  ```js {file="babel.config.mjs" copy=true}
  export default {
    presets: [
      [
        '@babel/preset-env',
        {
          targets: {
            chrome: "79"
          }
        }
      ]
    ]
  };
  ```

Step 4
: Place your JS file within the `assets/js` directory.

Step 5
: Add the Babel executable to Hugo's `security.exec.allow` list in your project configuration:

  {{< code-toggle file=hugo >}}
  [security.exec]
    allow = ['^(dart-)?sass(-embedded)?$', '^go$', '^git$', '^node$', '^postcss$', '^tailwindcss$', '^babel$']
  {{< /code-toggle >}}

Step 6
: Create a partial template to process the JavaScript:

  ```go-html-template {file="layouts/_partials/js.html" copy=true}
  {{ with resources.Get "js/main.js" }}
    {{ $opts := dict
      "minified" (cond hugo.IsDevelopment false true)
      "noComments" (cond hugo.IsDevelopment false true)
      "sourceMap" (cond hugo.IsDevelopment "inline" "none")
    }}
    {{ with . | js.Babel $opts }}
      {{ if hugo.IsDevelopment }}
        <script src="{{ .RelPermalink }}"></script>
      {{ else }}
        {{ with . | fingerprint }}
          <script src="{{ .RelPermalink }}" integrity="{{ .Data.Integrity }}" crossorigin="anonymous"></script>
        {{ end }}
      {{ end }}
    {{ end }}
  {{ end }}
  ```

Step 7
: Call the partial template from your base template:

  ```go-html-template {file="layouts/baseof.html" copy=true}
  <head>
    {{ partial "js.html" . }}
  </head>
  ```

## Options

The `js.Babel` function accepts an options map.

`compact`
: (`bool`) Whether to remove optional newlines and whitespace. Enabled when `minified` is `true`. Default is `false`.

`config`
: (`string`) The path to the Babel configuration file. By default, Hugo searches the root of the project directory and any modules for `babel.config.js`, `babel.config.mjs`, and `babel.config.cjs` in that order. Use this option only to point to a configuration file with a custom name or one located in a custom subdirectory.

`minified`
: (`bool`) Whether to minify transpiled code. Enables the `compact` option. Default is `false`.

`noBabelrc`
: (`bool`) Whether to ignore `.babelrc` and `.babelignore` files. Default is `false`.

`noComments`
: (`bool`) Whether to remove comments. Default is `false`.

`sourceMap`
: (`string`) Whether to generate source maps, one of `external`, `inline`, or `none`. Default is `none`.

`verbose`
: (`bool`) Whether to enable verbose logging. Default is `false`.

<!--
In the above, technically "none" is not one of the enumerated sourceMap
values but it has the same effect and is easier to document than an empty string.
-->

[Babel]: https://babeljs.io/
[Node.js]: https://nodejs.org/en/download


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/js/Batch.md
---


> [!NOTE]
> The `js.Batch` function is backed by the [`evanw/esbuild`][] package, providing a mature, high-performance foundation for bundling, transformation, and minification.

> [!NOTE]
> For a runnable example of this feature, see [this test and demo repo][js_batch_demo].

The Batch `ID` is used to create the base directory for this batch. Forward slashes are allowed. The `js.Batch` function returns an object with an API with this structure:

- [Group](#group)
  - [Script](#script)
    - [SetOptions](#optionssetter)
  - [Instance](#instance)
    - [SetOptions](#optionssetter)
  - [Runner](#runner)
    - [SetOptions](#optionssetter)
  - [Config](#config)
    - [SetOptions](#optionssetter)

## Group

The `Group` method take an `ID` (`string`) as argument. No slashes. It returns an object with these methods:

### Script

The `Script` method takes an `ID` (`string`) as argument. No slashes. It returns an [OptionsSetter](#optionssetter) that can be used to set [script options](#script-options) for this script.

```go-html-template
{{ with js.Batch "js/mybatch" }}
  {{ with .Group "mygroup" }}
      {{ with .Script "myscript" }}
          {{ .SetOptions (dict "resource" (resources.Get "myscript.js")) }}
      {{ end }}
  {{ end }}
{{ end }}
```

`SetOptions` takes a [script options](#script-options) map. Note that if you want the script to be handled by a [Runner](#runner), you need to set the `export` option to match what you want to pass on to the runner (default is `*`).

### Instance

The `Instance` method takes two `string` arguments `SCRIPT_ID` and `INSTANCE_ID`. No slashes. It returns an [OptionsSetter](#optionssetter) that can be used to set [params options](#params-options) for this instance.

```go-html-template
{{ with js.Batch "js/mybatch" }}
  {{ with .Group "mygroup" }}
      {{ with .Instance "myscript" "myinstance" }}
          {{ .SetOptions (dict "params" (dict "param1" "value1")) }}
      {{ end }}
  {{ end }}
{{ end }}
```

`SetOptions` takes a [params options](#params-options) map. The instance options will be passed to any [Runner](#runner) script in the same group, as JSON.

### Runner

The `Runner` method takes an `ID` (`string`) as argument. No slashes. It returns an [OptionsSetter](#optionssetter) that can be used to set [script options](#script-options) for this runner.

```go-html-template
{{ with js.Batch "js/mybatch" }}
  {{ with .Group "mygroup" }}
      {{ with .Runner "myrunner" }}
          {{ .SetOptions (dict "resource" (resources.Get "myrunner.js")) }}
      {{ end }}
  {{ end }}
{{ end }}
```

`SetOptions` takes a [script options](#script-options) map.

The runner will receive a data structure with all instances for that group with a live binding of the [JavaScript import][] of the defined `export`.

The runner script's export must be a function that takes one argument, the group data structure. An example of a group data structure as JSON is:

```json
{
    "id": "leaflet",
    "scripts": [
        {
            "id": "mapjsx",
            "binding": JAVASCRIPT_BINDING,
            "instances": [
                {
                    "id": "0",
                    "params": {
                        "c": "h-64",
                        "lat": 48.8533173846729,
                        "lon": 2.3497416090232535,
                        "r": "map.jsx",
                        "title": "Cathédrale Notre-Dame de Paris",
                        "zoom": 23
                    }
                },
                {
                    "id": "1",
                    "params": {
                        "c": "h-64",
                        "lat": 59.96300872062237,
                        "lon": 10.663529183196863,
                        "r": "map.jsx",
                        "title": "Holmenkollen",
                        "zoom": 3
                    }
                }
            ]
        }
    ]
}
```

Below is an example of a runner script that uses React to render elements. Note that the export (`default`) must match the `export` option in the [script options](#script-options) (`default` is the default value for runner scripts). Runnable versions of the examples on this page can be found in this `js.Batch` [demonstration repository][js_batch_demo].

```js
import * as ReactDOM from 'react-dom/client';
import * as React from 'react';

export default function Run(group) {
  console.log('Running react-create-elements.js', group);
  const scripts = group.scripts;
  for (const script of scripts) {
    for (const instance of script.instances) {
      /* This is a convention in this project. */
      let elId = `${script.id}-${instance.id}`;
      let el = document.getElementById(elId);
      if (!el) {
        console.warn(`Element with id ${elId} not found`);
        continue;
      }
      const root = ReactDOM.createRoot(el);
      const reactEl = React.createElement(script.binding, instance.params);
      root.render(reactEl);
    }
  }
}
```

### Config

Returns an [OptionsSetter](#optionssetter) that can be used to set [build options](#build-options) for the batch.

These are mostly the same as for `js.Build`, but note that:

- `targetPath` is set automatically (there may be multiple outputs).
- `format` must be `esm`, currently the only format that supports [code splitting][].
- `params` will be available in the `@params/config` namespace in the scripts. This way you can import both the [Script](#script) or [Runner](#runner) params and the [Config](#config) params with:

```js
import * as params from "@params";
import * as config from "@params/config";
```

Setting the `Config` for a batch can be done from any template (including shortcode templates), but will only be set once (the first will win):

```go-html-template
{{ with js.Batch "js/mybatch" }}
  {{ with .Config }}
       {{ .SetOptions (dict
        "target" "es2023"
        "format" "esm"
        "jsx" "automatic"
        "loaders" (dict ".png" "dataurl")
        "minify" true
        "params" (dict "param1" "value1")
        )
      }}
  {{ end }}
{{ end }}
```

## Options

### Build options

`format`
: (`string`) Currently, `esbuild` only supports `esm` output for [code splitting][].

{{% include "/_common/functions/js/options.md" %}}

### Script options

`resource`
: The resource to build. This can be a file resource or a virtual resource.

`export`
: The export to bind the runner to. Set it to `*` to export the [entire namespace][]. Default is `default` for [Runner](#runner) scripts and `*` for other [scripts](#script).

`importContext`
: An additional context for resolving imports. Hugo will always check this one first before falling back to `assets` and `node_modules`. A common use of this is to resolve imports inside a page bundle. See [import context](#import-context).

`params`
: A map of parameters that will be passed to the script as JSON. These gets bound to the `@params` namespace:

  ```js
  import * as params from '@params';
  ```

### Params options

`params`
: A map of parameters that will be passed to the script as JSON.

### Import context

Hugo will, by default, first try to resolve any import in the `assets` directory and, if not found, let `esbuild` resolve it (e.g. from `node_modules`). The `importContext` option can be used to set the first context for resolving imports. A common use of this is to resolve imports inside a [page bundle][].

```go-html-template
{{ $common := resources.Match "/js/headlessui/*.*" }}
{{ $importContext := (slice $.Page ($common.Mount "/js/headlessui" ".")) }}
```

You can pass any object that implements [`Resource.Get`][]. Pass a slice to set multiple contexts.

The example above uses [`Resources.Mount`][] to resolve a directory inside `assets` relative to the page bundle.

### OptionsSetter

An `OptionsSetter` is a special object that is returned once only. This means that you should wrap it with [`with`][]:

```go-html-template
{{ with .Script "myscript" }}
    {{ .SetOptions (dict "resource" (resources.Get "myscript.js"))}}
{{ end }}
```

## Build

The `Build` method returns an object with the following structure:

- Groups (map)
  - [`Resources`][]

Each [`Resource`][] will be of media type `application/javascript` or `text/css`.

In a template you would typically handle one group with a given `ID` (e.g., scripts for the current section). Because of the concurrent build, this needs to be done in a [`templates.Defer`][] block:

> [!NOTE]
> The [`templates.Defer`][] acts as a synchronisation point to handle scripts added concurrently by different templates. If you have a setup with where the batch is created in one go (in one template), you don't need it.
>
> See [this discussion][] for more information.

```go-html-template
{{ $group := .group }}
{{ with (templates.Defer (dict "key" $group "data" $group )) }}
  {{ with (js.Batch "js/mybatch") }}
    {{ with .Build }}
      {{ with index .Groups $ }}
        {{ range . }}
          {{ $s := . }}
          {{ if eq $s.MediaType.SubType "css" }}
            <link href="{{ $s.RelPermalink }}" rel="stylesheet" />
          {{ else }}
            <script src="{{ $s.RelPermalink }}" type="module"></script>
          {{ end }}
        {{ end }}
      {{ end }}
  {{ end }}
{{ end }}
```

## Known Issues

In the official documentation for the `esbuild` [code splitting][] feature, there's a warning note in the header. The two issues are:

- `esm` is currently the only implemented output format. This means that it will not work for legacy browsers. See [caniuse][].
- There's a known import ordering issue.

We have not seen the ordering issue as a problem during our [extensive testing][] of this new feature with different libraries. There are two main cases:

1. Undefined execution order of imports, see [this comment][comment-1]
1. Only one execution order of imports, see [this comment][comment-2]

Many would say that both of the above are [code smells][]. The first one has a simple workaround in Hugo. Define the import order in its own script and make sure it gets passed early to `esbuild`, e.g., by putting it in a script group with a name that comes early in the alphabet.

```js
import './lib2.js';
import './lib1.js';

console.log('entrypoints-workaround.js');
```

[JavaScript import]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/import
[`Resource.Get`]: /methods/page/resources/#get
[`Resource`]: /methods/resource/
[`Resources.Mount`]: /methods/page/resources/#mount
[`Resources`]: /methods/page/resources/
[`evanw/esbuild`]: https://github.com/evanw/esbuild
[`templates.Defer`]: /functions/templates/defer/
[`with`]: /functions/go-template/with/
[caniuse]: https://caniuse.com/?search=ESM
[code smells]: https://en.wikipedia.org/wiki/Code_smell
[code splitting]: https://esbuild.github.io/api/#splitting
[comment-1]: https://github.com/evanw/esbuild/issues/399#issuecomment-1458680887
[comment-2]: https://github.com/evanw/esbuild/issues/399#issuecomment-735355932
[entire namespace]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/import#namespace_import
[extensive testing]: https://github.com/bep/hugojsbatchdemo
[js_batch_demo]: https://github.com/bep/hugojsbatchdemo/
[page bundle]: /content-management/page-bundles/
[this discussion]: https://discourse.gohugo.io/t/js-batch-with-simple-global-script/53002/5


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/js/Build.md
---


> [!NOTE]
> The `js.Build` function is backed by the [`evanw/esbuild`][] package, providing a mature, high-performance foundation for bundling, transformation, and minification.

Use the `js.Build` function to:

- Bundle
- Transpile (TypeScript and JSX)
- Tree shake
- Minify
- Create source maps

```go-html-template
{{ with resources.Get "js/main.js" }}
  {{$opts := dict
    "minify" (cond hugo.IsDevelopment false true)
    "sourceMap" (cond hugo.IsDevelopment "linked" "none")
  }}
  {{ with . | js.Build $opts }}
    {{ if hugo.IsDevelopment }}
      <script src="{{ .RelPermalink }}"></script>
    {{ else }}
      {{ with . | fingerprint }}
        <script src="{{ .RelPermalink }}" integrity="{{ .Data.Integrity }}" crossorigin="anonymous"></script>
      {{ end }}
    {{ end }}
  {{ end }}
{{ end }}
```

## Options

The `js.Build` function accepts an options map.

`format`
: (`string`) The output format. One of: `iife`, `cjs`, `esm`. Default is `iife`, a self-executing function, suitable for inclusion as a `<script>` tag.

`targetPath`
: (`string`) If not set, the source path will be used as the base target path. Note that the target path's extension may change if the target MIME type is different, e.g. when the source is TypeScript.

{{% include "/_common/functions/js/options.md" %}}

## Import JS code from the assets directory

`js.Build` has full support for Hugo's [unified file system](g). You can see some simple examples in this [test project][], but in short this means that you can do this:

```js
import { hello } from 'my/module';
```

And it will resolve to the top-most `index.{js,ts,tsx,jsx}` inside `assets/my/module` in the layered file system.

```js
import { hello3 } from 'my/module/hello3';
```

Will resolve to `hello3.{js,ts,tsx,jsx}` inside `assets/my/module`.

Any imports starting with `.` are resolved relative to the current file:

```js
import { hello4 } from './lib';
```

For other files (e.g. `JSON`, `CSS`) you need to use the relative path including any extension, e.g:

```js
import * as data from 'my/module/data.json';
```

Any imports in a file outside `assets` or that does not resolve to a component inside `assets` will be resolved by [`esbuild`][] with the **project directory** as the resolve directory (used as the starting point when looking for `node_modules` etc.). Also see [`hugo mod npm pack`][]. If you have any imported npm dependencies in your project, you need to make sure to run `npm install` before you run `hugo build`.

Also note the new `params` option that can be passed from template to your JS files, e.g.:

```go-html-template
{{ $js := resources.Get "js/main.js" | js.Build (dict "params" (dict "api" "https://example.org/api")) }}
```

And then in your JS file:

```js
import * as params from '@params';
```

Hugo will, by default, generate a `assets/jsconfig.json` file that maps the imports. This is useful for navigation/intellisense help inside code editors, but if you don't need/want it, you can [turn it off][].

## Node.js dependencies

Use the `js.Build` function to include Node dependencies.

Any imports in a file outside `assets` or that does not resolve to a component inside `assets` will be resolved by [`esbuild`][] with the **project directory** as the resolve directory (used as the starting point when looking for `node_modules` etc.). Also see [`hugo mod npm pack`][]. If you have any imported npm dependencies in your project, you need to make sure to run `npm install` before you run `hugo build`.

The start directory for resolving npm packages (aka. packages that live inside a `node_modules` directory) is always the main project directory.

> [!NOTE]
> If you're developing a theme/component that is supposed to be imported and depends on dependencies inside `package.json`, we recommend reading about [`hugo mod npm pack`][], a tool to consolidate all the npm dependencies in a project.

## Examples

```go-html-template
{{ $built := resources.Get "js/index.js" | js.Build "main.js" }}
```

Or with options:

```go-html-template
{{ $externals := slice "react" "react-dom" }}
{{ $defines := dict "process.env.NODE_ENV" `"development"` }}

{{ $opts := dict "targetPath" "main.js" "externals" $externals "defines" $defines }}
{{ $built := resources.Get "scripts/main.js" | js.Build $opts }}
<script src="{{ $built.RelPermalink }}" defer></script>
```

[`esbuild`]: https://esbuild.github.io/
[`evanw/esbuild`]: https://github.com/evanw/esbuild
[`hugo mod npm pack`]: /commands/hugo_mod_npm_pack/
[test project]: https://github.com/gohugoio/hugoTestProjectJSModImports
[turn it off]: /configuration/build/#nojsconfiginassets

