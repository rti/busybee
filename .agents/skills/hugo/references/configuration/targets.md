## Targets

A target represents a deployment target such as "staging" or "production".

`cloudFrontDistributionID`
: (`string`) The CloudFront Distribution ID, applicable if you are using the Amazon Web Services CloudFront CDN. Hugo will invalidate the CDN when deploying this target.

`exclude`
: (`string`) A [glob pattern](g) matching files to exclude when deploying to this target. Local files failing the include/exclude filters are not uploaded, and remote files failing these filters are not deleted.

`googleCloudCDNOrigin`
: (`string`) The Google Cloud project and CDN origin to invalidate when deploying this target, specified as `<project>/<origin>`.

`include`
: (`string`) A [glob pattern](g) matching files to include when deploying to this target. Local files failing the include/exclude filters are not uploaded, and remote files failing these filters are not deleted.

`name`
: (`string`) An arbitrary name for this target.

`stripIndexHTML`
: (`bool`) Whether to map files named `<dir>/index.html` to `<dir>` on the remote (except for the root `index.html`). This is useful for key-value cloud storage (e.g., Amazon S3, Google Cloud Storage, Azure Blob Storage) to align canonical URLs with object keys. Default is `false`.

`url`
: (`string`) The [destination URL](#destination-urls) for deployment.

