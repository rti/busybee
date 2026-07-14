## GitHub Custom Emoji

| | ico | shortcode | ico | shortcode | |
| - | :-: | - | :-: | - | - |
| [top](#github-custom-emoji) | :accessibility: | `:accessibility:` | :atom: | `:atom:` | [top](#table-of-contents) |
| [top](#github-custom-emoji) | :basecamp: | `:basecamp:` | :basecampy: | `:basecampy:` | [top](#table-of-contents) |
| [top](#github-custom-emoji) | :bowtie: | `:bowtie:` | :dependabot: | `:dependabot:` | [top](#table-of-contents) |
| [top](#github-custom-emoji) | :electron: | `:electron:` | :feelsgood: | `:feelsgood:` | [top](#table-of-contents) |
| [top](#github-custom-emoji) | :finnadie: | `:finnadie:` | :fishsticks: | `:fishsticks:` | [top](#table-of-contents) |
| [top](#github-custom-emoji) | :goberserk: | `:goberserk:` | :godmode: | `:godmode:` | [top](#table-of-contents) |
| [top](#github-custom-emoji) | :hurtrealbad: | `:hurtrealbad:` | :neckbeard: | `:neckbeard:` | [top](#table-of-contents) |
| [top](#github-custom-emoji) | :octocat: | `:octocat:` | :rage1: | `:rage1:` | [top](#table-of-contents) |
| [top](#github-custom-emoji) | :rage2: | `:rage2:` | :rage3: | `:rage3:` | [top](#table-of-contents) |
| [top](#github-custom-emoji) | :rage4: | `:rage4:` | :shipit: | `:shipit:` | [top](#table-of-contents) |
| [top](#github-custom-emoji) | :suspect: | `:suspect:` | :trollface: | `:trollface:` | [top](#table-of-contents) |


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/functions.md
---


{{% quick-reference section="functions" %}}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/glob-patterns.md
---


{{% glossary-term "glob pattern" %}}

The table below details the supported glob pattern syntax and its matching behavior. Each example illustrates a specific match type, the pattern used, and the expected boolean result when evaluated against a test string.

| Match type | Glob pattern | Test string | Match? |
| :--- | :--- | :--- | :--- |
| Simple wildcard | `a/*.md` | `a/page.md` | true |
| Literal match | `'a/*.md'` | `a/*.md` | true |
| Single-level wildcard | `a/*/page.md` | `a/b/page.md` | true |
| Single-level wildcard | `a/*/page.md` | `a/b/c/page.md` | false |
| Multi-level wildcard | `a/**/page.md` | `a/b/c/page.md` | true |
| Single character | `file.???` | `file.txt` | true |
| Single character | `file.???` | `file.js` | false |
| Delimiter exclusion | `?at` | `f/at` | false |
| Character list | `f.[jt]xt` | `f.txt` | true |
| Negated list | `f.[!j]xt` | `f.txt` | true |
| Character range | `f.[a-c].txt` | `f.b.txt` | true |
| Character range | `f.[a-c].txt` | `f.z.txt` | false |
| Negated range | `f.[!a-c].txt` | `f.z.txt` | true |
| Pattern alternates | `*.{jpg,png}` | `logo.png` | true |
| No match | `*.{jpg,png}` | `logo.webp` | false |

The matching logic follows these rules:

- Standard wildcard (`*`) matches any character except for a delimiter.
- Super wildcard (`**`) matches any character including delimiters.
- Single character (`?`) matches exactly one character, excluding delimiters.
- Negation (`!`) matches any character except those specified in a list or range when used inside brackets.
- Character ranges (`[a-z]`) match any single character within the specified range.

The delimiter is a slash (`/`), except when matching semantic version strings, where the delimiter is a dot&nbsp;(`.`).


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/methods.md
---


{{% quick-reference section="methods" %}}


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/quick-reference/page-collections.md
---


