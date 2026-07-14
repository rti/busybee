## Options examples

> [!NOTE]
> For brevity, the examples below do not include [error handling](#error-handling).

To include a header:

```go-html-template
{{ $url := "https://example.org/api" }}
{{ $opts := dict
  "headers" (dict "Authorization" "Bearer abcd")
}}
{{ $resource := resources.GetRemote $url $opts }}
```

To specify more than one value for the same header key, use a slice:

```go-html-template
{{ $url := "https://example.org/api" }}
{{ $opts := dict
  "headers" (dict "X-List" (slice "a" "b" "c"))
}}
{{ $resource := resources.GetRemote $url $opts }}
```

To post data:

```go-html-template
{{ $url := "https://example.org/api" }}
{{ $opts := dict
  "method" "post"
  "body" `{"complete": true}`
  "headers" (dict  "Content-Type" "application/json")
}}
{{ $resource := resources.GetRemote $url $opts }}
```

To override the default cache key:

```go-html-template
{{ $url := "https://example.org/images/a.jpg" }}
{{ $opts := dict
  "key" (print $url (now.Format "2006-01-02"))
}}
{{ $resource := resources.GetRemote $url $opts }}
```

To extract specific headers from the server's response:

```go-html-template
{{ $url := "https://example.org/images/a.jpg" }}
{{ $opts := dict
  "method" "HEAD"
  "responseHeaders" (slice "X-Frame-Options" "Server")
}}
{{ $resource := resources.GetRemote $url $opts }}
```

Use the `timeout` option to prevent slow external requests from stalling the build when fetching multiple remote feeds:

```go-html-template
{{ $url := "https://example.org/feed.rss" }}
{{ $opts := dict "timeout" "10s" }}
{{ with try (resources.GetRemote $url $opts) }}
  {{ with .Err }}
    {{ warnf "Failed to fetch feed: %s" . }}
  {{ else with .Value }}
    {{ $data = . | transform.Unmarshal }}
  {{ end }}
{{ end }}
```

