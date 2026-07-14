## Remote data

When retrieving remote data, use the [`transform.Unmarshal`][] function to [unmarshal](g) the response.

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
```

> [!NOTE]
> When retrieving remote data, a misconfigured server may send a response header with an incorrect [Content-Type][]. For example, the server may set the Content-Type header to `application/octet-stream` instead of `application/json`.
>
> In these cases, pass the resource `Content` through the `transform.Unmarshal` function instead of passing the resource itself. For example, in the above, do this instead:
>
> `{{ $data = .Content | transform.Unmarshal }}`

