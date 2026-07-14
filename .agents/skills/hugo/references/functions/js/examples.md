## Examples

```go-html-template
{{ $built := resources.Get "js/index.js" | js.Build "main.js" }}
```

Or with options:

```go-html-template
{{ $externals := slice "react" "react-dom" }}
{{ $defines := dict "process.env.NODE_ENV" `"development"` }}

{{ $opts := dict "targetPath" "main.js" "externals" $externals "defines" $defines }}
{{ $built := resources.Get "scripts/main.js" | js.Build $opts }}
<script src="{{ $built.RelPermalink }}" defer></script>
```

[`esbuild`]: https://esbuild.github.io/
[`evanw/esbuild`]: https://github.com/evanw/esbuild
[`hugo mod npm pack`]: /commands/hugo_mod_npm_pack/
[test project]: https://github.com/gohugoio/hugoTestProjectJSModImports
[turn it off]: /configuration/build/#nojsconfiginassets

