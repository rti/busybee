
---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/getting-started/directory-structure.md
---


Each Hugo project is a directory, with subdirectories that contribute to  content, structure, behavior, and presentation.

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

## Unified file system

Hugo creates a [unified file system](g), allowing you to mount two or more directories to the same location. For example, let's say your home directory contains a Hugo project in one directory, and shared content in another:

```tree
home/
└── user/
    ├── my-project/
    │   ├── content/
    │   │   ├── books/
    │   │   │   ├── _index.md
    │   │   │   ├── book-1.md
    │   │   │   └── book-2.md
    │   │   └── _index.md
    │   ├── themes/
    │   │   └── my-theme/
    │   └── hugo.toml
    └── shared-content/
        └── films/
            ├── _index.md
            ├── film-1.md
            └── film-2.md
```

You can include the shared content using mounts. In your project configuration:

{{< code-toggle file=hugo >}}
[[module.mounts]]
source = 'content'
target = 'content'

[[module.mounts]]
source = '/home/user/shared-content'
target = 'content'
{{< /code-toggle >}}

> [!NOTE]
> Defining a custom mount replaces the default mounting for that [component](g). To overlay an external directory on top of the project default, you must explicitly mount both.
>
> Hugo does not follow symbolic links. If you need the functionality provided by symbolic links, use Hugo's unified file system instead.

After mounting, the unified file system has this structure:

```tree
home/
└── user/
    └── my-project/
        ├── content/
        │   ├── books/
        │   │   ├── _index.md
        │   │   ├── book-1.md
        │   │   └── book-2.md
        │   ├── films/
        │   │   ├── _index.md
        │   │   ├── film-1.md
        │   │   └── film-2.md
        │   └── _index.md
        ├── themes/
        │   └── my-theme/
        └── hugo.toml
```

When two or more files share the same path, the version in the highest layer takes precedence. In the example above, if the `shared-content` directory contains `books/book-1.md`, it is ignored because the project's `content` directory is the first (highest) mount.

You can mount directories to `archetypes`, `assets`, `content`, `data`, `i18n`, `layouts`, and `static`. See [details][mounts].

You can also mount directories from Git repositories using modules. See [details](/hugo-modules/).

## Theme skeleton

Hugo generates a functional theme skeleton when you create a new theme. For example, this command:

```sh
hugo new theme my-theme
```

Creates this directory structure (subdirectories not shown):

```tree
my-theme/
├── archetypes/
├── assets/
├── content/
├── data/
├── i18n/
├── layouts/
├── static/
└── hugo.toml
```

Using the unified file system described above, Hugo mounts each of these directories to the corresponding location in the project. When two files have the same path, the file in the project directory takes precedence. This allows you, for example, to override a theme's template by placing a copy in the same location within the project directory.

If you are simultaneously using components from two or more themes or modules, and there's a path collision, the first mount takes precedence.

[asset pipelines]: /hugo-pipes/introduction/
[build-your-project]: /getting-started/usage/#build-your-project
[configuration-directory]: /configuration/introduction/#configuration-directory
[mounts]: /configuration/module/#mounts


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/getting-started/quick-start.md
---


In this tutorial you will:

1. Create a project
1. Add content
1. Configure the project
1. Publish the project

## Prerequisites

Before you begin this tutorial you must:

1. [Install Hugo][] (any edition, {{% param "minVersion" %}} or later)
1. [Install Git][]

You must also be comfortable working from the command line.

## Create a project

### Commands

> [!NOTE]
> **If you are a Windows user:**
>
> - Do not use the Command Prompt
> - Do not use Windows PowerShell
> - Run these commands from [PowerShell][] or a Linux terminal such as WSL or Git > Bash
>
> PowerShell and Windows PowerShell [are different applications][].

Verify that you have installed Hugo {{% param "minVersion" %}} or later.

```sh
hugo version
```

Run these commands to create a Hugo project with the [Ananke][] theme. The next section provides an explanation of each command.

```sh
hugo new project quickstart
cd quickstart
git init
git submodule add https://github.com/gohugo-ananke/ananke themes/ananke
echo "theme = 'ananke'" >> hugo.toml
hugo server
```

View your project at the URL displayed in your terminal. Press `Ctrl + C` to stop Hugo's development server.

### Explanation of commands

Create the [project skeleton][] for your project in the `quickstart` directory.

```sh
hugo new project quickstart
```

Change the current directory to the root of your project.

```sh
cd quickstart
```

