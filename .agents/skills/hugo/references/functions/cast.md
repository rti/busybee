
---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/cast/ToFloat.md
---


With a decimal (base 10) input:

```go-html-template
{{ float 11 }} → 11 (float64)
{{ float "11" }} → 11 (float64)

{{ float 11.1 }} → 11.1 (float64)
{{ float "11.1" }} → 11.1 (float64)

{{ float 11.9 }} → 11.9 (float64)
{{ float "11.9" }} → 11.9 (float64)
```

With a binary (base 2) input:

```go-html-template
{{ float 0b11 }} → 3 (float64)
```

With an octal (base 8) input (use either notation):

```go-html-template
{{ float 011 }} → 9 (float64)
{{ float "011" }} → 11 (float64)

{{ float 0o11 }} → 9 (float64)
```

With a hexadecimal (base 16) input:

```go-html-template
{{ float 0x11 }} → 17 (float64)
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/cast/ToInt.md
---


With a decimal (base 10) input:

```go-html-template
{{ int 11 }} → 11 (int)
{{ int "11" }} → 11 (int)

{{ int 11.1 }} → 11 (int)
{{ int 11.9 }} → 11 (int)
```

With a binary (base 2) input:

```go-html-template
{{ int 0b11 }} → 3 (int)
{{ int "0b11" }} → 3 (int)
```

With an octal (base 8) input (use either notation):

```go-html-template
{{ int 011 }} → 9 (int)
{{ int "011" }} → 9 (int)

{{ int 0o11 }} → 9 (int)
{{ int "0o11" }} → 9 (int)
```

With a hexadecimal (base 16) input:

```go-html-template
{{ int 0x11 }} → 17 (int)
{{ int "0x11" }} → 17 (int)
```

> [!NOTE]
> Values with a leading zero are octal (base 8). When casting a string representation of a decimal (base 10) number, remove leading zeros:

`{{ strings.TrimLeft "0" "0011" | int }} → 11`


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/cast/ToString.md
---


With a decimal (base 10) input:

```go-html-template
{{ string 11 }} → 11 (string)
{{ string "11" }} → 11 (string)

{{ string 11.1 }} → 11.1 (string)
{{ string "11.1" }} → 11.1 (string)

{{ string 11.9 }} → 11.9 (string)
{{ string "11.9" }} → 11.9 (string)
```

With a binary (base 2) input:

```go-html-template
{{ string 0b11 }} → 3 (string)
{{ string "0b11" }} → 0b11 (string)
```

With an octal (base 8) input (use either notation):

```go-html-template
{{ string 011 }} → 9 (string)
{{ string "011" }} → 011 (string)

{{ string 0o11 }} → 9 (string)
{{ string "0o11" }} → 0o11 (string)
```

With a hexadecimal (base 16) input:

```go-html-template
{{ string 0x11 }} → 17 (string)
{{ string "0x11" }} → 0x11 (string)
```

