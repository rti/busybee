## Types supported

- `block` and `span`
- `image`. Note that the image handling is currently basic; we link to the `asset.url` using `asset.altText` as the image alt text and `asset.title` as the title. For more fine-grained control you may want to process the images in an [image render hook][].
- `code` (see the [code-input][] plugin). Code will be rendered as fenced code blocks with any file name provided passed as a Markdown attribute.

> [!NOTE]
> Since the Portable Text gets converted to Markdown before it gets passed to Hugo, rendering of links, headings, images and code blocks can be controlled with [render hooks][].

