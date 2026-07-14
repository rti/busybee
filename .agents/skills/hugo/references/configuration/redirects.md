## Redirects

You can define simple redirect rules.

{{< code-toggle file=config/development/server >}}
[[redirects]]
from = '/myspa/**'
to = '/myspa/'
status = 200
force = false
{{< /code-toggle >}}

The `200` status code in this example triggers a URL rewrite, which is typically the desired behavior for [single-page applications][].

