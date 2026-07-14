
---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/about/features.md
---


## Framework

[Multiplatform][]
: Install Hugo's single executable on Linux, macOS, Windows, and more.

[Multilingual][]
: Localize your project for each language and region, including translations, images, dates, currencies, numbers, percentages, and collation sequence. Hugo's multilingual framework supports single-host and multihost configurations.

[Output formats][]
: Render each page of your project to one or more output formats, with granular control by page kind, section, and path. While HTML is the default output format, you can add JSON, RSS, CSV, and more. For example, create a REST API to access content.

[Templates][]
: Create templates using variables, functions, and methods to transform your content, resources, and data into a published page. While HTML templates are the most common, you can create templates for any output format.

[Themes][]
: Reduce development time and cost by using one of the hundreds of themes contributed by the Hugo community. Themes are available for corporate sites, documentation projects, image portfolios, landing pages, personal and professional blogs, resumes, CVs, and more.

[Modules][]
: Reduce development time and cost by creating or importing packaged combinations of archetypes, assets, content, data, templates, translation tables, static files, or configuration settings. A module may serve as the basis for a new project, or to augment an existing project.

[Privacy][]
: Configure your project to help comply with regional privacy regulations.

[Security][]
: Hugo's security model is based on the premise that template and configuration authors are trusted, but content authors are not. This model enables generation of HTML output safe against code injection. Other protections prevent "shelling out" to arbitrary applications, limit access to specific environment variables, prevent connections to arbitrary remote data sources, and more.

## Content authoring

[Content formats][]
: Create your content using Markdown, HTML, AsciiDoc, Emacs Org Mode, Pandoc, or reStructuredText. Markdown is the default content format, conforming to the [CommonMark][] and [GitHub Flavored Markdown][] specifications.

[Markdown attributes][]
: Apply HTML attributes such as `class` and `id` to Markdown images and block elements including blockquotes, fenced code blocks, headings, horizontal rules, lists, paragraphs, and tables.

[Markdown extensions][]
: Leverage the embedded Markdown extensions to create tables, definition lists, footnotes, task lists, inserted text, mark text, subscripts, superscripts, and more.

[Markdown render hooks][]
: Override the conversion of Markdown to HTML when rendering blockquotes, fenced code blocks, headings, images, links, and tables. For example, render every standalone image as an HTML `figure` element.

[Diagrams][]
: Use fenced code blocks and Markdown render hooks to include diagrams in your content.

[Mathematics][]
: Include mathematical equations and expressions in Markdown using LaTeX markup.

[Syntax highlighting][]
: Syntactically highlight code examples using Hugo's embedded syntax highlighter, enabled by default for fenced code blocks in Markdown. The syntax highlighter supports hundreds of code languages and dozens of styles.

[Shortcodes][]
: Use Hugo's embedded shortcodes, or create your own, to insert complex content. For example, use shortcodes to include `audio` and `video` elements, render tables from local or remote data sources, insert snippets from other pages, and more.

## Content management

[Multidimensional content model][]
: Generate pages across any combination of language, version, and role from a single source. This allows a single piece of content to be published to multiple [sites](g) within your project, removing the need to duplicate files for different audiences or versions.

[Content adapters][]
: Create content adapters to dynamically add content when building your project. For example, use a content adapter to create pages from a remote data source such as JSON, TOML, YAML, or XML.

[Taxonomies][]
: Classify content to establish simple or complex logical relationships between pages. For example, create an authors taxonomy, and assign one or more authors to each page. Among other uses, the taxonomy system provides an inverted, weighted index to render a list of related pages, ordered by relevance.

[Data][]
: Augment your content using local or remote data sources including CSV, JSON, TOML, YAML, and XML. For example, create a shortcode to render an HTML table from a remote CSV file.

[Menus][]
: Provide rapid access to content via Hugo's menu system, configured automatically, globally, or on a page-by-page basis. The menu system is a key component of Hugo's multilingual architecture.

