## Custom

Create custom shortcodes to simplify and standardize content creation. For example, the following _shortcode_ template generates an audio player using a [global resource](g):

```go-html-template {file="layouts/_shortcodes/audio.html"}
{{ with resources.Get (.Get "src") }}
  <audio controls preload="auto" src="{{ .RelPermalink }}"></audio>
{{ end }}
```

Then call the shortcode from within markup:

```md {file="content/example.md"}
{{</* audio src=/audio/test.mp3 */>}}
```

Learn more about creating shortcodes in the [shortcode templates][] section.

