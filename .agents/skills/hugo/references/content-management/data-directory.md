## Data directory

The `data` directory in the root of your project may contain one or more data files, in either a flat or nested tree. Hugo merges the data files to create a single data structure, accessible with the `Data` method on a `Site` object.

Hugo also merges data directories from themes and modules into this single data structure, where the `data` directory in the root of your project takes precedence.

> [!NOTE]
> Hugo reads the combined data structure into memory and keeps it there for the entire build. For data that is infrequently accessed, use global or page resources instead.

Theme and module authors may wish to namespace their data files to prevent collisions. For example:

```tree
project/
└── data/
    └── mytheme/
        └── foo.json
```

> [!NOTE]
> Do not place CSV files in the `data` directory. Access CSV files as page, global, or remote resources.

See the documentation for the [`Data`][] method on a `Site` object for details and examples.

