## Target a template

You cannot change the lookup order to target a content page, but you can change a content page to target a template. Specify `type`, `layout`, or both in front matter.

Consider this content structure:

```tree
content/
├── about.md
└── contact.md
```

Files in the root of the `content` directory have a [content type](g) of `page`. To render these pages with a unique template, create a matching subdirectory:

```tree
layouts/
└── page/
    └── single.html
```

The contact page, however, probably has a form and requires a different template. In the front matter specify `layout`:

{{< code-toggle file=content/contact.md fm=true >}}
title = 'Contact'
layout = 'contact'
{{< /code-toggle >}}

Then create the template for the contact page:

```tree
layouts/
└── page/
    └── contact.html  <-- renders contact.md
    └── single.html   <-- renders about.md
```

As a content type, the word `page` is vague. Perhaps `miscellaneous` would be better. Add `type` to the front matter of each page:

{{< code-toggle file=content/about.md fm=true >}}
title = 'About'
type = 'miscellaneous'
{{< /code-toggle >}}

{{< code-toggle file=content/contact.md fm=true >}}
title = 'Contact'
type = 'miscellaneous'
layout = 'contact'
{{< /code-toggle >}}

Now place the layouts in the corresponding directory:

```tree
layouts/
└── miscellaneous/
    └── contact.html  <-- renders contact.md
    └── single.html   <-- renders about.md
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/templates/menu.md
---


