## Update

When you import a module, Hugo creates `go.mod` and `go.sum` files in your project root, storing version and checksum data. Clearing the module cache and rebuilding will re-download the originally imported module version, as specified in the `go.mod` file, ensuring consistent builds. Modules can be updated to other versions as needed.

To update a module to the latest version:

```sh
hugo mod get -u github.com/user/shortcodes-c
```

To update a module to a specific version:

```sh
hugo mod get -u github.com/user/shortcodes-c@v0.42.0
```

To update all modules to the latest version:

```sh
hugo mod get -u
```

To recursively update all modules to the latest version:

```sh
hugo mod get -u ./...
```

