## Comments

> [!NOTE]
> Do not attempt to use HTML comment delimiters to comment out template code.
>
> Hugo strips HTML comments when rendering a page, but first evaluates any template code within the HTML comment delimiters. Depending on the template code within the HTML comment delimiters, this could cause unexpected results or fail the build.

Template comments are similar to template actions. Paired opening and closing braces represent the beginning and end of a comment. For example:

```go-html-template
{{/* This is an inline comment. */}}
{{- /* This is an inline comment with adjacent whitespace removed. */ -}}
```

Code within a comment is not parsed, executed, or displayed. Comments may be inline, as shown above, or in block form:

```go-html-template
{{/*
This is a block comment.
*/}}

{{- /*
This is a block comment with
adjacent whitespace removed.
*/ -}}
```

You may not nest one comment inside of another.

To render an HTML comment, pass a string through the [`safe.HTML`][] function. For example:

```go-html-template
{{ "<!-- I am an HTML comment. -->" | safeHTML }}
{{ printf "<!-- This is the %s site. -->" .Site.Title | safeHTML }}
```

