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

