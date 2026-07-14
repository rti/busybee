## Garbage collection

As you modify your site or change your configuration, cached files from previous builds may remain on disk, consuming unnecessary space. Use the `hugo build --gc` command to remove these expired or unused entries from the file cache.

[`resources.GetRemote`]: /functions/resources/getremote/
[cachedir]: /configuration/all/#cachedir
[resourcedir]: /configuration/all/#resourcedir


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/configuration/cascade.md
---


You can configure your site to cascade front matter values to the home page and any of its descendants. However, this cascading will be prevented if the descendant already defines the field, or if a closer ancestor [branch](g) has already cascaded a value for the same field through its front matter's `cascade` key.

> [!NOTE]
> You can also configure cascading behavior within a page's front matter. See [details][].

For example, to cascade the `color` page parameter to all pages:

{{< code-toggle file=hugo >}}
[cascade.params]
color = 'red'
{{< /code-toggle >}}

