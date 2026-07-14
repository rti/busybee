## In a taxonomy template

Use these methods on the `Data` object within a _taxonomy_ template.

`Singular`
: (`string`) Returns the singular name of the taxonomy.

```go-html-template
{{ .Data.Singular }} → genre
```

`Plural`
: (`string`) Returns the plural name of the taxonomy.

```go-html-template
{{ .Data.Plural }} → genres
```

`Terms`
: (`page.Taxonomy`) Returns the `Taxonomy` object, consisting of a map of terms and the [weighted pages](g) associated with each term.

```go-html-template
{{ $taxonomyObject := .Data.Terms }}
```

> [!NOTE]
> Once you have captured the `Taxonomy` object, use any of the [taxonomy methods][] to sort, count, or capture a subset of its weighted pages.

Learn more about [taxonomy templates][].

