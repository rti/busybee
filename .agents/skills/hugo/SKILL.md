---
name: hugo
description: Hugo static site generator reference. Use when working with Hugo sites, configuring Hugo, writing templates, using Hugo functions/methods, or building static websites with Hugo. Covers configuration, content management, templates, functions, deployment, and more.
license: MIT
source: https://github.com/gohugoio/hugo/tree/master/docs
metadata:
  generated_by: generate-hugo-skill.sh
  hugo_docs_branch: master
  source_repo: gohugoio/hugo
---

# Hugo Static Site Generator

Hugo is the world's fastest framework for building websites. It is a static site generator written in Go, known for its speed and flexibility.

## Overview

This skill provides comprehensive reference material from the official Hugo documentation. The SKILL.md file serves as an index — load specific reference files for detailed information on individual topics.

## Topic Index

### `content-management` — Content Management

- [`image-processing`](references/content-management/image-processing.md) — Image Processing
- [`organization`](references/content-management/organization.md) — Organization

### `contribute` — Contribute

- [`documentation`](references/contribute/documentation.md) — Documentation

### `functions` — Functions

- [`cast`](references/functions/cast.md) — Cast
- [`collections`](references/functions/collections.md) — Collections
- [`compare`](references/functions/compare.md) — Compare
- [`crypto`](references/functions/crypto.md) — Crypto
- [`css`](references/functions/css.md) — Css
- [`debug`](references/functions/debug.md) — Debug
- [`diagrams`](references/functions/diagrams.md) — Diagrams
- [`encoding`](references/functions/encoding.md) — Encoding
- [`fmt`](references/functions/fmt.md) — Fmt
- [`global`](references/functions/global.md) — Global
- [`go-template`](references/functions/go-template.md) — Go Template
- [`hash`](references/functions/hash.md) — Hash
- [`hugo`](references/functions/hugo.md) — Hugo
- [`images`](references/functions/images.md) — Images
- [`inflect`](references/functions/inflect.md) — Inflect
- [`js`](references/functions/js.md) — Js
- [`lang`](references/functions/lang.md) — Lang
- [`math`](references/functions/math.md) — Math
- [`openapi3`](references/functions/openapi3.md) — Openapi3
- [`os`](references/functions/os.md) — Os
- [`partials`](references/functions/partials.md) — Partials
- [`path`](references/functions/path.md) — Path
- [`reflect`](references/functions/reflect.md) — Reflect
- [`resources`](references/functions/resources.md) — Resources
- [`safe`](references/functions/safe.md) — Safe
- [`strings`](references/functions/strings.md) — Strings
- [`templates`](references/functions/templates.md) — Templates
- [`time`](references/functions/time.md) — Time
- [`transform`](references/functions/transform.md) — Transform
- [`urls`](references/functions/urls.md) — Urls

### `getting-started` — Getting Started

- [`external-learning-resources`](references/getting-started/external-learning-resources.md) — External Learning Resources

### `host-and-deploy` — Host And Deploy

- [`host-on-aws-amplify`](references/host-and-deploy/host-on-aws-amplify.md) — Host On Aws Amplify
- [`host-on-cloudflare`](references/host-and-deploy/host-on-cloudflare.md) — Host On Cloudflare
- [`host-on-github-pages`](references/host-and-deploy/host-on-github-pages.md) — Host On Github Pages
- [`host-on-netlify`](references/host-and-deploy/host-on-netlify.md) — Host On Netlify
- [`host-on-render`](references/host-and-deploy/host-on-render.md) — Host On Render
- [`host-on-vercel`](references/host-and-deploy/host-on-vercel.md) — Host On Vercel

### `methods` — Methods

- [`duration`](references/methods/duration.md) — Duration
- [`menu-entry`](references/methods/menu-entry.md) — Menu Entry
- [`menu`](references/methods/menu.md) — Menu
- [`output-format`](references/methods/output-format.md) — Output Format
- [`page`](references/methods/page.md) — Page
- [`pager`](references/methods/pager.md) — Pager
- [`pages`](references/methods/pages.md) — Pages
- [`resource`](references/methods/resource.md) — Resource
- [`shortcode`](references/methods/shortcode.md) — Shortcode
- [`site`](references/methods/site.md) — Site
- [`taxonomy`](references/methods/taxonomy.md) — Taxonomy
- [`time`](references/methods/time.md) — Time

### `quick-reference` — Quick Reference

- [`glossary`](references/quick-reference/glossary.md) — Glossary

### `troubleshooting` — Troubleshooting

- [`audit`](references/troubleshooting/audit.md) — Audit

- [`about`](references/about.md) — About
- [`commands`](references/commands.md) — Commands
- [`configuration`](references/configuration.md) — Configuration
- [`content-management`](references/content-management.md) — Content Management
- [`contribute`](references/contribute.md) — Contribute
- [`getting-started`](references/getting-started.md) — Getting Started
- [`host-and-deploy`](references/host-and-deploy.md) — Host And Deploy
- [`hugo-modules`](references/hugo-modules.md) — Hugo Modules
- [`hugo-pipes`](references/hugo-pipes.md) — Hugo Pipes
- [`installation`](references/installation.md) — Installation
- [`quick-reference`](references/quick-reference.md) — Quick Reference
- [`render-hooks`](references/render-hooks.md) — Render Hooks
- [`shortcodes`](references/shortcodes.md) — Shortcodes
- [`templates`](references/templates.md) — Templates
- [`tools`](references/tools.md) — Tools
- [`troubleshooting`](references/troubleshooting.md) — Troubleshooting


## Usage with Hugo Sites

### Common Commands

```bash
hugo new site <name>       # Create a new site
hugo new <section>/<name>  # Create a new content page
hugo                      # Build the site
hugo server               # Run development server
hugo server -D            # Include draft content
hugo --minify             # Build with minification
```

### Typical Project Structure

```
my-site/
├── archetypes/       # Default front matter templates
├── assets/           # Source assets (SCSS, JS, images)
├── content/          # Markdown content files
├── data/             # Data files (JSON, YAML, TOML)
├── layouts/          # HTML templates
├── static/           # Static files (copied as-is)
├── themes/           # Hugo themes
├── config.toml       # Site configuration
└── go.mod            # Hugo modules (optional)
```

### Working with This Skill

1. **Quick lookup**: Read SKILL.md to find the relevant topic area
2. **Deep dive**: Load the corresponding `references/<topic>.md` or `references/<topic>/<subtopic>.md` file
3. **Functions reference**: The `functions/` and `methods/` references are organized by package (e.g., strings, collections, urls)

## Best Practices

- Keep SKILL.md under 500 lines for fast loading
- Reference files contain the actual Hugo docs content — load only what you need
- Function and method references are split by package to keep files small
