## Overview

Hugo's embedded sitemap templates conform to v0.9 of the [sitemap protocol][].

With a monolingual project, Hugo generates a sitemap.xml file in the root of the [`publishDir`][] using the [embedded sitemap template][].

With a multilingual project, Hugo generates:

- A sitemap.xml file in the root of each site (language) using the [embedded sitemap template][]
- A sitemap.xml file in the root of the [`publishDir`][] using the [embedded sitemapindex template][]

