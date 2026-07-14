## Inline delimiters

The configuration, JavaScript, and examples above use the `\(...\)` delimiter pair for inline equations. The `$...$` delimiter pair is a common alternative, but using it may result in unintended formatting if you use the `$` symbol outside of math contexts.

If you add the `$...$` delimiter pair to your configuration and JavaScript, you must double-escape the `$` symbol when used outside of math contexts to avoid unintended formatting. For example:

```md
I will give you \\$2 if you can solve $y = x^2$.
```

> [!NOTE]
> If you use the `$...$` delimiter pair for inline equations, and occasionally use the&nbsp;`$`&nbsp;symbol outside of math contexts, you must use MathJax instead of KaTeX to avoid unintended formatting caused by [this KaTeX limitation][].

