## Negation rules

{{< new-in 0.161.0 />}}

Any pattern in an allowlist can be negated by prefixing it with an exclamation mark (`!`) and one space to turn it into a deny rule. Deny rules take precedence over allow rules. An allowlist composed entirely of deny rules implicitly allows everything it does not deny. An empty allowlist rejects everything.

For example, to allow all URLs except those pointing to `evil.example.com`:

```toml
[security.http]
urls = ['.*', '! ^https?://evil\.example\.com']
```

Setting an allowlist to the string `none` will completely disable the associated feature.

