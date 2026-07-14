## GitHub workflow

> [!NOTE]
> This section assumes that you have a working knowledge of Git and GitHub, and are comfortable working on the command line.

Use this workflow to create and submit pull requests.

Step 1
: Fork the [documentation repository][].

Step 2
: Clone your fork.

Step 3
: Create a new branch with a descriptive name that includes the corresponding issue number, if any:

  ```sh
  git checkout -b restructure-foo-page-99999
  ```

Step 4
: Make changes.

Step 5
: Build the site locally to preview your changes.

Step 6
: Commit your changes with a descriptive commit message:

  - Provide a summary on the first line, typically 50 characters or less, followed by a blank line.
    - Begin the summary with one of `content`, `theme`, `config`, `all`, or `misc`, followed by a colon, a space, and a brief description of the change beginning with a capital letter
    - Use imperative present tense
  - Optionally, provide a detailed description where each line is 72 characters or less, followed by a blank line.
  - Optionally, add one or more "Fixes" or "Closes" keywords, each on its own line, referencing the [issues][] addressed by this change.

  For example:

  ```sh
  git commit -m "content: Restructure the taxonomy page

  This restructures the taxonomy page by splitting topics into logical
  sections, each with one or more examples.

  Fixes #9999
  Closes #9998"
  ```

Step 7
: Push the new branch to your fork of the documentation repository.

Step 8
: Visit the [documentation repository][] and create a pull request (PR).

Step 9
: A project maintainer will review your PR and may request changes. You may delete your branch after the maintainer merges your PR.

[^1]: The field is required, but its data is not.

[ATX]: https://spec.commonmark.org/current/#atx-headings
[Glossary]: /quick-reference/glossary/
[basic english]: https://simple.wikipedia.org/wiki/Basic_English
[collapsed link references]: https://discourse.gohugo.io/t/55714
[details]: https://github.com/gohugoio/hugoDocs/blob/master/layouts/_partials/layouts/blocks/feature-state.html
[developer documentation style guide]: https://developers.google.com/style
[documentation repository]: https://github.com/gohugoio/hugoDocs/
[fenced code blocks]: https://spec.commonmark.org/current/#fenced-code-blocks
[indented code blocks]: https://spec.commonmark.org/current/#indented-code-blocks
[inline links]: https://discourse.gohugo.io/t/55714
[issues]: https://github.com/gohugoio/hugoDocs/issues
[list items]: https://spec.commonmark.org/current/#list-items
[project repository]: https://github.com/gohugoio/hugo
[raw HTML]: https://spec.commonmark.org/current/#raw-html
[related content]: /content-management/related-content/
[setext]: https://spec.commonmark.org/current/#setext-heading

