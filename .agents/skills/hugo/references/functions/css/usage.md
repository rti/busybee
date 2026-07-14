## Usage

In this example, Hugo bundles the local files referenced by `@import` statements to create and publish a single resource with inline content.

```tree
assets/
└── css/
    ├── components/
    │   ├── a.css
    │   └── b.css
    └── main.css
```

```css {file="assets/css/main.css" copy=true}
@import url('https://cdn.jsdelivr.net/npm/the-new-css-reset/css/reset.min.css');

@import './components/a.css';
@import './components/b.css';

.c {color: blue; }
```

```css {file="assets/css/components/a.css" copy=true}
.a { color: red; }
```

```css {file="assets/css/components/b.css" copy=true}
.b { color: green; }
```

```go-html-template {file="layouts/_partials/css.html" copy=true}
{{ with resources.Get "css/main.css" | css.Build }}
  {{ if hugo.IsDevelopment }}
    <link rel="stylesheet" href="{{ .RelPermalink }}">
  {{ else }}
    {{ with . | fingerprint }}
      <link rel="stylesheet" href="{{ .RelPermalink }}" integrity="{{ .Data.Integrity }}" crossorigin="anonymous">
    {{ end }}
  {{ end }}
{{ end }}
```

```go-html-template {file="layouts/baseof.html" copy=true}
{{ partialCached "css.html" . }}
```

The generated CSS code:

```css {file="public/css/main.css"}
@import "https://cdn.jsdelivr.net/npm/the-new-css-reset/css/reset.min.css";

.a {
  color: red;
}

.b {
  color: green;
}

.c {
  color: blue;
}
```

To minify the generated CSS code, use the [`minify`](#minify) option as described below.

