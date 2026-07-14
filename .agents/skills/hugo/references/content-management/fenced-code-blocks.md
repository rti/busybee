## Fenced code blocks

In its default configuration, Hugo highlights code examples within fenced code blocks, following this form:

````md {file="content/example.md"}
```LANG [OPTIONS]
CODE
```
````

`CODE`
: The code to highlight.

`LANG`
: The language of the code to highlight. Choose from one of the [supported languages](#languages). This value is case-insensitive. If omitted or unsupported, Hugo renders the text as a plain text block without syntax highlighting. Consistent with the [CommonMark][] specification, fenced code blocks require a known language identifier to trigger semantic syntax highlighting.

`OPTIONS`
: One or more space-separated or comma-separated key-value pairs wrapped in braces. Set default values for each option in your [project configuration][]. The key names are case-insensitive.

For example, with this Markdown:

````md {file="content/example.md"}
```go {linenos=inline hl_lines=[3,"6-8"] style=emacs}
package main

import "fmt"

func main() {
    for i := 0; i < 3; i++ {
        fmt.Println("Value of i:", i)
    }
}
```
````

Hugo renders this:

```go {linenos=inline, hl_lines=[3, "6-8"], style=emacs}
package main

import "fmt"

func main() {
    for i := 0; i < 3; i++ {
        fmt.Println("Value of i:", i)
    }
}
```

