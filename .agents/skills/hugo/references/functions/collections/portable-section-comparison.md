## Portable section comparison

Useful for theme authors, avoid hardcoding section names by using the `where` function with the [`MainSections`][] method on a `Site` object.

```go-html-template
{{ $pages := where .Site.RegularPages "Section" "in" .Site.MainSections }}
```

With this construct, a theme author can instruct users to specify their main sections in their project configuration:

{{< code-toggle file=hugo >}}
mainSections = ['blog','galleries']
{{< /code-toggle >}}

If `mainSections` is not defined in your project configuration, the `MainSections` method returns a slice with one element---the top-level section with the most pages.

