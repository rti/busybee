## Headers

Include headers in every server response to facilitate testing, particularly for features like [Content Security Policies][].

{{< code-toggle file=config/development/server >}}
[[headers]]
for = '/**'

[headers.values]
X-Frame-Options = 'DENY'
X-XSS-Protection = '1; mode=block'
X-Content-Type-Options = 'nosniff'
Referrer-Policy = 'strict-origin-when-cross-origin'
Content-Security-Policy = 'script-src localhost:1313'
{{< /code-toggle >}}

