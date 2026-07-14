## Unmarshal a resource

Use the `transform.Unmarshal` function with global, page, and remote resources.

### Global resource

A global resource is a file within the `assets` directory, or within any directory mounted to the `assets` directory.

```tree
assets/
└── data/
    └── books.json
```

```go-html-template
{{ $data := dict }}
{{ $path := "data/books.json" }}
{{ with resources.Get $path }}
  {{ with . | transform.Unmarshal }}
    {{ $data = . }}
  {{ end }}
{{ else }}
  {{ errorf "Unable to get global resource %q" $path }}
{{ end }}

{{ range where $data "author" "Victor Hugo" }}
  {{ .title }} → Les Misérables
{{ end }}
```

### Page resource

A page resource is a file within a [page bundle][].

```tree
content/
├── post/
│   └── book-reviews/
│       ├── books.json
│       └── index.md
└── _index.md
```

```go-html-template
{{ $data := dict }}
{{ $path := "books.json" }}
{{ with .Resources.Get $path }}
  {{ with . | transform.Unmarshal }}
    {{ $data = . }}
  {{ end }}
{{ else }}
  {{ errorf "Unable to get page resource %q" $path }}
{{ end }}

{{ range where $data "author" "Victor Hugo" }}
  {{ .title }} → Les Misérables
{{ end }}
```

### Remote resource

A remote resource is a file on a remote server, accessible via HTTP or HTTPS.

```go-html-template
{{ $data := dict }}
{{ $url := "https://example.org/books.json" }}
{{ with try (resources.GetRemote $url) }}
  {{ with .Err }}
    {{ errorf "%s" . }}
  {{ else with .Value }}
    {{ $data = . | transform.Unmarshal }}
  {{ else }}
    {{ errorf "Unable to get remote resource %q" $url }}
  {{ end }}
{{ end }}

{{ range where $data "author" "Victor Hugo" }}
  {{ .title }} → Les Misérables
{{ end }}
```

> [!NOTE]
> When retrieving remote data, a misconfigured server may send a response header with an incorrect [Content-Type][]. For example, the server may set the Content-Type header to `application/octet-stream` instead of `application/json`.
>
> In these cases, pass the resource `Content` through the `transform.Unmarshal` function instead of passing the resource itself. For example, in the above, do this instead:
>
> `{{ $data = .Content | transform.Unmarshal }}`

