## Examples

The examples below help visualize template execution and require a `debug` parameter set to `true` in your project configuration:

{{< code-toggle file=hugo >}}
[params]
debug = true
{{< /code-toggle >}}

### Boundaries

To visually mark where a template begins and ends execution:

```go-html-template {file="layouts/page.html"}
{{ define "main" }}
  {{ if site.Params.debug }}
    <div class="debug">[entering {{ templates.Current.Filename }}]</div>
  {{ end }}

  <h1>{{ .Title }}</h1>
  {{ .Content }}

  {{ if site.Params.debug }}
    <div class="debug">[leaving {{ templates.Current.Filename }}]</div>
  {{ end }}
{{ end }}
```

### Call stack

To display the chain of templates that led to the current one, create a _partial_ template that iterates through its ancestors:

```go-html-template {file="layouts/_partials/template-call-stack.html" copy=true}
{{ with templates.Current }}
  <div class="debug">
    {{ range .Ancestors }}
      {{ .Filename }}<br>
      {{ with .Base }}
        {{ .Filename }}<br>
      {{ end }}
    {{ end }}
  </div>
{{ end }}
```

Then call the partial from any template:

```go-html-template {file="layouts/_partials/footer/copyright.html" copy=true}
{{ if site.Params.debug }}
  {{ partial "template-call-stack.html" . }}
{{ end }}
```

The rendered template stack would look something like this:

```text
/home/user/project/layouts/_partials/footer/copyright.html
/home/user/project/themes/foo/layouts/_partials/footer.html
/home/user/project/layouts/page.html
/home/user/project/themes/foo/layouts/baseof.html
```

To reverse the order of the entries, chain the `Reverse` method to the `Ancestors` method:

```go-html-template {file="layouts/_partials/template-call-stack.html" copy=true}
{{ with templates.Current }}
  <div class="debug">
    {{ range .Ancestors.Reverse }}
      {{ with .Base }}
        {{ .Filename }}<br>
      {{ end }}
      {{ .Filename }}<br>
    {{ end }}
  </div>
{{ end }}
```

### VS Code

To render links that, when clicked, will open the template in Microsoft Visual Studio Code, create a _partial_ template with anchor elements that use the `vscode` URI scheme:

```go-html-template {file="layouts/_partials/template-open-in-vs-code.html" copy=true}
{{ with templates.Current.Parent }}
  <div class="debug">
    <a href="vscode://file/{{ .Filename }}">{{ .Name }}</a>
    {{ with .Base }}
      <a href="vscode://file/{{ .Filename }}">{{ .Name }}</a>
    {{ end }}
  </div>
{{ end }}
```

Then call the partial from any template:

```go-html-template {file="layouts/page.html" copy=true}
{{ define "main" }}
  <h1>{{ .Title }}</h1>
  {{ .Content }}

  {{ if site.Params.debug }}
    {{ partial "template-open-in-vs-code.html" . }}
  {{ end }}
{{ end }}
```

Use the same approach to render the entire call stack as links:

```go-html-template {file="layouts/_partials/template-call-stack.html" copy=true}
{{ with templates.Current }}
  <div class="debug">
    {{ range .Ancestors }}
      <a href="vscode://file/{{ .Filename }}">{{ .Filename }}</a><br>
      {{ with .Base }}
        <a href="vscode://file/{{ .Filename }}">{{ .Filename }}</a><br>
      {{ end }}
    {{ end }}
  </div>
{{ end }}
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/templates/Defer.md
---


> [!NOTE]
> Do not call this function within a `partialCached` template. This restriction applies transitively: if `partialCached` calls a partial that calls `templates.Defer`, Hugo returns an error. Using this function within shortcode or render hook templates may also lead to unpredictable results.

In some rare use cases, you may need to defer the execution of a template until after all sites and output formats have been rendered. One such example could be [css.TailwindCSS][] using the output of [`hugo_stats.json`][] to determine which classes and other HTML identifiers are being used in the final output:

```go-html-template {file="layouts/baseof.html" copy=true}
<head>
  ...
  {{ with (templates.Defer (dict "key" "global")) }}
    {{ partial "css.html" . }}
  {{ end }}
  ...
</head>
```

```go-html-template {file="layouts/_partials/css.html" copy=true}
{{ with resources.Get "css/main.css" }}
  {{ $opts := dict "minify" (not hugo.IsDevelopment) }}
  {{ with . | css.TailwindCSS $opts }}
    {{ if hugo.IsDevelopment }}
      <link rel="stylesheet" href="{{ .RelPermalink }}">
    {{ else }}
      {{ with . | fingerprint }}
        <link rel="stylesheet" href="{{ .RelPermalink }}" integrity="{{ .Data.Integrity }}" crossorigin="anonymous">
      {{ end }}
    {{ end }}
  {{ end }}
{{ end }}
```

> [!NOTE]
> This function only works in combination with the `with` keyword.
>
> Variables defined on the outside are not visible on the inside and vice versa. To pass in data, use the `data` [option](#options).

For the above to work well when running the server (or `hugo -w`), you want to have a configuration similar to this:

{{< code-toggle file=hugo >}}
[build]
  [build.buildStats]
    enable = true
  [[build.cachebusters]]
    source = 'assets/notwatching/hugo_stats\.json'
    target = 'css'
  [[build.cachebusters]]
    source = '(postcss|tailwind)\.config\.js'
    target = 'css'
[module]
  [[module.mounts]]
    source = 'assets'
    target = 'assets'
  [[module.mounts]]
    disableWatch = true
    source = 'hugo_stats.json'
    target = 'assets/notwatching/hugo_stats.json'
{{< /code-toggle >}}

