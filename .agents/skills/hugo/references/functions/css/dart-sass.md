## Dart Sass

<!-- TODO
Revise the paragraphs below somewhere after v0.168.0, 15 minor releases
after the deprecation of the LibSass transpiler.
-->

Hugo's extended and extended/deploy editions include [LibSass][] to transpile Sass to CSS. In 2020, the Sass team deprecated LibSass in favor of [Dart Sass][].

Use the latest features of the Sass language by installing Dart Sass in your development and production environments.

### Installation overview

Dart Sass is compatible with Hugo v0.114.0 and later.

If you have been using Embedded Dart Sass[^1] with Hugo v0.113.0 and earlier, uninstall Embedded Dart Sass, then install Dart Sass. If you have installed both, Hugo will use Dart Sass.

If you install Hugo as a [Snap package][] there is no need to install Dart Sass. The Hugo Snap package includes Dart Sass.

### Installing in a development environment

When you install Dart Sass somewhere in your PATH, Hugo will find it.

OS      | Package manager | Site               | Installation
:-------|:----------------|:-------------------|:-----------------------------
Linux   | Homebrew        | [brew.sh][]        | `brew install sass/sass/sass`
Linux   | Snap            | [snapcraft.io][]   | `sudo snap install dart-sass`
macOS   | Homebrew        | [brew.sh][]        | `brew install sass/sass/sass`
Windows | Chocolatey      | [chocolatey.org][] | `choco install sass`
Windows | Scoop           | [scoop.sh][]       | `scoop install sass`

You may also install [prebuilt binaries][] for Linux, macOS, and Windows. You must install the prebuilt binary outside of your project directory and ensure its path is included in your system's PATH environment variable.

Run `hugo env` to list the active transpilers.

> [!NOTE]
> If you build Hugo from source and run `mage test -v`, the test will fail if you install Dart Sass as a Snap package. This is due to the Snap package's strict confinement model.

### Installing in a production environment

To use Dart Sass with Hugo on a [CI/CD](g) platform, you typically must modify your build workflow to install Dart Sass before the Hugo site build begins. This is because these platforms don't have Dart Sass pre-installed, and Hugo needs it to process your Sass files.

There's one key exception where you can skip this step: you have committed your `resources` directory to your repository. This is only possible if:

- You have not changed Hugo's default asset cache location.
- You have not set [`useResourceCacheWhen`][] to never in your project configuration.

By committing the `resources` directory, you're providing the pre-built CSS files directly to your CI/CD platform, so it doesn't need to run the Sass compilation itself.

For examples of how to install Dart Sass in a production environment, see these hosting guides:

- [Cloudflare][]
- [GitHub Pages][]
- [GitLab Pages][]
- [Netlify][]
- [Render][]
- [SourceHut][]
- [Vercel][]

[^1]: In 2023, the Sass team deprecated Embedded Dart Sass in favor of Dart Sass.

[Cloudflare]: /host-and-deploy/host-on-cloudflare/
[Dart Sass]: https://sass-lang.com/dart-sass/
[GitHub Pages]: /host-and-deploy/host-on-github-pages/
[GitLab Pages]: /host-and-deploy/host-on-gitlab-pages/
[LibSass]: https://sass-lang.com/libsass
[Netlify]: /host-and-deploy/host-on-netlify/
[Render]: /host-and-deploy/host-on-render/
[SCSS]: https://sass-lang.com/documentation/syntax#scss
[Snap package]: https://snapcraft.io/hugo
[SourceHut]: /host-and-deploy/host-on-sourcehut-pages/
[Vercel]: /host-and-deploy/host-on-vercel/
[`css.Quoted`]: /functions/css/quoted/
[`css.Unquoted`]: /functions/css/unquoted/
[`publishDir`]: /configuration/all/#publishdir
[`useResourceCacheWhen`]: /configuration/build/#useresourcecachewhen
[brew.sh]: https://brew.sh/
[chocolatey.org]: https://community.chocolatey.org/packages/sass
[indented]: https://sass-lang.com/documentation/syntax#the-indented-syntax
[prebuilt binaries]: https://github.com/sass/dart-sass/releases/latest
[scoop.sh]: https://scoop.sh/#/apps?q=sass
[snapcraft.io]: https://snapcraft.io/dart-sass
[v0.153.0]: https://github.com/gohugoio/hugo/releases/tag/v0.153.0


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/css/TailwindCSS.md
---


Use the `css.TailwindCSS` function to process your Tailwind CSS files. This function uses the Tailwind CSS CLI to:

1. Scan your templates for Tailwind CSS utility class usage.
1. Compile those utility classes into standard CSS.
1. Generate an optimized CSS output file.

> [!NOTE]
> Use this function with Tailwind CSS v4.0 and later, which require a relatively [modern browser][] to render correctly.

