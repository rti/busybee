## Repeated execution

A decorator can execute the captured content zero or more times. This is useful when the wrapper needs to repeat the same decoration for a collection of items, such as a list or a grid.

```go-html-template {file="layouts/_partials/list-decorator.html"}
<ul class="styled-list">
  {{ range .items }}
    <li>
      {{ templates.Inner . }}
    </li>
  {{ end }}
</ul>
```

In this example, the code provided by the caller is rendered once for every item in the .items collection, with the dot . updated to the current item in each iteration.

[`with`]: /functions/go-template/with/
[partial decorator]: /templates/partial-decorators/

