## Taxonomies

Classify content by adding taxonomy terms to front matter. For example, with this project configuration:

{{< code-toggle file=hugo >}}
[taxonomies]
tag = 'tags'
genre = 'genres'
{{< /code-toggle >}}

Add taxonomy terms as shown below:

{{< code-toggle file=content/example.md fm=true >}}
title = 'Example'
date = 2024-02-02T04:14:54-08:00
draft = false
weight = 10
tags = ['red','blue']
genres = ['mystery','romance']
[params]
author = 'John Smith'
{{< /code-toggle >}}

You can add taxonomy terms to the front matter of any these [page kinds](g):

- `home`
- `page`
- `section`
- `taxonomy`
- `term`

Access taxonomy terms from a template using the [`Params`][] or [`GetTerms`][] method on a `Page` object. For example:

```go-html-template {file="layouts/page.html"}
{{ with .GetTerms "tags" }}
  <p>Tags</p>
  <ul>
    {{ range . }}
      <li><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></li>
    {{ end }}
  </ul>
{{ end }}
```

