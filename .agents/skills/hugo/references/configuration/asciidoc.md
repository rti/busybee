## AsciiDoc

This is the default configuration for the AsciiDoc renderer:

{{< code-toggle config=markup.asciidocExt />}}

### AsciiDoc settings explained

`attributes`
: (`map`) A map of key-value pairs, each a document attribute. See Asciidoctor's [attributes][].

`backend`
: (`string`) The backend output file format. Default is `html5`.

`extensions`
: (`[]string`) An array of enabled extensions, such as `asciidoctor-html5s`, `asciidoctor-bibtex`, or `asciidoctor-diagram`.

  > [!NOTE]
  > To mitigate security risks, entries in the extension array may not contain forward slashes (`/`), backslashes (`\`), or periods. Due to this restriction, extensions must be in Ruby's `$LOAD_PATH`.

`failureLevel`
: (`string`) The minimum logging level that triggers a non-zero exit code (failure). Default is `fatal`.

`noHeaderOrFooter`
: (`bool`) Whether to output an embeddable document, which excludes the header, the footer, and everything outside the body of the document. Default is `true`.

`preserveTOC`
: (`bool`) Whether to preserve the table of contents (TOC) rendered by Asciidoctor. By default, to make the TOC compatible with existing themes, Hugo removes the TOC rendered by Asciidoctor. To render the TOC, use the [`TableOfContents`][] method on a `Page` object in your templates. Default is `false`.

`safeMode`
: (`string`) The safe mode level, one of `unsafe`, `safe`, `server`, or `secure`. Default is `unsafe`.

`sectionNumbers`
: (`bool`) Whether to number each section title. Default is `false`.

`trace`
: (`bool`) Whether to include backtrace information on errors. Default is `false`.

`verbose`
: (`bool`) Whether to verbosely print processing information and configuration file checks to stderr. Default is `false`.

`workingFolderCurrent`
: (`bool`) Whether to set the working directory to be the same as that of the AsciiDoc file being processed, allowing [includes][] to work with relative paths. Set to `true` to render diagrams with the [asciidoctor-diagram][] extension. Default is `false`.

### Configuration example

{{< code-toggle file=hugo >}}
[markup.asciidocExt]
extensions = ['asciidoctor-html5s','asciidoctor-diagram']
workingFolderCurrent = true
[markup.asciidocExt.attributes]
my-base-url = 'https://example.com/'
my-attribute-name = 'my value'
{{< /code-toggle >}}

### Syntax highlighting

Follow the steps below to enable syntax highlighting.

Step 1
: Set the `source-highlighter` attribute in your project configuration. For example:

  {{< code-toggle file=hugo >}}
  [markup.asciidocExt.attributes]
  source-highlighter = 'rouge'
  {{< /code-toggle >}}

Step 2
: Generate the highlighter CSS. For example:

  ```sh
  rougify style monokai.sublime > assets/css/syntax.css
  ```

Step 3
: In your base template add a link to the CSS file:

  ```go-html-template {file="layouts/baseof.html"}
  <head>
    ...
    {{ with resources.Get "css/syntax.css" }}
      <link rel="stylesheet" href="{{ .RelPermalink }}" integrity="{{ .Data.Integrity }}" crossorigin="anonymous">
    {{ end }}
    ...
  </head>
  ```

Step 4
: Add the code to be highlighted to your markup:

  ```text
  [#hello,ruby]
  ----
  require 'sinatra'

  get '/hi' do
    "Hello World!"
  end
  ----
  ```

### Troubleshooting

Run `hugo build --logLevel debug` to examine Hugo's call to the Asciidoctor executable:

```txt
INFO 2019/12/22 09:08:48 Rendering book-as-pdf.adoc with C:\Ruby26-x64\bin\asciidoctor.bat using asciidoc args [--no-header-footer -r asciidoctor-html5s -b html5s -r asciidoctor-diagram --base-dir D:\prototypes\hugo_asciidoc_ddd\docs -a outdir=D:\prototypes\hugo_asciidoc_ddd\build -] ...
```

