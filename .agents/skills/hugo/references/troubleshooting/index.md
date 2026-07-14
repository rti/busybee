# troubleshooting


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/troubleshooting/deprecation.md
---


When a project _deprecates_ something, they are telling its users:

1. Don't use Thing One anymore.
1. Use Thing Two instead.
1. We're going to remove Thing One at some point in the future.

Common [reasons for deprecation][]:

- A feature has been replaced by a more powerful alternative.
- A feature contains a design flaw.
- A feature is considered extraneous, and will be removed in the future in order to simplify the system as a whole.
- A future version of the software will make major structural changes, making it impossible or impractical to support older features.
- Standardization or increased consistency in naming.
- A feature that once was available only independently is now combined with its co-feature.

After the project team deprecates something in code, Hugo will:

1. Log an INFO message for 3 minor releases[^1]
1. Log a WARN message for another 12 minor releases
1. Log an ERROR message and fail the build thereafter

The project team will:

1. On the deprecation date, update the documentation with a note describing the deprecation and any relevant alternatives.
1. Remove the code six or more minor releases after Hugo begins logging ERROR messages and failing the build. At that point, Hugo will throw an error, but the error message will no longer mention the deprecation.
1. Remove the corresponding documentation two years after the deprecation date.

To see the INFO messages, you must use the `--logLevel` command line flag:

```sh
hugo build --logLevel info
```

To limit the output to deprecation notices:

```sh
hugo build --logLevel info | grep deprecate
```

Run the above command every time you upgrade Hugo.

[^1]: For example, v0.1.1 => v0.2.0 is a minor release.

[reasons for deprecation]: https://en.wikipedia.org/wiki/Deprecation


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/troubleshooting/faq.md
---


Hugo's [forum][] is an active community of users and developers who answer questions, share knowledge, and provide examples. A quick search of over 20,000 topics will often answer your question. Please be sure to read about [requesting help][] before asking your first question.

These are just a few of the questions most frequently asked by new users.

An error message indicates that a feature is not available. Why?
: When you attempt to use a feature that is not available in the edition that you installed, Hugo throws this error:

  ```go-html-template
  this feature is not available in this edition of Hugo
  ```

  To resolve, install a different edition. See the [installation][] section for details.

Why do I see "Page Not Found" when visiting the home page?
: In the `content/_index.md` file:

  - Is `draft` set to `true`?
  - Is the `date` in the future?
  - Is the `publishDate` in the future?
  - Is the `expiryDate` in the past?

  If the answer to any of these questions is yes, either change the field values, or use one of these command line flags: `--buildDrafts`, `--buildFuture`, or `--buildExpired`.

Why is a given page not published?
: In the `content/section/page.md` file, or in the `content/section/page/index.md` file:

  - Is `draft` set to `true`?
  - Is the `date` in the future?
  - Is the `publishDate` in the future?
  - Is the `expiryDate` in the past?

  If the answer to any of these questions is yes, either change the field values, or use one of these command line flags: `--buildDrafts`, `--buildFuture`, or `--buildExpired`.

Why can't I see any of a page's descendants?
: You may have an&nbsp;`index.md`&nbsp;file instead of an&nbsp;`_index.md`&nbsp;file. See [details][page bundles].

What is the difference between an&nbsp;`index.md`&nbsp;file and an&nbsp;`_index.md`&nbsp;file?
: A directory with an `index.md file` is a [leaf bundle](g). A directory with an&nbsp;`_index.md`&nbsp;file is a [branch bundle](g). See [details][page bundles].

Why is my _partial_ template not rendered as expected?
: You may have neglected to pass the required [context](g) when calling the partial. For example:

  ```go-html-template
  {{/* incorrect */}}
  {{ partial "pagination.html" }}

  {{/* correct */}}
  {{ partial "pagination.html" . }}
  ```

In a template, what's the difference between `:=` and `=` when assigning values to variables?
: Use `:=` to initialize a variable, and use `=` to assign a value to a variable that has been previously initialized. See [details][variables].

When I paginate a list page, why is the page collection not filtered as specified?
: You are probably invoking the [`Paginate`][] or [`Paginator`][] method more than once on the same page. See [details][pagination].

Why are there two ways to call a shortcode?
: Use the `{{%/* shortcode */%}}` notation if the _shortcode_ template, or the content between the opening and closing shortcode tags, contains Markdown. Otherwise use the\
`{{</* shortcode */>}}` notation. See [details][notation].

