## Consolidating with `hugo mod npm pack`

Run [`hugo mod npm pack`][] to collect Node dependencies from all modules and write them to `packages/hugoautogen/package.json`. Hugo also adds a `workspaces` entry to your project's root `package.json` pointing to this auto-generated package.

The resulting project structure:

```tree
project/
├── package.json                      # your project's package.json (updated with workspaces entry)
├── packages/
│   └── hugoautogen/
│       ├── package.json              # auto-generated, contains consolidated module deps
│       └── hugo_packagemeta.json     # metadata and checksums for staleness detection
└── ...
```

<!-- TODO
In the admonition below, remove the reference to v0.159.0 somewhere
after v0.174.0, 15 minor releases after the improvement.
-->

> [!NOTE]
In Hugo < v0.159.0 Hugo wrote the dependencies into your project's package.json, so if you have used `hugo mod npm pack` on your project using older Hugo versions, now is the time to do a spring cleaning of your project `package.json` file: Only direct Node dependencies needs to live in this file, all incoming dependencies from imported modules gets written to `packages/hugoautogen/package.json`.

When merging, the **topmost version, starting from the project, take precedence**. If a module declares `tailwindcss@4.1` but your project already has `tailwindcss@4.0`, the project version wins and the module dependency is excluded from the generated workspace package.

