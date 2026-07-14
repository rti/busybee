## Custom templates

Override Hugo's [embedded RSS template][] by creating one or more of your own. For example, to use different templates for home, section, taxonomy, and term pages:

```tree
layouts/
  ├── home.rss.xml
  ├── section.rss.xml
  ├── taxonomy.rss.xml
  └── term.rss.xml
```

RSS templates receive the `.Page` and `.Site` objects in context.

[embedded RSS template]: <{{% eturl rss %}}>


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/templates/shortcode.md
---


{{< newtemplatesystem >}}

> [!NOTE]
> Before creating custom shortcodes, please review the [shortcodes][] page in the [content management][] section. Understanding the usage details will help you design and create better templates.

