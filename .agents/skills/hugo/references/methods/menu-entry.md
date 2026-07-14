
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

## Explanation

If you specify a `pageRef` property when [defining a menu entry][] in your project configuration, Hugo looks for a matching page when rendering the entry.

If a matching page is found:

- The [`URL`][] method returns the page's relative permalink
- The [`Page`][] method returns the corresponding `Page` object
- The [`HasMenuCurrent`][] and [`IsMenuCurrent`][] methods on a `Page` object return the expected values

If a matching page is not found:

- The [`URL`][] method returns the entry's `url` property if set, else an empty string
- The [`Page`][] method returns nil
- The [`HasMenuCurrent`][] and [`IsMenuCurrent`][] methods on a `Page` object return `false`

> [!NOTE]
> In almost also scenarios you should use the [`URL`][] method instead.

## Example

This example is contrived.

> [!NOTE]
> In almost also scenarios you should use the [`URL`][] method instead.

Consider this content structure:

```tree
content/
├── products.md
└── _index.md
```

And this menu definition:

{{< code-toggle file=hugo >}}
[[menus.main]]
name = 'Products'
pageRef = '/products'
weight = 10
[[menus.main]]
name = 'Services'
pageRef = '/services'
weight = 20
{{< /code-toggle >}}

With this template code:

```go-html-template {file="layouts/_partials/menu.html"}
<ul>
  {{ range .Site.Menus.main }}
    <li><a href="{{ .URL }}">{{ .Name }}</a></li>
  {{ end }}
</ul>
```

Hugo render this HTML:

```html
<ul>
  <li><a href="/products/">Products</a></li>
  <li><a href="">Services</a></li>
</ul>
```

In the above note that the `href` attribute of the second `anchor` element is blank because Hugo was unable to find the `services` page.

With this template code:

```go-html-template {file="layouts/_partials/menu.html"}
<ul>
  {{ range .Site.Menus.main }}
    <li><a href="{{ or .URL .PageRef }}">{{ .Name }}</a></li>
  {{ end }}
</ul>
```

Hugo renders this HTML:

```html
<ul>
  <li><a href="/products/">Products</a></li>
  <li><a href="/services">Services</a></li>
</ul>
```

In the above note that Hugo populates the `href` attribute of the second `anchor` element with the `pageRef` property as defined in your project configuration because the template code falls back to the `PageRef` method.

[`HasMenuCurrent`]: /methods/page/hasmenucurrent/
[`IsMenuCurrent`]: /methods/page/ismenucurrent/
[`Page`]: /methods/menu-entry/page/
[`URL`]: /methods/menu-entry/url/
[defining a menu entry]: /content-management/menus/#define-in-project-configuration


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/menu-entry/Params.md
---


When you define menu entries in your [project configuration][] or in [front matter][], you can include a `params` key to attach additional information to the entry. For example:

{{< code-toggle file=hugo >}}
[[menus.main]]
name = 'About'
pageRef = '/about'
weight = 10

[[menus.main]]
name = 'Contact'
pageRef = '/contact'
weight = 20

[[menus.main]]
name = 'Hugo'
url = 'https://gohugo.io'
weight = 30
[menus.main.params]
  rel = 'external'
{{< /code-toggle >}}

With this template:

```go-html-template
<ul>
  {{ range .Site.Menus.main }}
    <li>
      <a href="{{ .URL }}" {{ with .Params.rel }}rel="{{ . }}"{{ end }}>
        {{ .Name }}
      </a>
    </li>
  {{ end }}
</ul>
```

Hugo renders:

```html
<ul>
  <li><a href="/about/">About</a></li>
  <li><a href="/contact/">Contact</a></li>
  <li><a href="https://gohugo.io" rel="external">Hugo</a></li>
</ul>
```

See the [menu templates][] section for more information.

[front matter]: /content-management/menus/#define-in-front-matter
[menu templates]: /templates/menu/#menu-entry-parameters
[project configuration]: /content-management/menus/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/menu-entry/Parent.md
---


With this menu definition:

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

This template renders the nested menu, listing the `parent` property next each of the child entries:

```go-html-template
<ul>
  {{ range .Site.Menus.main }}
    <li>
      <a href="{{ .URL }}">{{ .Name }}</a>
      {{ if .HasChildren }}
        <ul>
          {{ range .Children }}
            <li><a href="{{ .URL }}">{{ .Name }}</a> ({{ .Parent }})</li>
          {{ end }}
        </ul>
      {{ end }}
    </li>
  {{ end }}
</ul>
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/menu-entry/Post.md
---


{{% include "/_common/menu-entries/pre-and-post.md" %}}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/menu-entry/Pre.md
---


{{% include "/_common/menu-entries/pre-and-post.md" %}}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/menu-entry/Title.md
---


The `Title` method returns the `title` property of the given menu entry. If the `title` is not defined, and the menu entry resolves to a page, the `Title` returns the page [`Title`][].

```go-html-template
<ul>
  {{ range .Site.Menus.main }}
    <li><a href="{{ .URL }}" title="{{ .Title }}>{{ .Name }}</a></li>
  {{ end }}
</ul>
```

[`Title`]: /methods/page/title/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/menu-entry/URL.md
---


For menu entries associated with a page, the `URL` method returns the page's [`RelPermalink`][], otherwise it returns the entry's `url` property.

```go-html-template
<ul>
  {{ range .Site.Menus.main }}
    <li><a href="{{ .URL }}">{{ .Name }}</a></li>
  {{ end }}
</ul>
```

[`RelPermalink`]: /methods/page/relpermalink/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/methods/menu-entry/Weight.md
---


If you define the menu entry [automatically][], the `Weight` method returns the page's [`Weight`][].

If you define the menu entry in [front matter][] or in your [project configuration][], the `Weight` method returns the `weight` property, falling back to the page's `Weight`.

In this contrived example, we limit the number of menu entries based on weight:

```go-html-template
<ul>
  {{ range .Site.Menus.main }}
    {{ if le .Weight 42 }}
      <li><a href="{{ .URL }}">{{ .Name }}</a></li>
    {{ end }}
  {{ end }}
</ul>
```

[`Weight`]: /methods/page/weight/
[automatically]: /content-management/menus/#define-automatically
[front matter]: /content-management/menus/#define-in-front-matter
[project configuration]: /content-management/menus/#define-in-project-configuration

