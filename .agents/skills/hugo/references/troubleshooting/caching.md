## Caching

Some _partial_ templates such as sidebars or menus are executed many times during a site build. Depending on the content within the _partial_ template and the desired output, the template may benefit from caching to reduce the number of executions. The [`partialCached`][] function provides caching capabilities for _partial_ templates.

> [!NOTE]
> Note that you can create cached variants of each partial by passing additional arguments to `partialCached` beyond the initial context. See the `partialCached` documentation for more details.

