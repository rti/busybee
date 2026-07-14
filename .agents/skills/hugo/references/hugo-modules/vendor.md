## Vendor

{{% glossary-term vendor %}}

Vendoring a module provides the benefits described above and allows for local inspection of its [components](g).

```sh
hugo mod vendor
```

This command creates a `_vendor` directory containing copies of all imported modules, used in subsequent builds. Note that:

- The `hugo mod vendor` command can be run from any module tree level.
- Modules within the `themes` directory are not vendored.
- The `--ignoreVendorPaths` flag allows you to exclude vendored modules matching a [glob pattern](g) from specific commands.

> [!IMPORTANT]
> Instead of modifying files directly within the `_vendor` directory, override them by creating a corresponding file with the same relative path in your project's root.

To remove the vendored modules, delete the `_vendor` directory.