[URL management][]
: Serve any page from any path via global configuration or on a page-by-page basis.

## Asset pipelines

[CSS Processing][]
: Bundle, transform, minify, create source maps, perform SRI hashing, and integrate with PostCSS.

[Image processing][]
: Convert, resize, crop, rotate, adjust colors, apply filters, overlay text and images, and extract metadata.

[JavaScript bundling][]
: Transpile TypeScript and JSX to JavaScript, bundle, tree shake, minify, create source maps, and perform SRI hashing.

[Sass processing][]
: Transpile Sass to CSS, bundle, tree shake, minify, create source maps, perform SRI hashing, and integrate with PostCSS.

[Tailwind CSS processing][]
: Compile Tailwind CSS utility classes into standard CSS, bundle, tree shake, optimize, minify, perform SRI hashing, and integrate with PostCSS.

## Performance

[Caching][]
: Reduce build time and cost by rendering a _partial_ template once then cache the result, either globally or within a given context. For example, cache the result of an asset pipeline to prevent reprocessing on every rendered page.

[Segmentation][]
: Reduce build time and cost by partitioning your sites into segments. For example, render the home page and the "news section" every hour, and render the entire project once a week.

[Minification][]
: Minify HTML, CSS, and JavaScript to reduce file size, bandwidth consumption, and loading times.

[CSS Processing]: /functions/css/build/
[Caching]: /functions/partials/includecached/
[CommonMark]: https://spec.commonmark.org/current/
[Content adapters]: /content-management/content-adapters/
[Content formats]: /content-management/formats/
[Data]: /content-management/data-sources/
[Diagrams]: /content-management/diagrams/
[GitHub Flavored Markdown]: https://github.github.com/gfm/
[Image processing]: /content-management/image-processing/
[JavaScript bundling]: /functions/js/build/
[Markdown attributes]: /content-management/markdown-attributes/
[Markdown extensions]: /configuration/markup/#extensions
[Markdown render hooks]: /render-hooks/introduction/
[Mathematics]: /content-management/mathematics/
[Menus]: /content-management/menus/
[Minification]: /configuration/minify/
[Modules]: /hugo-modules/
[Multidimensional content model]: /quick-reference/glossary/#sites-matrix
[Multilingual]: /content-management/multilingual/
[Multiplatform]: /installation/
[Output formats]: /configuration/output-formats/
[Privacy]: /configuration/privacy/
[Sass processing]: /functions/css/sass/
[Security]: /about/security/
[Segmentation]: /configuration/segments/
[Shortcodes]: /content-management/shortcodes/
[Syntax highlighting]: /content-management/syntax-highlighting/
[Tailwind CSS processing]: /functions/css/tailwindcss/
[Taxonomies]: /content-management/taxonomies/
[Templates]: /templates/introduction/
[Themes]: https://themes.gohugo.io/
[URL management]: /content-management/urls/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/about/introduction.md
---


Hugo is a [static site generator][] written in [Go][], optimized for speed and designed for flexibility. With its advanced templating system and fast asset pipelines, Hugo renders a complete site in seconds, often less.

Due to its flexible framework, multilingual support, and powerful taxonomy system, Hugo is widely used to create:

- Corporate, government, nonprofit, education, news, event, and project sites
- Documentation sites
- Image portfolios
- Landing pages
- Business, professional, and personal blogs
- Resumes and CVs

Use Hugo's embedded web server during development to instantly see changes to content, structure, behavior, and presentation. Then deploy the site to your host, or push changes to your Git provider for automated builds and deployment.

And with [modules][] you can share content, assets, data, translations, themes, templates, and configuration with other projects via public or private Git repositories.

Learn more about Hugo's [features][], [privacy protections][], and [security model][].

{{< youtube 0RKpf3rK57I >}}

[Go]: https://go.dev
[features]: /about/features/
[modules]: /hugo-modules/
[privacy protections]: /configuration/privacy/
[security model]: /about/security/
[static site generator]: https://en.wikipedia.org/wiki/Static_site_generator


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/about/license.md
---


