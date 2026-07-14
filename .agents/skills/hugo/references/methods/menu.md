
---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/menu/ByName.md
---


The `Sort` method returns the given menu with its entries sorted by `name`.

Consider this menu definition:

{{< code-toggle file=hugo >}}
[[menus.main]]
name = 'Services'
pageRef = '/services'
weight = 10

[[menus.main]]
name = 'About'
pageRef = '/about'
weight = 20

[[menus.main]]
name = 'Contact'
pageRef = '/contact'
weight = 30
{{< /code-toggle >}}

To sort the entries by `name`:

```go-html-template
<ul>
  {{ range .Site.Menus.main.ByName }}
    <li><a href="{{ .URL }}">{{ .Name }}</a></li>
  {{ end }}
</ul>
```

Hugo renders this to:

```html
<ul>
  <li><a href="/about/">About</a></li>
  <li><a href="/contact">Contact</a></li>
  <li><a href="/services/">Services</a></li>
</ul>
```

You can also sort menu entries using the [`sort`][] function. For example, to sort by `name` in descending order:

```go-html-template
<ul>
  {{ range sort .Site.Menus.main "Name" "desc" }}
    <li><a href="{{ .URL }}">{{ .Name }}</a></li>
  {{ end }}
</ul>
```

When using the sort function with menu entries, specify any of the following keys: `Identifier`, `Name`, `Parent`, `Post`, `Pre`, `Title`, `URL`, or `Weight`.

[`sort`]: /functions/collections/sort/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/menu/ByWeight.md
---


The `ByWeight` method returns the given menu with its entries sorted by [`weight`](g), then by `name`, then by `identifier`. This is the default sort order.

Consider this menu definition:

{{< code-toggle file=hugo >}}
[[menus.main]]
identifier = 'about'
name = 'About'
pageRef = '/about'
weight = 20

[[menus.main]]
identifier = 'services'
name = 'Services'
pageRef = '/services'
weight = 10

[[menus.main]]
identifier = 'contact'
name = 'Contact'
pageRef = '/contact'
weight = 30
{{< /code-toggle >}}

To sort the entries by `weight`, then by `name`, then by `identifier`:

```go-html-template
<ul>
  {{ range .Site.Menus.main.ByWeight }}
    <li><a href="{{ .URL }}">{{ .Name }}</a></li>
  {{ end }}
</ul>
```

Hugo renders this to:

```html
<ul>
  <li><a href="/services/">Services</a></li>
  <li><a href="/about/">About</a></li>
  <li><a href="/contact">Contact</a></li>
</ul>
```

> [!NOTE]
> In the menu definition above, note that the `identifier` property is only required when two or more menu entries have the same name, or when localizing the name using translation tables.

You can also sort menu entries using the [`sort`][] function. For example, to sort by `weight` in descending order:

```go-html-template
<ul>
  {{ range sort .Site.Menus.main "Weight" "desc" }}
    <li><a href="{{ .URL }}">{{ .Name }}</a></li>
  {{ end }}
</ul>
```

When using the sort function with menu entries, specify any of the following keys: `Identifier`, `Name`, `Parent`, `Post`, `Pre`, `Title`, `URL`, or `Weight`.

[`sort`]: /functions/collections/sort/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/menu/Limit.md
---


The `Limit` method returns the given menu, limited to the first N entries.

Consider this menu definition:

{{< code-toggle file=hugo >}}
[[menus.main]]
name = 'Services'
pageRef = '/services'
weight = 10

[[menus.main]]
name = 'About'
pageRef = '/about'
weight = 20

[[menus.main]]
name = 'Contact'
pageRef = '/contact'
weight = 30
{{< /code-toggle >}}

To sort the entries by name, and limit to the first 2 entries:

```go-html-template
<ul>
  {{ range .Site.Menus.main.ByName.Limit 2 }}
    <li><a href="{{ .URL }}">{{ .Name }}</a></li>
  {{ end }}
</ul>
```

Hugo renders this to:

```html
<ul>
  <li><a href="/about/">About</a></li>
  <li><a href="/contact">Contact</a></li>
</ul>
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/menu/Reverse.md
---


The `Reverse` method returns the given menu, reversing the sort order of its entries.

Consider this menu definition:

{{< code-toggle file=hugo >}}
[[menus.main]]
name = 'Services'
pageRef = '/services'
weight = 10

[[menus.main]]
name = 'About'
pageRef = '/about'
weight = 20

[[menus.main]]
name = 'Contact'
pageRef = '/contact'
weight = 30
{{< /code-toggle >}}

To sort the entries by name in descending order:

```go-html-template
<ul>
  {{ range .Site.Menus.main.ByName.Reverse }}
    <li><a href="{{ .URL }}">{{ .Name }}</a></li>
  {{ end }}
</ul>
```

Hugo renders this to:

```html
<ul>
  <li><a href="/services/">Services</a></li>
  <li><a href="/contact">Contact</a></li>
  <li><a href="/about/">About</a></li>
</ul>
```

