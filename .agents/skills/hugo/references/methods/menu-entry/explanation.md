## Explanation

If you specify a `pageRef` property when [defining a menu entry][] in your project configuration, Hugo looks for a matching page when rendering the entry.

If a matching page is found:

- The [`URL`][] method returns the page's relative permalink
- The [`Page`][] method returns the corresponding `Page` object
- The [`HasMenuCurrent`][] and [`IsMenuCurrent`][] methods on a `Page` object return the expected values

If a matching page is not found:

- The [`URL`][] method returns the entry's `url` property if set, else an empty string
- The [`Page`][] method returns nil
- The [`HasMenuCurrent`][] and [`IsMenuCurrent`][] methods on a `Page` object return `false`

> [!NOTE]
> In almost also scenarios you should use the [`URL`][] method instead.

