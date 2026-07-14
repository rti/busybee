## Functions and context

You can use any template [function](g) within an archetype. As shown above, the default archetype uses the [`strings.Replace`][] function to replace hyphens with spaces when populating the title in front matter.

Archetypes receive the following [context](g):

`Date`
: (`string`) The current date and time, formatted in compliance with RFC3339.

`File`
: (`hugolib.fileInfo`) Returns [file information][] for the current page.

`Type`
: (`string`) The [content type](g) inferred from the top-level directory name, or as specified by the `--kind` flag passed to the `hugo new content` command.

`Site`
: (`page.Site`) The current `Site` object.

