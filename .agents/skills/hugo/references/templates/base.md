## Base

A _base_ template serves as a foundational layout that other templates can build upon. It typically defines the common structural components of your HTML, such as the `html`, `head`, and `body` elements. It also often includes recurring features like headers, footers, navigation, and script inclusions that appear across multiple pages of your site. By defining these common aspects once in a _base_ template, you avoid redundancy, ensure consistency, and simplify the maintenance of your website.

Hugo can apply a _base_ template to the following template types: [home](#home), [page](#page), [section](#section), [taxonomy](#taxonomy), [term](#term), [single](#single), [list](#list), and [all](#all). When Hugo parses any of these template types, it will apply a _base_ template only if the template being parsed meets these specific conditions:

- It must include at least one [`define`][] [action](g).
- It can only contain `define` actions, whitespace, and [template comments][]. No other content is allowed.

> [!NOTE]
> If a template doesn't meet all these criteria, Hugo executes it exactly as provided, without applying a _base_ template.

When Hugo applies a _base_ template, it replaces its [`block`][] actions with content from the corresponding `define` actions found in the template to which the base template is applied.

For example, the _base_ template below calls the [`partial`][] function to include `head`, `header`, and `footer` elements. The `block` action acts as a placeholder, and its content will be replaced by a matching `define` action  from the template to which it is applied.

```go-html-template {file="layouts/baseof.html"}
<!DOCTYPE html>
<html lang="{{ site.Language.Locale }}" dir="{{ or site.Language.Direction `ltr` }}">
<head>
  {{ partial "head.html" . }}
</head>
<body>
  <header>
    {{ partial "header.html" . }}
  </header>
  <main>
    {{ block "main" . }}
      This will be replaced with content from the
      corresponding "define" action found in the template
      to which this base template is applied.
    {{ end }}
  </main>
  <footer>
    {{ partial "footer.html" . }}
  </footer>
</body>
</html>
```

```go-html-template {file="layouts/home.html"}
{{ define "main" }}
  This will replace the content of the "block" action
  found in the base template.
{{ end }}
```

