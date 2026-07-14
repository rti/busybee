## Variables

A variable is a user-defined [identifier](g) prepended with a dollar sign (`$`), representing a value of any data type, initialized or assigned within a template action. For example, `$foo` and `$bar` are variables.

Variables may contain [scalars](g), [slices](g), [maps](g), or [objects](g).

Use `:=` to initialize a variable, and use `=` to assign a value to a variable that has been previously initialized. For example:

```go-html-template
{{ $total := 3 }}
{{ range slice 7 11 21 }}
  {{ $total = add $total . }}
{{ end }}
{{ $total }} → 42
```

Variables initialized inside of an `if`, `range`, or `with` block are scoped to the block. Variables initialized outside of these blocks are scoped to the template.

With variables that represent a slice or map, use the [`index`][] function to return the desired value.

```go-html-template
{{ $slice := slice "foo" "bar" "baz" }}
{{ index $slice 2 }} → baz

{{ $map := dict "a" "foo" "b" "bar" "c" "baz" }}
{{ index $map "c" }} → baz
```

> [!NOTE]
> Slices and arrays are zero-based; element 0 is the first element.

With variables that represent a map or object, [chain](g) identifiers to return the desired value or to access the desired method.

```go-html-template
{{ $map := dict "a" "foo" "b" "bar" "c" "baz" }}
{{ $map.c }} → baz

{{ $homePage := .Site.Home }}
{{ $homePage.Title }} → My Homepage
```

> [!NOTE]
> As seen above, object and method names are capitalized. Although not required, to avoid confusion we recommend beginning variable and map key names with a lowercase letter or underscore.

