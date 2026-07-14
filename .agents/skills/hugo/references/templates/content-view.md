## Content view

A _content view_ template is similar to a _partial_ template, invoked by calling the [`Render`][] method on a `Page` object. Unlike _partial_ templates, _content view_ templates:

- Inherit the context of the current page
- Can target any page kind, content type, logical path, language, or output format
- Can reside at any level within the `layouts` directory

For example, Hugo applies a _base_ template to the _home_ template below, then renders the page content and a card component for each page within the `films` section of your site.

```go-html-template {file="layouts/home.html"}
{{ define "main" }}
  {{ .Content }}
  <ul>
    {{ range where site.RegularPages "Section" "films" }}
      {{ .Render "view_card" }}
    {{ end }}
  </ul>
{{ end }}
```

```go-html-template {file="layouts/films/view_card.html"}
<div class="card">
  <h2><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></h2>
  {{ .Summary }}
</div>
```

In the example above, the content view template's name starts with `view_`. While not strictly required, this naming convention helps distinguish content view templates from other templates within the same directory, improving organization and clarity.

