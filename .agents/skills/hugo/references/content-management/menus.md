## Menus

Localization of menu entries depends on how you define them:

- When you define menu entries [automatically][] using the section pages menu, you must use translation tables to localize each entry.
- When you define menu entries in [front matter][], they are already localized based on the front matter itself. If the front matter values are insufficient, use translation tables to localize each entry.
- When you define menu entries in your [project configuration][], you must create language-specific menu entries under each language key. If the names of the menu entries are insufficient, use translation tables to localize each entry.

### Create language-specific menu entries

#### Method 1 -- Use a single configuration file

For a simple menu with a small number of entries, use a single configuration file. For example:

{{< code-toggle file=hugo >}}
[languages.de]
label = 'Deutsch'
locale = 'de-DE'
weight = 1

[[languages.de.menus.main]]
name = 'Produkte'
pageRef = '/products'
weight = 10

[[languages.de.menus.main]]
name = 'Leistungen'
pageRef = '/services'
weight = 20

[languages.en]
label = 'English'
locale = 'en-US'
weight = 2

[[languages.en.menus.main]]
name = 'Products'
pageRef = '/products'
weight = 10

[[languages.en.menus.main]]
name = 'Services'
pageRef = '/services'
weight = 20
{{< /code-toggle >}}

#### Method 2 -- Use a configuration directory

With a more complex menu structure, create a [configuration directory][] and split the menu entries into multiple files, one file per language. For example:

```tree
config/
└── _default/
    ├── menus.de.toml
    ├── menus.en.toml
    └── hugo.toml
```

{{< code-toggle file=config/_default/menus.de >}}
[[main]]
name = 'Produkte'
pageRef = '/products'
weight = 10
[[main]]
name = 'Leistungen'
pageRef = '/services'
weight = 20
{{< /code-toggle >}}

{{< code-toggle file=config/_default/menus.en >}}
[[main]]
name = 'Products'
pageRef = '/products'
weight = 10
[[main]]
name = 'Services'
pageRef = '/services'
weight = 20
{{< /code-toggle >}}

### Use translation tables

When rendering the text that appears in menu each entry, the [example menu template][] does this:

```go-html-template
{{ or (T .Identifier) .Name | safeHTML }}
```

It queries the translation table for the current language using the menu entry's `identifier` and returns the translated string. If the translation table does not exist, or if the `identifier` key is not present in the translation table, it falls back to `name`.

The `identifier` depends on how you define menu entries:

- If you define the menu entry [automatically][] using the section pages menu, the `identifier` is the page's `.Section`.
- If you define the menu entry in your [project configuration][] or in [front matter][], set the `identifier` property to the desired value.

For example, if you define menu entries in project configuration:

{{< code-toggle file=hugo >}}
[[menus.main]]
  identifier = 'products'
  name = 'Products'
  pageRef = '/products'
  weight = 10
[[menus.main]]
  identifier = 'services'
  name = 'Services'
  pageRef = '/services'
  weight = 20
{{< / code-toggle >}}

Create corresponding entries in the translation tables:

{{< code-toggle file=i18n/de >}}
products = 'Produkte'
services = 'Leistungen'
{{< / code-toggle >}}

