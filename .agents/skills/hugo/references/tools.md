
---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/tools/editors.md
---


## Visual Studio Code

[gotmplfmt](https://marketplace.visualstudio.com/items?itemName=GoHugoIO.gotmplfmt)
: Developed and maintained by the Hugo authors, this extension formats [templates](g) using the [gotmplfmt](https://github.com/gohugoio/gotmplfmt) CLI.

[Front Matter](https://marketplace.visualstudio.com/items?itemName=eliostruyf.vscode-front-matter)
: This extension maintains article metadata such as creation date, modified date, slug, title, SEO check, and more.

[Hugo Helper](https://marketplace.visualstudio.com/items?itemName=rusnasonov.vscode-hugo)
: This extension provides some useful commands. The source code is available on its [GitHub repository](https://github.com/rusnasonov/vscode-hugo).

[Hugo Language and Syntax Support](https://marketplace.visualstudio.com/items?itemName=budparr.language-hugo-vscode)
: This extension provides syntax highlighting and snippets. The source code is available on its [GitHub repository](https://github.com/budparr/language-hugo-vscode).

[Hugo Shortcodes](https://marketplace.visualstudio.com/items?itemName=thuliteio.hugo-shortcodes)
: This extension adds syntax highlighting and intelligent completions for shortcodes in Markdown, including shortcode names and arguments discovered from workspace templates. The source code is available on its [GitHub repository](https://github.com/thuliteio/hugo-shortcodes).

[Hugo Themer](https://marketplace.visualstudio.com/items?itemName=eliostruyf.vscode-hugo-themer)
: This extension simplifies theme development, making it easy to navigate theme files.

[Hugofy](https://marketplace.visualstudio.com/items?itemName=akmittal.hugofy)
: This extension streamlines project development. The source code is available on its [GitHub repository](https://github.com/akmittal/hugofy-vscode).

[Syntax Highlighting for Hugo Shortcodes](https://marketplace.visualstudio.com/items?itemName=kaellarkin.hugo-shortcode-syntax)
: This extension adds syntax highlighting for [shortcodes](g), making visual identification of individual pieces easier.

## JetBrains IDEs

[Smart Hugo](https://smarthugo.dev)
: This plugin for IntelliJ IDEA, WebStorm, PhpStorm, and other JetBrains IDEs adds template support including syntax highlighting, actions completion, code formatting, and optional advanced features.

## Emacs

[emacs-easy-hugo](https://github.com/masasam/emacs-easy-hugo)
: This major Emacs mode supports writing blogs using various markup formats, including Markdown, Org mode, AsciiDoc, reStructuredText, mmark, and HTML.

[ox-hugo.el](https://ox-hugo.scripter.co)
: This native Org mode exporter exports to Blackfriday Markdown with [front-matter](g). It supports two common Org blogging flows: exporting multiple Org subtrees in a single file to multiple posts, and exporting a single Org file to a single post. It also leverages the Org tag and property inheritance features. See [Why ox-hugo?](https://ox-hugo.scripter.co/doc/why-ox-hugo/) for more.

## Sublime Text

[Hugo Snippets](https://packagecontrol.io/packages/Hugo%20Snippets)
: This plugin adds automatic snippets.

[Hugofy](https://github.com/akmittal/Hugofy)
: This plugin streamlines project development.

## Vim

[Vim Hugo Helper](https://github.com/robertbasic/vim-hugo-helper)
: This plugin facilitates authoring pages and blog posts.

[vim-hugo](https://github.com/phelipetls/vim-hugo)
: This plugin provides syntax highlighting for templates and a few other features.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/tools/front-ends.md
---


## Commercial

[CloudCannon][]
: The intuitive Git-based CMS for your Hugo website. CloudCannon syncs changes from your Git repository and pushes content changes back, so your development and content teams are always in sync. Edit all of your content on the page with visual editing, build entire pages with reusable custom components and then publish confidently.

[DatoCMS][]
: DatoCMS is a fully customizable administrative area for your static websites. Use your favorite website generator, let your clients publish new content independently, and the host the site anywhere you like.

[GitCMS][]
: GitCMS is an AI-focused CMS for markdown-based content sites that brings together Content Agents for ChatGPT and Claude using MCP app, a friendly notion-like interface for non-technical team members, and a structured editorial publishing workflow. It is built for teams that want to manage blogs, documentation, changelogs, and other markdown content with the speed of AI assistance and the reliability of a review-driven publishing process.

[PubCrank][]
: PubCrank is a static site editor which lets you define templates for different front matter layouts in your site. This gives writers an easy-to-use visual interface to create and edit content while maintaining the guardrails that the developer has created. PubCrank is free for local editing.

[Sitepins][]
: Sitepins is a Git-based CMS built for static site generators like Hugo. It offers a clean visual editor, media management, role-based permissions, shortcode support, and more. To get started, simply connect your GitHub repository, configure your content folders, and start visually editing your Hugo site with Sitepins.

## Open-source

[Decap CMS][]
: Decap CMS is an open-source, serverless solution for managing Git based content in static sites, and it works on any platform that can host static sites. A [Hugo/Decap CMS starter][] is available to get new projects running quickly.

[Pages CMS][]
: Pages CMS is an open-source, Git-based CMS for static sites and apps. It lets you edit Hugo content stored in a GitHub repository through a web interface, with support for front matter fields, media management, rich text editing, etc.

[Quiqr Desktop][]
: Quiqr Desktop is a open-source, cross-platform, offline desktop CMS for Hugo with built-in Git functionality for deploying static sites to any hosting server.

[Sveltia CMS][]
:  Sveltia CMS is a drop-in replacement for Decap CMS which is built from the ground up with powerful and performant modern UI library Svelte. Sveltia CMS incorporates i18n into every corner of the product, while striving to radically improve UX, performance and productivity.

[CloudCannon]: https://cloudcannon.com/hugo-cms/
[DatoCMS]: https://www.datocms.com
[Decap CMS]: https://decapcms.org/
[GitCMS]: https://gitcms.dev
[Hugo/Decap CMS starter]: https://github.com/decaporg/one-click-hugo-cms
[Pages CMS]: https://pagescms.org/
[PubCrank]: https://www.pubcrank.com/
[Quiqr Desktop]: https://quiqr.org/
[Sitepins]: https://sitepins.com
[Sveltia CMS]: https://github.com/sveltia/sveltia-cms/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/tools/migrations.md
---


This section highlights some independently developed projects related to Hugo. These tools extend functionality or help you to get started.

Take a look at this list of migration tools if you currently use other blogging tools like Jekyll or WordPress but intend to switch to Hugo instead. They'll help you export your content into Hugo-friendly formats.

## Jekyll

Alternatively, you can use the [Jekyll import command](/commands/hugo_import_jekyll/).

[JekyllToHugo][]
: A Small script for converting Jekyll blog posts to a Hugo site.

[ConvertToHugo][]
: Convert your blog from Jekyll to Hugo.

## Octopress

[octohug][]
: Octopress to Hugo migrator.

## DokuWiki

[dokuwiki-to-hugo][]
: Migrates your DokuWiki source pages from [DokuWiki syntax][] to Hugo Markdown syntax. Includes extras like the TODO plugin. Written with extensibility in mind using Python 3. Also generates a TOML header for each page. Designed to copy-paste the wiki directory into your `content` directory.

## WordPress

[wordpress-to-hugo-exporter][]
: A one-click WordPress plugin that converts all posts, pages, taxonomies, metadata, and settings to Markdown and YAML which can be dropped into Hugo. (Note: If you have trouble using this plugin, you can [export your site for Jekyll][] and use Hugo's built-in Jekyll converter listed above.)

[blog2md][]
: Works with [exported xml](https://en.support.wordpress.com/export/) file of your free YOUR-TLD.wordpress.com website. It also saves approved comments to `YOUR-POST-NAME-comments.md` file along with posts.

[wordhugopress][]
: A small utility written in Java that exports the entire WordPress site from the database and resource (e.g., images) files stored locally or remotely. Therefore, migration from the backup files is possible. Supports merging multiple WordPress sites into a single Hugo site.

[wp2hugo][]
: A Go-based CLI tool to migrate WordPress websites to Hugo. It preserves original URLs, GUIDs, image URLs, code highlights, tables of contents, and WordPress navigation categories. It migrates WordPress custom post types, custom taxonomies, custom fields, and page hierarchy. It supports translated WordPress blogs via Polylang or WPML. It imports a WordPress media library database with original titles and dates. The tool can download all media or only media inserted into pages from the original server. It converts WordPress shortcodes and Gutenberg blocks to Hugo shortcodes including galleries, images, audio, YouTube embeds, Gists, and Google Maps.

## Medium

[medium2md][]
: A simple Medium to Hugo exporter able to import stories in one command, including front matter.

[medium-to-hugo][]
: A CLI tool written in Go to export medium posts into a Hugo-compatible Markdown format. Tags and images are included. All images will be downloaded locally and linked appropriately.

## Tumblr

[tumblr-importr][]
: An importer that uses the Tumblr API to create a Hugo static site.

[tumblr2hugomarkdown][]
: Export all your Tumblr content to Hugo Markdown files with preserved original formatting.

[Tumblr to Hugo][]
: A migration tool that converts each of your Tumblr posts to a content file with a proper title and path. It also generates a CSV file to help you set up URL redirects.

## Drupal

[drupal2hugo][]
: Convert a Drupal site to Hugo.

## Joomla

[hugojoomla][]
: This utility written in Java takes a Joomla database and converts all the content into Markdown files. It changes any URLs that are in Joomla's internal format and converts them to a suitable form.

## Blogger

[blogimport][]
: A tool to import from Blogger posts to Hugo.

[blogger-to-hugo][]
: Another tool to import Blogger posts to Hugo. It also downloads embedded images so they will be stored locally.

[blog2md][]
: Works with [exported xml](https://support.google.com/blogger/answer/41387?hl=en) file of your YOUR-TLD.blogspot.com website. It also saves comments to `YOUR-POST-NAME-comments.md` file along with posts.

[BloggerToHugo][]
: Yet another tool to import Blogger posts to Hugo. For Windows platform only, and .NET Framework 4.5 is required. See README.md before using this tool.

[blogger2hugo][]
: Converts a Blogger backup file (`.atom`) from [Google Takeout][] to Markdown (`.md`) files. The tool generates output compatible with the Hugo `content/` structure.

## Contentful

[contentful-hugo][]
: A tool to create content-files for Hugo from content on [Contentful][].

## BlogML

[BlogML2Hugo][]
: A tool that helps you convert BlogML xml file to Hugo Markdown files. Users need to take care of links to attachments and images by themselves. This helps the blogs that export BlogML files (e.g. BlogEngine.NET) transform to hugo sites easily.

[BlogML2Hugo]: https://github.com/jijiechen/BlogML2Hugo
[BloggerToHugo]: https://github.com/huanlin/blogger-to-hugo
[Contentful]: https://www.contentful.com/
[ConvertToHugo]: https://github.com/coderzh/ConvertToHugo
[DokuWiki syntax]: https://www.dokuwiki.org/wiki:syntax
[Google Takeout]: https://takeout.google.com/takeout/custom/blogger?hl=en
[JekyllToHugo]: https://github.com/fredrikloch/JekyllToHugo
[Tumblr to Hugo]: https://github.com/jipiboily/tumblr-to-hugo
[blog2md]: https://github.com/palaniraja/blog2md
[blogger-to-hugo]: https://pypi.org/project/blogger-to-hugo/
[blogger2hugo]: https://github.com/noorkhafidzin/blogger2hugo
[blogimport]: https://github.com/natefinch/blogimport
[contentful-hugo]: https://github.com/ModiiMedia/contentful-hugo
[dokuwiki-to-hugo]: https://github.com/wgroeneveld/dokuwiki-to-hugo
[drupal2hugo]: https://github.com/danapsimer/drupal2hugo
[export your site for Jekyll]: https://wordpress.org/plugins/jekyll-exporter/
[hugojoomla]: https://github.com/davetcc/hugojoomla
[medium-to-hugo]: https://github.com/bgadrian/medium-to-hugo
[medium2md]: https://github.com/gautamdhameja/medium-2-md
[octohug]: https://github.com/codebrane/octohug
[tumblr-importr]: https://github.com/carlmjohnson/tumblr-importr
[tumblr2hugomarkdown]: https://github.com/Wysie/tumblr2hugomarkdown
[wordhugopress]: https://github.com/nantipov/wordhugopress
[wordpress-to-hugo-exporter]: https://github.com/SchumacherFM/wordpress-to-hugo-exporter
[wp2hugo]: https://github.com/ashishb/wp2hugo


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/tools/other.md
---


And for all the other community projects around Hugo:

- [diego][] - A CLI tool that integrates with Hugo to assist in importing and utilizing exported social media data from popular services on Hugo websites.
- [Emacs Easy Hugo][] - Emacs package for writing blog posts in Markdown or org-mode and building your project with Hugo.
- [HugoPhotoSwipe][] - Make it easy to create image galleries using PhotoSwipe.
- [JAMStack Themes][] -  A collection of site themes filterable by static site generator and supported CMS to help build CMS-connected sites using Hugo (linking to Hugo-specific themes).
- [flickr-hugo-embed][] - Print shortcodes to embed a set of images from an album on Flickr into Hugo.
- [hugo-gallery][] - Create an image gallery for Hugo sites.
- [hugo-openapispec-shortcode][] - A shortcode that allows you to include [Open API Spec][] (formerly known as Swagger Spec) in a page.
- [plausible-hugo][] - Easy Hugo integration for Plausible Analytics, a simple, open-source, lightweight and privacy-friendly web analytics alternative to Google Analytics.

[Emacs Easy Hugo]: https://github.com/masasam/emacs-easy-hugo
[HugoPhotoSwipe]: https://github.com/GjjvdBurg/HugoPhotoSwipe
[JAMStack Themes]: https://jamstackthemes.dev/ssg/hugo/
[Open API Spec]: https://openapis.org
[diego]: https://github.com/ttybitnik/diego
[flickr-hugo-embed]: https://github.com/nikhilm/flickr-hugo-embed
[hugo-gallery]: https://github.com/icecreammatt/hugo-gallery
[hugo-openapispec-shortcode]: https://github.com/tenfourty/hugo-openapispec-shortcode
[plausible-hugo]: https://github.com/divinerites/plausible-hugo


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/tools/search.md
---


A static website with a dynamic search function? Yes, Hugo provides an alternative to embeddable scripts from Google or other search engines for static websites. Hugo allows you to provide your visitors with a custom search function by indexing your content files directly.

## Open-source

[Pagefind][]
: A fully static search library that aims to perform well on large sites, while using as little of your users' bandwidth as possible.

[GitHub Gist for Hugo Workflow][]
: This gist contains a simple workflow to create a search index for your static website. It uses a simple Grunt script to index all your content files and [lunr.js][] to serve the search results.

[hugo-lunr][]
: A simple way to add site search to your static Hugo site using [lunr.js][]. Hugo-lunr will create an index file of any HTML and Markdown documents in your Hugo project.

[hugo-lunr-zh][]
: A bit like Hugo-lunr, but Hugo-lunr-zh can help you separate the Chinese keywords.

[GitHub Gist for Fuse.js integration][]
: This gist demonstrates how to leverage Hugo's existing build time processing to generate a searchable JSON index used by [Fuse.js][] on the client side. Although this gist uses Fuse.js for fuzzy matching, any client-side search tool capable of reading JSON indexes will work. Does not require npm, grunt, or other build-time tools except Hugo!

[hugo-search-index][]
: A library containing Gulp tasks and a prebuilt browser script that implements search. Gulp generates a search index from project Markdown files.

[hugofastsearch][]
: A usability and speed update to "GitHub Gist for Fuse.js integration" — global, keyboard-optimized search.

[JS & Fuse.js tutorial][]
: A simple client-side search solution, using FuseJS (does not require jQuery).

[Hugo Lyra][]
: Hugo-Lyra is a JavaScript module to integrate [Lyra][] into a Hugo website. It contains the server-side part to generate the index and the client-side library (optional) to bootstrap the search engine easily.

[INFINI Pizza for WebAssembly][]
: Pizza is a super-lightweight yet fully featured search engine written in Rust. You can quickly add offline search functionality to your Hugo website in just five minutes with only three lines of code. For a step-by-step guide on integrating it with Hugo, check out [this blog tutorial][].

## Commercial

[Algolia DocSearch][]
: Algolia DocSearch is free for public technical documentation sites and easy to set up. For other use cases, [Algolia's Search API][] makes it easy to deliver a great search experience in your apps and websites. Algolia Search provides hosted full-text, numerical, faceted, and geolocalized search.

[Bonsai][]
: Bonsai is a fully-managed hosted Elasticsearch service that is fast, reliable, and simple to set up. Easily ingest your docs from Hugo into Elasticsearch following [this guide from the docs][].

[ExpertRec][]
: ExpertRec is a hosted search-as-a-service solution that is fast and scalable. Set-up and integration is extremely easy and takes only a few minutes. The search settings can be modified without coding using a dashboard.

[Algolia DocSearch]: https://docsearch.algolia.com/
[Algolia's Search API]: https://www.algolia.com
[Bonsai]: https://www.bonsai.io
[ExpertRec]: https://www.expertrec.com/
[Fuse.js]: https://fusejs.io/
[GitHub Gist for Fuse.js integration]: https://gist.github.com/eddiewebb/735feb48f50f0ddd65ae5606a1cb41ae
[GitHub Gist for Hugo Workflow]: https://gist.github.com/sebz/efddfc8fdcb6b480f567
[Hugo Lyra]: https://github.com/paolomainardi/hugo-lyra
[INFINI Pizza for WebAssembly]: https://github.com/infinilabs/pizza-docsearch
[JS & Fuse.js tutorial]: https://makewithhugo.com/add-search-to-a-hugo-site/
[Lyra]: https://github.com/LyraSearch/lyra
[Pagefind]: https://github.com/cloudcannon/pagefind
[hugo-lunr-zh]: https://www.npmjs.com/package/hugo-lunr-zh
[hugo-lunr]: https://www.npmjs.com/package/hugo-lunr
[hugo-search-index]: https://www.npmjs.com/package/hugo-search-index
[hugofastsearch]: https://gist.github.com/cmod/5410eae147e4318164258742dd053993
[lunr.js]: https://lunrjs.com/
[this blog tutorial]: https://dev.to/medcl/adding-search-functionality-to-a-hugo-static-site-based-on-infini-pizza-for-webassembly-4h5e
[this guide from the docs]: https://bonsai.io/docs/hugo

