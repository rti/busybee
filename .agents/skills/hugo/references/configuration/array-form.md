## Array form

{{< new-in 0.161.0 />}}

Define an array of permalink entries to apply different URL patterns to different subsets of pages. Each entry requires a `pattern` key. Hugo applies the first matching pattern.

The optional `target` key accepts a [page matcher](g). If `target` is omitted, the pattern applies to all pages.

{{% include "/_common/configuration/page-matcher.md" %}}

For example, to apply language-specific URL patterns to the `articles` section page and its leaf pages separately:

{{< code-toggle file=hugo >}}
[[permalinks]]
  pattern = '/artikel/'
  [permalinks.target]
    path = '{/articles}'
    [permalinks.target.sites]
      [permalinks.target.sites.matrix]
        languages = ['de']
[[permalinks]]
  pattern = '/artikel/:year/:month/:slug/'
  [permalinks.target]
    path = '{/articles/**}'
    [permalinks.target.sites]
      [permalinks.target.sites.matrix]
        languages = ['de']
[[permalinks]]
  pattern = '/blog/'
  [permalinks.target]
    path = '{/articles}'
    [permalinks.target.sites]
      [permalinks.target.sites.matrix]
        languages = ['en']
[[permalinks]]
  pattern = '/blog/:year/:month/:slug/'
  [permalinks.target]
    path = '{/articles/**}'
    [permalinks.target.sites]
      [permalinks.target.sites.matrix]
        languages = ['en']
{{< /code-toggle >}}

To define a fallback that matches any page not already matched by a preceding entry, place a pattern without a `target` key at the end:

{{< code-toggle file=hugo >}}
[[permalinks]]
pattern = '/:section/:slug/'
{{< /code-toggle >}}

