## Build stats

{{< code-toggle config=build.buildStats />}}

`enable`
: (`bool`) Whether to create a `hugo_stats.json` file in the root of your project. This file contains arrays of the `class` attributes, `id` attributes, and tags of every HTML element within your published site. Use this file as data source when [removing unused CSS][] from your site. This process is also known as pruning, purging, or tree shaking. Default is `false`.

`disableIDs`
: (`bool`) Whether to exclude `id` attributes. Default is `false`.

`disableTags`
: (`bool`) Whether to exclude element tags. Default is `false`.

`disableClasses`
: (`bool`) Whether to exclude `class` attributes. Default is `false`.

> [!NOTE]
> Given that CSS purging is typically limited to production builds, place the `buildStats` object below [`config/production`][].
>
> Built for speed, there may be "false positive" detections (e.g., HTML elements that are not HTML elements) while parsing the published site. These "false positives" are infrequent and inconsequential.

Due to the nature of partial server builds, new HTML entities are added while the server is running, but old values will not be removed until you restart the server or run `hugo build`.

[Hugo Starter Tailwind Basic]: https://github.com/bep/hugo-starter-tailwind-basic
[VS Code]: https://code.visualstudio.com/
[`config/production`]: /configuration/introduction/#configuration-directory
[js.Build]: /functions/js/build/
[removing unused CSS]: /functions/resources/postprocess/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/configuration/caches.md
---


This is the default configuration:

{{< code-toggle config=caches />}}

