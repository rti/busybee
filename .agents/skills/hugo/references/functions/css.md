
---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/css/Build.md
---


{{< new-in 0.158.0 />}}

> [!NOTE]
> The `css.Build` function is backed by the [`evanw/esbuild`][] package, providing a mature, high-performance foundation for bundling, transformation, and minification.

Use the `css.Build` function to:

- Recursively replace `@import` statements in CSS files with the content of the imported files
- Transform syntax for browser compatibility
- Apply vendor prefixes for browser compatibility
- Minify the bundled CSS code
- Create a source map

If an `@import` statement includes a media query, a feature query, or a cascade layer assignment, the function wraps the imported content in the corresponding `@media`, `@supports`, or `@layer` rule.

## Usage

In this example, Hugo bundles the local files referenced by `@import` statements to create and publish a single resource with inline content.

```tree
assets/
└── css/
    ├── components/
    │   ├── a.css
    │   └── b.css
    └── main.css
```

```css {file="assets/css/main.css" copy=true}
@import url('https://cdn.jsdelivr.net/npm/the-new-css-reset/css/reset.min.css');

@import './components/a.css';
@import './components/b.css';

.c {color: blue; }
```

```css {file="assets/css/components/a.css" copy=true}
.a { color: red; }
```

```css {file="assets/css/components/b.css" copy=true}
.b { color: green; }
```

```go-html-template {file="layouts/_partials/css.html" copy=true}
{{ with resources.Get "css/main.css" | css.Build }}
  {{ if hugo.IsDevelopment }}
    <link rel="stylesheet" href="{{ .RelPermalink }}">
  {{ else }}
    {{ with . | fingerprint }}
      <link rel="stylesheet" href="{{ .RelPermalink }}" integrity="{{ .Data.Integrity }}" crossorigin="anonymous">
    {{ end }}
  {{ end }}
{{ end }}
```

```go-html-template {file="layouts/baseof.html" copy=true}
{{ partialCached "css.html" . }}
```

The generated CSS code:

```css {file="public/css/main.css"}
@import "https://cdn.jsdelivr.net/npm/the-new-css-reset/css/reset.min.css";

.a {
  color: red;
}

.b {
  color: green;
}

.c {
  color: blue;
}
```

