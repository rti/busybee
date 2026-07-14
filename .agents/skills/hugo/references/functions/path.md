
---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/path/Base.md
---


```go-html-template
{{ path.Base "a/news.html" }} → news.html
{{ path.Base "news.html" }} → news.html
{{ path.Base "a/b/c" }} → c
{{ path.Base "/x/y/z/" }} → z
{{ path.Base "" }} → .
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/path/BaseName.md
---


```go-html-template
{{ path.BaseName "a/news.html" }} → news
{{ path.BaseName "news.html" }} → news
{{ path.BaseName "a/b/c" }} → c
{{ path.BaseName "/x/y/z/" }} → z
{{ path.BaseName "" }} → .
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/path/Clean.md
---


See Go's [`path.Clean`][] documentation for details.

```go-html-template
{{ path.Clean "foo/bar" }} → foo/bar
{{ path.Clean "/foo/bar" }} → /foo/bar
{{ path.Clean "/foo/bar/" }} → /foo/bar
{{ path.Clean "/foo//bar/" }} → /foo/bar
{{ path.Clean "/foo/./bar/" }} → /foo/bar
{{ path.Clean "/foo/../bar/" }} → /bar
{{ path.Clean "/../foo/../bar/" }} → /bar
{{ path.Clean "" }} → .
```

[`path.Clean`]: https://pkg.go.dev/path#Clean


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/path/Dir.md
---


```go-html-template
{{ path.Dir "a/news.html" }} → a
{{ path.Dir "news.html" }} → .
{{ path.Dir "a/b/c" }} → a/b
{{ path.Dir "/a/b/c" }} → /a/b
{{ path.Dir "/a/b/c/" }} → /a/b/c
{{ path.Dir "" }} → .
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/path/Ext.md
---


The extension is the suffix beginning at the final dot in the final slash-separated element of path; it is empty if there is no dot.

```go-html-template
{{ path.Ext "a/b/c/news.html" }} → .html
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/path/Join.md
---


See Go's [`path.Join`][] and [`path.Clean`][] documentation for details.

```go-html-template
{{ path.Join "partial" "news.html" }} → partial/news.html
{{ path.Join "partial/" "news.html" }} → partial/news.html
{{ path.Join "foo/bar" "baz" }} → foo/bar/baz
{{ path.Join "foo" "bar" "baz" }} → foo/bar/baz
{{ path.Join "foo" "" "baz" }} → foo/baz
{{ path.Join "foo" "." "baz" }} → foo/baz
{{ path.Join "foo" ".." "baz" }} → baz
{{ path.Join "/.." "foo" ".." "baz" }} → baz
```

[`path.Clean`]: https://pkg.go.dev/path#Clean
[`path.Join`]: https://pkg.go.dev/path#Join


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/path/Split.md
---


If there is no slash in the given path, `path.Split` returns an empty directory, and file set to path. The returned values have the property that path = dir+file.

```go-html-template
{{ $dirFile := path.Split "a/news.html" }}
{{ $dirFile.Dir }} → a/
{{ $dirFile.File }} → news.html

{{ $dirFile := path.Split "news.html" }}
{{ $dirFile.Dir }} → "" (empty string)
{{ $dirFile.File }} → news.html

{{ $dirFile := path.Split "a/b/c" }}
{{ $dirFile.Dir }} → a/b/
{{ $dirFile.File }} → c
```

