
---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/action.md
---


See [_template action_](g).


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/archetype.md
---


An _archetype_ is a template for new content.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/argument.md
---


An _argument_ is a [_scalar_](g), [_array_](g), [_slice_](g), [_map_](g), or [_object_](g) passed to a [_function_](g), [_method_](g), or [_shortcode_](g).


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/array.md
---


An _array_ is a numbered sequence of [_elements_](g). Unlike Go's [_slice_](g) data type, an array has a fixed length. Elements within an array can be [_scalars_](g), slices, [_maps_](g), pages, or other arrays.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/asset-pipeline.md
---


An _asset pipeline_ is a system that automates and optimizes the handling of static assets like images, stylesheets, and JavaScript files.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/bool.md
---


See [_boolean_](g).


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/boolean.md
---


A _boolean_ is a data type with two possible values, either `true` or `false`.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/branch-bundle.md
---


A _branch bundle_ is a top-level content directory or any content directory containing an&nbsp;`_index.md`&nbsp;file. Analogous to a physical branch, a branch bundle may have descendants including [_leaf bundles_](g) and other branch bundles. A branch bundle may also contain [_page resources_](g) such as images.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/branch.md
---


A _branch_ is a [_node_](g) with a [_page kind_](g) of `home`, `section`, `taxonomy`, or `term`. A branch may have descendants.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/build-artifacts.md
---


The _build artifacts_ are the static files produced during the [_build_](g) process. These assets are stored in the `public` directory by default and represent the final, ready-to-deploy output of the project.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/build.md
---


To _build_ (verb) is to generate the static files for a [_project_](g), including HTML, images, CSS, and JavaScript. This process involves rendering templates, transforming resources, and resolving the matrix of [_language_](g), [_role_](g), and [_version_](g) defined in your project configuration.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/bundle.md
---


See [_page bundle_](g).


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/cache.md
---


A _cache_ is a software component that stores data so that future requests for the same data are faster.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/canonical-output-format.md
---


The _canonical output format_ is the [_output format_](g) for the current page where the format's [`rel`][] property is set to `canonical` in your project configuration, if such a format exists. If there is only one _output format_ for the current page, that is the _canonical output format_, regardless of whether the format's `rel` property is set to `canonical`.

  By default, `html` is the only predefined _output format_ with this setting; the `rel` property for all others is set to `alternate`. If two or more _output formats_ for the current page have their `rel` property set to `canonical`, the _canonical output format_ is the first one specified in:

  - The [`outputs`][outputs_front_matter] front matter field of the current page, or
  - The [`outputs`][outputs_project_config] section of your project configuration for the current [_page kind_](g).

  [`rel`]: /configuration/output-formats/#rel
  [outputs_front_matter]: /configuration/outputs/#outputs-per-page
  [outputs_project_config]: /configuration/outputs/#outputs-per-page-kind


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/chain.md
---


To _chain_ (verb) is to connect one or more [_identifiers_](g) with a dot. An identifier can represent a [_method_](g), [_object_](g), or [_field_](g). For example, `.Site.Params.author.name` or `.Date.UTC.Hour`.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/cicd.md
---


The term _CI/CD_ is an abbreviation for Continuous Integration and Continuous Delivery or Continuous Deployment depending on context.

  Popular _CI/CD_ platforms for building and deploying Hugo sites include [Cloudflare][], [GitHub Pages][], [GitLab Pages][], [Netlify][], [Render][], and [Vercel][].

  [Cloudflare]: /host-and-deploy/host-on-cloudflare/
  [GitHub Pages]: /host-and-deploy/host-on-github-pages/
  [GitLab Pages]: /host-and-deploy/host-on-gitlab-pages/
  [Netlify]: /host-and-deploy/host-on-netlify/
  [Render]: /host-and-deploy/host-on-render/
  [Vercel]: /host-and-deploy/host-on-vercel/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/cjk.md
---


_CJK_ is a collective term for the Chinese, Japanese, and Korean languages.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/cli.md
---


_CLI_ stands for command-line interface, a text-based method for interacting with computer programs or operating systems.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/collection.md
---


A _collection_ is an [_array_](g), [_slice_](g), or [_map_](g).


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/component.md
---


