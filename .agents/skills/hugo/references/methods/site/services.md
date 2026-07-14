## Services

See [configure services][].

For example, to use Hugo's built-in Google Analytics template you must add a [Google tag ID][]:

{{< code-toggle file=hugo >}}
[services.googleAnalytics]
id = 'G-XXXXXXXXX'
{{< /code-toggle >}}

To access this value from a template:

```go-html-template
{{ .Site.Config.Services.GoogleAnalytics.ID }} → G-XXXXXXXXX
```

You must capitalize each identifier as shown above.

