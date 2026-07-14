## Configuration directory

Instead of a single project configuration file, split your configuration by [environment](g), root configuration key, and language. For example:

```tree
my-project/
└── config/
    ├── _default/
    │   ├── hugo.toml
    │   ├── menus.en.toml
    │   ├── menus.de.toml
    │   └── params.toml
    └── production/
        └── params.toml
```

The root configuration keys are {{< root-configuration-keys >}}.

### Root key

{{< new-in 0.162.0 />}}

When splitting the configuration by root key, you may omit or include the root key in the component file. For example, these are equivalent:

{{< code-toggle file=config/_default/hugo >}}
[params]
foo = 'bar'
{{< /code-toggle >}}

{{< code-toggle file=config/_default/params >}}
foo = 'bar'
{{< /code-toggle >}}

This also applies to keys whose values are maps of slices, such as `menus`. For example, these are equivalent:

{{< code-toggle file=config/_default/menus >}}
[[main]]
name = 'Home'
pageRef = '/'
weight = 10
{{< /code-toggle >}}

{{< code-toggle file=config/_default/menus >}}
[[menus.main]]
name = 'Home'
pageRef = '/'
weight = 10
{{< /code-toggle >}}

For pure slice-typed keys such as `cascade` and `permalinks`, including the root key is required. For example:

{{< code-toggle file=config/_default/cascade >}}
[[cascade]]
[cascade.params]
color = 'red'
[cascade.target]
path = '/articles/**'
{{< /code-toggle >}}

> [!NOTE]
> Hugo unwraps the root key only when it is the sole top-level key in the file and matches the file's basename.

### Recursive parsing

Hugo parses the `config` directory recursively, allowing you to organize the files into subdirectories. For example:

```tree
my-project/
└── config/
    └── _default/
        ├── navigation/
        │   ├── menus.de.toml
        │   └── menus.en.toml
        └── hugo.toml
```

### Example

```tree
my-project/
└── config/
    ├── _default/
    │   ├── hugo.toml
    │   ├── menus.en.toml
    │   ├── menus.de.toml
    │   └── params.toml
    ├── production/
    │   ├── hugo.toml
    │   └── params.toml
    └── staging/
        ├── hugo.toml
        └── params.toml
```

Considering the structure above, when running `hugo build --environment staging`, Hugo will use every setting from `config/_default` and merge `staging`'s on top of those.

Let's take an example to understand this better. Let's say you are using Google Analytics for your website. This requires you to specify a [Google tag ID][] in your project configuration:

{{< code-toggle file=hugo >}}
[services.googleAnalytics]
ID = 'G-XXXXXXXXX'
{{< /code-toggle >}}

Now consider the following scenario:

1. You don't want to load the analytics code when running `hugo server`.
1. You want to use different Google tag IDs for your production and staging environments. For example:
    - `G-PPPPPPPPP` for production
    - `G-SSSSSSSSS` for staging

To satisfy these requirements, configure your site as follows:

1. `config/_default/hugo.toml`
    - Exclude the `services.googleAnalytics` section. This will prevent loading of the analytics code when you run `hugo server`.
    - By default, Hugo sets its `environment` to `development` when running `hugo server`. In the absence of a `config/development` directory, Hugo uses the `config/_default` directory.
1. `config/production/hugo.toml`
    - Include this section only:

      {{< code-toggle file=hugo >}}
      [services.googleAnalytics]
      ID = 'G-PPPPPPPPP'
      {{< /code-toggle >}}

    - You do not need to include other parameters in this file. Include only those parameters that are specific to your production environment. Hugo will merge these parameters with the default configuration.
    - By default, Hugo sets its `environment` to `production` when running `hugo build`. The analytics code will use the `G-PPPPPPPPP` tag ID.

1. `config/staging/hugo.toml`

    - Include this section only:

      {{< code-toggle file=hugo >}}
      [services.googleAnalytics]
      ID = 'G-SSSSSSSSS'
      {{< /code-toggle >}}

    - You do not need to include other parameters in this file. Include only those parameters that are specific to your staging environment. Hugo will merge these parameters with the default configuration.
    - To build your staging site, run `hugo build --environment staging`. The analytics code will use the `G-SSSSSSSSS` tag ID.

