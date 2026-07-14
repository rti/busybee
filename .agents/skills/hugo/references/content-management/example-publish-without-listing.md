## Example -- publish without listing

Publish a section's descendant pages without publishing the section page itself.

```tree
content/
├── books/
│   ├── _index.md
│   ├── book-1.md
│   └── book-2.md
└── _index.md
```

Set the build options in front matter:

{{< code-toggle file=content/books/_index.md fm=true >}}
title = 'Books'
[build]
render = 'never'
list = 'never'
{{< /code-toggle >}}

The published site will have this structure:

```tree
public/
├── books/
│   ├── book-1/
│   │   └── index.html
│   └── book-2/
│       └── index.html
└── index.html
```

