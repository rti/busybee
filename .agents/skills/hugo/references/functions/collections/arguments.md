## Arguments

The where function takes three or four arguments. The `OPERATOR` argument is optional.

`SLICE`
: (`[]any`) A [page collection](g) or a [slice](g) of [maps](g).

`KEY`
: (`string`) The key of the page or map value to compare with `VALUE`. With page collections, commonly used comparison keys are `Section`, `Type`, and `Params`. To compare with a member of the page `Params` map, [chain](g) the subkey as shown below:

  ```go-html-template
  {{ $result := where .Site.RegularPages "Params.foo" "bar" }}
  ```

`OPERATOR`
: (`string`) The logical comparison [operator](#operators).

`VALUE`
: (`any`) The value with which to compare. The values to compare must have comparable data types. For example:

Comparison|Result
:--|:--
`"123" "eq" "123"`|`true`
`"123" "eq" 123`|`false`
`false "eq" "false"`|`false`
`false "eq" false`|`true`

When one or both of the values to compare is a slice, use the `in`, `not in`, or `intersect` operators as described below.

