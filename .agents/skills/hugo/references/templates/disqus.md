## Disqus

> [!NOTE]
> To override Hugo's embedded Disqus template, copy the [source code](<{{% eturl disqus %}}>) to a file with the same name in the `layouts/_partials` directory, then call it from your templates using the [`partial`][] function:
>
> `{{ partial "disqus.html" . }}`

Hugo includes an embedded template for [Disqus][], a commenting system for both static and dynamic websites. To use this template, you must first obtain a Disqus shortname by [signing up][] for the free service.

To include the embedded template:

```go-html-template
{{ partial "disqus.html" . }}
```

### Configuration {#configuration-disqus}

To use Hugo's Disqus template, first set up a single configuration value:

{{< code-toggle file=hugo >}}
[services.disqus]
shortname = 'your-disqus-shortname'
{{</ code-toggle >}}

You can also set the following in the [front matter][] for a given page:

`disqus_identifier`
: (`string`) A unique identifier for the page's discussion thread. Set this to preserve comment threads across URL changes.

`disqus_title`
: (`string`) The title of the discussion thread.

`disqus_url`
: (`string`) The canonical URL for the discussion thread. Use this to override the URL Disqus uses to identify the thread, for example when the same content is served at multiple URLs.

{{< code-toggle file=content/blog/my-post.md fm=true >}}
[params]
disqus_identifier = 'unique-identifier'
disqus_title = 'Post title'
disqus_url = 'https://example.org/blog/my-post/'
{{</ code-toggle >}}

> [!NOTE]
> When previewing your site locally, Hugo replaces the Disqus widget with the message "Disqus comments not available by default when the website is previewed locally."

### Privacy {#privacy-disqus}

Adjust the relevant privacy settings in your project configuration.

{{< code-toggle config=privacy.disqus />}}

`disable`
: (`bool`) Whether to disable the template. Default is `false`.

