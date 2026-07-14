## Example

Without a safe declaration:

```go-html-template
{{ $href := "irc://irc.freenode.net/#golang" }}
<a href="{{ $href }}">IRC</a>
```

Hugo renders the above to:

```html
<a href="#ZgotmplZ">IRC</a>
```

> [!NOTE]
> `ZgotmplZ` is a special value that indicates that unsafe content reached a CSS or URL context at runtime.

To declare the string as safe:

```go-html-template
{{ $href := "irc://irc.freenode.net/#golang" }}
<a href="{{ $href | safeURL }}">IRC</a>
```

Hugo renders the above to:

```html
<a href="irc://irc.freenode.net/#golang">IRC</a>
```

[Go documentation]: https://pkg.go.dev/html/template#URL