Initialize an empty Git repository in the current directory.

```sh
git init
```

Clone the [Ananke][] theme into the `themes` directory, adding it to your project as a [Git submodule][].

```sh
git submodule add https://github.com/gohugo-ananke/ananke themes/ananke
```

Append a line to your project configuration file, indicating the current theme.

```sh
echo "theme = 'ananke'" >> hugo.toml
```

Start Hugo's development server.

```sh
hugo server
```

Press `Ctrl + C` to stop Hugo's development server.

## Add content

Add a new page to your project.

```sh
hugo new content content/posts/my-first-post.md
```

Hugo created the file in the `content/posts` directory. Open the file with your editor.

```md
+++
title = 'My First Post'
date = 2024-01-14T07:07:07+01:00
draft = true
+++
```

Notice the `draft` value in the [front matter][] is `true`. By default, Hugo does not publish draft content when you build the project. Learn more about [draft, future, and expired content][].

Add some [Markdown][] to the body of the post, but do not change the `draft` value.

```md
+++
title = 'My First Post'
date = 2024-01-14T07:07:07+01:00
draft = true
+++
## Introduction

This is **bold** text, and this is *emphasized* text.

Visit the [Hugo](https://gohugo.io) website!
```

Save the file, then start Hugo's development server. You can run either of the following commands to include draft content.

```sh
hugo server --buildDrafts
hugo server -D
```

View your project at the URL displayed in your terminal. Keep the development server running as you continue to add and change content.

When satisfied with your new content, set the front matter `draft` parameter to `false`.

> [!NOTE]
> Hugo's rendering engine conforms to the CommonMark [specification][] for Markdown. The CommonMark organization provides a useful [live testing tool][] powered by the reference implementation.

## Configure the project

With your editor, open the [project configuration][] file in the root of your project directory:

```toml {file="hugo.toml"}
baseURL = 'https://example.org/'
locale = 'en-us'
title = 'My New Hugo Project'
theme = 'ananke'
```

Make the following changes:

1. Set the `baseURL` for your project. This value must begin with the protocol and end with a slash, as shown above.
1. Set the `locale` to your locale.
1. Set the `title` for your project.

Start Hugo's development server to see your changes, remembering to include draft content.

```sh
hugo server -D
```

> [!NOTE]
> Now that you have the Ananke theme installed, check out their [documentation][] and [demonstration site][] to learn how to configure and customize it.

## Publish the project

In this step you will _publish_ your project, but you will not _deploy_ it.

When you publish your project, Hugo renders all build artifacts to the `public` directory in the root of your project. This includes the HTML files for every site, along with assets such as images, CSS, and JavaScript. The command is simple.

```sh
hugo
```

To learn how to _deploy_ your project, see the [host and deploy][] section.

## Ask for help

Hugo's [forum][] is an active community of users and developers who answer questions, share knowledge, and provide examples. A quick search of over 20,000 topics will often answer your question. Please be sure to read about [requesting help][] before asking your first question.

## Other resources

For other resources to help you learn Hugo, including books and video tutorials, see the [external learning resources][] page.

[Ananke]: https://github.com/theNewDynamic/gohugo-theme-ananke
[Git submodule]: https://git-scm.com/book/en/v2/Git-Tools-Submodules
[Install Git]: https://git-scm.com/book/en/v2/Getting-Started-Installing-Git
[Install Hugo]: /installation/
[Markdown]: https://daringfireball.net/projects/markdown
[PowerShell]: https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-windows
[are different applications]: https://learn.microsoft.com/en-us/powershell/scripting/whats-new/differences-from-windows-powershell?view=powershell-7.3
[demonstration site]: https://ananke-theme.netlify.app/
[documentation]: https://ananke-documentation.netlify.app/
[draft, future, and expired content]: /getting-started/usage/#draft-future-and-expired-content
[external learning resources]: /getting-started/external-learning-resources/
[forum]: https://discourse.gohugo.io/
[front matter]: /content-management/front-matter/
[host and deploy]: /host-and-deploy/
[live testing tool]: https://spec.commonmark.org/dingus/
[project configuration]: /configuration/
[project skeleton]: /getting-started/directory-structure/#project-skeleton
[requesting help]: https://discourse.gohugo.io/t/requesting-help/9132
[specification]: https://spec.commonmark.org/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/getting-started/usage.md
---


## Test your installation

After [installing][] Hugo, test your installation by running:

```sh
hugo version
```

## Display available commands

