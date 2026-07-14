## Sort a slice

The examples below assume this project configuration:

{{< code-toggle file=hugo >}}
[params]
grades = ['b','a','c']
{{< /code-toggle >}}

### Ascending order {#slice-ascending-order}

Sort slice elements in ascending order using either of these constructs:

```go-html-template
{{ sort site.Params.grades }} → [a b c]
{{ sort site.Params.grades "value" "asc" }} → [a b c]
```

In the examples above, `value` is the `KEY` representing the value of the slice element.

### Descending order {#slice-descending-order}

Sort slice elements in descending order:

```go-html-template
{{ sort site.Params.grades "value" "desc" }} → [c b a]
```

In the example above, `value` is the `KEY` representing the value of the slice element.

