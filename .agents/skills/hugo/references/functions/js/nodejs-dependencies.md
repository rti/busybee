## Node.js dependencies

Use the `js.Build` function to include Node dependencies.

Any imports in a file outside `assets` or that does not resolve to a component inside `assets` will be resolved by [`esbuild`][] with the **project directory** as the resolve directory (used as the starting point when looking for `node_modules` etc.). Also see [`hugo mod npm pack`][]. If you have any imported npm dependencies in your project, you need to make sure to run `npm install` before you run `hugo build`.

The start directory for resolving npm packages (aka. packages that live inside a `node_modules` directory) is always the main project directory.

> [!NOTE]
> If you're developing a theme/component that is supposed to be imported and depends on dependencies inside `package.json`, we recommend reading about [`hugo mod npm pack`][], a tool to consolidate all the npm dependencies in a project.

