## Directories

Each of the subdirectories contributes to content, structure, behavior, or presentation.

`archetypes`
: The `archetypes` directory contains templates for new content. See [details](/content-management/archetypes/).

`assets`
: The `assets` directory contains global resources typically passed through an asset pipeline. This includes resources such as images, CSS, Sass, JavaScript, and TypeScript. See [details](/hugo-pipes/introduction/).

`config`
: The `config` directory contains your project configuration, possibly split into multiple subdirectories and files. For projects with minimal configuration or projects that do not need to behave differently in different environments, a single configuration file named `hugo.toml` in the root of the project is sufficient. See [details][configuration-directory].

`content`
: The `content` directory contains the markup files (typically Markdown) and page resources that comprise the content of your project. See [details](/content-management/organization/).

`data`
: The `data` directory contains data files (JSON, TOML, YAML, or XML) that augment content, configuration, localization, and navigation. See [details](/content-management/data-sources/).

`i18n`
: The `i18n` directory contains translation tables for multilingual projects. See [details](/content-management/multilingual/).

`layouts`
: The `layouts` directory contains templates to transform content, data, and resources into a complete website. See [details](/templates/).

`public`
: The `public` directory contains the published website, generated when you run the `hugo build` or `hugo server` commands. Hugo recreates this directory and its content as needed. See [details][build-your-project].

`resources`
: The `resources` directory contains cached output from Hugo's asset pipelines, generated when you run the `hugo build` or `hugo server` commands. By default this cache directory includes CSS and images. Hugo recreates this directory and its content as needed.

`static`
: The `static` directory contains files that will be copied to the `public` directory when you build your project. For example: `favicon.ico`, `robots.txt`, and files that verify website ownership. Before the introduction of [page bundles](g) and [asset pipelines][], the `static` directory was also used for images, CSS, and JavaScript.

`themes`
: The `themes` directory contains one or more [themes](g), each in its own subdirectory.

