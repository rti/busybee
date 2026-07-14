## Merge configuration settings

Hugo merges configuration settings from themes and modules, prioritizing the project's own settings. Given this simplified project structure with two themes:

```tree
project/
├── themes/
│   ├── theme-a/
│   │   └── hugo.toml
│   └── theme-b/
│       └── hugo.toml
└── hugo.toml
```

and this project-level configuration:

{{< code-toggle file=hugo >}}
baseURL = 'https://example.org/'
locale = 'en-us'
title = 'My New Hugo Site'
theme = ['theme-a','theme-b']
{{< /code-toggle >}}

Hugo merges settings in this order:

1. Project configuration (`hugo.toml` in the project root)
1. `theme-a` configuration
1. `theme-b` configuration

The `_merge` setting within each top-level configuration key controls _which_ settings are merged and _how_ they are merged.

The value for `_merge` can be one of:

`none`
: No merge.

`shallow`
: Only add values for new keys.

`deep`
: Add values for new keys, merge existing.

Note that you don't need to be so verbose as in the default setup below; a `_merge` value higher up will be inherited if not set.

{{< code-toggle file=hugo dataKey="config_helpers.mergeStrategy" skipHeader=true />}}

> [!NOTE]
> Hugo can merge map configuration values from modules and themes into the project configuration, but cannot merge slice values. This applies to top-level slice keys such as `menus`, as well as to map keys whose values are slices, such as the per-kind format lists in `outputs`.

