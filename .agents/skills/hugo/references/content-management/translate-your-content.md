## Translate your content

There are two ways to manage your content translations. Both ensure each page is assigned a language and is linked to its counterpart translations.

### Translation by file name

Considering the following example:

1. `/content/about.en.md`
1. `/content/about.fr.md`

The first file is assigned the English language and is linked to the second.
The second file is assigned the French language and is linked to the first.

Their language is assigned according to the language code added as a suffix to the file name.

By having the same path and base file name, the content pieces are linked together as translated pages.

> [!NOTE]
> The language code in a file name must be lowercase. For example, use `about.en-us.md` instead of `about.en-US.md`.

> [!NOTE]
> If a file has no language code, it will be assigned the default language.

### Translation by content directory

This system uses different content directories for each of the languages. Each language's `content` directory is set using the `contentDir` parameter.

{{< code-toggle file=hugo >}}
[languages.en]
contentDir = 'content/english'
label = "English"
weight = 10

[languages.fr]
contentDir = 'content/french'
label = "Français"
weight = 20
{{< /code-toggle >}}

The value of `contentDir` can be any valid path -- even absolute path references. The only restriction is that the content directories cannot overlap.

Considering the following example in conjunction with the configuration above:

1. `/content/english/about.md`
1. `/content/french/about.md`

The first file is assigned the English language and is linked to the second.
The second file is assigned the French language and is linked to the first.

Their language is assigned according to the `content` directory they are placed in.

By having the same path and basename (relative to their language `content` directory), the content pieces are linked together as translated pages.

### Bypassing default linking

Any pages sharing the same `translationKey` set in front matter will be linked as translated pages regardless of basename or location.

Considering the following example:

1. `/content/about-us.en.md`
1. `/content/om.nn.md`
1. `/content/presentation/a-propos.fr.md`

{{< code-toggle file=hugo >}}
translationKey: "about"
{{< /code-toggle >}}

By setting the `translationKey` front matter parameter to `about` in all three pages, they will be linked as translated pages.

### Localizing permalinks

Because paths and file names are used to handle linking, all translated pages will share the same URL (apart from the language subdirectory).

To localize URLs:

- For a regular page, set either [`slug`][] or [`url`][] in front matter
- For a section page, set [`url`][] in front matter

For example, a French translation can have its own localized slug.

{{< code-toggle file=content/about.fr.md fm=true >}}
title: A Propos
slug: "a-propos"
{{< /code-toggle >}}

At render, Hugo will build both `/about/` and `/fr/a-propos/` without affecting the translation link.

### Page bundles

To avoid the burden of having to duplicate files, each Page Bundle inherits the resources of its linked translated pages' bundles except for the content files (Markdown files, HTML files etc.).

Therefore, from within a template, the page will have access to the files from all linked pages' bundles.

If, across the linked bundles, two or more files share the same basename, only one will be included and chosen as follows:

- File from current language bundle, if present.
- First file found across bundles by order of language `Weight`.

> [!NOTE]
> Page Bundle resources follow the same language assignment logic as content files, both by file name (`image.jpg`, `image.fr.jpg`) and by directory (`english/about/header.jpg`, `french/about/header.jpg`).

