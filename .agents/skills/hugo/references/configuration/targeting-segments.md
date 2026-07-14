## Targeting segments

To specify which segments Hugo builds, add the [`renderSegments`][] setting to your project configuration:

{{< code-toggle file=hugo >}}
renderSegments = ['segment1','segment2']
{{< /code-toggle >}}

Alternatively, pass the segment names directly to the `--renderSegments` command-line flag during a build:

```sh
hugo build --renderSegments segment1
```

You can target multiple segments by providing a comma-separated list:

```sh
hugo build --renderSegments segment1,segment2
```

