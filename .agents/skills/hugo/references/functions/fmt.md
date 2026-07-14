
---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/fmt/Errorf.md
---


{{% include "/_common/functions/fmt/format-string.md" %}}

The `errorf` function evaluates the format string, then prints the result to the ERROR log and fails the build.

```go-html-template
{{ errorf "The %q shortcode requires a src argument. See %s" .Name .Position }}
```

Use the [`erroridf`][] function to allow optional suppression of specific errors.

[`erroridf`]: /functions/fmt/erroridf/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/fmt/Erroridf.md
---


{{% include "/_common/functions/fmt/format-string.md" %}}

The `erroridf` function evaluates the format string, then prints the result to the ERROR log and fails the build. Unlike the [`errorf`][] function, you may suppress errors logged by the `erroridf` function by adding the message ID to the `ignoreLogs` array in your project configuration.

This template code:

```go-html-template
{{ erroridf "error-42" "You should consider fixing this." }}
```

Produces this console log:

```text
ERROR You should consider fixing this.
You can suppress this error by adding the following to your project configuration:
ignoreLogs = ['error-42']
```

To suppress this message:

{{< code-toggle file=hugo >}}
ignoreLogs = ["error-42"]
{{< /code-toggle >}}

[`errorf`]: /functions/fmt/errorf/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/fmt/Print.md
---


```go-html-template
{{ print "foo" }} → foo
{{ print "foo" "bar" }} → foobar
{{ print (slice 1 2 3) }} → [1 2 3]
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/fmt/Printf.md
---


{{% include "/_common/functions/fmt/format-string.md" %}}

```go-html-template
{{ $var := "world" }}
{{ printf "Hello %s." $var }} → Hello world.
```

```go-html-template
{{ $pi := 3.14159265 }}
{{ printf "Pi is approximately %.2f." $pi }} → 3.14
```

Use the `printf` function with the [`safe.HTMLAttr`] function:

```go-html-template
{{ $desc := "Eat at Joe's" }}
<meta name="description" {{ printf "content=%q" $desc | safeHTMLAttr }}>
```

Hugo renders this to:

```html
<meta name="description" content="Eat at Joe's">
```

[`safe.HTMLAttr`]: /functions/safe/htmlattr/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/fmt/Println.md
---


```go-html-template
{{ println "foo" }} → foo\n
{{ println "foo" "bar" }} → foo bar\n
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/fmt/Warnf.md
---


{{% include "/_common/functions/fmt/format-string.md" %}}

The `warnf` function evaluates the format string, then prints the result to the WARNING log. Hugo prints each unique message once to avoid flooding the log with duplicate warnings.

```go-html-template
{{ warnf "The %q shortcode was unable to find %s. See %s" .Name $file .Position }}
```

Use the [`warnidf`][] function to allow optional suppression of specific warnings.

To prevent suppression of duplicate messages when using `warnf` for debugging, make each message unique with the [`math.Counter`][] function. For example:

```go-html-template
{{ range site.RegularPages }}
  {{ .Section | warnf "%#[2]v [%[1]d]" math.Counter }}
{{ end }}
```

[`math.Counter`]: /functions/math/counter/
[`warnidf`]: /functions/fmt/warnidf/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/fmt/Warnidf.md
---


{{% include "/_common/functions/fmt/format-string.md" %}}

The `warnidf` function evaluates the format string, then prints the result to the WARNING log. Unlike the [`warnf`][] function, you may suppress warnings logged by the `warnidf` function by adding the message ID to the `ignoreLogs` array in your project configuration.

This template code:

```go-html-template
{{ warnidf "warning-42" "You should consider fixing this." }}
```

Produces this console log:

```text
WARN You should consider fixing this.
You can suppress this warning by adding the following to your project configuration:
ignoreLogs = ['warning-42']
```

To suppress this message:

{{< code-toggle file=hugo >}}
ignoreLogs = ["warning-42"]
{{< /code-toggle >}}

[`warnf`]: /functions/fmt/warnf/

