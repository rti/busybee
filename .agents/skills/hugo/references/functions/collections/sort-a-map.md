## Sort a map

The examples below assume this project configuration:

{{< code-toggle file=hugo >}}
[params.authors.a]
firstName = 'Marius'
lastName  = 'Pontmercy'
[params.authors.b]
firstName = 'Victor'
lastName  = 'Hugo'
[params.authors.c]
firstName = 'Jean'
lastName  = 'Valjean'
{{< /code-toggle >}}

> [!NOTE]
> When sorting maps, the `KEY` argument must be lowercase.

### Ascending order {#map-ascending-order}

Sort map objects in ascending order using either of these constructs:

```go-html-template
{{ range sort site.Params.authors "firstname" }}
  {{ .firstName }}
{{ end }}

{{ range sort site.Params.authors "firstname" "asc" }}
  {{ .firstName }}
{{ end }}
```

These produce:

```text
Jean Marius Victor
```

### Descending order {#map-descending-order}

Sort map objects in descending order:

```go-html-template
{{ range sort site.Params.authors "firstname" "desc" }}
  {{ .firstName }}
{{ end }}
```

This produces:

```text
Victor Marius Jean
```

### First level key removal

Hugo removes the first level keys when sorting a map.

Original map:

```json
{
  "felix": {
    "breed": "malicious",
    "type": "cat"
  },
  "spot": {
    "breed": "boxer",
    "type": "dog"
  }
}
```

After sorting:

```json
[
  {
    "breed": "malicious",
    "type": "cat"
  },
  {
    "breed": "boxer",
    "type": "dog"
  }
]
```

