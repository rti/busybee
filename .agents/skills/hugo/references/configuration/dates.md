## Dates

There are four methods on a `Page` object that return a date.

Method|Description
:--|:--
[`Date`][]|Returns the date of the given page.
[`ExpiryDate`][]|Returns the expiry date of the given page.
[`Lastmod`][]|Returns the last modification date of the given page.
[`PublishDate`][]|Returns the publish date of the given page.

Hugo determines the values to return based on this configuration:

{{< code-toggle config=frontmatter />}}

The `ExpiryDate` method, for example, returns the `expirydate` value if it exists, otherwise it returns `unpublishdate`.

You can also use custom date parameters:

{{< code-toggle file=hugo >}}
[frontmatter]
date = ["myDate", "date"]
{{< /code-toggle >}}

In the example above, the `Date` method returns the `myDate` value if it exists, otherwise it returns `date`.

To fall back to the default sequence of dates, use the `:default` token:

{{< code-toggle file=hugo >}}
[frontmatter]
date = ["myDate", ":default"]
{{< /code-toggle >}}

In the example above, the `Date` method returns the `myDate` value if it exists, otherwise it returns the first valid date from `date`, `publishdate`, `pubdate`, `published`, `lastmod`, and `modified`.

