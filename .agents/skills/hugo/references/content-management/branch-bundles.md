## Branch bundles

A _branch bundle_ is a directory that contains an&nbsp;`_index.md`&nbsp;file and zero or more resources. Analogous to a physical branch, a branch bundle may have descendants including leaf bundles and other branch bundles. Top-level directories with or without `_index.md`&nbsp;files are also branch bundles. This includes the home page.

```tree
content/
├── branch-bundle-1/
│   ├── _index.md
│   ├── content-1.md
│   ├── content-2.md
│   ├── image-1.jpg
│   └── image-2.png
├── branch-bundle-2/
│   ├── a-leaf-bundle/
│   │   └── index.md
│   └── _index.md
└── _index.md
```

There are three branch bundles in the example above:

home page
: This branch bundle contains an index file, two descendant branch bundles, and no resources.

branch-bundle-1
:  This branch bundle contains an index file, two resources of [resource type](g) `page`, and two resources of resource type `image`.

branch-bundle-2
: This branch bundle contains an index file and a leaf bundle.

> [!NOTE]
> Create branch bundles at any depth within the `content` directory. Branch bundles may have descendants.

