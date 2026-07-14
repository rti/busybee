## Guidelines

### Style

Follow Google's [developer documentation style guide][] where practical.

### Markdown

Adhere to these Markdown conventions:

- Use [ATX][] headings (levels 2-4), not [setext][] headings.
- Use [collapsed link references][] instead of full or shortcut references. For example:

  ```md {file="content/example.md"}
  This is a [link][].

  [link]: https://example.org
  ```

- Use [inline links][] to link to fragments on the same page. For example:

  ```md {file="content/example.md"}
  This is a link to a [fragment][#fragment].
  ```

- Use [fenced code blocks][] instead of [indented code blocks][].
- Use hyphens, not asterisks, for unordered [list items][].
- Prefix each ordered list item with `1.` instead of numbering the items sequentially.
- Use [callouts](#callouts) instead of bold text for emphasis.
- Do not mix [raw HTML][] within Markdown.
- Do not use bold text in place of a heading or description term (`dt`).
- Remove consecutive blank lines.
- Remove trailing spaces.

### Glossary

[Glossary][] terms are defined on individual pages, providing a central repository for definitions, though these pages are not directly linked from the site.

Definitions must be complete sentences, with the first sentence defining the term. Italicize the first occurrence of the term and any referenced glossary terms for consistency.

Link to glossary terms using this syntax: `[term](g)`

Term lookups are case-insensitive, ignore formatting, and support singular and plural forms. For example, all of these variations will link to the same glossary term:

```md {file="content/example.md"}
[global resource](g)
[Global Resource](g)
[Global Resources](g)
[`Global Resources`](g)
```

Use the [glossary-term shortcode](#glossary-term) to insert a term definition:

```md {file="content/example.md"}
{{%/* glossary-term "global resource" */%}}
```

### Terminology

Link to the [glossary][] as needed and use terms consistently. Pay particular attention to:

- "client side" (noun), "client-side" (adjective)
- "file name" (two words)
- "flag" (instead of "option" for command-line flags)
- "front matter" (two words, except when referring to the configuration key)
- "home page" (two words)
- "map" (instead of "dictionary")
- "Markdown" (capitalized)
- "Node.js" (first mention per page), "Node" (subsequent mentions), "node" (for the executable), "npm" (always lowercase)
- "open source" (noun), "open-source" (adjective)
- "server side" (noun), "server-side" (adjective)
- "standalone" (noun or adjective)
- "stylesheet" (one word)
- "website" (one word)

### Template types

When you refer to a template type, italicize it:

```md {file="content/example.md"}
When creating a _taxonomy_ template, do this...
```

However, if the template type is also a link, do not italicize it to avoid distracting formatting:

```md {file="content/example.md"}
When creating a [taxonomy][] template, do this...
```

Do not italicize the template type in a title, heading, or front matter description.

### Titles and headings

- Use sentence-style capitalization.
- Avoid formatted strings.
- Keep them concise.

### Page descriptions

When writing the page `description` use imperative present tense when possible. For example:

{{< code-toggle file=content/en/functions/data/_index.md fm=true >}}
title: Data functions
linkTitle: data
description: Use these functions to read local or remote data files.
{{< /code-toggle >}}

### Writing style

Prefer active voice and present tense.

No → With Hugo you can build a static site.\
Yes → Build a static site with Hugo.

No → This will cause Hugo to generate HTML files in the `public` directory.\
Yes → Hugo generates HTML files in the `public` directory.

Use second person instead of third person.

No → Users should exercise caution when deleting files.\
Better → You must be cautious when deleting files.\
Best → Be cautious when deleting files.

Minimize adverbs.

No → Hugo is extremely fast.\
Yes → Hugo is fast.

> [!NOTE]
> "It's an adverb, Sam. It's a lazy tool of a weak mind." (Outbreak, 1995).

### Function and method descriptions

Start descriptions in the functions and methods sections with "Returns", or for booelan values, "Reports whether".

### File paths and names

Enclose directory names, file names, and file paths in backticks, except when used in:

- Page titles
- Section headings (`h1`-`h6`)
- The `description` field in front matter

### Miscellaneous

Other best practices:

- Introduce lists with a sentence or phrase, not directly under a heading.
- Do not use Hugo's `ref` or `relref` shortcodes.
- Prioritize current best practices over multiple options or historical information.
- Use short, focused code examples.
- Use [basic english][] where possible for a global audience.

