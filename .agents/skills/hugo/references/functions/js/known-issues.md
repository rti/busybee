## Known Issues

In the official documentation for the `esbuild` [code splitting][] feature, there's a warning note in the header. The two issues are:

- `esm` is currently the only implemented output format. This means that it will not work for legacy browsers. See [caniuse][].
- There's a known import ordering issue.

We have not seen the ordering issue as a problem during our [extensive testing][] of this new feature with different libraries. There are two main cases:

1. Undefined execution order of imports, see [this comment][comment-1]
1. Only one execution order of imports, see [this comment][comment-2]

Many would say that both of the above are [code smells][]. The first one has a simple workaround in Hugo. Define the import order in its own script and make sure it gets passed early to `esbuild`, e.g., by putting it in a script group with a name that comes early in the alphabet.

```js
import './lib2.js';
import './lib1.js';

console.log('entrypoints-workaround.js');
```

[JavaScript import]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/import
[`Resource.Get`]: /methods/page/resources/#get
[`Resource`]: /methods/resource/
[`Resources.Mount`]: /methods/page/resources/#mount
[`Resources`]: /methods/page/resources/
[`evanw/esbuild`]: https://github.com/evanw/esbuild
[`templates.Defer`]: /functions/templates/defer/
[`with`]: /functions/go-template/with/
[caniuse]: https://caniuse.com/?search=ESM
[code smells]: https://en.wikipedia.org/wiki/Code_smell
[code splitting]: https://esbuild.github.io/api/#splitting
[comment-1]: https://github.com/evanw/esbuild/issues/399#issuecomment-1458680887
[comment-2]: https://github.com/evanw/esbuild/issues/399#issuecomment-735355932
[entire namespace]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/import#namespace_import
[extensive testing]: https://github.com/bep/hugojsbatchdemo
[js_batch_demo]: https://github.com/bep/hugojsbatchdemo/
[page bundle]: /content-management/page-bundles/
[this discussion]: https://discourse.gohugo.io/t/js-batch-with-simple-global-script/53002/5


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/js/Build.md
---


> [!NOTE]
> The `js.Build` function is backed by the [`evanw/esbuild`][] package, providing a mature, high-performance foundation for bundling, transformation, and minification.

Use the `js.Build` function to:

- Bundle
- Transpile (TypeScript and JSX)
- Tree shake
- Minify
- Create source maps

```go-html-template
{{ with resources.Get "js/main.js" }}
  {{$opts := dict
    "minify" (cond hugo.IsDevelopment false true)
    "sourceMap" (cond hugo.IsDevelopment "linked" "none")
  }}
  {{ with . | js.Build $opts }}
    {{ if hugo.IsDevelopment }}
      <script src="{{ .RelPermalink }}"></script>
    {{ else }}
      {{ with . | fingerprint }}
        <script src="{{ .RelPermalink }}" integrity="{{ .Data.Integrity }}" crossorigin="anonymous"></script>
      {{ end }}
    {{ end }}
  {{ end }}
{{ end }}
```

