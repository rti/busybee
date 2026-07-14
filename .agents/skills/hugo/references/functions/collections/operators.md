## Operators

Use any of the following logical operators:

`=`, `==`, `eq`
: (`bool`) Reports whether the given field value is equal to `VALUE`.

`!=`, `<>`, `ne`
: (`bool`) Reports whether the given field value is not equal to `VALUE`.

`>=`, `ge`
: (`bool`) Reports whether the given field value is greater than or equal to `VALUE`.

`>`, `gt`
: `true` Reports whether the given field value is greater than `VALUE`.

`<=`, `le`
: (`bool`) Reports whether the given field value is less than or equal to `VALUE`.

`<`, `lt`
: (`bool`) Reports whether the given field value is less than `VALUE`.

`in`
: (`bool`) Reports whether the given field value is a member of `VALUE`. Compare string to slice, or string to string.

`not in`
: (`bool`) Reports whether the given field value is not a member of `VALUE`. Compare string to slice, or string to string.
`intersect`
: (`bool`) Reports whether the given field value (a slice) contains one or more elements in common with `VALUE`.

`like`
: (`bool`) Reports whether the given field value matches the [regular expression](g) specified in `VALUE`. Use the `like` operator to compare `string` values. The `like` operator returns `false` when comparing other data types to the regular expression.

> [!NOTE]
> The examples below perform comparisons within a page collection, but the same comparisons are applicable to a slice of maps.

