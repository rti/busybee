## Sorting

As a contrived example, create a table of an image's dominant colors with the most dominant color first, and display the relative luminance of each dominant color:

```go-html-template
{{ with resources.Get "images/a.jpg" }}
  <table>
    <thead>
      <tr>
        <th>Color</th>
        <th>Relative luminance</th>
      </tr>
    </thead>
    <tbody>
      {{ range .Colors }}
        <tr>
          <td>{{ .ColorHex }}</td>
          <td>{{ .Luminance | lang.FormatNumber 4 }}</td>
        </tr>
      {{ end }}
    </tbody>
  </table>
{{ end }}
```

Hugo renders this to:

ColorHex|Relative luminance
:--|:--
`#bebebd`|`0.5145`
`#514947`|`0.0697`
`#768a9a`|`0.2436`
`#647789`|`0.1771`
`#90725e`|`0.1877`
`#a48974`|`0.2704`

To sort by dominance with the least dominant color first:

```go-html-template
{{ range .Colors | collections.Reverse }}
```

To sort by relative luminance with the darkest color first:

```go-html-template
{{ range sort .Colors "Luminance" }}
```

To sort by relative luminance with the lightest color first, use either of these constructs:

```go-html-template
{{ range sort .Colors "Luminance" | collections.Reverse }}
{{ range sort .Colors "Luminance" "desc" }}
```

