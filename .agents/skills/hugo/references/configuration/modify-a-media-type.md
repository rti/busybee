## Modify a media type

You can modify any of the default media types. For example, to switch the primary suffix for `text/html` from `html` to `htm`:

{{< code-toggle file=hugo >}}
[mediaTypes.'text/html']
suffixes = ['htm','html']
{{< /code-toggle >}}

If you alter a default media type, you must also explicitly redefine all output formats that utilize that media type. For example, to ensure the changes above affect the `html` output format, redefine the `html` output format:

{{< code-toggle file=hugo >}}
[outputFormats.html]
mediaType = 'text/html'
{{< /code-toggle >}}

