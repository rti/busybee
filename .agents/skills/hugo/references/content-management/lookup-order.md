## Lookup order

Hugo looks for archetypes in the `archetypes` directory in the root of your project, falling back to the `archetypes` directory in themes or installed modules. An archetype for a specific content type takes precedence over the default archetype.

For example, if you have enabled a theme named `my-theme` and you run this command:

```sh
hugo new content posts/my-first-post.md
```

The archetype lookup order is:

1. `archetypes/posts.md`
1. `themes/my-theme/archetypes/posts.md`
1. `archetypes/default.md`
1. `themes/my-theme/archetypes/default.md`

If none of these exists, Hugo uses a built-in default archetype.

