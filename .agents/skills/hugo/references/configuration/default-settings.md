## Default settings

The development server defaults to redirecting to `/404.html` for any requests to URLs that don't exist. See the [404 errors](#404-errors) section below for details.

{{< code-toggle config=server />}}

`force`
: (`bool`) Whether to force a redirect even if there is existing content in the path.

`from`
: (`string`) A [glob pattern](g) matching the requested URL. Either `from` or `fromRE` must be set. If both `from` and `fromRe` are specified, the URL must match both patterns.

`fromHeaders`
: {{< new-in 0.144.0 />}}
: (`map[string][string]`) Headers to match for the redirect. This maps the HTTP header name to a [glob pattern](g) with values to match. If the map is empty, the redirect will always be triggered.

`fromRe`
: {{< new-in 0.144.0 />}}
: (`string`) A [regular expression](g) used to match the requested URL. Either `from` or `fromRE` must be set. If both `from` and `fromRe` are specified, the URL must match both patterns. Capture groups from the regular expression are accessible in the `to` field as `$1`, `$2`, and so on.

`status`
: (`string`) The HTTP status code to use for the redirect. A status code of 200 will trigger a URL rewrite.

`to`
: (`string`) The URL to forward the request to.

