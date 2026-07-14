## Example

An example table listing the dependencies:

```go-html-template
<h2>Dependencies</h2>
<table class="table table-dark">
  <thead>
    <tr>
      <th scope="col">#</th>
      <th scope="col">Owner</th>
      <th scope="col">Path</th>
      <th scope="col">Version</th>
      <th scope="col">Time</th>
      <th scope="col">Vendor</th>
    </tr>
  </thead>
  <tbody>
    {{ range $index, $element := hugo.Deps }}
    <tr>
      <th scope="row">{{ add $index 1 }}</th>
      <td>{{ with $element.Owner }}{{ .Path }}{{ end }}</td>
      <td>
        {{ $element.Path }}
        {{ with $element.Replace }}
        => {{ .Path }}
        {{ end }}
      </td>
      <td>{{ $element.Version }}</td>
      <td>{{ with $element.Time }}{{ . }}{{ end }}</td>
      <td>{{ $element.Vendor }}</td>
    </tr>
    {{ end }}
  </tbody>
</table>
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/hugo/Environment.md
---


The `hugo.Environment` function returns the current running [environment](g) as defined through the `--environment` command line flag.

```go-html-template
{{ hugo.Environment }} → production
```

Command line examples:

Command|Environment
:--|:--
`hugo build`|`production`
`hugo build --environment staging`|`staging`
`hugo server`|`development`
`hugo server --environment staging`|`staging`


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/hugo/Generator.md
---


```go-html-template
{{ hugo.Generator }} → <meta name="generator" content="Hugo 0.163.3">
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/hugo/GoVersion.md
---


```go-html-template
{{ hugo.GoVersion }} → go1.21.1
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/hugo/IsDevelopment.md
---


```go-html-template
{{ hugo.IsDevelopment }} → true/false
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/hugo/IsExtended.md
---


```go-html-template
{{ hugo.IsExtended }} → true/false
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/hugo/IsMultihost.md
---


Project configuration:

{{< code-toggle file=hugo >}}
defaultContentLanguage = 'de'
defaultContentLanguageInSubdir = true
[languages]
  [languages.de]
    baseURL = 'https://de.example.org/'
    label = 'Deutsch'
    locale = 'de-DE'
    title = 'Projekt Dokumentation'
    weight = 1
  [languages.en]
    baseURL = 'https://en.example.org/'
    label = 'English'
    locale = 'en-US'
    title = 'Project Documentation'
    weight = 2
{{< /code-toggle >}}

Template:

```go-html-template
{{ hugo.IsMultihost }} → true
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/hugo/IsMultilingual.md
---


Project configuration:

{{< code-toggle file=hugo >}}
defaultContentLanguage = 'de'
defaultContentLanguageInSubdir = true
[languages]
  [languages.de]
    label = 'Deutsch'
    locale = 'de-DE'
    title = 'Projekt Dokumentation'
    weight = 1
  [languages.en]
    label = 'English'
    locale = 'en-US'
    title = 'Project Documentation'
    weight = 2
{{< /code-toggle >}}

Template:

```go-html-template
{{ hugo.IsMultilingual }} → true
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/hugo/IsProduction.md
---


```go-html-template
{{ hugo.IsProduction }} → true/false
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/hugo/IsServer.md
---


```go-html-template
{{ hugo.IsServer }} → true/false
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/hugo/Sites.md
---


{{< new-in 0.156.0 />}}

{{% include "/_common/functions/hugo/sites-collection.md" %}}

With this project configuration:

{{< code-toggle file=hugo >}}
defaultContentLanguage = 'de'
defaultContentLanguageInSubdir = true
defaultContentVersionInSubdir = true

[languages.de]
contentDir = 'content/de'
direction = 'ltr'
label = 'Deutsch'
locale = 'de-DE'
title = 'Projekt Dokumentation'
weight = 1

[languages.en]
contentDir = 'content/en'
direction = 'ltr'
label = 'English'
locale = 'en-US'
title = 'Project Documentation'
weight = 2

[versions.'v1.0.0']
[versions.'v2.0.0']
[versions.'v3.0.0']
{{< /code-toggle >}}

This template:

```go-html-template
<ul>
  {{ range hugo.Sites }}
    <li><a href="{{ .Home.RelPermalink }}">{{ .Title }} {{ .Version.Name }}</a></li>
  {{ end }}
</ul>
```

Produces a list of links to each home page:

```html
<ul>
  <li><a href="/v3.0.0/de/">Projekt Dokumentation v3.0.0</a></li>
  <li><a href="/v2.0.0/de/">Projekt Dokumentation v2.0.0</a></li>
  <li><a href="/v1.0.0/de/">Projekt Dokumentation v1.0.0</a></li>
  <li><a href="/v3.0.0/en/">Project Documentation v3.0.0</a></li>
  <li><a href="/v2.0.0/en/">Project Documentation v2.0.0</a></li>
  <li><a href="/v1.0.0/en/">Project Documentation v1.0.0</a></li>
</ul>
```

To render a link to the home page of the [default site](g):

```go-html-template
{{ with hugo.Sites.Default }}
  <a href="{{ .Home.RelPermalink }}">{{ .Title }}</a>
{{ end }}
```

This is equivalent to:

```go-html-template
{{ with index hugo.Sites 0 }}
  <a href="{{ .Home.RelPermalink }}">{{ .Title }}</a>
{{ end }}
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/hugo/Store.md
---


{{< new-in 0.139.0 />}}

Use the `hugo.Store` function to create a globally scoped persistent data structure for storing and manipulating keyed values. To create a data structure with a different [scope](g), refer to the [scope](#scope) section below.

