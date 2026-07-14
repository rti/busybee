## Workspace

{{% glossary-term "workspace" %}}

Workspaces simplify local development of sites with modules. Create a `.work` file to define a workspace, and activate it via the [`workspace`][] configuration setting or the `HUGO_MODULE_WORKSPACE` environment variable.

A `.work` file example:

```text
go 1.26

use .
use ../my-hugo-module
```

Use the `use` directive to list module paths, including the main project (`.`). Start the Hugo server with the workspace enabled:

```sh
HUGO_MODULE_WORKSPACE=hugo.work hugo server --ignoreVendorPaths "**"
```

The `--ignoreVendorPaths` flag, used to ignore vendored dependencies (if applicable), enables live reloading of local edits within the workspace.

