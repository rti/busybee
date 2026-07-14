## Options

The `transform.Unmarshal` function accepts an options map.

`delimiter`
: (`string`) Applicable to CSV files. The delimiter used. Default is `,`.

`comment`
: (`string`) Applicable to CSV files. The comment character used in the CSV. If set, lines beginning with the comment character without preceding whitespace are ignored.

`format`
: {{< new-in 0.149.0 />}}
: (`string`) The serialization format of the input, one of `csv`, `json`, `org`, `toml`, `xml`, or `yaml`. If empty or unspecified, Hugo infers the format from the input. For resources, this option is only needed if the file lacks an extension or to override the inferred format. For strings, it's only required when the format is ambiguous.

`lazyQuotes`
: (`bool`) Applicable to CSV files. Whether to allow a quote in an unquoted field, or to allow a non-doubled quote in a quoted field. Default is `false`.

`targetType`
: {{< new-in 0.146.7 />}}
: (`string`) Applicable to CSV files. The target data type, either `slice` or `map`. Default is `slice`.

