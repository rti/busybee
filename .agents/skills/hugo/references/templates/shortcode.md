## Shortcode

A _shortcode_ template is used to render a component of your site. Unlike _partial_ or _content view_ templates, _shortcode_ templates are called from content pages.

For example, the _shortcode_ template below renders an audio element from a [global resource](g).

```go-html-template {file="layouts/_shortcodes/audio.html"}
{{ with resources.Get (.Get "src") }}
  <audio controls preload="auto" src="{{ .RelPermalink }}"></audio>
{{ end }}
```

Then call the shortcode from within markup:

```md {file="content/example.md"}
{{</* audio src=/audio/test.mp3 */>}}
```

Learn more about [shortcode templates][].

