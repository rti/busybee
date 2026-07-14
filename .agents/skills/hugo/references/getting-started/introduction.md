## Introduction

This is **bold** text, and this is *emphasized* text.

Visit the [Hugo](https://gohugo.io) website!
```

Save the file, then start Hugo's development server. You can run either of the following commands to include draft content.

```sh
hugo server --buildDrafts
hugo server -D
```

View your project at the URL displayed in your terminal. Keep the development server running as you continue to add and change content.

When satisfied with your new content, set the front matter `draft` parameter to `false`.

> [!NOTE]
> Hugo's rendering engine conforms to the CommonMark [specification][] for Markdown. The CommonMark organization provides a useful [live testing tool][] powered by the reference implementation.

