## Build

The `Build` method returns an object with the following structure:

- Groups (map)
  - [`Resources`][]

Each [`Resource`][] will be of media type `application/javascript` or `text/css`.

In a template you would typically handle one group with a given `ID` (e.g., scripts for the current section). Because of the concurrent build, this needs to be done in a [`templates.Defer`][] block:

> [!NOTE]
> The [`templates.Defer`][] acts as a synchronisation point to handle scripts added concurrently by different templates. If you have a setup with where the batch is created in one go (in one template), you don't need it.
>
> See [this discussion][] for more information.

```go-html-template
{{ $group := .group }}
{{ with (templates.Defer (dict "key" $group "data" $group )) }}
  {{ with (js.Batch "js/mybatch") }}
    {{ with .Build }}
      {{ with index .Groups $ }}
        {{ range . }}
          {{ $s := . }}
          {{ if eq $s.MediaType.SubType "css" }}
            <link href="{{ $s.RelPermalink }}" rel="stylesheet" />
          {{ else }}
            <script src="{{ $s.RelPermalink }}" type="module"></script>
          {{ end }}
        {{ end }}
      {{ end }}
  {{ end }}
{{ end }}
```