## Apache License

_Version 2.0, January 2004_
_<http://www.apache.org/licenses/>_

### Terms and Conditions for use, reproduction, and distribution

#### 1. Definitions

“License” shall mean the terms and conditions for use, reproduction, and distribution as defined by Sections 1 through 9 of this document.

“Licensor” shall mean the copyright owner or entity authorized by the copyright owner that is granting the License.

“Legal Entity” shall mean the union of the acting entity and all other entities that control, are controlled by, or are under common control with that entity. For the purposes of this definition, “control” means **(i)** the power, direct or indirect, to cause the direction or management of such entity, whether by contract or otherwise, or **(ii)** ownership of fifty percent (50%) or more of the outstanding shares, or **(iii)** beneficial ownership of such entity.

“You” (or “Your”) shall mean an individual or Legal Entity exercising permissions granted by this License.

“Source” form shall mean the preferred form for making modifications, including but not limited to software source code, documentation source, and configuration files.

“Object” form shall mean any form resulting from mechanical transformation or translation of a Source form, including but not limited to compiled object code, generated documentation, and conversions to other media types.

“Work” shall mean the work of authorship, whether in Source or Object form, made available under the License, as indicated by a copyright notice that is included in or attached to the work (an example is provided in the Appendix below).

“Derivative Works” shall mean any work, whether in Source or Object form, that is based on (or derived from) the Work and for which the editorial revisions, annotations, elaborations, or other modifications represent, as a whole, an original work of authorship. For the purposes of this License, Derivative Works shall not include works that remain separable from, or merely link (or bind by name) to the interfaces of, the Work and Derivative Works thereof.

“Contribution” shall mean any work of authorship, including the original version of the Work and any modifications or additions to that Work or Derivative Works thereof, that is intentionally submitted to Licensor for inclusion in the Work by the copyright owner or by an individual or Legal Entity authorized to submit on behalf of the copyright owner. For the purposes of this definition, “submitted” means any form of electronic, verbal, or written communication sent to the Licensor or its representatives, including but not limited to communication on electronic mailing lists, source code control systems, and issue tracking systems that are managed by, or on behalf of, the Licensor for the purpose of discussing and improving the Work, but excluding communication that is conspicuously marked or otherwise designated in writing by the copyright owner as “Not a Contribution.”

“Contributor” shall mean Licensor and any individual or Legal Entity on behalf of whom a Contribution has been received by Licensor and subsequently incorporated within the Work.

#### 2. Grant of Copyright License

Subject to the terms and conditions of this License, each Contributor hereby grants to You a perpetual, worldwide, non-exclusive, no-charge, royalty-free, irrevocable copyright license to reproduce, prepare Derivative Works of, publicly display, publicly perform, sublicense, and distribute the Work and such Derivative Works in Source or Object form.

#### 3. Grant of Patent License

Subject to the terms and conditions of this License, each Contributor hereby grants to You a perpetual, worldwide, non-exclusive, no-charge, royalty-free, irrevocable (except as stated in this section) patent license to make, have made, use, offer to sell, sell, import, and otherwise transfer the Work, where such license applies only to those patent claims licensable by such Contributor that are necessarily infringed by their Contribution(s) alone or by combination of their Contribution(s) with the Work to which such Contribution(s) was submitted. If You institute patent litigation against any entity (including a cross-claim or counterclaim in a lawsuit) alleging that the Work or a Contribution incorporated within the Work constitutes direct or contributory patent infringement, then any patent licenses granted to You under this License for that Work shall terminate as of the date such litigation is filed.

#### 4. Redistribution

You may reproduce and distribute copies of the Work or Derivative Works thereof in any medium, with or without modifications, and in Source or Object form, provided that You meet the following conditions:

