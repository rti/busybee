## Leaf bundles

A _leaf bundle_ is a directory that contains an&nbsp;`index.md`&nbsp;file and zero or more resources. Analogous to a physical leaf, a leaf bundle is at the end of a branch. It has no descendants.

```tree
content/
├── about
│   └── index.md
├── posts
│   ├── my-post
│   │   ├── content-1.md
│   │   ├── content-2.md
│   │   ├── image-1.jpg
│   │   ├── image-2.png
│   │   └── index.md
│   └── my-other-post
│       └── index.md
└── another-section
    ├── foo.md
    └── not-a-leaf-bundle
        ├── bar.md
        └── another-leaf-bundle
            └── index.md
```

There are four leaf bundles in the example above:

about
: This leaf bundle does not contain any page resources.

my-post
: This leaf bundle contains an index file, two resources of [resource type](g) `page`, and two resources of resource type `image`.

  - content-1, content-2

    These are resources of resource type `page`, accessible via the [`Resources`][] method on the `Page` object. Hugo will not render these as individual pages.

  - image-1, image-2

    These are resources of resource type `image`, accessible via the `Resources` method on the `Page` object

my-other-post
: This leaf bundle does not contain any page resources.

another-leaf-bundle
: This leaf bundle does not contain any page resources.

> [!NOTE]
> Create leaf bundles at any depth within the `content` directory, but a leaf bundle may not contain another bundle. Leaf bundles do not have descendants.

