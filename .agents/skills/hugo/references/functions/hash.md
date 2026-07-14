
---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/hash/FNV32a.md
---


```go-html-template
{{ hash.FNV32a "Hello world" }} → 1498229191
```


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/functions/hash/XxHash.md
---


```go-html-template
{{ hash.XxHash "Hello world" }} → c500b0c912b376d8
```

[xxHash][] is an exceptionally fast non-cryptographic hash algorithm. Hugo uses [this Go implementation][].

[this Go implementation]: https://github.com/cespare/xxhash
[xxHash]: https://xxhash.com/

