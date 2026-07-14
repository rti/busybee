## Manual summary

Use a `<!--more-->` divider to indicate the end of the summary. Hugo will not render the summary divider itself.

```md {file="content/example.md"}
+++
title: 'Example'
date: 2024-05-26T09:10:33-07:00
+++

This is the first paragraph.

<!--more-->

This is the second paragraph.
```

> [!NOTE]
> Place the summary divider on its own line. Do not place it inline with other content.

Correct placement:

```md {file="content/example.md"}

This is an example of **strong text** in a sentence. This is another sentence.

<!--more-->

This is another paragraph.
```

Incorrect placement:

```md {file="content/example.md"}

This is an example of **strong text** <!--more--> in a sentence. This is another sentence.

This is another paragraph.
```

When using the Emacs Org Mode [content format][], use a `# more` divider to indicate the end of the summary.

