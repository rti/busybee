## Create an output format

You can create new output formats as needed. For example, you may wish to create an output format to support Atom feeds.

Step 1
: Output formats require a specified media type. Because Atom feeds use `application/atom+xml`, which is not one of the [default media types][], you must create it first.

  {{< code-toggle file=hugo >}}
  [mediaTypes.'application/atom+xml']
  suffixes = ['atom']
  {{< /code-toggle >}}

  See [configure media types][] for more information.

Step 2
: Create a new output format:

  {{< code-toggle file=hugo >}}
  [outputFormats.atom]
  mediaType = 'application/atom+xml'
  noUgly = true
  {{< /code-toggle >}}

  Note that we use the default settings for all other output format properties.

Step 3
: Specify the page [kinds](g) for which to render this output format:

  {{< code-toggle file=hugo >}}
  [outputs]
  home = ['html', 'rss', 'atom']
  section = ['html', 'rss', 'atom']
  taxonomy = ['html', 'rss', 'atom']
  term = ['html', 'rss', 'atom']
  {{< /code-toggle >}}

  See [configure outputs][] for more information.

Step 4
: Create a template to render the output format. Since Atom feeds are lists, you need to create a list template. Consult the [template lookup order][] to find the correct template path:

  ```text
  layouts/list.atom.atom
  ```

  We leave writing the template code as an exercise for you. Aim for a result similar to the [embedded RSS template][].

