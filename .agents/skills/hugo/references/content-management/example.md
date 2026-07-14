## Example

Create pages from remote data, where each page represents a book review.

Step 1
: Create the content structure.

  ```tree
  content/
  └── books/
      ├── _content.gotmpl  <-- content adapter
      └── _index.md
  ```

Step 2
: Inspect the remote data to determine how to map key-value pairs to front matter fields.\
  <https://gohugo.io/shared/examples/data/books.json>

Step 3
: Create the content adapter.

  ```go-html-template {file="content/books/_content.gotmpl" copy=true}
  {{/* Get remote data. */}}
  {{ $data := dict }}
  {{ $url := "https://gohugo.io/shared/examples/data/books.json" }}
  {{ with try (resources.GetRemote $url) }}
    {{ with .Err }}
      {{ errorf "Unable to get remote resource %s: %s" $url . }}
    {{ else with .Value }}
      {{ $data = . | transform.Unmarshal }}
    {{ else }}
      {{ errorf "Unable to get remote resource %s" $url }}
    {{ end }}
  {{ end }}

  {{/* Add pages and page resources. */}}
  {{ range $data }}

    {{/* Add page. */}}
    {{ $content := dict "mediaType" "text/markdown" "value" .summary }}
    {{ $dates := dict "date" (time.AsTime .date) }}
    {{ $params := dict "author" .author "isbn" .isbn "rating" .rating "tags" .tags }}
    {{ $page := dict
      "content" $content
      "dates" $dates
      "kind" "page"
      "params" $params
      "path" .title
      "title" .title
    }}
    {{ $.AddPage $page }}

    {{/* Add page resource. */}}
    {{ $item := . }}
    {{ with $url := $item.cover }}
      {{ with try (resources.GetRemote $url) }}
        {{ with .Err }}
          {{ errorf "Unable to get remote resource %s: %s" $url . }}
        {{ else with .Value }}
          {{ $content := dict "mediaType" .MediaType.Type "value" .Content }}
          {{ $params := dict "alt" $item.title }}
          {{ $resource := dict
            "content" $content
            "params" $params
            "path" (printf "%s/cover.%s" $item.title .MediaType.SubType)
          }}
          {{ $.AddResource $resource }}
        {{ else }}
          {{ errorf "Unable to get remote resource %s" $url }}
        {{ end }}
      {{ end }}
    {{ end }}

  {{ end }}
  ```

Step 4
: Create a _page_ template to render each book review.

  ```go-html-template {file="layouts/books/page.html" copy=true}
  {{ define "main" }}
    <h1>{{ .Title }}</h1>

    {{ with .Resources.GetMatch "cover.*" }}
      <img src="{{ .RelPermalink }}" width="{{ .Width }}" height="{{ .Height }}" alt="{{ .Params.alt }}">
    {{ end }}

    <p>Author: {{ .Params.author }}</p>

    <p>
      ISBN: {{ .Params.isbn }}<br>
      Rating: {{ .Params.rating }}<br>
      Review date: {{ .Date | time.Format ":date_long" }}
    </p>

    {{ with .GetTerms "tags" }}
      <p>Tags:</p>
      <ul>
        {{ range . }}
          <li><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></li>
        {{ end }}
      </ul>
    {{ end }}

    {{ .Content }}
  {{ end }}
  ```

