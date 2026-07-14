## Working with CSV

The examples below use this CSV file:

```csv
"name","type","breed","age"
"Spot","dog","Collie",3
"Rover","dog","Boxer",5
"Felix","cat","Calico",7
```

To render an HTML table from a CSV file:

```go-html-template
{{ $data := slice }}
{{ $file := "pets.csv" }}
{{ with or (.Resources.Get $file) (resources.Get $file) }}
  {{ $opts := dict "targetType" "slice" }}
  {{ $data = transform.Unmarshal $opts . }}
{{ end }}

{{ with $data }}
  <table>
    <thead>
      <tr>
        {{ range index . 0 }}
          <th>{{ . }}</th>
        {{ end }}
      </tr>
    </thead>
    <tbody>
      {{ range . | after 1 }}
        <tr>
          {{ range . }}
            <td>{{ . }}</td>
          {{ end }}
        </tr>
      {{ end }}
    </tbody>
  </table>
{{ end }}
```

To extract a subset of the data, or to sort the data, unmarshal to a map instead of a slice:

```go-html-template
{{ $data := dict }}
{{ $file := "pets.csv" }}
{{ with or (.Resources.Get $file) (resources.Get $file) }}
  {{ $opts := dict "targetType" "map" }}
  {{ $data = transform.Unmarshal $opts . }}
{{ end }}

{{ with sort (where $data "type" "dog") "name" "asc" }}
  <table>
    <thead>
      <tr>
        <th>name</th>
        <th>type</th>
        <th>breed</th>
        <th>age</th>
      </tr>
    </thead>
    <tbody>
      {{ range . }}
        <tr>
          <td>{{ .name }}</td>
          <td>{{ .type }}</td>
          <td>{{ .breed }}</td>
          <td>{{ .age }}</td>
        </tr>
      {{ end }}
    </tbody>
  </table>
{{ end }}
```

