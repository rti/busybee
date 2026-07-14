## Code examples

With examples of template code:

- Indent with two spaces.
- Insert a space after an opening action delimiter.
- Insert a space before a closing action delimiter.
- Do not add white space removal syntax to action delimiters unless required. For example, inline elements like `img` and `a` require whitespace removal on both sides.

````md {file="content/example.md"}
```go-html-template
{{ if eq $foo $bar }}
  {{ fmt.Printf "%s is %s" $foo $bar }}
{{ end }}
```
````

### Fenced code blocks

The code block render hook performs several language substitutions:

Given language|Substitution|Reason
:--|:--|:--
`html`, `gotmpl`|`go-html-template`|Consistent rendering
`bash`, `ksh`, `sh`, `shell`, `zsh`|`text`|Avoid highlighting quirks
`md`, `mkd`|`text`|Avoid highlighting quirks
`tree`|`text`|There isn't a `tree` lexer

Set the language to `go-html-template` when including template examples:

````md {file="content/example.md"}
```go-html-template
{{ if eq $foo "bar" }}
  {{ print "foo is bar" }}
{{ end }}
```
````

Set the language to `md` when including Markdown examples:

````md {file="content/example.md"}
```md
This is **bold** text.
```
````

Set the language to `sh` when including command line examples:

````md {file="content/example.md"}
```sh
hugo server -D
```
````

Set the language to `tree` when documenting the output of the `tree` command:

````md {file="content/example.md"}
```tree
assets/
└── images/
    └── sunset.jpg
```
````

To include a file name header and copy-to-clipboard button:

````md {file="content/example.md"}
```go-html-template {file="layouts/_partials/foo.html" copy=true}
{{ if eq $foo "bar" }}
  {{ print "foo is bar" }}
{{ end }}
```
````

To wrap the code block within an initially-opened `details` element using a non-default summary:

````md {file="content/example.md"}
```go-html-template {details=true open=true summary="layouts/_partials/foo.html" copy=true}
{{ if eq $foo "bar" }}
  {{ print "foo is bar" }}
{{ end }}
```
````

Whitespace trimming is enabled by default. To override this behavior and preserve leading and trailing whitespace:

````md {file="content/example.md"}
```go-html-template {trim=false}

{{ if eq $foo "bar" }}
  {{ print "foo is bar" }}
{{ end }}

```
````

### Shortcode calls

Use this syntax to escape the call within examples:

```md {file="content/example.md"}
{{</*/* foo */*/>}}
{{%/*/* foo */*/%}}
```

### Project configuration

Use the [code-toggle shortcode](#code-toggle) to include project configuration examples:

```md {file="content/example.md"}
{{</* code-toggle file=hugo */>}}
baseURL = 'https://example.org/'
locale = 'en-US'
title = 'My Site'
{{</* /code-toggle */>}}
```

### Front matter

Use the [code-toggle shortcode](#code-toggle) to include front matter example, setting the `fm` attribute to `true`:

```md {file="content/example.md"}
{{</* code-toggle file=content/posts/my-first-post.md fm=true */>}}
title = 'My first post'
date = 2023-11-09T12:56:07-08:00
draft = false
{{</* /code-toggle */>}}
```

