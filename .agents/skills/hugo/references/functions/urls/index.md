# urls


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/urls/AbsLangURL.md
---


Use this function with both monolingual and multilingual configurations. The URL returned by this function depends on:

- Whether the input begins with a slash (`/`)
- The `baseURL` in your project configuration
- The language prefix, if any

This is the project configuration for the examples that follow:

{{< code-toggle file=hugo >}}
defaultContentLanguage = 'en'
defaultContentLanguageInSubdir = true
[languages.en]
weight = 1
[languages.es]
weight = 2
{{< /code-toggle >}}


## Sections

- [`input-does-not-begin-with-a-slash`](references/functions/urls/input-does-not-begin-with-a-slash.md) — Input Does Not Begin With A Slash
- [`input-begins-with-a-slash`](references/functions/urls/input-begins-with-a-slash.md) — Input Begins With A Slash
- [`input-does-not-begin-with-a-slash`](references/functions/urls/input-does-not-begin-with-a-slash.md) — Input Does Not Begin With A Slash
- [`input-begins-with-a-slash`](references/functions/urls/input-begins-with-a-slash.md) — Input Begins With A Slash
- [`usage`](references/functions/urls/usage.md) — Usage
- [`options`](references/functions/urls/options.md) — Options
- [`examples`](references/functions/urls/examples.md) — Examples
- [`error-handling`](references/functions/urls/error-handling.md) — Error Handling
- [`input-does-not-begin-with-a-slash`](references/functions/urls/input-does-not-begin-with-a-slash.md) — Input Does Not Begin With A Slash
- [`input-begins-with-a-slash`](references/functions/urls/input-begins-with-a-slash.md) — Input Begins With A Slash
- [`usage`](references/functions/urls/usage.md) — Usage
- [`options`](references/functions/urls/options.md) — Options
- [`examples`](references/functions/urls/examples.md) — Examples
- [`error-handling`](references/functions/urls/error-handling.md) — Error Handling
- [`input-does-not-begin-with-a-slash`](references/functions/urls/input-does-not-begin-with-a-slash.md) — Input Does Not Begin With A Slash
- [`input-begins-with-a-slash`](references/functions/urls/input-begins-with-a-slash.md) — Input Begins With A Slash
- [`example`](references/functions/urls/example.md) — Example