A _component_ is a collection of related files, housed within the [_unified file system_](g), that fulfills a specific function in building a Hugo [_project_](g). These components are categorized into seven types: [_archetypes_](g), assets, content, data, templates, [_translation tables_](g), and static files, and can be defined within the project or provided by [_modules_](g). Each component has a dedicated directory within the unified file system:

  Component|Directory within the unified file system
  :--|:--
  archetypes|`archetypes`
  assets|`assets`
  content|`content`
  data|`data`
  templates|`layouts`
  translation tables|`i18n`
  static files|`static`
  {class="!mt-0"}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/content-adapter.md
---


A _content adapter_ is a template that dynamically creates pages when building a site. For example, use a content adapter to create pages from a remote data source such as JSON, TOML, YAML, or XML.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/content-dimension.md
---


See [_dimension_](g).


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/content-format.md
---


A _content format_ is a markup language for creating content. Typically Markdown, but may also be HTML, AsciiDoc, Org, Pandoc, or reStructuredText.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/content-type.md
---


A _content type_ is a classification of content inferred from the top-level directory name or the `type` set in [_front matter_](g). Pages in the root of the `content` directory, including the home page, are of type "page". The content type is a contributing factor in the template lookup order and determines which [_archetype_](g) template to use when creating new content.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/content-view.md
---


A _content view_ is a template called with the [`Render`][] method on a `Page` object.

  [`Render`]: /methods/page/render/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/context.md
---


Represented by a dot (`.`) within a [_template action_](g), _context_ is the current location in a data structure. For example, while iterating over a [_collection_](g) of pages, the context within each iteration is the page's data structure. The context received by each template depends on template type and/or how it was called.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/default-language.md
---


The _default language_ is the value defined by the [`defaultContentLanguage`][] setting, falling back to the first language in the project, and finally to `en`. The first language is identified by the lowest [_weight_](g), using lexicographical order as the final fallback if weights are tied or undefined.

  See also: [_language_](g).

  [`defaultContentLanguage`]: /configuration/all/#defaultcontentlanguage


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/default-role.md
---


The _default role_ is the value defined by the [`defaultContentRole`][] setting, falling back to the first role in the project, and finally to `guest`. The first role is identified by the lowest [_weight_](g), using lexicographical order as the final fallback if weights are tied or undefined.

  See also: [_role_](g).

  [`defaultContentRole`]: /configuration/all/#defaultcontentrole


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/default-site.md
---


The _default site_ is the [_site_](g) with the [_default language_](g), [_default version_](g), and [_default role_](g).


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/default-sort-order.md
---


The _default sort order_ for [_page collections_](g), used when no other criteria are set, follows this priority:

  1. [`weight`][] (ascending)
  1. [`date`][] (descending)
  1. [`linkTitle`][] falling back to [`title`][] (ascending)
  1. [logical path](g) (ascending)

  [`date`]: /content-management/front-matter/#date
  [`linkTitle`]: /content-management/front-matter/#linktitle
  [`title`]: /content-management/front-matter/#title
  [`weight`]: /content-management/front-matter/#weight


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/default-version.md
---


The _default version_ is the value defined by the [`defaultContentVersion`][] setting, falling back to the first version in the project, and finally to `v1.0.0`. The first version is identified by the lowest [_weight_](g), using a descending semantic sort as the final fallback if weights are tied or undefined.

  See also: [_version_](g).

  [`defaultContentVersion`]: /configuration/all/#defaultcontentversion


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/dependency-graph.md
---


A _dependency graph_ visually represents the relationships between the [_modules_](g) used in a Hugo project. It shows how modules depend on each other, forming a network of dependencies.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/dimension.md
---


A _dimension_ is a categorized axis of content variation that allows multiple variations of a logical page to exist simultaneously. The three dimensions are [_language_](g), [_role_](g), and [_version_](g). For example, a logical page may exist in 6 languages, 4 versions, and 2 roles.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/duration.md
---


A _duration_ is a data type that represent a length of time, expressed using units such as seconds (represented by `s`), minutes (represented by `m`), and hours (represented by `h`). For example, `42s` means 42 seconds, `6m7s` means 6 minutes and 7 seconds, and `6h7m42s` means 6 hours, 7 minutes, and 42 seconds.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/element.md
---


An _element_ is a member of a [_slice_](g) or [_array_](g).


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/embedded-template.md
---


An _embedded template_ is a built-in component within the Hugo application. This includes features like [_partials_](g), [_shortcodes_](g), and [_render hooks_](g) that provide pre-defined structures or functionalities for creating website content.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/environment.md
---


