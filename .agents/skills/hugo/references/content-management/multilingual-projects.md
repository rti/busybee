## Multilingual projects

With multilingual projects you can:

1. Create one content adapter for all languages using the [`EnableAllLanguages`](#enablealllanguages) method as described above.
1. Create content adapters unique to each language. See the examples below.

### Translations by file name

With this project configuration:

{{< code-toggle file=hugo >}}
[languages.en]
weight = 1

[languages.de]
weight = 2
{{< /code-toggle >}}

Include a language designator in the content adapter's file name.

```tree
content/
└── books/
    ├── _content.de.gotmpl
    ├── _content.en.gotmpl
    ├── _index.de.md
    └── _index.en.md
```

### Translations by content directory

With this project configuration:

{{< code-toggle file=hugo >}}
[languages.en]
contentDir = 'content/en'
weight = 1

[languages.de]
contentDir = 'content/de'
weight = 2
{{< /code-toggle >}}

Create a single content adapter in each directory:

```tree
content/
├── de/
│   └── books/
│       ├── _content.gotmpl
│       └── _index.md
└── en/
    └── books/
        ├── _content.gotmpl
        └── _index.md
```

