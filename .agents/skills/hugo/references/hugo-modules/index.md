# hugo-modules


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/hugo-modules/introduction.md
---


Hugo uses modules as its fundamental organizational units. A module can be a full Hugo project or a smaller, reusable piece providing one or more of Hugo's seven component types: static files, content, layouts, data, assets, internationalization (i18n) resources, and archetypes.

Modules are combinable in any arrangement, and external directories (including those from non-Hugo projects) can be mounted, effectively creating a single, unified file system.

Some example projects:

<https://github.com/bep/docuapi>
: A theme that has been ported to Hugo modules while testing this feature. It is a good example of a non-Hugo-project mounted into Hugo's directory structure.

<https://github.com/bep/my-modular-site>
: A simple site used for testing.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/hugo-modules/nodejs-dependencies.md
---


Modules that need Node packages (e.g. for Tailwind CSS) can declare those dependencies in a standard `package.json` at the module root. Hugo consolidates dependencies from all modules into an [npm workspace][], so you only need a single `npm install` at the project level.


## Sections

- [`declaring-dependencies`](references/hugo-modules/declaring-dependencies.md) — Declaring Dependencies
- [`consolidating-with-hugo-mod-npm-pack`](references/hugo-modules/consolidating-with-hugo-mod-npm-pack.md) — Consolidating With `hugo Mod Npm Pack`
- [`staleness-detection`](references/hugo-modules/staleness-detection.md) — Staleness Detection
- [`introduction`](references/hugo-modules/introduction.md) — Introduction
- [`import`](references/hugo-modules/import.md) — Import
- [`update`](references/hugo-modules/update.md) — Update
- [`tidy`](references/hugo-modules/tidy.md) — Tidy
- [`cache`](references/hugo-modules/cache.md) — Cache
- [`vendor`](references/hugo-modules/vendor.md) — Vendor
- [`replace`](references/hugo-modules/replace.md) — Replace
- [`workspace`](references/hugo-modules/workspace.md) — Workspace
- [`graph`](references/hugo-modules/graph.md) — Graph
- [`mounts`](references/hugo-modules/mounts.md) — Mounts

