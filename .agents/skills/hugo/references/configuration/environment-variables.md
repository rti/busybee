## Environment variables

You can also override your project configuration with environment variables. For example, to block `resources.GetRemote` from accessing any URL:

```txt
export HUGO_SECURITY_HTTP_URLS=none
```

Learn more about [using environment variables][] to configure your site.

[`os.Getenv`]: /functions/os/getenv/
[`resources.GetRemote`]: /functions/resources/getremote/
[classification]: /content-management/formats/#classification
[inline shortcodes]: /content-management/shortcodes/#inline
[permission model]: https://nodejs.org/api/permissions.html#permission-model
[using environment variables]: /configuration/introduction/#environment-variables


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/configuration/segments.md
---


> [!NOTE]
> The `segments` configuration applies only to segmented rendering. While it controls when content is rendered, it doesn't restrict access to Hugo's complete object graph (sites and pages), which remains fully available.

Segmented rendering offers several advantages:

- Faster builds: Process large sites more efficiently.
- Rapid development: Render only a subset of your site for quicker iteration.
- Scheduled rebuilds: Rebuild specific sections at different frequencies (e.g., home page and news hourly, full site weekly).
- Targeted output: Generate specific output formats (like JSON for search indexes).

