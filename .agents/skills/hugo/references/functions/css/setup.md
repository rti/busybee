## Setup

Step 1
: Install Tailwind CSS v4.0 or later:

  ```sh {copy=true}
  npm install --save-dev tailwindcss @tailwindcss/cli @tailwindcss/typography
  ```

  <!-- TODO
  Remove the admonition below somewhere after v0.176.0, 15 minor releases
  after deprecation.
  -->

  > [!NOTE]
  > As of v0.161.0, Hugo no longer supports the Tailwind [standalone binary][]. You must now install the Tailwind CSS CLI via `npm` as shown above.

Step 2
: Add this to your project configuration:

  {{< code-toggle file=hugo copy=true >}}
  [build]
    [build.buildStats]
      enable = true
    [[build.cachebusters]]
      source = 'assets/notwatching/hugo_stats\.json'
      target = 'css'
    [[build.cachebusters]]
      source = '(postcss|tailwind)\.config\.js'
      target = 'css'
  [module]
    [[module.mounts]]
      source = 'assets'
      target = 'assets'
    [[module.mounts]]
      disableWatch = true
      source = 'hugo_stats.json'
      target = 'assets/notwatching/hugo_stats.json'
  {{< /code-toggle >}}

Step 3
: Create a CSS entry file:

  ```css {file="assets/css/main.css" copy=true}
  @import "tailwindcss";
  @plugin "@tailwindcss/typography";
  @source "hugo_stats.json";
  ```

  Tailwind CSS respects `.gitignore` files. This means that if `hugo_stats.json` is listed in your `.gitignore` file, Tailwind CSS will ignore it. To make `hugo_stats.json` available to Tailwind CSS you must explicitly source it as shown in the example above.

Step 4
: Create a _partial_ template to process the CSS with the Tailwind CSS CLI:

  ```go-html-template {file="layouts/_partials/css.html" copy=true}
  {{ with resources.Get "css/main.css" }}
    {{ $opts := dict "minify" (not hugo.IsDevelopment) }}
    {{ with . | css.TailwindCSS $opts }}
      {{ if hugo.IsDevelopment }}
        <link rel="stylesheet" href="{{ .RelPermalink }}">
      {{ else }}
        {{ with . | fingerprint }}
          <link rel="stylesheet" href="{{ .RelPermalink }}" integrity="{{ .Data.Integrity }}" crossorigin="anonymous">
        {{ end }}
      {{ end }}
    {{ end }}
  {{ end }}
  ```

Step 5
: Call the _partial_ template from your base template, deferring template execution until after all sites and output formats have been rendered:

  ```go-html-template {file="layouts/baseof.html" copy=true}
  <head>
    {{ with (templates.Defer (dict "key" "global")) }}
      {{ partial "css.html" . }}
    {{ end }}
  </head>
  ```

