## Directory structure

Create _shortcode_ templates within the `layouts/_shortcodes` directory, either at its root or organized into subdirectories.

```tree
layouts/
└── _shortcodes/
    ├── diagrams/
    │   ├── kroki.html
    │   └── plotly.html
    ├── media/
    │   ├── audio.html
    │   ├── gallery.html
    │   └── video.html
    ├── capture.html
    ├── column.html
    ├── include.html
    └── row.html
```

When calling a shortcode in a subdirectory, specify its path relative to the `_shortcode` directory, excluding the file extension.

```md
{{</* media/audio path=/audio/podcast/episode-42.mp3 */>}}
```

