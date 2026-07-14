## Context

The most important concept to understand before creating a template is _context_, the data passed into each template. The data may be a simple value, or more commonly [objects](g) and associated [methods](g).

For example, a _page_ template receives a `Page` object, and the `Page` object provides methods to return values or perform actions.

### Current context

Within a template, the dot (`.`) represents the current context.

```go-html-template {file="layouts/page.html"}
<h2>{{ .Title }}</h2>
```

In the example above the dot represents the `Page` object, and we call its [`Title`][] method to return the title as defined in [front matter][].

The current context may change within a template. For example, at the top of a template the context might be a `Page` object, but we rebind the context to another value or object within [`range`][] or [`with`][] blocks.

```go-html-template {file="layouts/page.html"}
<h2>{{ .Title }}</h2>

{{ range slice "foo" "bar" }}
  <p>{{ . }}</p>
{{ end }}

{{ with "baz" }}
  <p>{{ . }}</p>
{{ end }}
```

In the example above, the context changes as we `range` through the [slice](g) of values. In the first iteration the context is "foo", and in the second iteration the context is "bar". Inside of the `with` block the context is "baz". Hugo renders the above to:

```html
<h2>My Page Title</h2>
<p>foo</p>
<p>bar</p>
<p>baz</p>
```

### Template context

Within a `range` or `with` block you can access the context passed into the template by prepending a dollar sign (`$`) to the dot:

```go-html-template {file="layouts/page.html"}
{{ with "foo" }}
  <p>{{ $.Title }} - {{ . }}</p>
{{ end }}
```

Hugo renders this to:

```html
<p>My Page Title - foo</p>
```

> [!NOTE]
> Make sure that you thoroughly understand the concept of _context_ before you continue reading. The most common templating errors made by new users relate to context.

