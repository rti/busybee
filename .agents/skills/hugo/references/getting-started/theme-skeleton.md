## Theme skeleton

Hugo generates a functional theme skeleton when you create a new theme. For example, this command:

```sh
hugo new theme my-theme
```

Creates this directory structure (subdirectories not shown):

```tree
my-theme/
├── archetypes/
├── assets/
├── content/
├── data/
├── i18n/
├── layouts/
├── static/
└── hugo.toml
```

Using the unified file system described above, Hugo mounts each of these directories to the corresponding location in the project. When two files have the same path, the file in the project directory takes precedence. This allows you, for example, to override a theme's template by placing a copy in the same location within the project directory.

If you are simultaneously using components from two or more themes or modules, and there's a path collision, the first mount takes precedence.

[asset pipelines]: /hugo-pipes/introduction/
[build-your-project]: /getting-started/usage/#build-your-project
[configuration-directory]: /configuration/introduction/#configuration-directory
[mounts]: /configuration/module/#mounts


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/getting-started/quick-start.md
---


In this tutorial you will:

1. Create a project
1. Add content
1. Configure the project
1. Publish the project

