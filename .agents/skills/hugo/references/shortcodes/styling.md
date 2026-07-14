## Styling

Use CSS to style the `details` element, the `summary` element, and the content itself.

```css
/* target the details element */
details { }

/* target the summary element */
details > summary { }

/* target the children of the summary element */
details > summary > * { }

/* target the content */
details > :not(summary) { }
```

[source code]: <{{% eturl details %}}>


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/shortcodes/figure.md
---


> [!NOTE]
> To override Hugo's embedded `figure` shortcode, copy the [source code][] to a file with the same name in the `layouts/_shortcodes` directory.

