## Actions

In the examples above, the paired opening and closing braces represent the beginning and end of a template action, a data evaluation or control structure within a template.

A template action may contain literal values ([boolean](g), [string](g), [integer](g), and [float](g)), the [current context](#current-context), [variables](#variables), [functions](#functions), [methods](#methods), and the [`nil`](#nil) keyword.

```go-html-template {file="layouts/page.html"}
{{ $convertToLower := true }}
{{ if $convertToLower }}
  <h2>{{ strings.ToLower .Title }}</h2>
{{ end }}
```

In the example above:

- `$convertToLower` is a variable
- `true` is a literal boolean value
- `if` is the beginning of a control structure
- `strings.ToLower` is a function that converts all characters to lowercase
- `Title` is a method on a the `Page` object
- `end` is the end of a control structure

Hugo renders the above to:

```html {trim=false}

    <h2>my page title</h2>

```

### Whitespace

Notice the blank lines and indentation in the previous example? Although irrelevant in production when you typically minify the output, you can remove the adjacent whitespace by using template action delimiters with hyphens:

```go-html-template {file="layouts/page.html"}
{{- $convertToLower := true -}}
{{- if $convertToLower -}}
  <h2>{{ strings.ToLower .Title }}</h2>
{{- end -}}
```

Hugo renders this to:

```html
<h2>my page title</h2>
```

Whitespace includes spaces, horizontal tabs, carriage returns, and newlines.

### Quote characters

Hugo templates use different quote characters to define how text and characters are processed.

Use double quotes for [interpreted string literals](g). These interpret backslashes as special instructions:

```go-html-template
{{ print "Hello world\u0021" }} → Hello world!
```

Use backticks for [raw string literals](g). These ignore backslashes and treat every character literally:

```go-html-template
{{ print `Hello world\u0021` }} → Hello world\u0021
```

Use single quotes for [rune literals](g). Unlike strings, these represent a single character as its numerical Unicode value:

```go-html-template
{{ print '!' }} → 33
```

In practical terms, you will rarely, if ever, use rune literals in your template code. They are most commonly used in low-level programming; in a Hugo template, you will almost always want a string instead.

### Pipes

Within a template action you may [pipe](g) a value to a function or method. The piped value becomes the final argument to the function or method. For example, these are equivalent:

```go-html-template
{{ strings.ToLower "Hugo" }} → hugo
{{ "Hugo" | strings.ToLower }} → hugo
```

You can pipe the result of one function or method into another. For example, these are equivalent:

```go-html-template
{{ strings.TrimSuffix "o" (strings.ToLower "Hugo") }} → hug
{{ "Hugo" | strings.ToLower | strings.TrimSuffix "o" }} → hug
```

These are also equivalent:

```go-html-template
{{ mul 6 (add 2 5) }} → 42
{{ 5 | add 2 | mul 6 }} → 42
```

> [!NOTE]
> Remember that the piped value becomes the final argument to the function or method to which you are piping.

### Line splitting

You can split a template action over two or more lines. For example, these are equivalent:

```go-html-template
{{ $v := or $arg1 $arg2 }}

{{ $v := or
  $arg1
  $arg2
}}
```

You can also split [raw string literals](g) over two or more lines. For example, these are equivalent:

```go-html-template
{{ $msg := "This is line one.\nThis is line two." }}

{{ $msg := `This is line one.
This is line two.`
}}
```

### Nil

Other than using the `nil` keyword in comparisons, you may not use it as an argument to any function or method, nor may you assign it to a variable. For example, these are valid uses of the `nil` keyword:

```go-html-template
{{ if gt 42 nil }}
  <p>42 is greater than nil</p>
{{ end }}

{{ $pages := where .Site.RegularPages "Params.color" "ne" nil }}
```

These, on the other hand, are invalid:

```go-html-template
{{ $a := nil }}
{{ add 3 nil }}
{{ nil | print}}
```

The actions above throw an error.

