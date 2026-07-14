## Include content

Although typically used as a front matter template, you can also use an archetype to populate content.

For example, in a documentation site you might have a section (content type) for functions. Every page within this section should follow the same format: a brief description, the function signature, examples, and notes. We can pre-populate the page to remind content authors of the standard format.

````md {file="archetypes/functions.md"}

A brief description of what the function does, using simple present tense in the third person singular form. For example:

`someFunction` returns the string `s` repeated `n` times.

