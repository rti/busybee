## Structure

Create templates in the `layouts` directory in the root of your project.

Although your site may not require each of these templates, the example below is typical for a site of medium complexity.

```tree
layouts/
├── _markup/
│   ├── render-image.html   <-- render hook
│   └── render-link.html    <-- render hook
├── _partials/
│   ├── footer.html
│   └── header.html
├── _shortcodes/
│   ├── audio.html
│   └── video.html
├── books/
│   ├── page.html
│   └── section.html
├── films/
│   ├── view_card.html      <-- content view
│   ├── view_li.html        <-- content view
│   ├── page.html
│   └── section.html
├── baseof.html
├── home.html
├── page.html
├── section.html
├── taxonomy.html
└── term.html
```

Hugo's [template lookup order][] determines the template path, allowing you to create unique templates for any page.

> [!NOTE]
> You must have thorough understanding of the template lookup order when creating templates. Template selection is based on template type, page kind, content type, section, language, and output format.

The purpose of each template type is described below.

