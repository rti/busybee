## Setup

Follow these instructions to include mathematical equations and expressions in your Markdown using LaTeX markup.

Step 1
: Enable and configure the Goldmark [passthrough extension][] in your project configuration. The passthrough extension preserves raw Markdown within delimited snippets of text, including the delimiters themselves.

  {{< code-toggle file=hugo copy=true >}}
  [markup.goldmark.extensions.passthrough]
  enable = true

  [markup.goldmark.extensions.passthrough.delimiters]
  block = [['\[', '\]'], ['$$', '$$']]
  inline = [['\(', '\)']]

  [params]
  math = true
  {{< /code-toggle >}}

  The configuration above enables mathematical rendering on every page unless you set the `math` parameter to `false` in front matter. To enable mathematical rendering as needed, set the `math` parameter to `false` in your project configuration, and set the `math` parameter to `true` in front matter. Use this parameter in your base template as shown in [Step 3](#step-3).

  > [!NOTE]
  > The configuration above precludes the use of the `$...$` delimiter pair for inline equations. Although you can add this delimiter pair to the configuration and JavaScript, you must double-escape the `$` symbol when used outside of math contexts to avoid unintended formatting.
  >
  > See the [inline delimiters](#inline-delimiters) section for details.

  To disable passthrough of inline snippets, omit the `inline` key from the configuration:

  {{< code-toggle file=hugo >}}
  [markup.goldmark.extensions.passthrough.delimiters]
  block = [['\[', '\]'], ['$$', '$$']]
  {{< /code-toggle >}}

  You can define your own opening and closing delimiters, provided they match the delimiters that you set in [Step 2](#step-2).

  {{< code-toggle file=hugo >}}
  [markup.goldmark.extensions.passthrough.delimiters]
  block = [['@@', '@@']]
  inline = [['@', '@']]
  {{< /code-toggle >}}

Step 2
: Create a _partial_ template to load MathJax or KaTeX. The example below loads MathJax, or you can use KaTeX as described in the [engines](#engines) section.

  ```go-html-template {file="layouts/_partials/math.html" copy=true}
  <script id="MathJax-script" async src="https://cdn.jsdelivr.net/npm/mathjax@4/tex-mml-chtml.js"></script>

  <script>
    MathJax = {
      tex: {
        displayMath: [['\\[', '\\]'], ['$$', '$$']],  // block
        inlineMath: [['\\(', '\\)']]                  // inline
      },
      loader:{
        load: ['ui/safe']
      },
    };
  </script>
  ```

  The delimiters above must match the delimiters in your project configuration.

Step 3
: Conditionally call the _partial_ template from the base template.

  ```go-html-template {file="layouts/baseof.html"}
  <head>
    ...
    {{ if .Param "math" }}
      {{ partialCached "math.html" . }}
    {{ end }}
    ...
  </head>
  ```

  The example above loads the _partial_ template if you have set the `math` parameter in front matter to `true`. If you have not set the `math` parameter in front matter, the conditional statement falls back to the `math` parameter in your project configuration.

Step 4
: If you set the `math` parameter to `false` in your project configuration, you must set the `math` parameter to `true` in front matter. For example:

  {{< code-toggle file=content/math-examples.md fm=true >}}
  title = 'Math examples'
  date = 2024-01-24T18:09:49-08:00
  [params]
  math = true
  {{< /code-toggle >}}

Step 5
: Include mathematical equations and expressions in Markdown using LaTeX markup.

  ```md {file="content/math-examples.md" copy=true}
  This is an inline \(a^*=x-b^*\) equation.

  These are block equations:

  \[a^*=x-b^*\]

  \[ a^*=x-b^* \]

  \[
  a^*=x-b^*
  \]

  These are also block equations:

  $$a^*=x-b^*$$

  $$ a^*=x-b^* $$

  $$
  a^*=x-b^*
  $$
  ```

