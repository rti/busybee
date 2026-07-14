## Destination URLs

Service|URL example
:--|:--
Amazon Simple Storage Service (S3)|`s3://my-bucket?region=us-west-1`
Azure Blob Storage|`azblob://my-container`
Google Cloud Storage (GCS)|`gs://my-bucket`

With Google Cloud Storage you can target a subdirectory:

```text
gs://my-bucket?prefix=a/subdirectory
```

You can also to deploy to storage servers compatible with Amazon S3 such as:

- [Ceph][]
- [MinIO][]
- [SeaweedFS][]

For example, the `url` for a MinIO deployment target might resemble this:

```text
s3://my-bucket?endpoint=https://my.minio.instance&awssdk=v2&use_path_style=true&disable_https=false
```

