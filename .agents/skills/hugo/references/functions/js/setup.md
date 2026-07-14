## Setup

Step 1
: Install [Node.js][].

Step 2
: Install the required Node packages in the root of your project. For example, to install Babel's core compiler, its command-line interface, and the preset for transpiling modern JavaScript based on your target environments:

  ```sh
  npm install --save-dev @babel/core @babel/cli @babel/preset-env
  ```

Step 3
: Create a Babel configuration file in the root of your project. For example, to use the environment preset to target Google Chrome version 79 or later:

  ```js {file="babel.config.mjs" copy=true}
  export default {
    presets: [
      [
        '@babel/preset-env',
        {
          targets: {
            chrome: "79"
          }
        }
      ]
    ]
  };
  ```

Step 4
: Place your JS file within the `assets/js` directory.

Step 5
: Add the Babel executable to Hugo's `security.exec.allow` list in your project configuration:

  {{< code-toggle file=hugo >}}
  [security.exec]
    allow = ['^(dart-)?sass(-embedded)?$', '^go$', '^git$', '^node$', '^postcss$', '^tailwindcss$', '^babel$']
  {{< /code-toggle >}}

Step 6
: Create a partial template to process the JavaScript:

  ```go-html-template {file="layouts/_partials/js.html" copy=true}
  {{ with resources.Get "js/main.js" }}
    {{ $opts := dict
      "minified" (cond hugo.IsDevelopment false true)
      "noComments" (cond hugo.IsDevelopment false true)
      "sourceMap" (cond hugo.IsDevelopment "inline" "none")
    }}
    {{ with . | js.Babel $opts }}
      {{ if hugo.IsDevelopment }}
        <script src="{{ .RelPermalink }}"></script>
      {{ else }}
        {{ with . | fingerprint }}
          <script src="{{ .RelPermalink }}" integrity="{{ .Data.Integrity }}" crossorigin="anonymous"></script>
        {{ end }}
      {{ end }}
    {{ end }}
  {{ end }}
  ```

Step 7
: Call the partial template from your base template:

  ```go-html-template {file="layouts/baseof.html" copy=true}
  <head>
    {{ partial "js.html" . }}
  </head>
  ```

