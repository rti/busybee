## Import

To import a module, first initialize the project itself as a module. For example:

```sh
hugo mod init github.com/user/project
```

This will generate a [`go.mod`][] file in the project root.

> [!NOTE]
> The module name is a unique identifier rather than a hosting requirement. Using a name like `github.com/user/project` is a common convention but it does not mean you must use Git or host your code on GitHub. You can use any name you like if you do not plan to have others import your project as a module. For example, you could use a simple name such as `my-project` when you run the initialization command.

Then define one or more imports in your project configuration. This contrived example imports three modules, each containing custom shortcodes:

{{< code-toggle file=hugo >}}
[module]
  [[module.imports]]
    path = 'shortcodes-a'
  [[module.imports]]
    path = '/home/user/shortcodes-b'
  [[module.imports]]
    path = 'github.com/user/shortcodes-c'
{{< /code-toggle >}}

Import precedence is top-down. For example, if `shortcodes-a`, `shortcodes-b`, and `shortcodes-c` each define an `image` shortcode, the `image` shortcode from `shortcodes-a` will take effect.

> [!NOTE]
> If multiple modules contain data files or [translation tables](g) with identical paths, the data is deeply merged, following top-down precedence.

When you build your project, Hugo will:

1. Download the modules
1. Cache them for future use
1. Generate a [`go.sum`][] file in the project root

See [configuring module imports][] for details and options.

