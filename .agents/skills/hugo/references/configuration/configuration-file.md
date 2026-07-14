## Configuration file

Create a project configuration file in the root of your project directory, naming it `hugo.toml`, `hugo.yaml`, or `hugo.json`, with that order of precedence.

```tree
my-project/
└── hugo.toml
```

A simple example:

{{< code-toggle file=hugo >}}
baseURL = 'https://example.org/'
locale = 'en-us'
title = 'ABC Widgets, Inc.'
[params]
subtitle = 'The Best Widgets on Earth'
[params.contact]
email = 'info@example.org'
phone = '+1 202-555-1212'
{{< /code-toggle >}}

To use a different configuration file when building your project, use the `--config` flag:

```sh
hugo build --config other.toml
```

Combine two or more configuration files, with left-to-right precedence:

```sh
hugo build --config a.toml,b.yaml,c.json
```

> [!NOTE]
> See the specifications for each file format: [TOML][], [YAML][], and [JSON][].

