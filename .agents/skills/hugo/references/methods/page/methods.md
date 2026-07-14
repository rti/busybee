## Methods

Use these methods on the `Sitemap` object.

`ChangeFreq`
: (`string`) How frequently a page is likely to change. Valid values are `always`, `hourly`, `daily`, `weekly`, `monthly`, `yearly`, and `never`. With the default value of `""` Hugo will omit this field from the sitemap. See [details][changefreqdef].

  ```go-html-template
  {{ .Sitemap.ChangeFreq }}
  ```

`Disable`
: (`bool`) Whether to disable page inclusion. Default is `false`. Set to `true` in front matter to exclude the page.

  ```go-html-template
  {{ .Sitemap.Disable }}
  ```

`Priority`
: (`float`) The priority of a page relative to any other page on the site. Valid values range from 0.0 to 1.0. With the default value of `-1` Hugo will omit this field from the sitemap. See [details][prioritydef].

  ```go-html-template
  {{ .Sitemap.Priority }}
  ```

