## Example

The following templates illustrate how to nest three wrapper components including a section, a column, and a card while passing context through each layer.

The _home_ template initiates the structure by calling the section, column, and card partials as decorators:

```go-html-template {file="layouts/home.html" copy=true}
{{ $ctx := dict
  "page" .
  "label" "Recent Posts"
  "pageCollection" ((site.GetPage "/posts").RegularPages)
}}

{{ with partial "components/section.html" $ctx }}
  <div class="grid-wrapper">
    {{ range .pageCollection }}
      {{ with partial "components/column.html" (dict "page" . "class" "col-half") }}
        {{ with partial "components/card.html" (dict "page" .page "url" .page.RelPermalink "title" .page.LinkTitle) }}
          <p>
            {{ .page.Content | plainify | strings.Truncate 240 }}
          </p>
        {{ end }}
      {{ end }}
    {{ end }}
  </div>
{{ end }}
```

The section component provides a semantic container and an optional heading:

```go-html-template {file="layouts/_partials/components/section.html" copy=true}
<section class="content-section">
  {{ with .label }}
    <h2 class="section-label">{{ . }}</h2>
  {{ end }}
  <div class="section-content">
    {{ templates.Inner . }}
  </div>
</section>
```

The column component manages layout width by applying a CSS class:

```go-html-template {file="layouts/_partials/components/column.html" copy=true}
<div class="{{ .class | default `column-default` }}">
  {{ templates.Inner . }}
</div>
```

The card component defines the visual boundary for the content:

```go-html-template {file="layouts/_partials/components/card.html" copy=true}
<div class="card">
  {{ with .title }}
    <h2 class="card-title">
      {{ if $.url }}
        <a href="{{ $.url }}">{{ . }}</a>
      {{ else }}
        {{ . }}
      {{ end }}
    </h2>
  {{ end }}

  <div class="card-body">
    {{ templates.Inner . }}
  </div>

  {{ with .url }}
    <div class="card-footer">
      <a href="{{ . }}">Read more</a>
    </div>
  {{ end }}
</div>
```

[`with`]: /functions/go-template/with/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/templates/robots.md
---


To generate a robots.txt file from a template, change your project configuration:

{{< code-toggle file=hugo >}}
enableRobotsTXT = true
{{< /code-toggle >}}

By default, Hugo generates robots.txt using an [embedded template][].

```text
User-agent: *
```

Search engines that honor the Robots Exclusion Protocol will interpret this as permission to crawl everything on the site.

