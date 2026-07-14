## Cache

Hugo caches modules to avoid repeated downloads during site builds. By default, these are stored in the `modules` directory within the [`cacheDir`][].

To clean the module cache for the current project:

```sh
hugo mod clean
```

To clean the module cache for all projects:

```sh
hugo mod clean --all
```

For details on cache location and eviction, see [configuring file caches][].

