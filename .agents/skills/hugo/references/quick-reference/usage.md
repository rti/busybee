## Usage

Configure Hugo to enable emoji processing in Markdown:

{{< code-toggle file=hugo >}}
enableEmoji = true
{{< /code-toggle >}}

With emoji processing enabled, this Markdown:

```md
Hello! :wave:
```

Is rendered to:

```html
Hello! &#x1f44b;
```

And in your browser... Hello! :wave:

To process an emoji shortcode from within a template, use the [`emojify`][] function or pass the string through the [`RenderString`][] method on a `Page` object:

```go-html-template
{{ "Hello! :wave:" | .RenderString }}
```

[GitHub Emoji API]: https://api.github.com/emojis
[Unicode Full Emoji List]: https://unicode.org/emoji/charts/full-emoji-list.html
[`RenderString`]: /methods/page/renderstring/
[`emojify`]: /functions/transform/emojify/
[ikatyang/emoji-cheat-sheet]: https://github.com/ikatyang/emoji-cheat-sheet/

<!--
To generate the sections below:

    git clone https://github.com/ikatyang/emoji-cheat-sheet
    cd emoji-cheat-sheet
    npm install
    npm run generate

Then...

    1. Copy and paste from README.md
    2. Search/replace (regex) "^###\s" with "## "
    3. Search/replace "^####\s " with "### "
    4. Search/replace (regex) "<br />" ""
-->

