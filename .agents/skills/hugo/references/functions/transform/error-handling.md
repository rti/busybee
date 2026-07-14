## Error handling

There are three ways to handle errors:

1. Let KaTeX throw an error and fail the build. This is the default behavior.
1. Set the `throwOnError` option to `false` to make KaTeX render the expression as an error instead of throwing an error. See [options](#options).
1. Handle the error in your template.

The example below demonstrates error handing within a template.

