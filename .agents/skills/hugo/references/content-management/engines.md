## Engines

MathJax and KaTeX are open-source JavaScript display engines.

> [!NOTE]
> If you use the `$...$` delimiter pair for inline equations, and occasionally use the&nbsp;`$`&nbsp;symbol outside of math contexts, you must use MathJax instead of KaTeX to avoid unintended formatting caused by [this KaTeX limitation][].
>
>See the [inline delimiters](#inline-delimiters) section for details.

To use KaTeX instead of MathJax, replace the _partial_ template from [Step 2](#step-2) with this:

```go-html-template {file="layouts/_partials/math.html" copy=true}
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/katex@0.17.0/dist/katex.min.css" integrity="sha384-vlBdW0r3AcZO/HboRPznQNowvexd3fY8qHOWkBi5q7KGgqJ+F48+DceybYmrVbmB" crossorigin="anonymous">

<script defer src="https://cdn.jsdelivr.net/npm/katex@0.17.0/dist/katex.min.js" integrity="sha384-AtrdNsnxl/75rvBneBVH7DtOvCxSVahR2zWqle1coBKd8DEmLoviqNeJSx64gNAs" crossorigin="anonymous"></script>

<script defer src="https://cdn.jsdelivr.net/npm/katex@0.17.0/dist/contrib/auto-render.min.js" integrity="sha384-bjyGPfbij8/NDKJhSGZNP/khQVgtHUE5exjm4Ydllo42FwIgYsdLO2lXGmRBf5Mz" crossorigin="anonymous"
    onload="renderMathInElement(document.body);">
</script>

<script>
  document.addEventListener("DOMContentLoaded", function() {
    renderMathInElement(document.body, {
      delimiters: [
        {left: '\\[', right: '\\]', display: true},   // block
        {left: '$$', right: '$$', display: true},     // block
        {left: '\\(', right: '\\)', display: false},  // inline
      ],
      throwOnError : false
    });
  });
</script>
```

The delimiters above must match the delimiters in your project configuration.