To minify the generated CSS code, use the [`minify`](#minify) option as described below.

## Options

The `css.Build` function accepts an options map to fine-tune bundling, minification, and browser compatibility.

`externals`
: (`[]string`) A slice of path patterns to exclude from bundling. The `@import` statements for these patterns remain as-is in the generated CSS code. See [details][esb external].

  ```go-html-template
  {{ $opts := dict "externals" (slice "./exclude-these/*" "./exclude-these-too/*") }}
  {{ $r := resources.Get "css/main.css" | css.Build $opts }}
  ```

`loaders`
: (`map`) A map of file extensions to loader types. This determines how files with a given extension are processed during bundling. By default, Hugo uses the `css` loader for `.css` files and the `file` loader for all others. Common loaders include:

  - `css`: Processes the file as a CSS file
  - `dataurl`: Embeds the file as a base64-encoded data URL
  - `empty`: Excludes the file from the bundle
  - `file`: Copies the file to the output directory and rewrites the URL
  - `text`: Loads the file content as a string

  See [details][esb loader].

  ```go-html-template
  {{ $opts := dict "loaders" (dict ".png" "dataurl" ".svg" "dataurl") }}
  {{ $r := resources.Get "css/main.css" | css.Build $opts }}
  ```

`mainFields`
: (`[]string`) A prioritized slice of field names in a `package.json` file that determine the CSS entry point of a Node package. The default is `["style", "main"]`. See [details][esb mainfields].

  When an `@import` statement references a Node package, Hugo consults the metadata in the `package.json` file to find the stylesheet. Use this option to support packages that define a CSS entry point using non-standard fields.

  ```go-html-template
  {{ $opts := dict "mainFields" (slice "css" "style" "main") }}
  {{ $r := resources.Get "css/main.css" | css.Build $opts }}
  ```

`minify`
: (`bool`) Whether to minify the generated CSS code. Default is `false`. See [details][esb minify].

  ```go-html-template
  {{ $opts := dict "minify" true }}
  {{ $r := resources.Get "css/main.css" | css.Build $opts }}
  ```

`sourceMap`
: (`string`) The type of source map to generate. One of `external`, `inline`, `linked`, or `none`. Default is `none`. See [details][esb sourcemap].

  ```go-html-template
  {{ $opts := dict "sourceMap" "linked" }}
  {{ $r := resources.Get "css/main.css" | css.Build $opts }}
  ```

`sourcesContent`
: (`bool`) Whether to include the content of the source files in the source map. Default is `true`. See [details][esb sourcesContent].

  ```go-html-template
  {{ $opts := dict "sourceMap" "linked" "sourcesContent" false }}
  {{ $r := resources.Get "css/main.css" | css.Build $opts }}
  ```

`target`
: (`[]string`) The target environment for the generated CSS code. This determines which syntax transformations to perform and which vendor prefixes to apply. If unset, no transformations or prefixing are performed. Each element consists of a target name and a version number. Supported targets include `chrome`, `edge`, `firefox`, `ie`, `ios`, `opera`, and `safari`. See [details][esb target].

  ```go-html-template
  {{ $target := slice "chrome115" "edge115" "firefox116" "ios16.4" "opera101" "safari16.4" }}
  {{ $opts := dict "target" $target }}
  {{ $r := resources.Get "css/main.css" | css.Build $opts }}
  ```

  In the example above, the target environment is roughly equivalent to the [browserlist][] "baseline widely available" profile as of March 2026.

`targetPath`
: (`string`) The path to the generated CSS file, relative to the project's [`publishDir`][]. If unset, this defaults to the asset's original path with a `.css` extension.

  ```go-html-template
  {{ $opts := dict "targetPath" "css/styles.css" }}
  {{ $r := resources.Get "css/main.css" | css.Build $opts }}
  ```

`vars`
: {{< new-in 0.160.0 />}}
: (`map`) A map of key-value pairs used to generate CSS variables. The `css.Build` function injects these variables into the stylesheet when it encounters the `hugo:vars` internal identifier within an `@import` statement.

  ```go-html-template
  {{ $vars := dict
    "font-family" "\"Times New Roman\", Times, serif"
    "font-size" "24px"
    "primary-color" "blue"
  }}
  {{ $opts := dict "vars" $vars }}
  {{ $r := resources.Get "css/main.css" | css.Build $opts }}
  ```

  In the example above, using the identifier in your CSS allows you to access the values using standard CSS variable syntax.

  ```css
  @import 'hugo:vars';

  .element {
    color: var(--primary-color);
    font-family: var(--font-family);
    font-size: var(--font-size);
  }
  ```

  The above produces output equivalent to:

  ```css
  :root {
    --font-family:
      "Times New Roman",
      Times,
      serif;
    --font-size: 24px;
    --primary-color: blue;
  }

  .element {
    color: var(--primary-color);
    font-family: var(--font-family);
    font-size: var(--font-size);
  }
  ```

  {{< new-in 0.161.0 />}}

  The map may optionally contain nested maps. Each nested map is exposed as a separate `hugo:vars/<name>` namespace, where `<name>` is the key of the nested map (lowercased). Top-level scalar values and nested maps are independent. A top-level `@import 'hugo:vars'` only includes scalar values, while `@import 'hugo:vars/<name>'` only includes the scalars from the named nested map.

  ```go-html-template
  {{ $vars := dict
    "font-family" "\"Times New Roman\", Times, serif"
    "font-size" "24px"
    "primary-color" "blue"
    "mobile" (dict
      "font-size" "12px"
      "primary-color" "red"
    )
  }}
  {{ $opts := dict "vars" $vars }}
  {{ $r := resources.Get "css/main.css" | css.Build $opts }}
  ```

  Because nested imports follow the same rules as regular `@import` statements, you can attach a media query, feature query, or cascade layer assignment to a `hugo:vars/<name>` import.

  ```css
  @import 'hugo:vars';
  @import 'hugo:vars/mobile' (max-width: 650px);

  body {
    background-color: var(--primary-color);
    font-family: var(--font-family);
  }
  ```

  The above produces output equivalent to:

  ```css
  :root {
    --font-family: "Times New Roman", Times, serif;
    --font-size: 24px;
    --primary-color: blue;
  }

  @media (max-width: 650px) {
    :root {
      --font-size: 12px;
      --primary-color: red;
    }
  }

  body {
    background-color: var(--primary-color);
    font-family: var(--font-family);
  }
  ```

  The `vars` option is useful for setting CSS variables within your project configuration.

  {{< code-toggle file=hugo >}}
  [params.theme.style]
  font-family = '"Times New Roman", Times, serif'
  font-size = '24px'
  primary-color = 'blue'

  [params.theme.style.mobile]
  font-size = '12px'
  primary-color = 'red'
  {{< /code-toggle >}}

  ```go-html-template
  {{ $opts := dict "vars" site.Params.theme.style }}
  {{ $r := resources.Get "css/main.css" | css.Build $opts }}
  ```

  When passing a `vars` map to the `css.Build` function, you can use the [`css.Quoted`][] function to explicitly indicate that a value must be treated as a quoted string, most commonly for `font-family` names or the `content` property.

  > [!NOTE]
  > If you're using TailwindCSS and want to use the `vars` option to inject CSS variables, see [this section in the TailwindCSS documentation](./TailwindCSS.md#inject-css-variables).

## Example

The example below uses several of the [options](#options) described above to bundle, transform, and minify CSS code.

```go-html-template {file="layouts/_partials/css.html" copy=true}
{{ with resources.Get "css/main.css" }}
  {{ $opts := dict
    "loaders" (dict ".png" "dataurl" ".svg" "dataurl")
    "minify" (cond hugo.IsDevelopment false true)
    "sourceMap" (cond hugo.IsDevelopment "linked" "none")
    "target" (slice "chrome115" "edge115" "firefox116" "ios16.4" "opera101" "safari16.4")
    "targetPath" "css/styles.css"
  }}
  {{ with . | css.Build $opts }}
    {{ if hugo.IsDevelopment }}
      <link rel="stylesheet" href="{{ .RelPermalink }}">
    {{ else }}
      {{ with . | fingerprint }}
        <link rel="stylesheet" href="{{ .RelPermalink }}" integrity="{{ .Data.Integrity }}" crossorigin="anonymous">
      {{ end }}
    {{ end }}
  {{ end }}
{{ end }}
```

Using the options above, Hugo does the following:

- Embeds PNG and SVG images as data URLs in the generated CSS code
- Minifies the output in production but not in development
- Generates an external source map in development but not in production
- Transforms syntax for compatibility with the targeted browser versions
- Adds vendor prefixes for compatibility with the targeted browser versions
- Publishes the generated CSS code to `css/styles.css`
- In production, adds an SRI hash and inserts a file hash into the filename

## Common patterns

The examples below cover the most frequent use cases for referencing resources within your project or within Node packages. These patterns apply to both `@import` statements and the `url()` functional notation used for images and fonts.

All resources referenced by a path, including images, fonts, and stylesheets, must reside in the `assets` directory of the [unified file system](g), or within a Node package.

### Files in the assets directory

To include a stylesheet from the `assets` directory, you can use a bare path, a relative path, or a root-relative path. When you use a bare path, Hugo searches relative to the current stylesheet, then relative to the `assets` directory.

```css {file="/assets/css/main.css"}
/* A bare path */
@import "variables.css";

/* A relative path */
@import "./theme.css";
@import "../layout.css";

/* A root-relative path */
@import "/css/grid.css";

/* A url() reference using the same resolution logic */
.logo { background: url("/images/logo.svg"); }
```

### Node packages

When referencing a Node package by name, Hugo consults the `package.json` file within that package to find the entry point.

```css {file="/assets/css/main.css"}
@import "bootstrap";
```

### Files within a package

To reference a specific file within a Node package, provide the path starting with the package name.

```css {file="/assets/css/main.css"}
@import "bootstrap/dist/css/bootstrap-grid.css";
```

[`css.Quoted`]: /functions/css/quoted/
[`evanw/esbuild`]: https://github.com/evanw/esbuild
[`publishDir`]: /configuration/all/#publishdir
[browserlist]: https://browsersl.ist
[esb external]: https://esbuild.github.io/api/#external
[esb loader]: https://esbuild.github.io/api/#loader
[esb mainfields]: https://esbuild.github.io/api/#main-fields
[esb minify]: https://esbuild.github.io/api/#minify
[esb sourcemap]: https://esbuild.github.io/api/#sourcemap
[esb sourcesContent]: https://esbuild.github.io/api/#sources-content
[esb target]: https://esbuild.github.io/api/#target


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/css/PostCSS.md
---


The `css.PostCSS` function transforms CSS using [PostCSS][] and any of its [plugins][].

## Setup

Step 1
: Install [Node.js][].

Step 2
: Install the required Node packages in the root of your project. For example, to install PostCSS, its command-line interface, and the plugin to automatically add vendor prefixes to your CSS:

  ```sh
  npm install --save-dev postcss postcss-cli autoprefixer
  ```

Step 3
: Create a PostCSS configuration file in the root of your project. The current Hugo [environment](g) name is available in the Node context. For example, in this configuration, running `hugo server` disables vendor prefixes but enables an inline sourcemap. Conversely, when building for production, it applies vendor prefixes and disables the sourcemap:

  ```js {file="postcss.config.mjs" copy=true}
  import autoprefixer from 'autoprefixer';

  const isDev = process.env.HUGO_ENVIRONMENT === 'development';

  export default {
    plugins: [
      !isDev ? autoprefixer : null
    ],
    map: isDev ? { inline: true } : false
  };
  ```

Step 4
: Place your CSS file within the `assets/css` directory.

Step 5
: Create a partial template to process the CSS:

  ```go-html-template {file="layouts/_partials/css.html" copy=true}
  {{ with resources.Get "css/main.css" }}
    {{ $opts := dict
      "inlineImports" true
    }}
    {{ with . | css.PostCSS $opts }}
      {{ if hugo.IsDevelopment }}
        <link rel="stylesheet" href="{{ .RelPermalink }}">
      {{ else }}
        {{ with . | minify | fingerprint }}
          <link rel="stylesheet" href="{{ .RelPermalink }}" integrity="{{ .Data.Integrity }}" crossorigin="anonymous">
        {{ end }}
      {{ end }}
    {{ end }}
  {{ end }}
  ```

Step 6
: Call the partial template from your base template:

  ```go-html-template {file="layouts/baseof.html" copy=true}
  <head>
    {{ partial "css.html" . }}
  </head>
  ```

## Options

The `css.PostCSS` function accepts an options map.

`config`
: (`string`) The path to the directory that contains the PostCSS configuration file. By default, Hugo searches the root of the project directory and any modules for `postcss.config.js`, `postcss.config.mjs`, and `postcss.config.cjs` in that order. Use this option only if your configuration file is located in a custom subdirectory.

`inlineImports`
: (`bool`) Whether to enable inlining of import statements. It does so recursively, but will only import a file once. Hugo looks for imports relative to the module mount and respects theme overrides. Default is `false`.

  Note that Hugo's internal import routine does not adhere to the CSS specification; you can place `@import` statements anywhere in the file. However, external URL imports and imports with media queries are ignored during the inlining process.

  The following snippet illustrates an external URL import that Hugo will ignore:

  ```css
  @import url('https://fonts.googleapis.com/css?family=Open+Sans&display=swap');
  ```

`skipInlineImportsNotFound`
: (`bool`) Whether to allow the build process to continue despite unresolved import statements, preserving the original import declarations. Set this option to `true` if you want to retain standard CSS imports unparsed. Default is `false`.

To avoid using a PostCSS configuration file, you can specify a minimal configuration with these options:

`noMap`
: (`bool`) Whether to disable the default inline source maps. Default is `false`.

`parser`
: (`string`) A custom PostCSS parser.

`stringifier`
: (`string`) A custom PostCSS stringifier.

`syntax`
: (`string`) Custom PostCSS syntax.

`use`
: (`string`) A space-delimited list of PostCSS plugins to use.

For example, to pass your plugins and disable source maps directly through the options map instead of a configuration file:

```go-html-template {file="layouts/_partials/css.html" copy=true}
{{ with resources.Get "css/main.css" }}
  {{ $opts := dict
    "noMap" true
    "use" "autoprefixer postcss-color-alpha"
  }}
  {{ with . | css.PostCSS $opts }}
    {{ if hugo.IsDevelopment }}
      <link rel="stylesheet" href="{{ .RelPermalink }}">
    {{ else }}
      {{ with . | fingerprint }}
        <link rel="stylesheet" href="{{ .RelPermalink }}" integrity="{{ .Data.Integrity }}" crossorigin="anonymous">
      {{ end }}
    {{ end }}
  {{ end }}
{{ end }}
```

[Node.js]: https://nodejs.org/en
[PostCSS]: https://postcss.org/
[plugins]: https://postcss.org/docs/postcss-plugins


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/css/Quoted.md
---


> [!NOTE]
> This function is only applicable to the `vars` option passed to the [`css.Build`][] or [`css.Sass`][] functions.

When passing a `vars` map to the `css.Sass` function, Hugo detects common typed CSS values such as `24px` or `#FF0000` using regular expression matching. If necessary, you can bypass automatic type inference by using the `css.Quoted` function to explicitly indicate that the value must be treated as a quoted string.

For the `css.Build` function, use `css.Quoted` to explicitly indicate that a value must be treated as a quoted string, most commonly for `font-family` names or the `content` property.

In the example below, we use `css.Quoted` to ensure the values for the `content` property are injected as strings.

```go-html-template
{{ $vars := dict
  "ol-li-after" ("6" | css.Quoted)
  "ul-li-after" ("7" | css.Quoted)
}}

{{ $opts := dict "vars" $vars "transpiler" "dartsass" }}
{{ with resources.Get "sass/main.scss" | css.Sass $opts }}
  <link rel="stylesheet" href="{{ .RelPermalink }}">
{{ end }}
```

Using the `hugo:vars` identifier in your stylesheet:

```scss
@use "hugo:vars" as h;

ol li::after {
  content: h.$ol-li-after;
}

ul li::after {
  content: h.$ul-li-after;
}
```

The resulting CSS contains quoted strings:

```css
ol li::after {
  content: "6";
}

ul li::after {
  content: "7";
}
```

[`css.Build`]: /functions/css/build/#vars
[`css.Sass`]: /functions/css/sass/#vars


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/css/Sass.md
---


Transpile Sass to CSS using the LibSass transpiler included in Hugo's extended and extended/deploy editions, or [install Dart Sass](#dart-sass) to use the latest features of the Sass language.

<!-- TODO
Remove the admonition below somewhere after v0.168.0, 15 minor releases
after deprecation.
-->

> [!WARNING]
> The embedded LibSass transpiler was deprecated in [v0.153.0][] and will be removed in a future release. Use the Dart Sass transpiler instead by setting the `transpiler` option to `dartsass` as shown in the examples below.

Sass has two forms of syntax: [SCSS][] and [indented][]. Hugo supports both.

## Options

The `css.Sass` function accepts an options map.

`enableSourceMap`
: (`bool`) Whether to generate a source map. Default is `false`.

  ```go-html-template
  {{ $opts := dict
    "transpiler" "dartsass"
    "enableSourceMap" true
  }}
  {{ $r := resources.Get "sass/main.scss" | css.Sass $opts }}
  ```

`includePaths`
: (`slice`) A slice of paths, relative to the project root, that the transpiler will use when resolving `@use` and `@import` statements.

  ```go-html-template
  {{ $opts := dict
    "transpiler" "dartsass"
    "includePaths" (slice "node_modules/bootstrap/scss")
  }}
  {{ $r := resources.Get "sass/main.scss" | css.Sass $opts }}
  ```

`outputStyle`
: (`string`) The output style of the resulting CSS. With LibSass, one of `nested` (default), `expanded`, `compact`, or `compressed`. With Dart Sass, either `expanded` (default) or `compressed`.

  ```go-html-template
  {{ $opts := dict
    "transpiler" "dartsass"
    "outputStyle" "compressed"
  }}
  {{ $r := resources.Get "sass/main.scss" | css.Sass $opts }}
  ```

`precision`
: (`int`) The precision of floating point math. Applicable to LibSass. Default is `8`.

  ```go-html-template
  {{ $opts := dict
    "transpiler" "dartsass"
    "precision" 10
  }}
  {{ $r := resources.Get "sass/main.scss" | css.Sass $opts }}
  ```

`silenceDeprecations`
: {{< new-in 0.139.0 />}}
: (`slice`) A slice of deprecation IDs to silence. IDs are enclosed in brackets within Dart Sass warning messages (e.g., `import` in `WARN Dart Sass: DEPRECATED [import]`). Applicable to Dart Sass.

  ```go-html-template
  {{ $opts := dict
    "transpiler" "dartsass"
    "silenceDeprecations" (slice "import")
  }}
  {{ $r := resources.Get "sass/main.scss" | css.Sass $opts }}
  ```

`silenceDependencyDeprecations`
: {{< new-in 0.146.0 />}}
: (`bool`) Whether to silence deprecation warnings from dependencies, where a dependency is considered any file transitively imported through a load path. This does not apply to `@warn` or `@debug` rules. Default is `false`.

  ```go-html-template
  {{ $opts := dict
    "transpiler" "dartsass"
    "silenceDependencyDeprecations" true
  }}
  {{ $r := resources.Get "sass/main.scss" | css.Sass $opts }}
  ```

`sourceMapIncludeSources`
: (`bool`) Whether to embed sources in the generated source map. Applicable to Dart Sass. Default is `false`.

  ```go-html-template
  {{ $opts := dict
    "transpiler" "dartsass"
    "enableSourceMap" true "sourceMapIncludeSources" true
  }}
  {{ $r := resources.Get "sass/main.scss" | css.Sass $opts }}
  ```

`targetPath`
: (`string`) The publish path for the transformed resource, relative to the [`publishDir`][]. If unset, the target path defaults to the asset's original path with a `.css` extension.

  ```go-html-template
  {{ $opts := dict
    "transpiler" "dartsass"
    "targetPath" "css/bundle.css"
  }}
  {{ $r := resources.Get "sass/main.scss" | css.Sass $opts }}
  ```

`transpiler`
: (`string`) The transpiler to use, either `libsass` or `dartsass`. Hugo's extended and extended/deploy editions include the LibSass transpiler. To use the Dart Sass transpiler, see the [installation instructions](#dart-sass). Default is `libsass`.

  ```go-html-template
  {{ $opts := dict "transpiler" "dartsass" }}
  {{ $r := resources.Get "sass/main.scss" | css.Sass $opts }}
  ```

`vars`
: (`map`) A map of key-value pairs used to generate Sass variables. The `css.Sass` function injects these variables into the stylesheet when it encounters the `hugo:vars` internal identifier within a `@use` or `@import` statement.

  ```go-html-template
  {{ $vars := dict
    "font-family" "\"Times New Roman\", Times, serif"
    "font-size" "24px"
    "primary-color" "blue"
  }}
  {{ $opts := dict
    "transpiler" "dartsass"
    "vars" $vars
  }}
  {{ $r := resources.Get "sass/main.scss" | css.Sass $opts }}
  ```

  In the example above, using the identifier in your stylesheet allows you to access the values as Sass variables in the `hugo:vars` namespace:

  ```scss
  @use 'hugo:vars' as v;

  .element {
    color: v.$primary-color;
    font-family: v.$font-family;
    font-size: v.$font-size;
  }
  ```

  The above produces output equivalent to:

  ```css
  .element {
    color: blue;
    font-family: "Times New Roman", Times, serif;
    font-size: 24px;
  }
  ```

  {{< new-in 0.161.0 />}}

  The map may optionally contain nested maps. Each nested map is exposed as a separate `hugo:vars/<name>` namespace, where `<name>` is the key of the nested map (lowercased). Top-level scalar values and nested maps are independent. A top-level `@use 'hugo:vars'` only includes scalar values, while `@use 'hugo:vars/<name>'` only includes the scalars from the named nested map.

  ```go-html-template
  {{ $vars := dict
    "font-family" "\"Times New Roman\", Times, serif"
    "font-size" "24px"
    "primary-color" "blue"
    "mobile" (dict
      "font-size" "12px"
      "primary-color" "red"
    )
  }}
  {{ $opts := dict
    "transpiler" "dartsass"
    "vars" $vars
  }}
  {{ $r := resources.Get "sass/main.scss" | css.Sass $opts }}
  ```

  In the stylesheet, reference each nested namespace with a separate `@use` statement. Assign an alias to access the variables from that namespace:

  ```scss
  @use 'hugo:vars' as v;
  @use 'hugo:vars/mobile' as mobile;

  body {
    color: v.$primary-color;
    font-family: v.$font-family;
    font-size: v.$font-size;
  }

  @media (max-width: 650px) {
    body {
      color: mobile.$primary-color;
      font-size: mobile.$font-size;
    }
  }
  ```

  The above produces output equivalent to:

  ```css
  body {
    color: blue;
    font-family: "Times New Roman", Times, serif;
    font-size: 24px;
  }

  @media (max-width: 650px) {
    body {
      color: red;
      font-size: 12px;
    }
  }
  ```

  The `vars` option is useful for setting Sass variables within your project configuration.

  {{< code-toggle file=hugo >}}
  [params.theme.style]
  font-family = '"Times New Roman", Times, serif'
  font-size = '24px'
  primary-color = 'blue'

  [params.theme.style.mobile]
  font-size = '12px'
  primary-color = 'red'
  {{< /code-toggle >}}

  ```go-html-template
  {{ $opts := dict
    "transpiler" "dartsass"
    "vars" site.Params.theme.style }}
  {{ $r := resources.Get "sass/main.scss" | css.Sass $opts }}
  ```

  When passing a `vars` map to the `css.Sass` function, Hugo detects common typed CSS values such as `24px` or `#FF0000` using regular expression matching. If necessary, you can bypass automatic type inference by using the [`css.Quoted`][] or [`css.Unquoted`][] function to explicitly indicate a value's type.

## Example

```go-html-template {copy=true}
{{ with resources.Get "sass/main.scss" }}
  {{ $opts := dict
    "enableSourceMap" hugo.IsDevelopment
    "outputStyle" (cond hugo.IsDevelopment "expanded" "compressed")
    "targetPath" "css/main.css"
    "transpiler" "dartsass"
    "vars" site.Params.styles
    "includePaths" (slice "node_modules/bootstrap/scss")
  }}
  {{ with . | css.Sass $opts }}
    {{ if hugo.IsDevelopment }}
      <link rel="stylesheet" href="{{ .RelPermalink }}">
    {{ else }}
      {{ with . | fingerprint }}
        <link rel="stylesheet" href="{{ .RelPermalink }}" integrity="{{ .Data.Integrity }}" crossorigin="anonymous">
      {{ end }}
    {{ end }}
  {{ end }}
{{ end }}
```

## Dart Sass

<!-- TODO
Revise the paragraphs below somewhere after v0.168.0, 15 minor releases
after the deprecation of the LibSass transpiler.
-->

Hugo's extended and extended/deploy editions include [LibSass][] to transpile Sass to CSS. In 2020, the Sass team deprecated LibSass in favor of [Dart Sass][].

Use the latest features of the Sass language by installing Dart Sass in your development and production environments.

### Installation overview

Dart Sass is compatible with Hugo v0.114.0 and later.

If you have been using Embedded Dart Sass[^1] with Hugo v0.113.0 and earlier, uninstall Embedded Dart Sass, then install Dart Sass. If you have installed both, Hugo will use Dart Sass.

If you install Hugo as a [Snap package][] there is no need to install Dart Sass. The Hugo Snap package includes Dart Sass.

### Installing in a development environment

When you install Dart Sass somewhere in your PATH, Hugo will find it.

OS      | Package manager | Site               | Installation
:-------|:----------------|:-------------------|:-----------------------------
Linux   | Homebrew        | [brew.sh][]        | `brew install sass/sass/sass`
Linux   | Snap            | [snapcraft.io][]   | `sudo snap install dart-sass`
macOS   | Homebrew        | [brew.sh][]        | `brew install sass/sass/sass`
Windows | Chocolatey      | [chocolatey.org][] | `choco install sass`
Windows | Scoop           | [scoop.sh][]       | `scoop install sass`

You may also install [prebuilt binaries][] for Linux, macOS, and Windows. You must install the prebuilt binary outside of your project directory and ensure its path is included in your system's PATH environment variable.

Run `hugo env` to list the active transpilers.

> [!NOTE]
> If you build Hugo from source and run `mage test -v`, the test will fail if you install Dart Sass as a Snap package. This is due to the Snap package's strict confinement model.

### Installing in a production environment

To use Dart Sass with Hugo on a [CI/CD](g) platform, you typically must modify your build workflow to install Dart Sass before the Hugo site build begins. This is because these platforms don't have Dart Sass pre-installed, and Hugo needs it to process your Sass files.

There's one key exception where you can skip this step: you have committed your `resources` directory to your repository. This is only possible if:

- You have not changed Hugo's default asset cache location.
- You have not set [`useResourceCacheWhen`][] to never in your project configuration.

By committing the `resources` directory, you're providing the pre-built CSS files directly to your CI/CD platform, so it doesn't need to run the Sass compilation itself.

For examples of how to install Dart Sass in a production environment, see these hosting guides:

- [Cloudflare][]
- [GitHub Pages][]
- [GitLab Pages][]
- [Netlify][]
- [Render][]
- [SourceHut][]
- [Vercel][]

[^1]: In 2023, the Sass team deprecated Embedded Dart Sass in favor of Dart Sass.

[Cloudflare]: /host-and-deploy/host-on-cloudflare/
[Dart Sass]: https://sass-lang.com/dart-sass/
[GitHub Pages]: /host-and-deploy/host-on-github-pages/
[GitLab Pages]: /host-and-deploy/host-on-gitlab-pages/
[LibSass]: https://sass-lang.com/libsass
[Netlify]: /host-and-deploy/host-on-netlify/
[Render]: /host-and-deploy/host-on-render/
[SCSS]: https://sass-lang.com/documentation/syntax#scss
[Snap package]: https://snapcraft.io/hugo
[SourceHut]: /host-and-deploy/host-on-sourcehut-pages/
[Vercel]: /host-and-deploy/host-on-vercel/
[`css.Quoted`]: /functions/css/quoted/
[`css.Unquoted`]: /functions/css/unquoted/
[`publishDir`]: /configuration/all/#publishdir
[`useResourceCacheWhen`]: /configuration/build/#useresourcecachewhen
[brew.sh]: https://brew.sh/
[chocolatey.org]: https://community.chocolatey.org/packages/sass
[indented]: https://sass-lang.com/documentation/syntax#the-indented-syntax
[prebuilt binaries]: https://github.com/sass/dart-sass/releases/latest
[scoop.sh]: https://scoop.sh/#/apps?q=sass
[snapcraft.io]: https://snapcraft.io/dart-sass
[v0.153.0]: https://github.com/gohugoio/hugo/releases/tag/v0.153.0


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/css/TailwindCSS.md
---


Use the `css.TailwindCSS` function to process your Tailwind CSS files. This function uses the Tailwind CSS CLI to:

1. Scan your templates for Tailwind CSS utility class usage.
1. Compile those utility classes into standard CSS.
1. Generate an optimized CSS output file.

> [!NOTE]
> Use this function with Tailwind CSS v4.0 and later, which require a relatively [modern browser][] to render correctly.

## Setup

Step 1
: Install Tailwind CSS v4.0 or later:

  ```sh {copy=true}
  npm install --save-dev tailwindcss @tailwindcss/cli @tailwindcss/typography
  ```

  <!-- TODO
  Remove the admonition below somewhere after v0.176.0, 15 minor releases
  after deprecation.
  -->

  > [!NOTE]
  > As of v0.161.0, Hugo no longer supports the Tailwind [standalone binary][]. You must now install the Tailwind CSS CLI via `npm` as shown above.

Step 2
: Add this to your project configuration:

  {{< code-toggle file=hugo copy=true >}}
  [build]
    [build.buildStats]
      enable = true
    [[build.cachebusters]]
      source = 'assets/notwatching/hugo_stats\.json'
      target = 'css'
    [[build.cachebusters]]
      source = '(postcss|tailwind)\.config\.js'
      target = 'css'
  [module]
    [[module.mounts]]
      source = 'assets'
      target = 'assets'
    [[module.mounts]]
      disableWatch = true
      source = 'hugo_stats.json'
      target = 'assets/notwatching/hugo_stats.json'
  {{< /code-toggle >}}

Step 3
: Create a CSS entry file:

  ```css {file="assets/css/main.css" copy=true}
  @import "tailwindcss";
  @plugin "@tailwindcss/typography";
  @source "hugo_stats.json";
  ```

  Tailwind CSS respects `.gitignore` files. This means that if `hugo_stats.json` is listed in your `.gitignore` file, Tailwind CSS will ignore it. To make `hugo_stats.json` available to Tailwind CSS you must explicitly source it as shown in the example above.

Step 4
: Create a _partial_ template to process the CSS with the Tailwind CSS CLI:

  ```go-html-template {file="layouts/_partials/css.html" copy=true}
  {{ with resources.Get "css/main.css" }}
    {{ $opts := dict "minify" (not hugo.IsDevelopment) }}
    {{ with . | css.TailwindCSS $opts }}
      {{ if hugo.IsDevelopment }}
        <link rel="stylesheet" href="{{ .RelPermalink }}">
      {{ else }}
        {{ with . | fingerprint }}
          <link rel="stylesheet" href="{{ .RelPermalink }}" integrity="{{ .Data.Integrity }}" crossorigin="anonymous">
        {{ end }}
      {{ end }}
    {{ end }}
  {{ end }}
  ```

Step 5
: Call the _partial_ template from your base template, deferring template execution until after all sites and output formats have been rendered:

  ```go-html-template {file="layouts/baseof.html" copy=true}
  <head>
    {{ with (templates.Defer (dict "key" "global")) }}
      {{ partial "css.html" . }}
    {{ end }}
  </head>
  ```

## Options

The `css.TailwindCSS` function accepts an options map.

`minify`
: (`bool`) Whether to optimize and minify the output. Default is `false`.

`optimize`
: (`bool`) Whether to optimize the output without minifying. Default is `false`.

`disableInlineImports`
: {{< new-in 0.147.4 />}}
: (`bool`) Whether to disable inlining of `@import` statements. Inlining is performed recursively, but currently once only per file. It is not possible to import the same file in different scopes (root, media query, etc.). Note that this import routine does not care about the CSS specification, so you can have `@import` statements anywhere in the file. Default is `false`.

`skipInlineImportsNotFound`
: (`bool`) Whether to allow the build process to continue despite unresolved import statements, preserving the original import declarations. It is important to note that the inline importer does not process URL-based imports or those with media queries, and these will remain unaltered even when this option is disabled. Default is `false`.

## Inject CSS variables

The [`css.Build`][] function has a [`vars`][] option that can be used to inject CSS variables into your stylesheets. This is particularly useful for dynamically setting values based on your site's configuration or other data. To use this with Tailwind CSS, you can use `css.Build` as a preprocessor step before passing the result to `css.TailwindCSS`. Here's how you can do it:

```go-html-template
{{ with resources.Get "css/styles.css" }}
  {{ $cssOpts := dict
    "vars" (dict "favourite-color" "#7f93c9")
    "externals" (slice "tailwindcss")
  }}
  {{ $tailwindOpts := dict "disableInlineImports" true }}
  {{ with . | css.Build $cssOpts | css.TailwindCSS $tailwindOpts }}
    <link rel="stylesheet" href="{{ .RelPermalink }}">
  {{ end }}
{{ end }}
```

Some notes to the above:

- Marking `tailwindcss` as an external in the `css.Build` options prevents it from being processed by the build step, allowing it to be correctly handled by the Tailwind CSS CLI in the subsequent step.
- The `disableInlineImports` option is set to `true` for the Tailwind CSS step as imports are handled by the `css.Build`.

[modern browser]: https://tailwindcss.com/docs/compatibility#browser-support
[standalone binary]: https://github.com/tailwindlabs/tailwindcss/releases/latest
[`css.Build`]: /functions/css/build/
[`vars`]: /functions/css/build/#vars


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/css/Unquoted.md
---


> [!NOTE]
> This function is only applicable to the `vars` option passed to the [`css.Sass`][] function.

When passing a `vars` map to the `css.Sass` function, Hugo detects common typed CSS values such as `24px` or `#FF0000` using regular expression matching. If necessary, you can bypass automatic type inference by using the `css.Unquoted` function to explicitly indicate that the value must be treated as an unquoted string.

In the example below, we use `css.Unquoted` to ensure the value for the `font-family` property is injected without quotes.

```go-html-template
{{ $vars := dict
  "font-main" ("sans-serif" | css.Unquoted)
}}

{{ $opts := dict "vars" $vars "transpiler" "dartsass" }}
{{ with resources.Get "sass/main.scss" | css.Sass $opts }}
  <link rel="stylesheet" href="{{ .RelPermalink }}">
{{ end }}
```

Using the `hugo:vars` identifier in your stylesheet:

```scss
@use "hugo:vars" as h;

body {
  font-family: h.$font-main;
}
```

The resulting CSS contains an unquoted string:

```css
body {
  font-family: sans-serif;
}
```

[`css.Sass`]: /functions/css/sass/#vars

