## Example

In this example, after the build is complete, Hugo will:

1. Purge unused CSS using the [PurgeCSS][] plugin for [PostCSS][]
1. Add vendor prefixes to CSS rules using the [Autoprefixer][] plugin for PostCSS
1. [Minify][] the CSS
1. [Fingerprint][] the CSS

Step 1
: Install [Node.js][].

Step 2
: Install the required Node packages in the root of your project:

  ```sh {copy=true}
  npm i -D postcss postcss-cli autoprefixer @fullhuman/postcss-purgecss
  ```

Step 3
: Enable creation of the `hugo_stats.json` file when building the site. If you are only using this for the production build, consider placing it below [`config/production`][].

  {{< code-toggle file=hugo copy=true >}}
  [build.buildStats]
  enable = true
  {{< /code-toggle >}}

  See the [configure build][] documentation for details and options.

Step 4
: Create a PostCSS configuration file in the root of your project.

  ```js {file="postcss.config.mjs" copy=true}
  import autoprefixer from 'autoprefixer';
  import purgeCSSPlugin from '@fullhuman/postcss-purgecss';

  const purgecss = purgeCSSPlugin({
    content: ['./hugo_stats.json'],
    defaultExtractor: content => {
      const els = JSON.parse(content).htmlElements;
      return [
        ...(els.tags || []),
        ...(els.classes || []),
        ...(els.ids || []),
      ];
    },
    // https://purgecss.com/safelisting.html
    safelist: []
  });

  export default {
    plugins: [
      process.env.HUGO_ENVIRONMENT !== 'development' ? purgecss : null,
      autoprefixer,
    ]
  };
  ```

Step 5
: Place your CSS file within the `assets/css` directory.

Step 6
: If the current environment is not `development`, process the resource with PostCSS:

  ```go-html-template {copy=true}
  {{ with resources.Get "css/main.css" }}
    {{ if hugo.IsDevelopment }}
      <link rel="stylesheet" href="{{ .RelPermalink }}">
    {{ else }}
      {{ with . | postCSS | minify | fingerprint | resources.PostProcess }}
        <link rel="stylesheet" href="{{ .RelPermalink }}" integrity="{{ .Data.Integrity }}" crossorigin="anonymous">
      {{ end }}
    {{ end }}
  {{ end }}
  ```

