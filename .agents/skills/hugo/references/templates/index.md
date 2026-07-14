# templates


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/templates/404.md
---


To render a 404 error page in the root of your site, create a 404 template in the root of the `layouts` directory. For example:

```go-html-template {file="layouts/404.html"}
{{ define "main" }}
  <h1>404 Not Found</h1>
  <p>The page you requested cannot be found.</p>
  <p>
    <a href="{{ .Site.Home.RelPermalink }}">
      Return to the home page
    </a>
  </p>
{{ end }}
```

For multilingual projects, add the language key to the file name:

```tree
layouts/
├── 404.de.html
├── 404.en.html
└── 404.fr.html
```

Your production server redirects the browser to the 404 page when a page is not found. Capabilities and configuration vary by host.

Host|Capabilities and configuration
:--|:--
Amazon CloudFront|See [details](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/GeneratingCustomErrorResponses.html).
Amazon S3|See [details](https://docs.aws.amazon.com/AmazonS3/latest/userguide/CustomErrorDocSupport.html).
Apache|See [details](https://httpd.apache.org/docs/2.4/custom-error.html).
Azure Static Web Apps|See [details](https://learn.microsoft.com/en-us/azure/static-web-apps/configuration#response-overrides).
Azure Storage|See [details](https://learn.microsoft.com/en-us/azure/storage/blobs/storage-blob-static-website#setting-up-a-static-website).
Caddy|See [details](https://caddyserver.com/docs/caddyfile/directives/handle_errors).
Codeberg Pages|See [details](https://docs.codeberg.org/codeberg-pages/advanced-usage/#custom-error-page-for-404s).
Cloudflare Pages|See [details](https://developers.cloudflare.com/pages/configuration/serving-pages/#not-found-behavior).
DigitalOcean App Platform|See [details](https://docs.digitalocean.com/products/app-platform/how-to/manage-static-sites/#configure-a-static-site).
Firebase|See [details](https://firebase.google.com/docs/hosting/full-config#404).
GitHub Pages|Redirection to is automatic and not configurable.
GitLab Pages|See [details](https://docs.gitlab.com/ee/user/project/pages/introduction.html#custom-error-codes-pages).
NGINX|See [details](https://nginx.org/en/docs/http/ngx_http_core_module.html#error_page).
Netlify|See [details](https://docs.netlify.com/routing/redirects/redirect-options/).


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/templates/embedded.md
---



## Sections

- [`disqus`](references/templates/disqus.md) — Disqus
- [`google-analytics`](references/templates/google-analytics.md) — Google Analytics
- [`open-graph`](references/templates/open-graph.md) — Open Graph
- [`pagination`](references/templates/pagination.md) — Pagination
- [`schema`](references/templates/schema.md) — Schema
- [`x-twitter-cards`](references/templates/x-twitter-cards.md) — X (Twitter) Cards
- [`context`](references/templates/context.md) — Context
- [`actions`](references/templates/actions.md) — Actions
- [`variables`](references/templates/variables.md) — Variables
- [`functions`](references/templates/functions.md) — Functions
- [`methods`](references/templates/methods.md) — Methods
- [`comments`](references/templates/comments.md) — Comments
- [`include`](references/templates/include.md) — Include
- [`examples`](references/templates/examples.md) — Examples
- [`lookup-rules`](references/templates/lookup-rules.md) — Lookup Rules
- [`target-a-template`](references/templates/target-a-template.md) — Target A Template
- [`overview`](references/templates/overview.md) — Overview
- [`example`](references/templates/example.md) — Example
- [`page-references`](references/templates/page-references.md) — Page References
- [`menu-entry-parameters`](references/templates/menu-entry-parameters.md) — Menu Entry Parameters
- [`localize`](references/templates/localize.md) — Localize
- [`changes-to-the-layouts-folder`](references/templates/changes-to-the-layouts-folder.md) — Changes To The `layouts` Folder
- [`changes-to-template-lookup-order`](references/templates/changes-to-template-lookup-order.md) — Changes To Template Lookup Order
- [`example-folder-structure`](references/templates/example-folder-structure.md) — Example Folder Structure
- [`terminology`](references/templates/terminology.md) — Terminology
- [`configuration`](references/templates/configuration.md) — Configuration
- [`methods`](references/templates/methods.md) — Methods
- [`examples`](references/templates/examples.md) — Examples
- [`caching`](references/templates/caching.md) — Caching
- [`grouping`](references/templates/grouping.md) — Grouping
- [`navigation`](references/templates/navigation.md) — Navigation
- [`structure`](references/templates/structure.md) — Structure
- [`overview`](references/templates/overview.md) — Overview
- [`implementation`](references/templates/implementation.md) — Implementation
- [`benefits-of-composition`](references/templates/benefits-of-composition.md) — Benefits Of Composition
- [`example`](references/templates/example.md) — Example
- [`robotstxt-template-lookup-order`](references/templates/robotstxt-template-lookup-order.md) — Robots.txt Template Lookup Order
- [`robotstxt-template-example`](references/templates/robotstxt-template-example.md) — Robots.txt Template Example
- [`configuration`](references/templates/configuration.md) — Configuration
- [`include-feed-reference`](references/templates/include-feed-reference.md) — Include Feed Reference
- [`custom-templates`](references/templates/custom-templates.md) — Custom Templates
- [`introduction`](references/templates/introduction.md) — Introduction
- [`directory-structure`](references/templates/directory-structure.md) — Directory Structure
- [`lookup-order`](references/templates/lookup-order.md) — Lookup Order
- [`methods`](references/templates/methods.md) — Methods
- [`examples`](references/templates/examples.md) — Examples
- [`detection`](references/templates/detection.md) — Detection
- [`overview`](references/templates/overview.md) — Overview
- [`configuration`](references/templates/configuration.md) — Configuration
- [`override-default-values`](references/templates/override-default-values.md) — Override Default Values
- [`override-builtin-templates`](references/templates/override-builtin-templates.md) — Override Built-in Templates
- [`disable-sitemap-generation`](references/templates/disable-sitemap-generation.md) — Disable Sitemap Generation
- [`structure`](references/templates/structure.md) — Structure
- [`base`](references/templates/base.md) — Base
- [`home`](references/templates/home.md) — Home
- [`page`](references/templates/page.md) — Page
- [`section`](references/templates/section.md) — Section
- [`taxonomy`](references/templates/taxonomy.md) — Taxonomy
- [`term`](references/templates/term.md) — Term
- [`single`](references/templates/single.md) — Single
- [`list`](references/templates/list.md) — List
- [`all`](references/templates/all.md) — All
- [`partial`](references/templates/partial.md) — Partial
- [`content-view`](references/templates/content-view.md) — Content View
- [`render-hook`](references/templates/render-hook.md) — Render Hook
- [`shortcode`](references/templates/shortcode.md) — Shortcode
- [`other`](references/templates/other.md) — Other

