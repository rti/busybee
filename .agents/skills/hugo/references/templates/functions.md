## Functions

Used within a template action, a function takes one or more arguments and returns a value. Unlike methods, functions are not associated with an object.

Go's `text/template` and `html/template` packages provide a small set of functions, operators, and statements for general use. See the [go-templates][] section of the function documentation for details.

Hugo provides hundreds of custom [functions][] categorized by namespace. For example, the `strings` namespace includes these and other functions:

Function|Alias
:--|:--
[`strings.ToLower`][]|`lower`
[`strings.ToUpper`][]|`upper`
[`strings.Replace`][]|`replace`

As shown above, frequently used functions have an alias. Use aliases in your templates to reduce code length.

When calling a function, separate the arguments from the function, and from each other, with a space. For example:

```go-html-template
{{ $total := add 1 2 3 4 }}
```

