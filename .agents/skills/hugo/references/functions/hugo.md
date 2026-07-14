
---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/hugo/BuildDate.md
---


The `hugo.BuildDate` function returns the compile date of the Hugo binary, formatted per [RFC 3339][].

```go-html-template
{{ hugo.BuildDate }} → 2023-11-01T17:57:00Z
```

[RFC 3339]: https://datatracker.ietf.org/doc/html/rfc3339


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/hugo/CommitHash.md
---


```go-html-template
{{ hugo.CommitHash }} → a4892a07b41b7b3f1f143140ee4ec0a9a5cf3970
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/hugo/Data.md
---


{{< new-in 0.156.0 />}}

Use the `hugo.Data` function to access data within the `data` directory, or within any directory [mounted][] to the `data` directory. Supported data formats include JSON, TOML, YAML, and XML.

> [!NOTE]
> Although Hugo can [unmarshal](g) CSV files with the [`transform.Unmarshal`][] function, do not place CSV files in the `data` directory. You cannot access data within CSV files using this method.

Consider this `data` directory:

```tree
data/
├── books/
│   ├── fiction.yaml
│   └── nonfiction.yaml
├── films.json
├── paintings.xml
└── sculptures.toml
```

And these data files:

```yaml {file="data/books/fiction.yaml"}
- title: The Hunchback of Notre Dame
  author: Victor Hugo
  isbn: 978-0140443530
- title: Les Misérables
  author: Victor Hugo
  isbn: 978-0451419439
```

```yaml {file="data/books/nonfiction.yaml"}
- title: The Ancien Régime and the Revolution
  author: Alexis de Tocqueville
  isbn: 978-0141441641
- title: Interpreting the French Revolution
  author: François Furet
  isbn: 978-0521280495
```

Access the data by [chaining](g) the [identifiers](g):

```go-html-template
{{ range $category, $books := hugo.Data.books }}
  <p>{{ $category | title }}</p>
  <ul>
    {{ range $books }}
      <li>{{ .title }} ({{ .isbn }})</li>
    {{ end }}
  </ul>
{{ end }}
```

Hugo renders this to:

```html
<p>Fiction</p>
<ul>
  <li>The Hunchback of Notre Dame (978-0140443530)</li>
  <li>Les Misérables (978-0451419439)</li>
</ul>
<p>Nonfiction</p>
<ul>
  <li>The Ancien Régime and the Revolution (978-0141441641)</li>
  <li>Interpreting the French Revolution (978-0521280495)</li>
</ul>
```

To limit the listing to fiction, and sort by title:

```go-html-template
<ul>
  {{ range sort hugo.Data.books.fiction "title" }}
    <li>{{ .title }} ({{ .author }})</li>
  {{ end }}
