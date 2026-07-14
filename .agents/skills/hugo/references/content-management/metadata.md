## Metadata

Display metadata about each term by creating a corresponding branch bundle in the `content` directory.

For example, create an `authors` taxonomy:

{{< code-toggle file=hugo >}}
[taxonomies]
author = 'authors'
{{< /code-toggle >}}

Then create content with one [branch bundle](g) for each term:

```tree
content/
└── authors/
    ├── jsmith/
    │   ├── _index.md
    │   └── portrait.jpg
    └── rjones/
        ├── _index.md
        └── portrait.jpg
```

Then add front matter to each term page:

{{< code-toggle file=content/authors/jsmith/_index.md fm=true >}}
title = 'John Smith'
affiliation = 'University of Chicago'
{{< /code-toggle >}}

Then create a _taxonomy_ template specific to the `authors` taxonomy:

```go-html-template {file="layouts/authors/taxonomy.html"}
{{ define "main" }}
  <h1>{{ .Title }}</h1>
  {{ .Content }}
  {{ range .Data.Terms.Alphabetical }}
    <h2><a href="{{ .Page.RelPermalink }}">{{ .Page.LinkTitle }}</a></h2>
    <p>Affiliation: {{ .Page.Params.Affiliation }}</p>
    {{ with .Page.Resources.Get "portrait.jpg" }}
      {{ with .Fill "100x100" }}
        <img src="{{ .RelPermalink }}" width="{{ .Width }}" height="{{ .Height }}" alt="portrait">
      {{ end }}
    {{ end }}
  {{ end }}
{{ end }}
```

In the example above we list each author including their affiliation and portrait.

Or create a _term_ template specific to the `authors` taxonomy:

```go-html-template {file="layouts/authors/term.html"}
{{ define "main" }}
  <h1>{{ .Title }}</h1>
  <p>Affiliation: {{ .Params.affiliation }}</p>
  {{ with .Resources.Get "portrait.jpg" }}
    {{ with .Fill "100x100" }}
      <img src="{{ .RelPermalink }}" width="{{ .Width }}" height="{{ .Height }}" alt="portrait">
    {{ end }}
  {{ end }}
  {{ .Content }}
  {{ range .Pages }}
    <h2><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></h2>
  {{ end }}
{{ end }}
```

In the example above we display the author including their affiliation and portrait, then a list of associated content.

[configure taxonomies]: /configuration/taxonomies/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/content-management/urls.md
---