Typically one of `development`, `staging`, or `production`, each _environment_ may exhibit different behavior depending on configuration and template logic. For example, in a production environment you might minify and fingerprint CSS, but that probably doesn't make sense in a development environment.

  When running the built-in development server with the `hugo server` command, the environment is set to `development`. When building your project with the `hugo build` command, the environment is set to `production`. To override the environment value, use the `--environment` command line flag or the `HUGO_ENVIRONMENT` environment variable.

  To determine the current environment within a template, use the [`hugo.Environment`](/functions/hugo/environment/) function.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/field.md
---


A _field_ is a predefined key-value pair in front matter such as `date` or `title`.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/flag.md
---


A _flag_ is an option passed to a command-line program, beginning with one or two hyphens.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/float.md
---


See [floating point](g).


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/floating-point.md
---


The term _floating point_ refers to a numeric data type with a fractional component. For example, `3.14159`.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/fragment.md
---


A _fragment_ is the final segment of a URL, beginning with a hash (`#`) mark, that references an `id` attribute of an HTML element on the page.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/front-matter.md
---


The term _front matter_ refers to the metadata at the beginning of each content page, separated from the content by format-specific delimiters.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/function.md
---


Used within a [_template action_](g), a _function_ takes one or more [_arguments_](g) and returns a value. Unlike [_methods_](g), functions are not associated with an [_object_](g).


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/glob-pattern.md
---


A _glob pattern_ is a pattern used to match sets of values. It is a shorthand for specifying multiple targets at once, making it easier to work with groups of data or configurations.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/glob-slice.md
---


A _glob slice_ is a [_slice_](g) of [_glob patterns_](g). Within the _slice_, a _glob_ can be negated by prefixing it with an exclamation mark (`!`) and one space. Matches in negated patterns short-circuit the evaluation of the rest of the _slice_, and are useful for early coarse grained exclusions.

  The following example illustrates how to use _glob slices_ to define a [_sites matrix_](g) in your project configuration:

  ```toml
  [sites.matrix]
  languages = [ "! no", "**" ]
  versions = [ "! v1.2.3", "v1.*.*", "v2.*.*" ]
  roles = [ "{member, guest}" ]
  ```

  The `versions` example above evaluates as: `(not v1.2.3) AND (v1.*.* OR v2.*.*)`.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/global-resource.md
---


A _global resource_ is file within the `assets` directory, or within any directory mounted to the `assets` directory.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/headless-bundle.md
---


A _headless bundle_ is an unpublished [_leaf bundle_](g) or an unpublished [_branch bundle_](g) whose content and resources you can include in other pages.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/i18n.md
---


See [_internationalization_](g).


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/iana.md
---


_IANA_ is an abbreviation for the Internet Assigned Numbers Authority, a non-profit organization that manages the allocation of global IP addresses, autonomous system numbers, DNS root zone, media types, and other Internet Protocol-related resources.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/identifier.md
---


An _identifier_ is a string that represents a variable, method, object, or field. It must conform to Go's [language specification][], beginning with a letter or underscore, followed by zero or more letters, digits, or underscores.

  [language specification]: https://go.dev/ref/spec#Identifiers


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/int.md
---


See [_integer_](g).


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/integer.md
---


An _integer_ is a numeric data type without a fractional component. For example, `42`.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/interleave.md
---


To _interleave_ (verb) is to insert a string at the beginning, the end, and between every character of another string.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/internationalization.md
---


The term _internationalization_ refers to software design and development efforts that enable [_localization_](g).


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/interpreted-string-literal.md
---


An _interpreted string literal_ is a character sequence between double quotes, as in `"foo"`. Within the quotes, any character may appear except a newline and an unescaped double quote. The text between the quotes forms the value of the literal, with backslash escapes interpreted.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/interval.md
---


