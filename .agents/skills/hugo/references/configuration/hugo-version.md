## Hugo version

You can specify a required Hugo version for your module in the `module` section. Users will then receive a warning if their Hugo version is incompatible.

This is the default configuration:

{{< code-toggle config=module.hugoVersion />}}

You can omit any of the settings above.

`extended`
: {{< deprecated-in v0.153.0 />}}
: (`bool`) Whether the extended edition of Hugo is required, satisfied by installing either the extended or extended/deploy edition.

  > [!NOTE]
  > The extended version check is disabled in v0.153.2 and later.
  >
  > Historically, certain features—specifically WebP encoding and LibSass—required the Hugo Extended binary. However, as of v0.153.0:
  >
  > - WebP encoding is now supported in all Hugo editions.
  > - LibSass has been deprecated in favor of [Dart Sass][], which is compatible with any Hugo edition.
  >
  > Because these dependencies no longer require a specialized binary, the internal enforcement check for the extended version has been removed. Site and theme authors are encouraged to use Dart Sass to ensure cross-edition compatibility.

`max`
: (`string`) The maximum Hugo version supported, for example `0.153.0`.

`min`
: (`string`) The minimum Hugo version supported, for example `0.102.0`.

