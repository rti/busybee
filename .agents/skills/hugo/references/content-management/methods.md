## Methods

Use these methods within a content adapter.

`AddPage`
: Adds a page to the site.

  ```go-html-template {file="content/books/_content.gotmpl"}
  {{ $content := dict
    "mediaType" "text/markdown"
    "value" "The _Hunchback of Notre Dame_ was written by Victor Hugo."
  }}
  {{ $page := dict
    "content" $content
    "kind" "page"
    "path" "the-hunchback-of-notre-dame"
    "title" "The Hunchback of Notre Dame"
  }}
  {{ .AddPage $page }}
  ```

`AddResource`
: Adds a page resource to the site.

  ```go-html-template {file="content/books/_content.gotmpl"}
  {{ with resources.Get "images/a.jpg" }}
    {{ $content := dict
      "mediaType" .MediaType.Type
      "value" .
    }}
    {{ $resource := dict
      "content" $content
      "path" "the-hunchback-of-notre-dame/cover.jpg"
    }}
    {{ $.AddResource $resource }}
  {{ end }}
  ```

  Then retrieve the new page resource with something like:

  ```go-html-template {file="layouts/page.html"}
  {{ with .Resources.Get "cover.jpg" }}
    <img src="{{ .RelPermalink }}" width="{{ .Width }}" height="{{ .Height }}" alt="">
  {{ end }}
  ```

`Site`
: (`Site`) Returns the site to which the pages will be added.

  ```go-html-template {file="content/books/_content.gotmpl"}
  {{ .Site.Title }}
  ```

  > [!NOTE]
  > The `Site` object is not fully initialized while Hugo executes a content adapter.
  > Methods that depend on built pages, such as `Site.Pages`, are unavailable at this stage and return an error.

`Store`
: (`maps.Scratch`) Returns a persistent data structure for storing and manipulating keyed values. The main use case for this is to transfer values between executions when [EnableAllLanguages](#enablealllanguages) is set. See [examples][].

  ```go-html-template {file="content/books/_content.gotmpl"}
  {{ .Store.Set "key" "value" }}
  {{ .Store.Get "key" }}
  ```

`EnableAllLanguages`
: By default, Hugo executes the content adapter only once for the first matching site in the [sites matrix](g). Use this method to expand execution to all languages while maintaining the current role and version.

  For more fine-grained control, define a `sites.matrix` in front matter or in a content mount.

  ```go-html-template {file="content/books/_content.gotmpl"}
  {{ .EnableAllLanguages }}
  {{ $content := dict
    "mediaType" "text/markdown"
    "value" "The _Hunchback of Notre Dame_ was written by Victor Hugo."
  }}
  {{ $page := dict
    "content" $content
    "kind" "page"
    "path" "the-hunchback-of-notre-dame"
    "title" "The Hunchback of Notre Dame"
  }}
  {{ .AddPage $page }}
  ```

`EnableAllDimensions`
: By default, Hugo executes the content adapter only once for the first matching site in the [sites matrix](g). Use this method to expand execution to every possible combination of language, version, and role.

  For more fine-grained control, define a `sites.matrix` in front matter or in a content mount.

