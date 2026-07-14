## Options

The `templates.Defer` function requires a single argument, a map with the following optional keys:

`key`
: (`string`) The key to use for the deferred template. This will, combined with a hash of the template content, be used as a cache key. If this is not set, Hugo will execute the deferred template on every render. This is not what you want for shared resources like CSS and JavaScript.

`data`
: (`map`) Optional map to pass as data to the deferred template. This will be available in the deferred template as `.` or `$`.

```go-html-template
Language Outside: {{ site.Language.Name }}
Page Outside: {{ .RelPermalink }}
I18n Outside: {{ i18n "hello" }}
{{ $data := (dict "page" . )}}
{{ with (templates.Defer (dict "data" $data )) }}
     Language Inside: {{ site.Language.Name }}
     Page Inside: {{ .page.RelPermalink }}
     I18n Inside: {{ i18n "hello" }}
{{ end }}
```

The [output format][], [site][], and [language][] will be the same, even if the execution is deferred. In the example above, this means that the `site.Language.Name` and `.RelPermalink` will be the same on the inside and the outside of the deferred template.

[`hugo_stats.json`]: /configuration/build/
[css.TailwindCSS]: /functions/css/tailwindcss/
[language]: /methods/site/language/
[output format]: /configuration/output-formats/
[site]: /methods/page/site/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/templates/Exists.md
---


A template file is any file within the `layouts` directory of either the project or any of its theme components.

Use the `templates.Exists` function with dynamic template paths:

```go-html-template
{{ $partialPath := printf "headers/%s.html" .Type }}
{{ if templates.Exists ( printf "_partials/%s" $partialPath ) }}
  {{ partial $partialPath . }}
{{ else }}
  {{ partial "headers/default.html" . }}
{{ end }}
```

In the example above, if a "headers" partial does not exist for the given content type, Hugo falls back to a default template.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/templates/Inner.md
---


{{< new-in 0.154.0 />}}

The `templates.Inner` function defines the injection point for code nested within a block style partial call. This is the core mechanism used to create a [partial decorator][].

