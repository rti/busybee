## Examples

To create a QR code using the default values for `level` and `scale`:

```go-html-template
{{ $text := "https://gohugo.io" }}
{{ with images.QR $text }}
  <img src="{{ .RelPermalink }}" width="{{ .Width }}" height="{{ .Height }}" alt="">
{{ end }}
```

{{< qr text="https://gohugo.io" class="qrcode" targetDir="images/qr" />}}

Specify `level`, `scale`, and `targetDir` as needed to achieve the desired result:

```go-html-template
{{ $text := "https://gohugo.io" }}
{{ $opts := dict
  "level" "high"
  "scale" 3
  "targetDir" "images/qr"
}}
{{ with images.QR $text $opts }}
  <img src="{{ .RelPermalink }}" width="{{ .Width }}" height="{{ .Height }}" alt="">
{{ end }}
```

{{< qr text="https://gohugo.io" level="high" scale=3 targetDir="codes" class="qrcode" targetDir="images/qr" />}}

To include a QR code that points to the `Permalink` of the current page:

```go-html-template {file="layouts/page.html"}
{{ with images.QR .Permalink }}
  <img
    src="{{ .RelPermalink }}"
    width="{{ .Width }}"
    height="{{ .Height }}"
    alt="QR code linking to {{ $.Permalink }}"
    class="qr-code"
    loading="lazy"
  >
{{ end }}
```

Then hide the QR code with CSS unless printing the page:

```css
/* Hide QR code by default */
.qr-code {
  display: none;
}

/* Show QR code when printing */
@media print {
  .qr-code {
    display: block;
  }
}
```