Can I use environment variables to control configuration?
: Yes. See [details][environment-variables].

Why am I seeing inconsistent output from one build to the next?
: The most common causes are page collisions (publishing two pages to the same path) and the effects of concurrency. Use the `--printPathWarnings` command line flag to check for page collisions, and create a topic on the [forum][] if you suspect concurrency problems.

Why isn't Hugo's development server detecting file changes?
: In its default configuration, Hugo's file watcher may not be able detect file changes when:

  - Running Hugo within Windows Subsystem for Linux (WSL/WSL2) with project files on a Windows partition
  - Running Hugo locally with project files on a removable drive
  - Running Hugo locally with project files on a storage server accessed via the NFS, SMB, or CIFS protocols

  In these cases, instead of monitoring native file system events, use the `--poll` command line flag. For example, to poll the project files every 700 milliseconds, use `--poll 700ms`.

Why is my page Store missing a value?
: The [`Store`][] method on a `Page` object creates a persistent data structure for storing and manipulating keyed values on the given page. Values are often set within a _shortcode_ template, a _partial_ template called by a _shortcode_ template, or by a _render hook_ template. In all three cases, the stored values are not determinate until Hugo renders the page content.

  If you need to access a stored value from a parent template, and the parent template has not yet rendered the page content, you can trigger content rendering by assigning the returned value to a [noop](g) variable:

  ```go-html-template
  {{ $noop := .Content }}
  {{ .Store.Get "mykey" }}
  ```

  You can trigger content rendering with other methods as well. See next FAQ.

Which page methods trigger content rendering?
: The following methods on a `Page` object trigger content rendering: `Content`, `ContentWithoutSummary`, `FuzzyWordCount`, `Len`, `Plain`, `PlainWords`, `ReadingTime`, `Summary`, `Truncated`, and `WordCount`.

> [!NOTE]
> For other questions please visit the [forum][]. A quick search of over 20,000 topics will often answer your question. Please be sure to read about [requesting help][] before asking your first question.

[`Paginate`]: /methods/page/paginate/
[`Paginator`]: /methods/page/paginator/
[`Store`]: /methods/page/store/
[environment-variables]: /configuration/introduction/#environment-variables
[forum]: https://discourse.gohugo.io
[installation]: /installation/
[notation]: /content-management/shortcodes/#notation
[page bundles]: /content-management/page-bundles/
[pagination]: /templates/pagination/
[requesting help]: https://discourse.gohugo.io/t/requesting-help/9132
[variables]: https://pkg.go.dev/text/template#hdr-Variables


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/troubleshooting/inspection.md
---


Use the [`debug.Dump`][] function to inspect a data structure:

```go-html-template
<pre>{{ debug.Dump .Params }}</pre>
```

```text
{
  "date": "2023-11-10T15:10:42-08:00",
  "draft": false,
  "iscjklanguage": false,
  "lastmod": "2023-11-10T15:10:42-08:00",
  "publishdate": "2023-11-10T15:10:42-08:00",
  "tags": [
    "foo",
    "bar"
  ],
  "title": "My first post"
}
```

Use the [`printf`][] function (render) or [`warnf`][] function (log to console) to inspect simple data structures. The layout string below displays both value and data type.

```go-html-template
{{ $value := 42 }}
{{ printf "%[1]v (%[1]T)" $value }} → 42 (int)
```

{{< new-in 0.146.0 />}}

Use the [`templates.Current`][] function to visually mark template execution boundaries or to display the template call stack.

[`debug.Dump`]: /functions/debug/dump/
[`printf`]: /functions/fmt/printf/
[`templates.Current`]: /functions/templates/current/
[`warnf`]: /functions/fmt/warnf/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/troubleshooting/logging.md
---



## Sections

- [`command-line`](references/troubleshooting/command-line.md) — Command Line
- [`template-functions`](references/troubleshooting/template-functions.md) — Template Functions
- [`livereload`](references/troubleshooting/livereload.md) — LiveReload
- [`virus-scanning`](references/troubleshooting/virus-scanning.md) — Virus Scanning
- [`template-metrics`](references/troubleshooting/template-metrics.md) — Template Metrics
- [`caching`](references/troubleshooting/caching.md) — Caching
- [`timers`](references/troubleshooting/timers.md) — Timers