</ul>
```

To find a fiction book by ISBN:

```go-html-template
{{ range where hugo.Data.books.fiction "isbn" "978-0140443530" }}
  <li>{{ .title }} ({{ .author }})</li>
{{ end }}
```

In the template examples above, each of the keys is a valid identifier. For example, none of the keys contains a hyphen. To access a key that is not a valid identifier, use the [`index`][] function. For example:

```go-html-template
{{ index hugo.Data.books "historical-fiction" }}
```

[`index`]: /functions/collections/indexfunction/
[`transform.Unmarshal`]: /functions/transform/unmarshal/
[mounted]: /configuration/module/#mounts


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/hugo/Deps.md
---


The `hugo.Deps` function returns a slice of project dependencies, either modules or local theme components.

## Methods

Use these methods on each `hugo.Dependency` object returned by `hugo.Deps`.

`Owner`
: (`hugo.Dependency`) In the dependency tree, this is the first module that defines this module as a dependency (e.g., `github.com/gohugoio/hugo-mod-bootstrap-scss/v5`).

`Path`
: (`string`) Returns the module path or the path below your `themes` directory (e.g., `github.com/gohugoio/hugo-mod-jslibs-dist/popperjs/v2`).

`Replace`
: (`hugo.Dependency`) Returns the dependency that replaces this dependency.

`Time`
: (`time.Time`) Returns the time that the version was created (e.g., `2022-02-13 15:11:28 +0000 UTC`).

`Vendor`
: (`bool`) Reports whether the dependency is vendored.

`Version`
: (`string`) Returns the module version (e.g., `v2.21100.20000`).

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

## Methods

Use these methods on the data structure.

`Set`
: Sets the value of the given key.

  ```go-html-template
  {{ hugo.Store.Set "greeting" "Hello" }}
  ```

`Get`
: (`any`) Gets the value of the given key.

  ```go-html-template
  {{ hugo.Store.Set "greeting" "Hello" }}
  {{ hugo.Store.Get "greeting" }} → Hello
  ```

`Add`
: Adds the given value to the existing value(s) of the given key.

  For single values, `Add` accepts values that support Go's `+` operator. If the first `Add` for a key is an array or slice, the following adds will be appended to that list.

  ```go-html-template
  {{ hugo.Store.Set "greeting" "Hello" }}
  {{ hugo.Store.Add "greeting" "Welcome" }}
  {{ hugo.Store.Get "greeting" }} → HelloWelcome
  ```

  ```go-html-template
  {{ hugo.Store.Set "total" 3 }}
  {{ hugo.Store.Add "total" 7 }}
  {{ hugo.Store.Get "total" }} → 10
  ```

  ```go-html-template
  {{ hugo.Store.Set "greetings" (slice "Hello") }}
  {{ hugo.Store.Add "greetings" (slice "Welcome" "Cheers") }}
  {{ hugo.Store.Get "greetings" }} → [Hello Welcome Cheers]
  ```

`SetInMap`
: Takes a `key`, `mapKey` and `value` and adds a map of `mapKey` and `value` to the given `key`.

  ```go-html-template
  {{ hugo.Store.SetInMap "greetings" "english" "Hello" }}
  {{ hugo.Store.SetInMap "greetings" "french" "Bonjour" }}
  {{ hugo.Store.Get "greetings" }} → map[english:Hello french:Bonjour]
  ```

`DeleteInMap`
: Takes a `key` and `mapKey` and removes the map of `mapKey` from the given `key`.

  ```go-html-template
  {{ hugo.Store.SetInMap "greetings" "english" "Hello" }}
  {{ hugo.Store.SetInMap "greetings" "french" "Bonjour" }}
  {{ hugo.Store.DeleteInMap "greetings" "english" }}
  {{ hugo.Store.Get "greetings" }} → map[french:Bonjour]
  ```

`GetSortedMapValues`
: (`[]any`) Returns an array of values from `key` sorted by `mapKey`.

  ```go-html-template
  {{ hugo.Store.SetInMap "greetings" "english" "Hello" }}
  {{ hugo.Store.SetInMap "greetings" "french" "Bonjour" }}
  {{ hugo.Store.GetSortedMapValues "greetings" }} → [Hello Bonjour]
  ```

`Delete`
: Removes the given key.

  ```go-html-template
  {{ hugo.Store.Set "greeting" "Hello" }}
  {{ hugo.Store.Delete "greeting" }}
  ```

{{% include "_common/store-scope.md" %}}

## Determinate values

The `Store` method is often used to set values within a _shortcode_ template, a _partial_ template called by a _shortcode_ template, or by a _render hook_ template. In all three cases, the stored values are indeterminate until Hugo renders the page content.

If you need to access a stored value from a parent template, and the parent template has not yet rendered the page content, you can trigger content rendering by assigning the returned value to a [noop](g) variable:

```go-html-template
{{ $noop := .Content }}
{{ hugo.Store.Get "mykey" }}
```

You can also trigger content rendering with the `ContentWithoutSummary`, `FuzzyWordCount`, `Len`, `Plain`, `PlainWords`, `ReadingTime`, `Summary`, `Truncated`, and `WordCount` methods. For example:

```go-html-template
{{ $noop := .WordCount }}
{{ hugo.Store.Get "mykey" }}
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/hugo/Version.md
---


```go-html-template
{{ hugo.Version }} → 0.163.3
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/hugo/WorkingDir.md
---


```go-html-template
{{ hugo.WorkingDir }} → /home/user/projects/my-hugo-site
```

