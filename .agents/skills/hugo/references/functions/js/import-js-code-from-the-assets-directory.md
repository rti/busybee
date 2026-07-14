## Import JS code from the assets directory

`js.Build` has full support for Hugo's [unified file system](g). You can see some simple examples in this [test project][], but in short this means that you can do this:

```js
import { hello } from 'my/module';
```

And it will resolve to the top-most `index.{js,ts,tsx,jsx}` inside `assets/my/module` in the layered file system.

```js
import { hello3 } from 'my/module/hello3';
```

Will resolve to `hello3.{js,ts,tsx,jsx}` inside `assets/my/module`.

Any imports starting with `.` are resolved relative to the current file:

```js
import { hello4 } from './lib';
```

For other files (e.g. `JSON`, `CSS`) you need to use the relative path including any extension, e.g:

```js
import * as data from 'my/module/data.json';
```

Any imports in a file outside `assets` or that does not resolve to a component inside `assets` will be resolved by [`esbuild`][] with the **project directory** as the resolve directory (used as the starting point when looking for `node_modules` etc.). Also see [`hugo mod npm pack`][]. If you have any imported npm dependencies in your project, you need to make sure to run `npm install` before you run `hugo build`.

Also note the new `params` option that can be passed from template to your JS files, e.g.:

```go-html-template
{{ $js := resources.Get "js/main.js" | js.Build (dict "params" (dict "api" "https://example.org/api")) }}
```

And then in your JS file:

```js
import * as params from '@params';
```

Hugo will, by default, generate a `assets/jsconfig.json` file that maps the imports. This is useful for navigation/intellisense help inside code editors, but if you don't need/want it, you can [turn it off][].

