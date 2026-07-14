## Explanation

Sections and non-sections behave differently.

&nbsp;|Sections|Non-sections
:--|:-:|:-:
Directory names become URL segments|:heavy_check_mark:|:heavy_check_mark:
Have logical ancestors and descendants|:heavy_check_mark:|:x:
Have list pages|:heavy_check_mark:|:x:

With the file structure from the [example above](#overview):

1. The list page for the articles section includes all articles, regardless of directory structure; none of the subdirectories are sections.
1. The articles/2022 and articles/2023 directories do not have list pages; they are not sections.
1. The list page for the products section, by default, includes product-1 and product-2, but not their descendant pages. To include descendant pages, use the `RegularPagesRecursive` method instead of the `Pages` method in the _section_ template.
1. All directories in the products section have list pages; each directory is a section.

