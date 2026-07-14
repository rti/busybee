## Segment definition

Each segment is defined by an `includes` key and an `excludes` key, both of which accept an array of filters.

A _filter_ is a collection of one or more conditions, represented as an item in the configuration array. A _condition_ compares a specific page [field](#fields) to a given [glob pattern](g).

### Evaluation rules

The evaluation logic adheres to three rules:

- All conditions within a single filter item must match for that filter to evaluate as true, creating an AND relationship.
- If the `includes` or `excludes` array contains multiple filters, only one filter needs to evaluate as true for the entire array to match, creating an OR relationship.
- The `excludes` array takes absolute precedence. If a page matches any filter in the `excludes` array, Hugo omits it from the segment regardless of whether it matches the `includes` array.

### Performance optimization

Using the `excludes` array to target sites or output formats allows Hugo to skip entire groups of pages during evaluation instead of checking every page. This optimization helps with performance in larger setups.

For example, excluding unwanted output formats is faster:

{{< code-toggle file=hugo >}}
[segments]
  [segments.segment1]
    [[segments.segment1.excludes]]
      output = '! json'
{{< /code-toggle >}}

Including only the desired output format is slower:

{{< code-toggle file=hugo >}}
[segments]
  [segments.segment1]
    [[segments.segment1.includes]]
      output = 'json'
{{< /code-toggle >}}

