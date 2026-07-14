## Project skeleton

Hugo generates a project skeleton when you create a new project. For example, this command:

```sh
hugo new project my-project
```

Creates this directory structure:

```txt
my-project/
├── archetypes/
│   └── default.md
├── assets/
├── content/
├── data/
├── i18n/
├── layouts/
├── static/
├── themes/
└── hugo.toml         <-- project configuration
```

Depending on requirements, you may wish to organize your project configuration into subdirectories:

```txt
my-project/
├── archetypes/
│   └── default.md
├── assets/
├── config/           <-- project configuration
│   └── _default/
│       └── hugo.toml
├── content/
├── data/
├── i18n/
├── layouts/
├── static/
└── themes/
```

When you build your project, Hugo creates a `public` directory, and typically a `resources` directory as well:

```txt
my-project/
├── archetypes/
│   └── default.md
├── assets/
├── config/
│   └── _default/
│       └── hugo.toml
├── content/
├── data/
├── i18n/
├── layouts/
├── public/       <-- created when you build your project
├── resources/    <-- created when you build your project
├── static/
└── themes/
```

