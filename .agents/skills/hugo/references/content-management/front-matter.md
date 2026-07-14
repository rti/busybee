## Front matter

### `slug`

Set the `slug` in front matter to override the last segment of the path. This front matter field is not applicable to `home`, `section`, `taxonomy`, or `term` pages.

{{< code-toggle file=content/posts/post-1.md fm=true >}}
title = 'My First Post'
slug = 'my-first-post'
{{< /code-toggle >}}

The resulting URL will be:

```text
https://example.org/posts/my-first-post/
```

### `url`

Set the `url` in front matter to override the entire path. Use this with either regular pages or section pages.

> [!NOTE]
> Hugo does not sanitize the `url` front matter field, allowing you to generate:
>
> - File paths that contain characters reserved by the operating system. For example, file paths on Windows may not contain any of these [reserved characters][]. Hugo throws an error if a file path includes a character reserved by the current operating system.
> - URLs that contain disallowed characters. For example, the less than sign (`<`) is not allowed in a URL.

If you set both `slug` and `url` in front matter, the `url` value takes precedence.

#### Include a colon

{{< new-in 0.136.0 />}}

If you need to include a colon in the  `url` front matter field, escape it with backslash characters. Use one backslash if you wrap the string within single quotes, or use two backslashes if you wrap the string within double quotes. With YAML front matter, use a single backslash if you omit quotation marks.

For example, with this front matter:

{{< code-toggle file=content/example.md fm=true >}}
title: Example
url: "my\\:example"
{{< /code-toggle >}}

The resulting URL will be:

```text
https://example.org/my:example/
```

As described above, this will fail on Windows because the colon (`:`) is a reserved character.

#### File extensions

With this front matter:

{{< code-toggle file=content/posts/post-1.md fm=true >}}
title = 'My First Article'
url = 'articles/my-first-article'
{{< /code-toggle >}}

The resulting URL will be:

```text
https://example.org/articles/my-first-article/
```

If you include a file extension:

{{< code-toggle file=content/posts/post-1.md fm=true >}}
title = 'My First Article'
url = 'articles/my-first-article.html'
{{< /code-toggle >}}

The resulting URL will be:

```text
https://example.org/articles/my-first-article.html
```

#### Leading slashes

With monolingual projects, `url` values with or without a leading slash are relative to the [`baseURL`][]. With multilingual projects, `url` values with a leading slash are relative to the `baseURL`, and  `url` values without a leading slash are relative to the `baseURL` plus the language prefix.

Site type|Front matter `url`|Resulting URL
:--|:--|:--
monolingual|`/about`|`https://example.org/about/`
monolingual|`about`|`https://example.org/about/`
multilingual|`/about`|`https://example.org/about/`
multilingual|`about`|`https://example.org/de/about/`

#### Tokens

You can also use tokens when setting the `url` value. This is typically used in `cascade` sections:

{{< code-toggle file=content/foo/bar/_index.md fm=true >}}
title ='Bar'
[[cascade]]
  url = '/:sections[last]/:slug'
{{< /code-toggle >}}

Use any of these tokens:

{{% include "/_common/permalink-tokens.md" %}}

