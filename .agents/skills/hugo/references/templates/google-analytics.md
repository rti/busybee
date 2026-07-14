## Google Analytics

> [!NOTE]
> To override Hugo's embedded Google Analytics template, copy the [source code](<{{% eturl google_analytics %}}>) to a file with the same name in the `layouts/_partials` directory, then call it from your templates using the [`partial`][] function:
>
> `{{ partial "google_analytics.html" . }}`

Hugo includes an embedded template for [Google Analytics 4][].

To include the embedded template:

```go-html-template
{{ partial "google_analytics.html" . }}
```

### Configuration {#configuration-google-analytics}

Provide your tracking ID in your configuration file:

{{< code-toggle file=hugo >}}
[services.googleAnalytics]
id = 'G-MEASUREMENT_ID'
{{</ code-toggle >}}

> [!NOTE]
> If the configured ID begins with `ua-` (case-insensitive), Hugo logs a warning and renders nothing. Google Universal Analytics (UA) was replaced by Google Analytics 4 (GA4) effective 1 July 2023. Create a GA4 property and data stream, then update your project configuration with the new measurement ID.

### Privacy {#privacy-google-analytics}

Adjust the relevant privacy settings in your project configuration.

{{< code-toggle config=privacy.googleAnalytics />}}

`disable`
: (`bool`) Whether to disable the template. Default is `false`.

`respectDoNotTrack`
: (`bool`) Whether to respect the browser's "do not track" setting. Default is `true`.

