
---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/strings/Diff/index.md
---


Use `strings.Diff` to compare two strings and render a highlighted diff:

```go-html-template
{{ $want := `
<p>The product of 6 and 7 is 42.</p>
<p>The product of 7 and 6 is 42.</p>
`}}

{{ $got := `
<p>The product of 6 and 7 is 42.</p>
<p>The product of 7 and 6 is 13.</p>
`}}

{{ $diff := strings.Diff "want" $want "got" $got }}
{{ transform.Highlight $diff "diff" }}
```

Rendered:

![screen capture](diff-screen-capture.png)

