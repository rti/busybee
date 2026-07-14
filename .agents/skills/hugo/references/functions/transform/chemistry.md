## Chemistry

{{< new-in 0.144.0 />}}

You can also use the `transform.ToMath` function to render chemical equations, leveraging the `\ce` and `\pu` functions from the [`mhchem`][] package.

```md
$$C_p[\ce{H2O(l)}] = \pu{75.3 J // mol K}$$
```

$$C_p[\ce{H2O(l)}] = \pu{75.3 J // mol K}$$

[KaTeX]: https://katex.org/
[MathML]: https://developer.mozilla.org/en-US/docs/Web/MathML
[`Content`]: /methods/page/content/
[`Summary`]: /methods/page/summary/
[`mhchem`]: https://mhchem.github.io/MathJax-mhchem/
[hexadecimal color]: https://developer.mozilla.org/en-US/docs/Web/CSS/hex-color
[passthrough extension]: /configuration/markup/#passthrough
[passthrough render hook]: /render-hooks/passthrough/
[rendering options]: https://katex.org/docs/options.html


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/transform/Unmarshal.md
---


The input can be a string or a [resource](g).

