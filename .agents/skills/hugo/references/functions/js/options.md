## Options

The `js.Build` function accepts an options map.

`format`
: (`string`) The output format. One of: `iife`, `cjs`, `esm`. Default is `iife`, a self-executing function, suitable for inclusion as a `<script>` tag.

`targetPath`
: (`string`) If not set, the source path will be used as the base target path. Note that the target path's extension may change if the target MIME type is different, e.g. when the source is TypeScript.

{{% include "/_common/functions/js/options.md" %}}