An [_interval_](https://en.wikipedia.org/wiki/Interval_(mathematics)) is a range of numbers between two endpoints: closed, open, or half-open.

  - A _closed interval_, denoted by brackets, includes its endpoints. For example, [0,&nbsp;1]&nbsp;is the interval where `0 <= x <= 1`.

  - An _open interval_, denoted by parentheses, excludes its endpoints. For example, (0,&nbsp;1)&nbsp;is the interval where `0 < x < 1`.

  - A _half-open interval_ includes only one of its endpoints. For example, (0,&nbsp;1]&nbsp;is the _left-open_ interval where `0 < x <= 1`, while [0,&nbsp;1)&nbsp;is the _right-open_ interval where `0 <= x < 1`.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/kind.md
---


See [_page kind_](g).


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/l10n.md
---


See [_localization_](g).


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/language.md
---


A _language_ is a [_dimension_](g) that facilitates the localization and internationalization of content. While [_version_](g) focuses on lifecycle and [_role_](g) focuses on audience, the language dimension allows a logical page to be represented in different locales across the project.

  See also: [_default language_](g).


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/layout.md
---


See [_template_](g).


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/leaf-bundle.md
---


A _leaf bundle_ is a directory that contains an&nbsp;`index.md`&nbsp;file and zero or more [_resources_](g). Analogous to a physical leaf, a leaf bundle is at the end of a [_branch bundle_](g). It has no descendants.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/lexer.md
---


A _lexer_ is a software component that identifies keywords, identifiers, operators, numbers, and other basic building blocks of a programming language within the input text.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/list-page.md
---


A list page is any [_page kind_](g) that receives a page [_collection_](g) in [_context_](g). This includes the home page, [_section pages_](g), [_taxonomy pages_](g), and [_term pages_](g).


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/localization.md
---


The term _localization_ refers to the process of adapting a site to meet language and regional requirements. This includes translations, date formats, number formats, currency formats, and collation order.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/logical-path.md
---


A _logical path_ is a page or page resource identifier derived from the file path, excluding its extension and language identifier. This value is neither a file path nor a URL. Starting with a file path relative to the `content` directory, Hugo determines the logical path by stripping the file extension and language identifier, converting to lower case, then replacing spaces with hyphens. Path segments are separated with a slash (`/`).

  When used to describe content, the logical path is the path between two [_nodes_](g) in the [_logical tree_](g), either relative to each other or absolute from the root of the tree.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/logical-tree.md
---


A _logical tree_ is the hierarchy of [_nodes_](g) in a Hugo site, organized by their [_logical paths_](g). Just as file paths form a file tree, logical paths form a logical tree. Unlike the file tree, the logical tree abstracts away file extensions, language identifiers, and physical directory structure, providing a consistent way to address and navigate content.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/map.md
---


A _map_ is an unordered group of elements, each indexed by a unique key.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/markdown-attribute.md
---


A _Markdown attribute_ is a key-value pair attached to a Markdown element. These attributes are commonly used to add HTML attributes, like `class` and `id`, to the element when it's rendered into HTML. They provide a way to extend the basic Markdown syntax and add more semantic meaning or styling hooks to your content.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/marshal.md
---


To _marshal_ (verb) is to transform a data structure into a serialized object. For example, transforming a [_map_](g) into a JSON string.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/media-type.md
---


A _media type_ (formerly known as a MIME type) is a two-part identifier for file formats and transmitted content. For example, the media type for HTML content is `text/html`.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/method.md
---


Used within a [_template action_](g) and associated with an [_object_](g), a _method_ takes zero or more [_arguments_](g) and either returns a value or performs an action. For example, `IsHome` is a method on a `Page` object which returns `true` if the current page is the home page. See also [_function_](g).


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/module.md
---


A _module_ is a packaged combination of [_components_](g) which may include [_archetypes_](g), assets, content, data, templates, [_translation tables_](g), and static files. A module may be a [_theme_](g), a complete project, or a smaller collection of one or more components.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/mount.md
---


A _mount_ is a configuration object that maps a file path (source) to a [_component_](g) path (target) within Hugo's [_unified file system_](g).


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/node.md
---


A _node_ is any page in the [_logical tree_](g). A node may be a [_branch_](g), with a [_page kind_](g) of `home`, `section`, `taxonomy`, or `term`, or a regular page with a page kind of `page`.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/noop.md
---


An abbreviated form of "no operation", a _noop_ is a statement that does nothing.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/object.md
---


An _object_ is a data structure with or without associated [_methods_](g).


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/ordered-taxonomy.md
---


Created by invoking the [`Alphabetical`][] or [`ByCount`][] method on a [`Taxonomy`](g) object, which is a [_map_](g), an _ordered taxonomy_ is a [_slice_](g), where each element is an object that contains the [_term_](g) and a slice of its [_weighted pages_](g).

  [`Alphabetical`]: /methods/taxonomy/alphabetical/
  [`ByCount`]: /methods/taxonomy/bycount/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/output-format.md
---


An _output format_ is a collection of settings that defines how Hugo renders a file when building a site. For example, `html`, `json`, and `rss` are built-in output formats. You can create multiple output formats and control their generation based on [_page kind_](g), or by enabling one or more output formats for specific pages.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/page-bundle.md
---


A _page bundle_ is a directory that encapsulates both content and associated [_resources_](g). There are two types of page bundles: [_leaf bundles_](g) and [_branch bundles_](g).


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/page-collection.md
---


A _page collection_ is a slice of `Page` objects.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/page-kind.md
---


A _page kind_ is a classification of pages, one of `home`, `page`, `section`, `taxonomy`, or `term`.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/page-matcher.md
---


A _page matcher_ is a set of criteria used to filter pages by [_logical path_](g), [_page kind_](g), [_environment_](g), or [_site_](g). For example, use page matchers when configuring [cascade][] and [permalink][] targets.

  [cascade]: /configuration/cascade/
  [permalink]: /configuration/permalinks/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/page-relative.md
---


A _page-relative_ path is resolved relative to the current page's location in the content hierarchy. These paths do not begin with a leading slash. Examples include `old-name`, `./old-name`, and `../old-name`.

  See also: [_site-relative_](g), [_server-relative_](g).


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/page-resource.md
---


A _page resource_ is a file within a [_page bundle_](g).


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/pager.md
---


Created during [_pagination_](g), a _pager_ contains a subset of a list page and navigation links to other pagers.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/paginate.md
---


To _paginate_ (verb) is to split a list page into two or more subsets.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/pagination.md
---


The term _pagination_ refers to the process of [_paginating_](g) a list page.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/paginator.md
---


A _paginator_ is a collection of [_pagers_](g).


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/parameter.md
---


A _parameter_ is typically a user-defined key-value pair at the site or page level, but may also refer to a configuration setting or an [_argument_](g).


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/partial-decorator.md
---


A _partial decorator_ is specific type of [_partial_](g) that functions as a [_wrapper component_](g). While a standard partial simply renders data within a fixed template, a decorator uses composition to enclose an entire block of content. It utilizes the [`templates.Inner`][] function as a placeholder to define exactly where that external content should be injected within the wrapper's layout.

  [`templates.Inner`]: /functions/templates/inner/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/partial.md
---


A _partial_ is a [_template_](g) called from any other template including [_shortcodes_](g), [render hooks](g), and other partials. A partial either renders something or returns something. A partial can also call itself, for example, to [_walk_](g) a data structure.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/permalink.md
---


A _permalink_ is the absolute URL of a published resource or a rendered page, including scheme and host.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/pipe.md
---


See [_pipeline_](g).


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/pipeline.md
---


Within a [_template action_](g), a _pipeline_ is a possibly chained sequence of values, [_function_](g) calls, or [_method_](g) calls. Functions and methods in the pipeline may take multiple [_arguments_](g).

  A pipeline may be chained by separating a sequence of commands with pipeline characters (`|`). In a chained pipeline, the result of each command is passed as the last argument to the following command. The output of the final command in the pipeline is the value of the pipeline.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/pretty-url.md
---


A _pretty URL_ is a URL that does not include a file extension.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/primary-output-format.md
---


A _primary output format_ defines the default URL returned by the [`Permalink`][] and [`RelPermalink`][] methods for a given [_page kind_](g). It is specified as the first entry within the [outputs configuration][] for that page kind.

  [`Permalink`]: /methods/page/permalink/
  [`RelPermalink`]: /methods/page/relpermalink/
  [outputs configuration]: /configuration/outputs/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/processable-image.md
---


A _processable image_ is an image file characterized by one of the following [_media types_](g):

  - `image/avif`
  - `image/bmp`
  - `image/gif`
  - `image/jpeg`
  - `image/png`
  - `image/tiff`
  - `image/webp`

  Hugo can decode and encode these image formats, allowing you to use any of the [resource methods][] applicable to images such as `Width`, `Height`, `Crop`, `Fill`, `Fit`, `Filter`, `Process`, `Resize`, etc.

  Use the [`reflect.IsImageResourceProcessable`][] function to determine if an image can be processed.

  [`reflect.IsImageResourceProcessable`]: /functions/reflect/isimageresourceprocessable/
  [resource methods]: /methods/resource/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/project.md
---


A _project_ is a collection of [_components_](g) used to generate one or more [sites](g). While a project may consist of only a single site, Hugo allows a single project to generate a matrix of sites based on [_language_](g), [role](g), and [_version_](g). The project serves as the parent container for the common assets and logic used across all sites within the build.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/publish.md
---


See [_build_](g).


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/raw-string-literal.md
---


A _raw string literal_ is a character sequence between backticks, as in `` `bar` ``. Within the backticks, any character may appear except a backtick. Backslashes have no special meaning and the string may contain newlines. Carriage return characters (`\r`) inside raw string literals are discarded from the raw string value.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/regular-expression.md
---


A _regular expression_, also known as a _regex_, is a sequence of characters that defines a search pattern. Use the [RE2 syntax][] when defining regular expressions in your templates or in your project configuration.

  [RE2 syntax]: https://github.com/google/re2/wiki/syntax


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/regular-page.md
---


A _regular page_ is a page with the `page` [_page kind_](g). See also [_section page_](g).


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/relative-permalink.md
---


A _relative permalink_ is the host-relative URL of a published resource or a rendered page.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/remote-resource.md
---


A _remote resource_ is a file on a remote server, accessible via HTTP or HTTPS.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/render-hook.md
---


A _render hook_ is a [_template_](g) that overrides standard Markdown rendering.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/resource-type.md
---


A _resource type_ is the main type of a resource's [_media type_](g). Content files such as Markdown, HTML, AsciiDoc, Pandoc, reStructuredText, and Emacs Org Mode have resource type `page`. Other resource types include `image`, `text`, `video`, and others. Retrieve the resource type using the [`ResourceType`](/methods/resource/resourcetype/) method on a `Resource` object.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/resource.md
---


A _resource_ is any file consumed by the build process to augment or generate content, structure, behavior, or presentation. For example: images, videos, content snippets, CSS, Sass, JavaScript, and data.

  Hugo supports three types of resources: [_global resources_](g), [_page resources_](g), and [_remote resources_](g).


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/role.md
---


A _role_ is a [_dimension_](g) that allows a logical page to be served in different forms depending on the target audience. While [_language_](g) focuses on localization and [_version_](g) focuses on lifecycle, the role dimension allows a project to generate variations of a page without duplicating content.

  See also: [_default role_](g).


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/rune-literal.md
---


A _rune literal_ is the textual representation of a [_rune_](g) within a [_template_](g). It consists of a character sequence enclosed in single quotes, such as `'x'`, `'\n'`, or `'ü'`.

  Unlike [_interpreted string literals_](g) or [_raw string literals_](g), which represent a sequence of characters, a _rune literal_ represents a single [_integer_](g) value identifying a Unicode [code point][]. Within the quotes, any character may appear except a newline or an unescaped single quote. Multi-character sequences starting with a backslash (`\`) can be used to encode specific values, such as `\n` for a newline or `\u00FC` for the letter `ü`.

  [code point]: https://en.wikipedia.org/wiki/Code_point


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/rune.md
---


A _rune_ is a way to represent a single character as a number. In Hugo and Go, text is stored as a sequence of bytes. However, while a basic letter like `x` uses only one byte, a single character such as the German `ü` is made up of multiple bytes. A _rune_ represents the entire character as one single value, no matter how many bytes it takes to store it.

  Technically, a _rune_ is just another name for a 32-bit [_integer_](g). It stores the Unicode [code point][], which is the official number assigned to that specific character.

  When you want to manipulate text character-by-character rather than by raw data size, you are working with _runes_. You write a _rune_ in a [_template_](g) using a [_rune literal_](g), such as `'x'`, `'\n'`, or `'ü'`.

  [code point]: https://en.wikipedia.org/wiki/Code_point


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/scalar.md
---


A _scalar_ is a single value, one of [_string_](g), [_integer_](g), [floating point](g), or [_boolean_](g).


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/scope.md
---


The term _scope_ refers to the specific region of code where a [_variable_](g) or [_object_](g) is accessible. For example, a variable initialized in one [_template_](g) is not available within another.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/section-page.md
---


A _section page_ is a page with the `section` [_page kind_](g). Typically a listing of [_regular pages_](g) and/or other section pages within the current [_section_](g).


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/section.md
---


A _section_ is a top-level content directory or any content directory containing an&nbsp;`_index.md`&nbsp;file.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/seed.md
---


A _seed_ is the starting point for a computer algorithm that generates pseudo-random numbers. Using the same seed will always produce the identical sequence of numbers, which is essential for reproducibility in areas like simulations, cryptography, and video games.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/segment.md
---


A _segment_ is a subset of a site, filtered by [_logical path_](g), [_sites matrix_](g), [_page kind_](g), or [_output format_](g).


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/server-relative.md
---


A _server-relative_ path is the final path from the web server's root, used in the generated site. These paths always begin with a leading slash and account for the [`baseURL`][] and [_content dimension_](g) prefixes such as language, [_role_](g), or version. For example, `/en/examples/old-name/` is a server-relative path.

  See also: [_page-relative_](g), [_site-relative_](g).

  [`baseURL`]: /configuration/all/#baseurl


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/shortcode.md
---


A _shortcode_ is a [_template_](g) invoked within markup, accepting any number of [_arguments_](g). They can be used with any [_content format_](g) to insert elements such as videos, images, and social media embeds into your content.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/site-relative.md
---


A _site-relative_ path is resolved relative to the root of the content directory. These paths begin with a leading slash. For example, `/old-name` is a site-relative path.

  See also: [_page-relative_](g), [_server-relative_](g).


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/site-root.md
---


The _site root_ is the root directory of the current [_site_](g), relative to the [`publishDir`][]. The _site root_ may include one or more content [_dimension_](g) prefixes, such as [_language_](g), [_role_](g), or [_version_](g).

  Project description|Site root examples
  :--|:--|:--
  Monolingual|`/`, `/guest`, `/guest/v1.2.3`
  Multilingual single-host|`/en`, `/guest/en`, `/guest/v1.2.3/en`
  Multilingual multihost|`/en`, `/en/guest`, `/en/guest/v1.2.3`

  [`publishDir`]: /configuration/all/#publishdir


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/site.md
---


A _site_ is a specific instance of your [_project_](g) representing a unique combination of [_language_](g), [_role_](g), and [_version_](g). While a simple project may consist of only a single site, Hugo's multidimensional content model allows a single codebase to generate a matrix of sites simultaneously.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/sites-complements.md
---


A _sites complements_ is a configuration object defined in content front matter or a file mount. The links will point to the complementary [_sites_](g). The configuration is structured as a map of [_glob slices_](g).


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/sites-matrix.md
---


A _sites matrix_ is a configuration object defined in content front matter or a file mount to precisely control which [_sites_](g) the content should be generated for. When defined in a file mount for templates, it controls which sites the template will be applied to. In Hugo multidimensional content model, the matrix defines the intersection of three dimensions: [_language_](g), [_role_](g), and [_version_](g). The configuration is structured as a map of [_glob slices_](g).

  See also [_sites complements_](g), [front matter: sites][], [module mounts: sites][], and [segments: sites][].

  [front matter: sites]: /content-management/front-matter/#sites
  [module mounts: sites]: /configuration/module/#sites
  [segments: sites]: /configuration/segments/#sites


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/slice.md
---


A _slice_ is a numbered sequence of elements. Unlike Go's [_array_](g) data type, slices are dynamically sized. [_Elements_](g) within a slice can be [_scalars_](g), [_arrays_](g), [_maps_](g), pages, or other slices.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/string.md
---


A _string_ is a sequence of bytes. For example, `"What is 6 times 7?"`.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/taxonomic-weight.md
---


Defined in front matter and unique to each taxonomy, a _taxonomic weight_ is a [_weight_](g) that determines the sort order of page collections contained within a [`Taxonomy`](g) object.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/taxonomy-object.md
---


A _taxonomy object_ is a [_map_](g) of [_terms_](g) and the [_weighted pages_](g) associated with each term.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/taxonomy-page.md
---


A _taxonomy page_ is a page with the `taxonomy` [_page kind_](g). Typically a listing of [_terms_](g) within a given [_taxonomy_](g).


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/taxonomy.md
---

A _taxonomy_ is a group of related [_terms_](g) used to classify content. For example, a `colors` taxonomy might include the terms `red`, `green`, and `blue`.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/template-action.md
---


A data evaluation or control structure within a [_template_](g), delimited by `{{`&nbsp;and&nbsp;`}}`.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/template.md
---


A _template_ is a file with [_template actions_](g), located within the `layouts` directory of a project, theme, or module.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/term-page.md
---


A _term page_ is a page with the `term` [_page kind_](g). Typically a listing of [_regular pages_](g) and [_section pages_](g) with a given [_term_](g).


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/term.md
---


A _term_ is a member of a [_taxonomy_](g), used to classify content.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/theme.md
---


A _theme_ is a [_module_](g) that delivers a complete set of [_components_](g) defining a site's layout, presentation, and behavior. While every theme is a module, not every module is a theme.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/token.md
---


A _token_ is an identifier within a format string, beginning with a colon and replaced with a value when rendered. Use tokens when:

  - Configuring [file caches][], [front matter][], and [permalinks][]
  - Localizing [dates][]
  - Setting the [`url`][] in front matter

  [`url`]: /content-management/urls/#tokens
  [dates]: /functions/time/format/#localization
  [file caches]: /configuration/caches/#tokens
  [front matter]: /configuration/front-matter/#tokens
  [permalinks]: /configuration/permalinks/#tokens


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/translation-table.md
---


A _translation table_ is a JSON, TOML, or YAML file within the `i18n` directory, named according to [RFC 5646][] and holding translations for a single language.

[RFC 5646]: https://datatracker.ietf.org/doc/html/rfc5646


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/type.md
---


See [_content type_](g).


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/ugly-url.md
---


An _ugly URL_ is a URL that includes a file extension.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/unified-file-system.md
---


Hugo's _unified file system_ provides a layered view for each of its seven [_component_](g) types: [_archetypes_](g), assets, content, data, templates, [_translation tables_](g), and static files. Project component directories are layered over [_module_](g) component directories. When multiple layers contain the same file, Hugo uses the version from the highest layer.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/unmarshal.md
---


To _unmarshal_ (verb) is to transform a serialized object into a data structure. For example, transforming a JSON file into a [_map_](g) that you can access within a template.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/utc.md
---


_UTC_ is an abbreviation for Coordinated Universal Time, the primary time standard used worldwide to regulate clocks and time. It is the basis for civil time and time zones across the globe.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/variable.md
---


A _variable_ is a user-defined [_identifier_](g) prepended with a `$` symbol, representing a value of any data type, initialized or assigned within a [_template action_](g). For example, `$foo`&nbsp;and&nbsp;`$bar` are variables.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/vendor.md
---


To _vendor_ (verb) in a software context is the process of including the source code of third-party dependencies directly within your own project's repository, rather than downloading them on the fly from an external package manager.

  When you are asked to "vendor the dependencies into the project root," you are being told to move those external libraries from a temporary cache into a dedicated folder that gets committed to your version control system.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/version.md
---


A _version_ is a [_dimension_](g) that represents a specific iteration, release, or lifecycle stage of content. While [_language_](g) focuses on localization and [_role_](g) focuses on audience, the version dimension allows you to maintain multiple states of the same content simultaneously using [semantic versioning][].

  See also: [_default version_](g).

  [semantic versioning]: https://semver.org/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/walk.md
---


To _walk_ (verb) is to recursively traverse a nested data structure. For example, rendering a multilevel menu.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/weight.md
---


A _weight_ is a numeric value used to position an element within a sorted [_collection_](g). Assign weights using non-zero integers. Lighter items float to the top, while heavier items sink to the bottom. Unweighted or zero-weighted elements are placed at the end of the collection. Weights are typically assigned to pages, menu entries, languages, [_roles_](g), versions, and output formats.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/weighted-page.md
---


Contained within a [_taxonomy object_](g), a _weighted page_ is a [_map_](g) with two [_elements_](g): a `Page` object, and its [_taxonomic weight_](g) as defined in front matter. Access the elements using the `Page` and `Weight` keys.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/workspace.md
---


A _workspace_ is a collection of [_modules_](g) on disk.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/wrapper-component.md
---


A _wrapper component_ is an interface pattern that encloses other content through composition rather than fixed parameters. It provides a reusable shell to handle layout, styling, or logic, allowing the calling template to inject arbitrary content into the component's interior.

  See also: [_partial decorator_](g).


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glossary/zero-time.md
---


The _zero time_ is January 1, 0001, 00:00:00 UTC. Formatted per [RFC3339][] the _zero time_ is 0001-01-01T00:00:00-00:00.

  [RFC3339]: https://www.rfc-editor.org/rfc/rfc3339

