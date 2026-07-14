
---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/templates/Current.md
---


> [!NOTE]
> This function is experimental and subject to change.

{{< new-in 0.146.0 />}}

The `templates.Current` function provides introspection capabilities, allowing you to access details about the currently executing templates. This is useful for debugging complex template hierarchies and understanding the flow of execution during rendering.

## Methods

Use these methods on the `CurrentTemplateInfo` object.

`Ancestors`
: (`tpl.CurrentTemplateInfos`) Returns a slice containing information about each template in the current execution chain, starting from the parent of the current template and going up towards the initial template called. It excludes any base template applied via `define` and `block`. You can chain the `Reverse` method to this result to get the slice in chronological execution order.

`Base`
: (`tpl.CurrentTemplateInfoCommonOps`) Returns an object representing the base template that was applied to the current template, if any. This may be `nil`.

`Filename`
: (`string`) Returns the absolute path of the current template. This will be empty for embedded templates.

`Name`
: (`string`) Returns the name of the current template. This is usually the path relative to the layouts directory.

`Parent`
: (`tpl.CurrentTemplateInfo`) Returns an object representing the parent of the current template, if any. This may be `nil`.

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

## Overview

The `templates.Inner` function acts as a placeholder within a partial template. When a partial is called as a decorator, it captures a block of code from the calling template rather than rendering it immediately. The `templates.Inner` function tells Hugo exactly where to inject that captured content.

This signals a reversal of execution where the callee becomes the caller. The partial manages the outer structure while the calling template remains in control of the inner content.

## Usage

To use this function, the calling template must use the block style syntax with a [`with`][] statement. This allows decorators to be deeply nested.

```go-html-template {file="layouts/home.html"}
{{ with partial "components/card.html" . }}
  <p>This content is passed to the partial.</p>
{{ end }}
```

Inside the partial, call `templates.Inner` to render the captured block.

```go-html-template {file="layouts/_partials/components/card.html"}
<div class="card-frame">
  {{ templates.Inner . }}
</div>
```

## Arguments

The function accepts one optional argument: the [context](g). This argument determines the value of the dot (`.`) inside the captured block when it is rendered.

- If you provide an argument, such as `{{ templates.Inner .SomeData }}`, the dot inside the captured block is rebound to that specific data.
- If you do not provide an argument, the captured block uses the context of the caller where the partial was first invoked.

## Context and scope

When using decorators, the `with` statement creates a new [scope](g). Variables defined outside the with block in the calling template are not automatically available inside the captured block.

By passing a context to `templates.Inner`, you ensure that the injected content has access to the correct data even when nested inside multiple layers of wrappers. This is critical when the decorator is used inside a loop or a specific data overlay.

## Repeated execution

A decorator can execute the captured content zero or more times. This is useful when the wrapper needs to repeat the same decoration for a collection of items, such as a list or a grid.

```go-html-template {file="layouts/_partials/list-decorator.html"}
<ul class="styled-list">
  {{ range .items }}
    <li>
      {{ templates.Inner . }}
    </li>
  {{ end }}
</ul>
```

In this example, the code provided by the caller is rendered once for every item in the .items collection, with the dot . updated to the current item in each iteration.

[`with`]: /functions/go-template/with/
[partial decorator]: /templates/partial-decorators/