To see a list of the available commands and flags:

```sh
hugo help
```

To get help with a subcommand, use the `--help` flag. For example:

```sh
hugo server --help
```

## Build your project

To build your project, `cd` into your project directory and run:

```sh
hugo build
```

The [`hugo build`][] command builds your project, publishing the files to the `public` directory. To publish your project to a different directory, use the [`--destination`][] flag or set [`publishDir`][] in your project configuration.

> [!NOTE]
> Hugo does not clear the `public` directory before building your project. Existing files are overwritten, but not deleted. This behavior is intentional to prevent the inadvertent removal of files that you may have added to the `public` directory after the build.
>
> Depending on your needs, you may wish to manually clear the contents of the `public` directory before every build.

## Draft, future, and expired content

Hugo allows you to set `draft`, `date`, `publishDate`, and `expiryDate` in the [front matter][] of your content. By default, Hugo will not publish content when:

- The `draft` value is `true`
- The `date` is in the future
- The `publishDate` is in the future
- The `expiryDate` is in the past

> [!NOTE]
> Hugo publishes descendants of draft, future, and expired [branch](g) pages. To prevent publication of these descendants, use the [`cascade`][] front matter field to cascade [build options][] to the descendant pages.

You can override the default behavior when running `hugo build` or `hugo server` with command line flags:

```sh
hugo build --buildDrafts    # or -D
hugo build --buildExpired   # or -E
hugo build --buildFuture    # or -F
```

Although you can also set these values in your project configuration, it can lead to unwanted results unless all content authors are aware of, and understand, the settings.

> [!NOTE]
> As noted above, Hugo does not clear the `public` directory before building your project. Depending on the _current_ evaluation of the four conditions above, after the build your `public` directory may contain extraneous files from a previous build.
>
> A common practice is to manually clear the contents of the `public` directory before each build to remove draft, expired, and future content.

## Develop and test your site

To view your site while developing layouts or creating content, `cd` into your project directory and run:

```sh
hugo server
```

The [`hugo server`][] command builds your site and serves your pages using a minimal HTTP server. When you run `hugo server` it will display the URL of your local site:

```text
Web Server is available at http://localhost:1313/
```

While the server is running, it watches your project directory for changes to assets, configuration, content, data, layouts, translations, and static files. When it detects a change, the server rebuilds your site and refreshes your browser using [LiveReload][].

Most Hugo builds are so fast that you may not notice the change unless you are looking directly at your browser.

### LiveReload

While the server is running, Hugo injects JavaScript into the generated HTML pages. The LiveReload script creates a connection from the browser to the server via web sockets. You do not need to install any software or browser plugins, nor is any configuration required.

### Automatic redirection

When editing content, if you want your browser to automatically redirect to the page you last modified, run:

```sh
hugo server --navigateToChanged
```

## Deploy your site

> [!NOTE]
> As noted above, Hugo does not clear the `public` directory before building your project. Manually clear the contents of the `public` directory before each build to remove draft, expired, and future content.

When you are ready to deploy your site, run:

```sh
hugo
```

This builds your site, publishing the files to the `public` directory. The directory structure will look something like this:

```tree
public/
├── categories/
│   ├── index.html
│   └── index.xml  <-- RSS feed for this section
├── posts/
│   ├── my-first-post/
│   │   └── index.html
│   ├── index.html
│   └── index.xml  <-- RSS feed for this section
├── tags/
│   ├── index.html
│   └── index.xml  <-- RSS feed for this section
├── index.html
├── index.xml      <-- RSS feed for the site
└── sitemap.xml
```

In a simple hosting environment, where you typically `ftp`, `rsync`, or `scp` your files to the root of a virtual host, the contents of the `public` directory are all that you need.

Most of our users deploy their sites to a [CI/CD](g) platform, where a push[^1] to their remote Git repository triggers a build and deployment. Learn more in the [host and deploy][] section.

[^1]: The Git repository contains the entire project directory, typically excluding the `public` directory because the site is built _after_ the push.

[LiveReload]: https://github.com/livereload/livereload-js
[`--destination`]: /commands/hugo/#options
[`cascade`]: /content-management/front-matter/#cascade
[`hugo build`]: /commands/hugo/
[`hugo server`]: /commands/hugo_server/
[`publishDir`]: /configuration/all/#publishdir
[build options]: /content-management/build-options/
[front matter]: /content-management/front-matter/
[host and deploy]: /host-and-deploy/
[installing]: /installation/

