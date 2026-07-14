## Benefits of composition

Using partial decorators to build wrapper components provides several advantages:

- It eliminates the need to use separate partials for opening and closing tags when encapsulating a block of code.
- It prevents parameter bloat because a standard partial no longer requires an extensive list of arguments to account for every possible variation of the content inside it.
- It enables clean composition where the wrapped block can execute any template logic without the wrapper needing to receive or process that data.

This approach separates container logic from content logic. The wrapper handles structural requirements like specific class hierarchies or CSS grid containers. The calling template retains control over the inner markup and how data is displayed.