* **(a)** You must give any other recipients of the Work or Derivative Works a copy of this License; and
* **(b)** You must cause any modified files to carry prominent notices stating that You changed the files; and
* **(c)** You must retain, in the Source form of any Derivative Works that You distribute, all copyright, patent, trademark, and attribution notices from the Source form of the Work, excluding those notices that do not pertain to any part of the Derivative Works; and
* **(d)** If the Work includes a “NOTICE” text file as part of its distribution, then any Derivative Works that You distribute must include a readable copy of the attribution notices contained within such NOTICE file, excluding those notices that do not pertain to any part of the Derivative Works, in at least one of the following places: within a NOTICE text file distributed as part of the Derivative Works; within the Source form or documentation, if provided along with the Derivative Works; or, within a display generated by the Derivative Works, if and wherever such third-party notices normally appear. The contents of the NOTICE file are for informational purposes only and do not modify the License. You may add Your own attribution notices within Derivative Works that You distribute, alongside or as an addendum to the NOTICE text from the Work, provided that such additional attribution notices cannot be construed as modifying the License.

You may add Your own copyright statement to Your modifications and may provide additional or different license terms and conditions for use, reproduction, or distribution of Your modifications, or for any such Derivative Works as a whole, provided Your use, reproduction, and distribution of the Work otherwise complies with the conditions stated in this License.

#### 5. Submission of Contributions

Unless You explicitly state otherwise, any Contribution intentionally submitted for inclusion in the Work by You to the Licensor shall be under the terms and conditions of this License, without any additional terms or conditions. Notwithstanding the above, nothing herein shall supersede or modify the terms of any separate license agreement you may have executed with Licensor regarding such Contributions.

#### 6. Trademarks

This License does not grant permission to use the trade names, trademarks, service marks, or product names of the Licensor, except as required for reasonable and customary use in describing the origin of the Work and reproducing the content of the NOTICE file.

#### 7. Disclaimer of Warranty

Unless required by applicable law or agreed to in writing, Licensor provides the Work (and each Contributor provides its Contributions) on an “AS IS” BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied, including, without limitation, any warranties or conditions of TITLE, NON-INFRINGEMENT, MERCHANTABILITY, or FITNESS FOR A PARTICULAR PURPOSE. You are solely responsible for determining the appropriateness of using or redistributing the Work and assume any risks associated with Your exercise of permissions under this License.

#### 8. Limitation of Liability

In no event and under no legal theory, whether in tort (including negligence), contract, or otherwise, unless required by applicable law (such as deliberate and grossly negligent acts) or agreed to in writing, shall any Contributor be liable to You for damages, including any direct, indirect, special, incidental, or consequential damages of any character arising as a result of this License or out of the use or inability to use the Work (including but not limited to damages for loss of goodwill, work stoppage, computer failure or malfunction, or any and all other commercial damages or losses), even if such Contributor has been advised of the possibility of such damages.

#### 9. Accepting Warranty or Additional Liability

While redistributing the Work or Derivative Works thereof, You may choose to offer, and charge a fee for, acceptance of support, warranty, indemnity, or other liability obligations and/or rights consistent with this License. However, in accepting such obligations, You may act only on Your own behalf and on Your sole responsibility, not on behalf of any other Contributor, and only if You agree to indemnify, defend, and hold each Contributor harmless for any liability incurred by, or claims asserted against, such Contributor by reason of your accepting any such warranty or additional liability.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/about/security.md
---


## Security Boundaries

- The templates inside `layouts` are trusted.
- The assets inside `archetypes`, `assets`, `resources`, `data`, `i18n` and `static` are trusted.
- The content and the content produced by [content adapters][] inside `content` is not trusted. The one exception here is if [inline shortcodes][] is enabled. Note that for content adapters, this is scoped to the result of the adapter.
- The development server, `hugo server`, and its livereload script is trusted and meant for _local_ development only.

## Runtime security

Hugo generates static websites, meaning the final output runs directly in the browser and interacts with any integrated APIs. However, during development and site building, the `hugo` executable itself is the runtime environment.

