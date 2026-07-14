# menu-entry


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/menu-entry/Children.md
---


Use the `Children` method when rendering a nested menu.

With this project configuration:

{{< code-toggle file=hugo >}}
[[menus.main]]
name = 'Products'
pageRef = '/product'
weight = 10

[[menus.main]]
name = 'Product 1'
pageRef = '/products/product-1'
parent = 'Products'
weight = 1

[[menus.main]]
name = 'Product 2'
pageRef = '/products/product-2'
parent = 'Products'
weight = 2
{{< /code-toggle >}}

And this template:

```go-html-template
<ul>
  {{ range .Site.Menus.main }}
    <li>
      <a href="{{ .URL }}">{{ .Name }}</a>
      {{ if .HasChildren }}
        <ul>
          {{ range .Children }}
            <li><a href="{{ .URL }}">{{ .Name }}</a></li>
          {{ end }}
        </ul>
      {{ end }}
    </li>
  {{ end }}
</ul>
```

Hugo renders this HTML:

```html
<ul>
  <li>
    <a href="/products/">Products</a>
    <ul>
      <li><a href="/products/product-1/">Product 1</a></li>
      <li><a href="/products/product-2/">Product 2</a></li>
    </ul>
  </li>
</ul>
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/menu-entry/HasChildren.md
---


Use the `HasChildren` method when rendering a nested menu.

With this project configuration:

{{< code-toggle file=hugo >}}
[[menus.main]]
name = 'Products'
pageRef = '/product'
weight = 10

[[menus.main]]
name = 'Product 1'
pageRef = '/products/product-1'
parent = 'Products'
weight = 1

[[menus.main]]
name = 'Product 2'
pageRef = '/products/product-2'
parent = 'Products'
weight = 2
{{< /code-toggle >}}

And this template:

```go-html-template
<ul>
  {{ range .Site.Menus.main }}
    <li>
      <a href="{{ .URL }}">{{ .Name }}</a>
      {{ if .HasChildren }}
        <ul>
          {{ range .Children }}
            <li><a href="{{ .URL }}">{{ .Name }}</a></li>
          {{ end }}
        </ul>
      {{ end }}
    </li>
  {{ end }}
</ul>
```

Hugo renders this HTML:

```html
<ul>
  <li>
    <a href="/products/">Products</a>
    <ul>
      <li><a href="/products/product-1/">Product 1</a></li>
      <li><a href="/products/product-2/">Product 2</a></li>
    </ul>
  </li>
</ul>
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/menu-entry/Identifier.md
---


The `Identifier` method returns the `identifier` property of the menu entry. If you define the menu entry [automatically][], it returns the page's section.

{{< code-toggle file=hugo >}}
[[menus.main]]
identifier = 'about'
name = 'About'
pageRef = '/about'
weight = 10

[[menus.main]]
identifier = 'contact'
name = 'Contact'
pageRef = '/contact'
weight = 20
{{< /code-toggle >}}

This example uses the `Identifier` method when querying the translation table on a multilingual project, falling back the `name` property if a matching key in the translation table does not exist:

```go-html-template
<ul>
  {{ range .Site.Menus.main }}
    <li><a href="{{ .URL }}">{{ or (T .Identifier) .Name }}</a></li>
  {{ end }}
</ul>
```

> [!NOTE]
> In the menu definition above, note that the `identifier` property is only required when two or more menu entries have the same name, or when localizing the name using translation tables.

[automatically]: /content-management/menus/#define-automatically


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/menu-entry/KeyName.md
---


In this menu definition, the second entry does not contain an `identifier`, so the `Identifier` method returns its `name` property instead:

{{< code-toggle file=hugo >}}
[[menus.main]]
identifier = 'about'
name = 'About'
pageRef = '/about'
weight = 10

[[menus.main]]
name = 'Contact'
pageRef = '/contact'
weight = 20
{{< /code-toggle >}}

This example uses the `KeyName` method when querying the translation table on a multilingual project, falling back the `name` property if a matching key in the translation table does not exist:

```go-html-template
<ul>
  {{ range .Site.Menus.main }}
    <li><a href="{{ .URL }}">{{ or (T (.KeyName | lower)) .Name }}</a></li>
  {{ end }}
</ul>
```

In the example above, we need to pass the value returned by `.KeyName` through the [`strings.ToLower`][] function because the keys in the translation table are lowercase.

[`strings.ToLower`]: /functions/strings/tolower/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/menu-entry/Menu.md
---


```go-html-template
{{ range .Site.Menus.main }}
  {{ .Menu }} → main
{{ end }}
```

Use this method with the [`IsMenuCurrent`][] and [`HasMenuCurrent`][] methods on a `Page` object to set "active" and "ancestor" classes on a rendered entry. See [this example][].

[`HasMenuCurrent`]: /methods/page/hasmenucurrent/
[`IsMenuCurrent`]: /methods/page/ismenucurrent/
[this example]: /templates/menu/#example


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/menu-entry/Name.md
---


If you define the menu entry [automatically][], the `Name` method returns the page's [`LinkTitle`][], falling back to its [`Title`][].

If you define the menu entry in [front matter][] or in your [project configuration][], the `Name` method returns the `name` property of the given menu entry. If the `name` is not defined, and the menu entry resolves to a page, the `Name` returns the page [`LinkTitle`][], falling back to its [`Title`][].

```go-html-template
<ul>
  {{ range .Site.Menus.main }}
    <li><a href="{{ .URL }}">{{ .Name }}</a></li>
  {{ end }}
</ul>
```

[`LinkTitle`]: /methods/page/linktitle/
[`Title`]: /methods/page/title/
[automatically]: /content-management/menus/#define-automatically
[front matter]: /content-management/menus/#define-in-front-matter
[project configuration]: /content-management/menus/#define-in-project-configuration


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/menu-entry/Page.md
---


Regardless of how you [define menu entries][], an entry associated with a page has access to its [methods][].

In this menu definition, the first two entries are associated with a page, the last entry is not:

{{< code-toggle file=hugo >}}
[[menus.main]]
pageRef = '/about'
weight = 10

[[menus.main]]
pageRef = '/contact'
weight = 20

[[menus.main]]
name = 'Hugo'
url = 'https://gohugo.io'
weight = 30
{{< /code-toggle >}}

In this example, if the menu entry is associated with a page, we use page's [`RelPermalink`][] and [`LinkTitle`][] when rendering the anchor element.

If the entry is not associated with a page, we use its `url` and `name` properties.

```go-html-template
<ul>
  {{ range .Site.Menus.main }}
    {{ with .Page }}
      <li><a href="{{ .RelPermalink }}">{{ .Title }}</a></li>
    {{ else }}
      <li><a href="{{ .URL }}">{{ .Name }}</a></li>
    {{ end }}
  {{ end }}
</ul>
```

See the [menu templates][] section for more information.

[`LinkTitle`]: /methods/page/linktitle/
[`RelPermalink`]: /methods/page/relpermalink/
[define menu entries]: /content-management/menus/
[menu templates]: /templates/menu/#page-references
[methods]: /methods/page/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/menu-entry/PageRef.md
---


> [!NOTE]
> The use case for this method is rare.
> In almost also scenarios you should use the [`URL`][] method instead.


## Sections

- [`explanation`](references/methods/menu-entry/explanation.md) — Explanation
- [`example`](references/methods/menu-entry/example.md) — Example

