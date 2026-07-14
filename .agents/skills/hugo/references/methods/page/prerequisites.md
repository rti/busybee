## Prerequisites

Install Git, create a repository, and commit your project files.

You must also allow Hugo to access your repository by adding this to your project configuration:

{{< code-toggle file=hugo >}}
enableGitInfo = true
{{< /code-toggle >}}

> [!NOTE]
> When you set [`enableGitInfo`][] to `true`, the last modification date for each content page will automatically be the Author Date of the last commit for that file.
>
> This is configurable. See [details][].

