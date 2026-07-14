## Date format

To insert date and time with a different format, use the [`time.Now`][] function:

{{< code-toggle file=archetypes/default.md fm=true >}}
title = '{{ replace .File.ContentBaseName `-` ` ` | title }}'
date = '{{ time.Now.Format "2006-01-02" }}'
draft = true
{{< /code-toggle >}}

