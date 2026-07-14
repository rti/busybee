
---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/crypto/HMAC.md
---


Set the `HASH_TYPE` argument to `md5`, `sha1`, `sha256`, or `sha512`.

Set the optional `ENCODING` argument to either `hex` (default) or `binary`.

```go-html-template
{{ hmac "sha256" "Secret key" "Secret message" }}
5cceb491f45f8b154e20f3b0a30ed3a6ff3027d373f85c78ffe8983180b03c84

{{ hmac "sha256" "Secret key" "Secret message" "hex" }}
5cceb491f45f8b154e20f3b0a30ed3a6ff3027d373f85c78ffe8983180b03c84

{{ hmac "sha256" "Secret key" "Secret message" "binary" | base64Encode }}
XM60kfRfixVOIPOwow7Tpv8wJ9Nz+Fx4/+iYMYCwPIQ=
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/crypto/Hash.md
---


The `ALGORITHM` is one of `md5`, `sha1`, `sha256` (the default), `sha384`, or `sha512`:

```go-html-template
{{ crypto.Hash "sha256" "Hello world" }} → 64ec88ca00b268e5ba1a35678a1b5316d212f4f366b2477232534a8aeca37f3c
{{ "Hello world" | crypto.Hash "sha512" }} → b7f783baed8297f0db917462184ff4f08e69c2d5e5f79a942600f9725f58ce1f29c18139bf80b06c0fff2bdd34738452ecf40c488c22a7e3d80cdf6f9c1c0d47
```

If you omit the algorithm, it defaults to `sha256`:

```go-html-template
{{ "Hello world" | crypto.Hash }} → 64ec88ca00b268e5ba1a35678a1b5316d212f4f366b2477232534a8aeca37f3c
```

The supported algorithms match those used for the [Subresource Integrity] hash in [`.Data.Integrity`] on a fingerprinted resource. Combine `crypto.Hash` with [`encoding.HexDecode`] and [`encoding.Base64Encode`] to construct an SRI hash from a string:

```go-html-template
{{ $algo := "sha256" }}
{{ $integrity := printf "%s-%s" $algo ("Hello world" | crypto.Hash $algo | encoding.HexDecode | encoding.Base64Encode) }}
```

[Subresource Integrity]: https://developer.mozilla.org/en-US/docs/Web/Security/Subresource_Integrity
[`.Data.Integrity`]: /methods/resource/data/
[`encoding.HexDecode`]: /functions/encoding/hexdecode/
[`encoding.Base64Encode`]: /functions/encoding/base64encode/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/crypto/MD5.md
---


```go-html-template
{{ md5 "Hello world" }} → 3e25960a79dbc69b674cd4ec67a72c62
```

This can be useful if you want to use [Gravatar][] for generating a unique avatar:

```html
<img src="https://www.gravatar.com/avatar/{{ md5 "your@email.com" }}?s=100&d=identicon">
```

[Gravatar]: https://en.gravatar.com/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/crypto/SHA1.md
---


```go-html-template
{{ sha1 "Hello world" }} → 7b502c3a1f48c8609ae212cdfb639dee39673f5e
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/crypto/SHA256.md
---


```go-html-template
{{ sha256 "Hello world" }} → 64ec88ca00b268e5ba1a35678a1b5316d212f4f366b2477232534a8aeca37f3c
```

