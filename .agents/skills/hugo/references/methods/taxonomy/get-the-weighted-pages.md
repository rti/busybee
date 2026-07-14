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

