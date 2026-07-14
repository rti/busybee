## Example

Instead of client-side JavaScript rendering of mathematical markup using MathJax or KaTeX, create a passthrough render hook which calls the `transform.ToMath` function.

Step 1
: Enable and configure the Goldmark [passthrough extension][] in your project configuration. The passthrough extension preserves raw Markdown within delimited snippets of text, including the delimiters themselves.

  {{< code-toggle file=hugo copy=true >}}
  [markup.goldmark.extensions.passthrough]
  enable = true
  [markup.goldmark.extensions.passthrough.delimiters]
  block = [['\[', '\]'], ['$$', '$$']]
  inline = [['\(', '\)']]
  {{< /code-toggle >}}

  > [!NOTE]
  > The configuration above precludes the use of the `$...$` delimiter pair for inline equations. Although you can add this delimiter pair to the configuration, you must double-escape the `$` symbol when used outside of math contexts to avoid unintended formatting.

Step 2
: Create a [passthrough render hook][] to capture and render the LaTeX markup.4

  ```go-html-template {file="layouts/_markup/render-passthrough.html" copy=true}
  {{- $opts := dict "output" "htmlAndMathml" "displayMode" (eq .Type "block") }}
  {{- with try (transform.ToMath .Inner $opts) }}
    {{- with .Err }}
      {{- errorf "Unable to render mathematical markup to HTML using the transform.ToMath function. The KaTeX display engine threw the following error: %s: see %s." . $.Position }}
    {{- else }}
      {{- .Value }}
      {{- $.Page.Store.Set "hasMath" true }}
    {{- end }}
  {{- end -}}
  ```

Step 3
: In your base template, conditionally include the KaTeX CSS within the head element.

  ```go-html-template {file="layouts/baseof.html" copy=true}
  <head>
    {{ $noop := .WordCount }}
    {{ if .Page.Store.Get "hasMath" }}
      <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/katex@0.17.0/dist/katex.min.css" integrity="sha384-vlBdW0r3AcZO/HboRPznQNowvexd3fY8qHOWkBi5q7KGgqJ+F48+DceybYmrVbmB" crossorigin="anonymous">
    {{ end }}
  </head>
  ```

  In the above, note the use of a [noop](g) statement to force content rendering before we check the value of `hasMath` with the `Store.Get` method.

  > [!NOTE]
  > This conditional approach only identifies math on the current page. Mathematical expressions will not display correctly when one page's content is embedded within another. For example, if a [list page](g) calls the [`Content`][] or [`Summary`][] methods while ranging through its page collection, the list page will not load the KaTeX CSS.
  >
  > If this affects your site, use this conditional logic instead:
  >
  > ```go-html-template {file="layouts/baseof.html" copy=true}
  > {{ $noop := .WordCount }}
  > {{ if or (.Page.Store.Get "hasMath") .IsNode }}
  >   <link rel="stylesheet" href="...">
  > {{ end }}
  > ```

Step 4
: Add some mathematical markup to your content, then test.

  ```md {file="content/example.md"}
  This is an inline \(a^*=x-b^*\) equation.

  These are block equations:

  \[a^*=x-b^*\]

  $$a^*=x-b^*$$
  ```

