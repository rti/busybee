## Add Disqus

Hugo comes with all the code you need to load Disqus into your templates. Before adding Disqus to your site, you'll need to [set up an account][].

### Configure Disqus

Disqus comments require you set a single value in your project configuration:

{{< code-toggle file=hugo >}}
[services.disqus]
shortname = 'your-disqus-shortname'
{{</ code-toggle >}}

For many websites, this is enough configuration. However, you also have the option to set the following in the front matter of a single content file:

- `params.disqus_identifier`
- `params.disqus_title`
- `params.disqus_url`

### Render Hugo's embedded Disqus partial

To render it, add the following code where you want comments to appear:

```go-html-template
{{ partial "disqus.html" . }}
```

