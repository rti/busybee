## Unified file system

Hugo creates a [unified file system](g), allowing you to mount two or more directories to the same location. For example, let's say your home directory contains a Hugo project in one directory, and shared content in another:

```tree
home/
└── user/
    ├── my-project/
    │   ├── content/
    │   │   ├── books/
    │   │   │   ├── _index.md
    │   │   │   ├── book-1.md
    │   │   │   └── book-2.md
    │   │   └── _index.md
    │   ├── themes/
    │   │   └── my-theme/
    │   └── hugo.toml
    └── shared-content/
        └── films/
            ├── _index.md
            ├── film-1.md
            └── film-2.md
```

You can include the shared content using mounts. In your project configuration:

{{< code-toggle file=hugo >}}
[[module.mounts]]
source = 'content'
target = 'content'

[[module.mounts]]
source = '/home/user/shared-content'
target = 'content'
{{< /code-toggle >}}

> [!NOTE]
> Defining a custom mount replaces the default mounting for that [component](g). To overlay an external directory on top of the project default, you must explicitly mount both.
>
> Hugo does not follow symbolic links. If you need the functionality provided by symbolic links, use Hugo's unified file system instead.

After mounting, the unified file system has this structure:

```tree
home/
└── user/
    └── my-project/
        ├── content/
        │   ├── books/
        │   │   ├── _index.md
        │   │   ├── book-1.md
        │   │   └── book-2.md
        │   ├── films/
        │   │   ├── _index.md
        │   │   ├── film-1.md
        │   │   └── film-2.md
        │   └── _index.md
        ├── themes/
        │   └── my-theme/
        └── hugo.toml
```

When two or more files share the same path, the version in the highest layer takes precedence. In the example above, if the `shared-content` directory contains `books/book-1.md`, it is ignored because the project's `content` directory is the first (highest) mount.

You can mount directories to `archetypes`, `assets`, `content`, `data`, `i18n`, `layouts`, and `static`. See [details][mounts].

You can also mount directories from Git repositories using modules. See [details](/hugo-modules/).

