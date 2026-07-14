## Caching

> [!NOTE]
> The most common templating mistake related to pagination is invoking pagination more than once for a given list page.

Regardless of pagination method, the initial invocation is cached and cannot be changed. If you invoke pagination more than once for a given list page, subsequent invocations use the cached result. This means that subsequent invocations will not behave as written.

When paginating conditionally, do not use the `compare.Conditional` function due to its eager evaluation of arguments. Use an `if-else` construct instead.