Securing a runtime is a complex task. Hugo addresses this through a robust sandboxing approach and a strict security policy with default protections. Key features include:

- Virtual file system: Hugo employs a virtual file system, limiting file access. Only the main project, not external components, can access files or directories outside the project root.
- Read-Only access: User-defined components have read-only access to the file system, preventing unintended modifications.
- Controlled external binaries: While Hugo utilizes external binaries for features like Asciidoctor support, these are strictly predefined with specific flags and are disabled by default. The [security policy][] details these limitations.
- No arbitrary commands: To mitigate risks, Hugo intentionally avoids implementing general functions that would allow users to execute arbitrary operating system commands.
- Pragmatic defaults: The default [security policy][] aims to balance security and usability, enabling common workflows out of the box while keeping more sensitive capabilities opt-in. These defaults may be tightened in future releases, but each project is ultimately responsible for reviewing the policy and adjusting it to match its own trust model and requirements.

This combination of sandboxing and strict defaults effectively minimizes potential security vulnerabilities during the Hugo build process.

## Dependency security

Hugo utilizes [Go modules][] to manage its dependencies, compiling as a static binary. Go modules create a `go.sum` file, a critical security feature. This file acts as a database, storing the expected cryptographic checksums of all dependencies, including those required indirectly (transitive dependencies).

[Hugo modules][], which extend the functionality of Go modules, also produce a `go.sum` file. To ensure dependency integrity, commit this `go.sum` file to your version control. If Hugo detects a checksum mismatch during the build process, it will fail, indicating a possible attempt to [tamper with your project's dependencies][].

## Web application security

Hugo's security philosophy is rooted in established security standards, primarily aligning with the threats defined by [OWASP][]. For HTML output, Hugo operates under a clear trust model. This model assumes that template and configuration authors, the developers, are trustworthy. However, the data supplied to these templates is inherently considered untrusted. This distinction is crucial for understanding how Hugo handles potential security risks.

To prevent unintended escaping of data that developers know is safe, Hugo provides  [`safe`][] functions, such as [`safe.HTML`][]. These functions allow developers to explicitly mark data as trusted, bypassing the default escaping mechanisms. This is essential for scenarios where data is generated or sourced from reliable sources. However, an exception exists: enabling [inline shortcodes][]. By activating this feature, you are implicitly trusting the logic within the shortcodes and the data contained within your content files.

It's vital to remember that Hugo is a static site generator. This architectural choice significantly reduces the attack surface by eliminating the complexities and vulnerabilities associated with dynamic user input. Unlike dynamic websites, Hugo generates static HTML files, minimizing the risk of real-time attacks. Regarding content, Hugo's default Markdown renderer is [configured to sanitize][] potentially unsafe content. This default behavior ensures that potentially malicious code or scripts are removed or escaped. However, this setting can be reconfigured if you have a high degree of confidence in the safety of your content sources.

In essence, Hugo prioritizes secure output by establishing a clear trust boundary between developers and data. By default, it errs on the side of caution, sanitizing potentially unsafe content and escaping data. Developers have the flexibility to adjust these defaults through [`safe`][] functions and [configuration settings][], but they must do so with a clear understanding of the security implications. Hugo's static site generation model further strengthens its security posture by minimizing dynamic vulnerabilities.

## Configuration

See [configure security][].

[Go modules]: https://go.dev/wiki/Modules#modules
[Hugo modules]: /hugo-modules/
[OWASP]: https://en.wikipedia.org/wiki/OWASP
[`safe.HTML`]: /functions/safe/html/
[`safe`]: /functions/safe/
[configuration settings]: /configuration/security/
[configure security]: /configuration/security/
[configured to sanitize]: /configuration/markup/#rendererunsafe
[content adapters]: /content-management/content-adapters/
[inline shortcodes]: /content-management/shortcodes/#inline
[security policy]: /configuration/security/
[tamper with your project's dependencies]: https://julienrenaux.fr/2019/12/20/github-actions-security-risk/

