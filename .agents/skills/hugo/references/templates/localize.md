## Localize

Hugo provides two methods to localize your menu entries. See [multilingual][].

[Menu entry defined in front matter]: /content-management/menus/#example
[Menu entry defined in your project configuration]: /configuration/menus/
[automatic]: /content-management/menus/#define-automatically
[define menu entries]: /content-management/menus/
[defining menu entries]: /content-management/menus/
[front matter]: /content-management/menus/#define-in-front-matter
[localize the menu entries]: /content-management/multilingual/#menus
[menu methods]: /methods/menu/
[multilingual]: /content-management/multilingual/#menus
[project configuration]: /content-management/menus/#define-in-project-configuration


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/templates/new-templatesystem-overview.md
---


In [Hugo v0.146.0][], we performed a full re-implementation of how Go templates are handled in Hugo. This includes structural changes to the `layouts` folder and a new, more powerful template lookup system.

We have aimed to maintain as much backward compatibility as possible by mapping "old to new," but some reported breakages have occurred. We're working on a full overhaul of the documentation on this topic – until then, this is a one-pager with the most important changes.

