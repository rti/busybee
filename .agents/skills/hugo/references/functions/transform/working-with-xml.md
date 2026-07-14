## Working with XML

When unmarshaling an XML file, do not include the root node when accessing data. For example, after unmarshaling the RSS feed below, access the feed title with `$data.channel.title`.

```xml
<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">
  <channel>
    <title>Books on Example Site</title>
    <link>https://example.org/books/</link>
    <description>Recent content in Books on Example Site</description>
    <language>en-US</language>
    <atom:link href="https://example.org/books/index.xml" rel="self" type="application/rss+xml" />
    <item>
      <title>The Hunchback of Notre Dame</title>
      <description>Written by Victor Hugo</description>
      <link>https://example.org/books/the-hunchback-of-notre-dame/</link>
      <pubDate>Mon, 09 Oct 2023 09:27:12 -0700</pubDate>
      <guid>https://example.org/books/the-hunchback-of-notre-dame/</guid>
    </item>
    <item>
      <title>Les Misérables</title>
      <description>Written by Victor Hugo</description>
      <link>https://example.org/books/les-miserables/</link>
      <pubDate>Mon, 09 Oct 2023 09:27:11 -0700</pubDate>
      <guid>https://example.org/books/les-miserables/</guid>
    </item>
  </channel>
</rss>
```

Get the remote data:

```go-html-template
{{ $data := dict }}
{{ $url := "https://example.org/books/index.xml" }}
{{ with try (resources.GetRemote $url) }}
  {{ with .Err }}
    {{ errorf "%s" . }}
  {{ else with .Value }}
    {{ $data = . | transform.Unmarshal }}
  {{ else }}
    {{ errorf "Unable to get remote resource %q" $url }}
  {{ end }}
{{ end }}
```

Inspect the data structure:

```go-html-template
<pre>{{ debug.Dump $data }}</pre>
```

List the book titles:

```go-html-template
{{ with $data.channel.item }}
  <ul>
    {{ range . }}
      <li>{{ .title }}</li>
    {{ end }}
  </ul>
{{ end }}
```

Hugo renders this to:

```html
<ul>
  <li>The Hunchback of Notre Dame</li>
  <li>Les Misérables</li>
</ul>
```

### XML attributes and namespaces

Let's add a `lang` attribute to the `title` nodes of our RSS feed, and a namespaced node for the ISBN number:

```xml
<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<rss version="2.0"
  xmlns:atom="http://www.w3.org/2005/Atom"
  xmlns:isbn="http://schemas.isbn.org/ns/1999/basic.dtd"
>
  <channel>
    <title>Books on Example Site</title>
    <link>https://example.org/books/</link>
    <description>Recent content in Books on Example Site</description>
    <language>en-US</language>
    <atom:link href="https://example.org/books/index.xml" rel="self" type="application/rss+xml" />
    <item>
      <title lang="en">The Hunchback of Notre Dame</title>
      <description>Written by Victor Hugo</description>
      <isbn:number>9780140443530</isbn:number>
      <link>https://example.org/books/the-hunchback-of-notre-dame/</link>
      <pubDate>Mon, 09 Oct 2023 09:27:12 -0700</pubDate>
      <guid>https://example.org/books/the-hunchback-of-notre-dame/</guid>
    </item>
    <item>
      <title lang="fr">Les Misérables</title>
      <description>Written by Victor Hugo</description>
      <isbn:number>9780451419439</isbn:number>
      <link>https://example.org/books/les-miserables/</link>
      <pubDate>Mon, 09 Oct 2023 09:27:11 -0700</pubDate>
      <guid>https://example.org/books/les-miserables/</guid>
    </item>
  </channel>
</rss>
```

After retrieving the remote data, inspect the data structure:

```go-html-template
<pre>{{ debug.Dump $data }}</pre>
```

Each item node looks like this:

```json
{
  "description": "Written by Victor Hugo",
  "guid": "https://example.org/books/the-hunchback-of-notre-dame/",
  "link": "https://example.org/books/the-hunchback-of-notre-dame/",
  "number": "9780140443530",
  "pubDate": "Mon, 09 Oct 2023 09:27:12 -0700",
  "title": {
    "#text": "The Hunchback of Notre Dame",
    "-lang": "en"
  }
}
```

The title keys do not begin with an underscore or a letter---they are not valid [identifiers](g). Use the [`index`][] function to access the values:

```go-html-template
{{ with $data.channel.item }}
  <ul>
    {{ range . }}
      {{ $title := index .title "#text" }}
      {{ $lang := index .title "-lang" }}
      {{ $ISBN := .number }}
      <li>{{ $title }} ({{ $lang }}) {{ $ISBN }}</li>
    {{ end }}
  </ul>
{{ end }}
```

Hugo renders this to:

```html
<ul>
  <li>The Hunchback of Notre Dame (en) 9780140443530</li>
  <li>Les Misérables (fr) 9780451419439</li>
</ul>
```

[Content-Type]: https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Type
[`index`]: /functions/collections/indexfunction/
[page bundle]: /content-management/page-bundles/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/transform/XMLEscape.md
---


The `transform.XMLEscape` function removes [disallowed characters][] as defined in the XML specification, then escapes the result by replacing the following characters with [HTML entities][]:

- `"` → `&#34;`
- `'` → `&#39;`
- `&` → `&amp;`
- `<` → `&lt;`
- `>` → `&gt;`
- `\t` → `&#x9;`
- `\n` → `&#xA;`
- `\r` → `&#xD;`

For example:

```go-html-template
{{ transform.XMLEscape "<p>abc</p>" }} → &lt;p&gt;abc&lt;/p&gt;
```

When using `transform.XMLEscape` in a template rendered by Go's [`html/template`][] package, declare the string to be safe HTML to avoid double escaping. For example, in an RSS template:

```xml {file="layouts/rss.xml"}
<description>{{ .Summary | transform.XMLEscape | safeHTML }}</description>
```

[HTML entities]: https://developer.mozilla.org/en-US/docs/Glossary/Entity
[`html/template`]: https://pkg.go.dev/html/template
[disallowed characters]: https://www.w3.org/TR/xml/#charsets

