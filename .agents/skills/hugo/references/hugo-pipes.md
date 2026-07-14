
---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/hugo-pipes/bundling.md
---


See the [`resources.Concat`](/functions/resources/concat/) function.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/hugo-pipes/fingerprint.md
---


See the [`resources.Fingerprint`](/functions/resources/fingerprint/) function.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/hugo-pipes/introduction.md
---


## Find resources in assets

This is about global and remote resources.

global resource
: A file within the `assets` directory, or within any directory [mounted][] to the `assets` directory.

remote resource
: A file on a remote server, accessible via HTTP or HTTPS.

For `.Page` scoped resources, see the [page resources][] section.

## Get a resource

In order to process an asset with Hugo Pipes, it must be retrieved as a resource.

For global resources, use:

- [`resources.ByType`][]
- [`resources.Get`][]
- [`resources.GetMatch`][]
- [`resources.Match`][]

For remote resources, use:

- [`resources.GetRemote`][]

## Copy a resource

See the [`resources.Copy`][] function.

## Asset directory

Asset files must be stored in the asset directory. This is `assets` by default, but can be configured via the configuration file's `assetDir` key.

## Asset publishing

Hugo publishes assets to the `publishDir` (typically `public`) when you invoke `.Permalink`, `.RelPermalink`, or `.Publish`. You can use `.Content` to inline the asset.

## Go Pipes

For improved readability, the Hugo Pipes examples of this documentation will be written using [Go Pipes][]:

```go-html-template
{{ $style := resources.Get "sass/main.scss" | css.Sass | resources.Minify | resources.Fingerprint }}
<link rel="stylesheet" href="{{ $style.Permalink }}">
```

## Caching

Hugo Pipes invocations are cached based on the entire _pipe chain_.

An example of a pipe chain is:

```go-html-template
{{ $mainJs := resources.Get "js/main.js" | js.Build "main.js" | minify | fingerprint }}
```

The pipe chain is only invoked the first time it is encountered in a site build, and results are otherwise loaded from cache. As such, Hugo Pipes can be used in templates which are executed thousands or millions of times without negatively impacting the build performance.

[Go Pipes]: /templates/introduction/#pipes
[`resources.ByType`]: /functions/resources/bytype/
[`resources.Copy`]: /functions/resources/copy/
[`resources.GetMatch`]: /functions/resources/getmatch/
[`resources.GetRemote`]: /functions/resources/getremote/
[`resources.Get`]: /functions/resources/get/
[`resources.Match`]: /functions/resources/match/
[mounted]: /configuration/module/#mounts
[page resources]: /content-management/page-resources/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/hugo-pipes/js.md
---


See [JS functions][].

[JS functions]: /functions/js/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/hugo-pipes/minification.md
---


See the [`resources.Minify`](/functions/resources/minify/) function.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/hugo-pipes/postcss.md
---


See the [`css.PostCSS`](/functions/css/postcss/) function.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/hugo-pipes/postprocess.md
---


See the [`resources.PostProcess`](/functions/resources/postprocess/) function.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/hugo-pipes/resource-from-string.md
---


See the [`resources.FromString`](/functions/resources/fromstring/) function.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/hugo-pipes/resource-from-template.md
---


See the [`resources.ExecuteAsTemplate`](/functions/resources/executeastemplate/) function.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/hugo-pipes/transpile-sass-to-css.md
---


See the [`css.Sass`](/functions/css/sass) function.

