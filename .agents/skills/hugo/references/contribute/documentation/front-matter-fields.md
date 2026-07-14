## Front matter fields

This site uses the front matter fields listed in the table below.

Of the four required fields, only `title` and `description` require data.

{{< code-toggle file=content/example.md fm=true >}}
title: The title
description: The description
categories: []
keywords: []
{{< /code-toggle >}}

If quotation marks are required, prefer single quotes to double quotes when possible.

Field|Description|Required
:--|:--|:--
`title`|The page title|:heavy_check_mark:
`linkTitle`|A short version of the page title|&nbsp;
`description`|A complete sentence describing the page|:heavy_check_mark:
`categories`|An array of terms in the categories taxonomy|:heavy_check_mark: [^1]
`keywords`|An array of keywords used to identify related content|:heavy_check_mark: [^1]
`publishDate`|Applicable to news items: the publication date|&nbsp;
`params.alt_title`|An alternate title: used in the "see also" panel if provided|&nbsp;
`params.functions_and_methods.aliases`|Applicable to function and method pages: an array of alias names|&nbsp;
`params.functions_and_methods.returnType`|Applicable to function and method pages: the data type returned|&nbsp;
`params.functions_and_methods.signatures`|Applicable to function and method pages: an array of signatures|&nbsp;
`params.hide_in_this_section`|Whether to hide the "in this section" panel|&nbsp;
`params.label`|Applicable to second-level section pages such as concepts, guides, references, and tutorials: a lowercase 3-letter code to identify the section, used in the `related` partial|&nbsp;
`params.minversion`|Applicable to the quick start page: the minimum Hugo version required|&nbsp;
`params.permalink`|Reserved for use by the news content adapter|&nbsp;
`params.reference`|Applicable to glossary entries: a URL for additional information|&nbsp;
`params.searchable`|Whether to add the content of this page to the search index. The default value is cascaded down from the project configuration; `true` if the page kind is `page`, and `false` if the page kind is one of `home`, `section`, `taxonomy`, or `term`. Add this field to override the default value.|&nbsp;
`params.show_publish_date`|Whether to show the `publishDate` when rendering the page|&nbsp;
`weight`|The page weight|&nbsp;
`aliases`|Previous URLs used to access this page|&nbsp;
`expirydate`|The expiration date|&nbsp;

