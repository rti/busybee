## Deprecated features

Use the [deprecated-in](#deprecated-in) shortcode to indicate that a feature is deprecated.

The deprecated-in shortcode will trigger a build warning if the specified version is older than a predefined threshold, based on differences in major and minor versions. This serves as a reminder to remove this shortcode call and the associated content. See [details][].

When deprecating a feature that has its own page, also set the `expiryDate` in front matter to two years from the date of deprecation. Include a brief comment to explain the setting:

```yaml
expiryDate: 2028-03-03 # deprecated 2026-03-03 in v0.157.0
```

