## Multilingual projects

With multilingual projects, the `GetPage` method on a `Site` object resolves the given path to a page in the current language.

To get a page from a different language, query the `Sites` object:

```go-html-template
{{ with where hugo.Sites "Language.Name" "eq" "de" }}
  {{ with index . 0 }}
    {{ with .GetPage "/works/paintings/starry-night" }}
      {{ .Title }} → Sternenklare Nacht
    {{ end }}
  {{ end }}
{{ end }}
```

