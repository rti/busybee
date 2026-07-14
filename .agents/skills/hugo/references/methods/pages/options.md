## Options

`indices`
: (`slice`) The indices to search within.

`document`
: (`page`) The page for which to find related content. Required when specifying an options map.

`namedSlices`
: (`slice`) The keywords to search for, expressed as a slice of `KeyValues` using the [`keyVals`][] function.

`fragments`
: (`slice`) A list of special keywords that is used for indices configured as type "fragments". This will match the [fragment](g) identifiers of the documents.

A contrived example using all of the above:

```go-html-template
{{ $page := . }}
{{ $opts := dict
  "indices" (slice "tags" "keywords")
  "document" $page
  "namedSlices" (slice (keyVals "tags" "hugo" "rocks") (keyVals "date" $page.Date))
  "fragments" (slice "heading-1" "heading-2")
}}
```

[`keyVals`]: /functions/collections/keyvals/
[details]: /content-management/related-content/
[related content configuration]: /configuration/related-content/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/pages/Reverse.md
---


```go-html-template
{{ range .Pages.ByDate.Reverse }}
  <h2><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></h2>
{{ end }}
```

