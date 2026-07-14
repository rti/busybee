## Ancestors and descendants

A section has one or more ancestors (including the home page), and zero or more descendants. With the file structure from the [example above](#overview):

```text
content/products/product-1/benefits/benefit-1.md
```

The content file (benefit-1.md) has four ancestors: benefits, product-1, products, and the home page. This logical relationship allows us to use the `.Parent` and `.Ancestors` methods to traverse the site structure.

For example, use the `.Ancestors` method to render breadcrumb navigation.

```go-html-template {file="layouts/_partials/breadcrumb.html"}
<nav aria-label="breadcrumb" class="breadcrumb">
  <ol>
    {{ range .Ancestors.Reverse }}
      <li>
        <a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a>
      </li>
    {{ end }}
    <li class="active">
      <a aria-current="page" href="{{ .RelPermalink }}">{{ .LinkTitle }}</a>
    </li>
  </ol>
</nav>
```

With this CSS:

```css
.breadcrumb ol {
  padding-left: 0;
}

.breadcrumb li {
  display: inline;
}

.breadcrumb li:not(:last-child)::after {
  content: "»";
}
```

Hugo renders this, where each breadcrumb is a link to the corresponding page:

```text
Home » Products » Product 1 » Benefits » Benefit 1
```

[lookup order]: /templates/lookup-order/
[lookup rules]: /templates/lookup-order/#lookup-rules


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/content-management/shortcodes.md
---


