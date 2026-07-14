## HTTP polling

Polling is used in watch mode (e.g., `hugo server`) to detect changes in remote resources. Polling can be enabled even if HTTP caching is disabled. Detected changes trigger a rebuild of pages using the affected resource. Polling can be disabled for specific resources, typically those known to be static.

The default configuration disables everything:

{{< code-toggle file=hugo >}}
[[HTTPCache.polls]]
disable = true
high = '0s'
low = '0s'
[HTTPCache.polls.for]
includes = ['**']
excludes = []
{{< /code-toggle >}}

`polls`
: (`[]PollConfig`) A slice of polling configurations.

`polls.disable`
: (`bool`) Whether to disable polling for this configuration. Default is `true`.

`polls.high`
: (`string`) The maximum polling interval expressed as a [duration](g). This is used when the resource is considered stable. Default is `0s`.

`polls.low`
: (`string`) The minimum polling interval expressed as a [duration](g). This is used after a recent change and gradually increases towards `polls.high`. Default is `0s`.

`polls.for.excludes`
: (`[]string`) A list of [glob patterns](g) to exclude from polling for this configuration.

`polls.for.includes`
: (`[]string`) A list of [glob patterns](g) to include in polling for this configuration.

