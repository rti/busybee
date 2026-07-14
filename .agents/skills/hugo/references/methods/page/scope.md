## Scope

Commit metadata is available for content stored in your local repository and for content provided by [modules](g).

### Local content

Hugo retrieves commit metadata for files tracked within your project's local repository. This includes all content files managed by Git in your main project directory.

### Module content

{{< new-in 0.157.0 />}}

Hugo also retrieves commit metadata for content provided by modules. This allows you to display commit data for remote repositories that are mounted as content directories, such as when aggregating documentation from multiple sources.

> [!NOTE]
> The `GitInfo` method returns nil for module content in these cases:
>
> - The module is vendored via `hugo mod vendor`
> - A [module replacement][] is configured via a `replace` directive in `go.mod` or the [`replacements`][] configuration parameter

