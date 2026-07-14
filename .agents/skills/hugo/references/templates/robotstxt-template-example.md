## robots.txt template example

```text {file="layouts/robots.txt"}
User-agent: *
{{ range .Pages }}
Disallow: {{ .RelPermalink }}
{{ end }}
```

This template creates a robots.txt file with a `Disallow` directive for each page on the site. Search engines that honor the Robots Exclusion Protocol will not crawl any page on the site.

> [!NOTE]
> To create a robots.txt file without using a template:
>
> 1. Set `enableRobotsTXT` to `false` in your project configuration.
> 1. Create a robots.txt file in the `static` directory.
>
> Remember that Hugo copies everything in the static director to the root of `publishDir` (typically `public`) when you build your project.

[embedded template]: <{{% eturl robots %}}>


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/templates/rss.md
---


