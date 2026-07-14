## Group

The `Group` method take an `ID` (`string`) as argument. No slashes. It returns an object with these methods:

### Script

The `Script` method takes an `ID` (`string`) as argument. No slashes. It returns an [OptionsSetter](#optionssetter) that can be used to set [script options](#script-options) for this script.

```go-html-template
{{ with js.Batch "js/mybatch" }}
  {{ with .Group "mygroup" }}
      {{ with .Script "myscript" }}
          {{ .SetOptions (dict "resource" (resources.Get "myscript.js")) }}
      {{ end }}
  {{ end }}
{{ end }}
```

`SetOptions` takes a [script options](#script-options) map. Note that if you want the script to be handled by a [Runner](#runner), you need to set the `export` option to match what you want to pass on to the runner (default is `*`).

### Instance

The `Instance` method takes two `string` arguments `SCRIPT_ID` and `INSTANCE_ID`. No slashes. It returns an [OptionsSetter](#optionssetter) that can be used to set [params options](#params-options) for this instance.

```go-html-template
{{ with js.Batch "js/mybatch" }}
  {{ with .Group "mygroup" }}
      {{ with .Instance "myscript" "myinstance" }}
          {{ .SetOptions (dict "params" (dict "param1" "value1")) }}
      {{ end }}
  {{ end }}
{{ end }}
```

`SetOptions` takes a [params options](#params-options) map. The instance options will be passed to any [Runner](#runner) script in the same group, as JSON.

### Runner

The `Runner` method takes an `ID` (`string`) as argument. No slashes. It returns an [OptionsSetter](#optionssetter) that can be used to set [script options](#script-options) for this runner.

```go-html-template
{{ with js.Batch "js/mybatch" }}
  {{ with .Group "mygroup" }}
      {{ with .Runner "myrunner" }}
          {{ .SetOptions (dict "resource" (resources.Get "myrunner.js")) }}
      {{ end }}
  {{ end }}
{{ end }}
```

`SetOptions` takes a [script options](#script-options) map.

The runner will receive a data structure with all instances for that group with a live binding of the [JavaScript import][] of the defined `export`.

The runner script's export must be a function that takes one argument, the group data structure. An example of a group data structure as JSON is:

```json
{
    "id": "leaflet",
    "scripts": [
        {
            "id": "mapjsx",
            "binding": JAVASCRIPT_BINDING,
            "instances": [
                {
                    "id": "0",
                    "params": {
                        "c": "h-64",
                        "lat": 48.8533173846729,
                        "lon": 2.3497416090232535,
                        "r": "map.jsx",
                        "title": "Cathédrale Notre-Dame de Paris",
                        "zoom": 23
                    }
                },
                {
                    "id": "1",
                    "params": {
                        "c": "h-64",
                        "lat": 59.96300872062237,
                        "lon": 10.663529183196863,
                        "r": "map.jsx",
                        "title": "Holmenkollen",
                        "zoom": 3
                    }
                }
            ]
        }
    ]
}
```

Below is an example of a runner script that uses React to render elements. Note that the export (`default`) must match the `export` option in the [script options](#script-options) (`default` is the default value for runner scripts). Runnable versions of the examples on this page can be found in this `js.Batch` [demonstration repository][js_batch_demo].

```js
import * as ReactDOM from 'react-dom/client';
import * as React from 'react';

export default function Run(group) {
  console.log('Running react-create-elements.js', group);
  const scripts = group.scripts;
  for (const script of scripts) {
    for (const instance of script.instances) {
      /* This is a convention in this project. */
      let elId = `${script.id}-${instance.id}`;
      let el = document.getElementById(elId);
      if (!el) {
        console.warn(`Element with id ${elId} not found`);
        continue;
      }
      const root = ReactDOM.createRoot(el);
      const reactEl = React.createElement(script.binding, instance.params);
      root.render(reactEl);
    }
  }
}
```

### Config

Returns an [OptionsSetter](#optionssetter) that can be used to set [build options](#build-options) for the batch.

These are mostly the same as for `js.Build`, but note that:

- `targetPath` is set automatically (there may be multiple outputs).
- `format` must be `esm`, currently the only format that supports [code splitting][].
- `params` will be available in the `@params/config` namespace in the scripts. This way you can import both the [Script](#script) or [Runner](#runner) params and the [Config](#config) params with:

```js
import * as params from "@params";
import * as config from "@params/config";
```

Setting the `Config` for a batch can be done from any template (including shortcode templates), but will only be set once (the first will win):

```go-html-template
{{ with js.Batch "js/mybatch" }}
  {{ with .Config }}
       {{ .SetOptions (dict
        "target" "es2023"
        "format" "esm"
        "jsx" "automatic"
        "loaders" (dict ".png" "dataurl")
        "minify" true
        "params" (dict "param1" "value1")
        )
      }}
  {{ end }}
{{ end }}
```

