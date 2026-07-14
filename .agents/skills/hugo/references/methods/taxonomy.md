
---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/taxonomy/Alphabetical.md
---


The `Alphabetical` method on a `Taxonomy` object returns an [ordered taxonomy](g), sorted alphabetically by [term](g).

While a `Taxonomy` object is a [map](g), an ordered taxonomy is a [slice](g), where each element is an object that contains the term and a slice of its [weighted pages](g).

{{% include "/_common/methods/taxonomy/get-a-taxonomy-object.md" %}}

## Get the ordered taxonomy

Now that we have captured the “genres” Taxonomy object, let's get the ordered taxonomy sorted alphabetically by term:

```go-html-template
{{ $taxonomyObject.Alphabetical }}
```

To reverse the sort order:

```go-html-template
{{ $taxonomyObject.Alphabetical.Reverse }}
```

To inspect the data structure:

```go-html-template
<pre>{{ debug.Dump $taxonomyObject.Alphabetical }}</pre>
```

{{% include "/_common/methods/taxonomy/ordered-taxonomy-element-methods.md" %}}

## Example

With this template:

```go-html-template
{{ range $taxonomyObject.Alphabetical }}
  <h2><a href="{{ .Page.RelPermalink }}">{{ .Page.LinkTitle }}</a> ({{ .Count }})</h2>
  <ul>
    {{ range .Pages.ByTitle }}
      <li><a href="{{ .RelPermalink }}">{{ .Title }}</a></li>
    {{ end }}
  </ul>
{{ end }}
```

Hugo renders:

```html
<h2><a href="/genres/romance/">romance</a> (2)</h2>
<ul>
  <li><a href="/books/jamaica-inn/">Jamaica inn</a></li>
  <li><a href="/books/pride-and-prejudice/">Pride and prejudice</a></li>
</ul>
<h2><a href="/genres/suspense/">suspense</a> (3)</h2>
<ul>
  <li><a href="/books/and-then-there-were-none/">And then there were none</a></li>
  <li><a href="/books/death-on-the-nile/">Death on the nile</a></li>
  <li><a href="/books/jamaica-inn/">Jamaica inn</a></li>
</ul>
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/taxonomy/ByCount.md
---


The `ByCount` method on a `Taxonomy` object returns an [ordered taxonomy](g), sorted by the number of pages associated with each [term](g), then sorted alphabetically by term in the event of a tie.

While a `Taxonomy` object is a [map](g), an ordered taxonomy is a [slice](g), where each element is an object that contains the term and a slice of its [weighted pages](g).

{{% include "/_common/methods/taxonomy/get-a-taxonomy-object.md" %}}

## Get the ordered taxonomy

Now that we have captured the “genres” Taxonomy object, let's get the ordered taxonomy sorted by the number of pages associated with each term:

```go-html-template
{{ $taxonomyObject.ByCount }}
```

To reverse the sort order:

```go-html-template
{{ $taxonomyObject.ByCount.Reverse }}
```

To inspect the data structure:

```go-html-template
<pre>{{ debug.Dump $taxonomyObject.ByCount }}</pre>
```

{{% include "/_common/methods/taxonomy/ordered-taxonomy-element-methods.md" %}}

## Example

With this template:

```go-html-template
{{ range $taxonomyObject.ByCount }}
  <h2><a href="{{ .Page.RelPermalink }}">{{ .Page.LinkTitle }}</a> ({{ .Count }})</h2>
  <ul>
    {{ range .Pages.ByTitle }}
      <li><a href="{{ .RelPermalink }}">{{ .Title }}</a></li>
    {{ end }}
  </ul>
{{ end }}
```

Hugo renders:

```html
<h2><a href="/genres/suspense/">suspense</a> (3)</h2>
<ul>
  <li><a href="/books/and-then-there-were-none/">And then there were none</a></li>
  <li><a href="/books/death-on-the-nile/">Death on the nile</a></li>
  <li><a href="/books/jamaica-inn/">Jamaica inn</a></li>
</ul>
<h2><a href="/genres/romance/">romance</a> (2)</h2>
<ul>
  <li><a href="/books/jamaica-inn/">Jamaica inn</a></li>
  <li><a href="/books/pride-and-prejudice/">Pride and prejudice</a></li>
</ul>
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/taxonomy/Count.md
---


The `Count` method on a `Taxonomy` object returns the number of number of [weighted pages](g) to which the given [term](g) has been assigned.

{{% include "/_common/methods/taxonomy/get-a-taxonomy-object.md" %}}

## Count the weighted pages

Now that we have captured the `genres` `Taxonomy` object, let's count the number of weighted pages to which the `suspense` term has been assigned:

```go-html-template
{{ $taxonomyObject.Count "suspense" }} → 3
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/taxonomy/Get.md
---


The `Get` method on a `Taxonomy` object returns a slice of [weighted pages](g) to which the given [term](g) has been assigned.

{{% include "/_common/methods/taxonomy/get-a-taxonomy-object.md" %}}

## Get the weighted pages

Now that we have captured the `genres` `Taxonomy` object, let's get the weighted pages to which the `suspense` term has been assigned:

```go-html-template
{{ $weightedPages := $taxonomyObject.Get "suspense" }}
```

The above is equivalent to:

```go-html-template
{{ $weightedPages := $taxonomyObject.suspense }}
```

If the term is not a valid [identifier](g), you cannot use the [chaining](g) syntax. For example, this will throw an error because the identifier contains a hyphen:

```go-html-template
{{ $weightedPages := $taxonomyObject.my-genre }}
```

You could also use the [`index`][] function, but the syntax is more verbose:

```go-html-template
{{ $weightedPages := index $taxonomyObject "my-genre" }}
```

To inspect the data structure:

```go-html-template
<pre>{{ debug.Dump $weightedPages }}</pre>
```

## Example

With this template:

```go-html-template
{{ $weightedPages := $taxonomyObject.Get "suspense" }}
{{ range $weightedPages }}
  <h2><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></h2>
{{ end }}
```

Hugo renders:

```html
<h2><a href="/books/jamaica-inn/">Jamaica inn</a></h2>
<h2><a href="/books/death-on-the-nile/">Death on the nile</a></h2>
<h2><a href="/books/and-then-there-were-none/">And then there were none</a></h2>
```

[`index`]: /functions/collections/indexfunction/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/taxonomy/Page.md
---


This `TAXONOMY` method returns nil if the taxonomy has no terms, so you must code defensively:

```go-html-template
{{ with .Site.Taxonomies.tags.Page }}
  <a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a>
{{ end }}
```

This is rendered to:

```html
<a href="/tags/">Tags</a>
```

