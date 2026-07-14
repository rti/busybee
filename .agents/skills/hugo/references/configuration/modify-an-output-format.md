## Modify an output format

You can modify any of the default output formats. For example, to prioritize `json` rendering over `html` rendering, when both are generated, adjust the [`weight`](#weight):

{{< code-toggle file=hugo >}}
[outputFormats.json]
weight = 1
[outputFormats.html]
weight = 2
{{< /code-toggle >}}

The example above shows that when you modify a default content format, you only need to define the properties that differ from their default values.

