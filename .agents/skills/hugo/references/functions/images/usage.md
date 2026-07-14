## Usage

Create the filter:

```go-html-template
{{ $filter := images.UnsharpMask 10 0.4 0.03 }}
```

{{% include "/_common/functions/images/apply-image-filter.md" %}}

