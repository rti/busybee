## Environment variables

Hugo passes the environment variables below to PostCSS, allowing you to do something like:

```js
process.env.HUGO_ENVIRONMENT !== 'development' ? purgecss : null,
```

`PWD`
: The absolute path to the project working directory.

`HUGO_ENVIRONMENT`
: The current Hugo environment, set with the `--environment` command line flag.
Default is `production` for `hugo build` and `development` for `hugo server`.

`HUGO_PUBLISHDIR`
: The absolute path to the publish directory, typically `public`. This value points to a directory on disk, even when rendering to memory with the `--renderToMemory` command line flag.

`HUGO_FILE_X`
: Hugo automatically mounts the following files from your project's root directory under `assets/_jsconfig`:

- `babel.config.js`, `babel.config.mjs`, `babel.config.cjs`
- `postcss.config.js`, `postcss.config.mjs`, `postcss.config.cjs`
- `tailwind.config.js`, `tailwind.config.mjs`, `tailwind.config.cjs`

For each file, Hugo creates a corresponding environment variable named `HUGO_FILE_:filename:`, where `:filename:` is the uppercase version of the filename with periods replaced by underscores. This allows you to access these files within your JavaScript, for example:

```js
let tailwindConfig = process.env.HUGO_FILE_TAILWIND_CONFIG_JS || './tailwind.config.js';
```

