## Draft, future, and expired content

Hugo allows you to set `draft`, `date`, `publishDate`, and `expiryDate` in the [front matter][] of your content. By default, Hugo will not publish content when:

- The `draft` value is `true`
- The `date` is in the future
- The `publishDate` is in the future
- The `expiryDate` is in the past

> [!NOTE]
> Hugo publishes descendants of draft, future, and expired [branch](g) pages. To prevent publication of these descendants, use the [`cascade`][] front matter field to cascade [build options][] to the descendant pages.

You can override the default behavior when running `hugo build` or `hugo server` with command line flags:

```sh
hugo build --buildDrafts    # or -D
hugo build --buildExpired   # or -E
hugo build --buildFuture    # or -F
```

Although you can also set these values in your project configuration, it can lead to unwanted results unless all content authors are aware of, and understand, the settings.

> [!NOTE]
> As noted above, Hugo does not clear the `public` directory before building your project. Depending on the _current_ evaluation of the four conditions above, after the build your `public` directory may contain extraneous files from a previous build.
>
> A common practice is to manually clear the contents of the `public` directory before each build to remove draft, expired, and future content.

