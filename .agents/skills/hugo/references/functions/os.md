
---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/os/FileExists.md
---


The `os.FileExists` function attempts to resolve the path relative to the root of your project directory. If a matching file or directory is not found, it will attempt to resolve the path relative to the [`contentDir`][]. A leading path separator (`/`) is optional.

With this directory structure:

```tree
content/
├── about.md
├── contact.md
└── news/
    ├── article-1.md
    └── article-2.md
```

The function returns these values:

```go-html-template
{{ fileExists "content" }} → true
{{ fileExists "content/news" }} → true
{{ fileExists "content/news/article-1" }} → false
{{ fileExists "content/news/article-1.md" }} → true
{{ fileExists "news" }} → true
{{ fileExists "news/article-1" }} → false
{{ fileExists "news/article-1.md" }} → true
```

[`contentDir`]: /configuration/all/#contentdir


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/os/Getenv.md
---


## Security

By default, when using the `os.Getenv` function Hugo allows access to:

- The `CI` environment variable
- Any environment variable beginning with `HUGO_`

To access other environment variables, adjust your project configuration. For example, to allow access to the `HOME` and `USER` environment variables:

{{< code-toggle file=hugo >}}
[security.funcs]
getenv = ['^HUGO_', '^CI$', '^USER$', '^HOME$']
{{< /code-toggle >}}

For more information see [configure security][].

## Examples

```go-html-template
{{ getenv "HOME" }} → /home/victor
{{ getenv "USER" }} → victor
```

You can pass values when building your project:

```sh
MY_VAR1=foo MY_VAR2=bar hugo

OR

export MY_VAR1=foo
export MY_VAR2=bar
hugo
```

And then retrieve the values within a template:

```go-html-template
{{ getenv "MY_VAR1" }} → foo
{{ getenv "MY_VAR2" }} → bar
```

[configure security]: /configuration/security/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/os/ReadDir.md
---


The `os.ReadDir` function resolves the path relative to the root of your project directory. A leading path separator (`/`) is optional.

With this directory structure:

```tree
content/
├── about.md
├── contact.md
└── news/
    ├── article-1.md
    └── article-2.md
```

This template code:

```go-html-template
{{ range readDir "content" }}
  {{ .Name }} → {{ .IsDir }}
{{ end }}
```

Produces:

```html
about.md → false
contact.md → false
news → true
```

Note that `os.ReadDir` is not recursive.

Details of the `FileInfo` structure are available in the [Go documentation][].

[Go documentation]: https://pkg.go.dev/io/fs#FileInfo


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/os/ReadFile.md
---


The `os.ReadFile` function attempts to resolve the path relative to the root of your project directory. If a matching file is not found, it will attempt to resolve the path relative to the [`contentDir`][]. A leading path separator (`/`) is optional.

With a file named README.md in the root of your project directory:

```md
This is **bold** text.
```

This template code:

```go-html-template
{{ readFile "README.md" }}
```

Produces:

```html
This is **bold** text.
```

Note that `os.ReadFile` returns raw (uninterpreted) content.

[`contentDir`]: /configuration/all/#contentdir


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/os/Stat.md
---


The `os.Stat` function attempts to resolve the path relative to the root of your project directory. If a matching file or directory is not found, it will attempt to resolve the path relative to the [`contentDir`][]. A leading path separator (`/`) is optional.

```go-html-template
{{ $f := os.Stat "README.md" }}
{{ $f.IsDir }}    → false (bool)
{{ $f.ModTime }}  → 2021-11-25 10:06:49.315429236 -0800 PST (time.Time)
{{ $f.Name }}     → README.md (string)
{{ $f.Size }}     → 241 (int64)

{{ $d := os.Stat "content" }}
{{ $d.IsDir }}    → true (bool)
```

Details of the `FileInfo` structure are available in the [Go documentation][].

[Go documentation]: https://pkg.go.dev/io/fs#FileInfo
[`contentDir`]: /configuration/all/#contentdir

