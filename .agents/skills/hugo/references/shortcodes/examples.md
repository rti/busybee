## Examples

The `relref` shortcode typically provides the destination for a Markdown link.

> [!NOTE]
> Always use [Markdown notation][] notation when calling this shortcode.

The following examples show the rendered output for a page on the English version of the site:

```md
[Link A]({{%/* relref "/books/book-1" */%}})

[Link B]({{%/* relref path="/books/book-1" */%}})

[Link C]({{%/* relref path="/books/book-1" lang="de" */%}})

[Link D]({{%/* relref path="/books/book-1" lang="de" outputFormat="json" */%}})
```

Rendered:

```html
<a href="/en/books/book-1/">Link A</a>

<a href="/en/books/book-1/">Link B</a>

<a href="/de/books/book-1/">Link C</a>

<a href="/de/books/book-1/index.json">Link D</a>
```

