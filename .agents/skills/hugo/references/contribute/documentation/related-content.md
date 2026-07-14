## Related content

When available, the "See also" sidebar displays related pages using Hugo's [related content][] feature, based on front matter keywords. We ensure consistent keyword usage by validating them against `data/keywords.yaml` during the build. If a keyword is not found, you'll be alerted and must either modify the keyword or update the data file. This validation process helps to refine the related content for better results.

If the title in the "See also" sidebar is ambiguous or the same as another page, you can define an alternate title in the front matter:

{{< code-toggle file=hugo >}}
title = 'Long descriptive title'
linkTitle = 'Short title'
[params]
alt_title = 'Whatever you want'
{{< /code-toggle >}}

Use of the alternate title is limited to the "See also" sidebar.

> [!NOTE]
> Think carefully before setting the `alt_title`. Use it only when necessary.

