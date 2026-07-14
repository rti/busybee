## Methods

Use these methods on the `Version` object.

`IsDefault`
: (`bool`) Reports whether this is the [default version](g).

  ```go-html-template
  {{ .Site.Version.IsDefault }} → true
  ```

`Name`
: (`string`) Returns the version name. This is the lowercased key from your project configuration.

  ```go-html-template
  {{ .Site.Version.Name }} → v1.0.0
  ```

