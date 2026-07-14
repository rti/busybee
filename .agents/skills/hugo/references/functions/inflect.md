
---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/inflect/Humanize.md
---


```go-html-template
{{ humanize "my-first-post" }} → My first post
{{ humanize "myCamelPost" }} → My camel post
```

If the input is an integer or a string representation of an integer, humanize returns the number with the proper ordinal appended.

```go-html-template
{{ humanize "52" }} → 52nd
{{ humanize 103 }} → 103rd
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/inflect/Pluralize.md
---


```go-html-template
{{ "cat" | pluralize }} → cats
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/inflect/Singularize.md
---


```go-html-template
{{ "cats" | singularize }} → cat
```

