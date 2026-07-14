## Simple translations

Let's say your multilingual project supports two languages, English and Polish. Create a translation table for each language in the `i18n` directory.

```tree
i18n/
├── en.toml
└── pl.toml
```

The English translation table:

{{< code-toggle file=i18n/en >}}
privacy = 'privacy'
security = 'security'
{{< /code-toggle >}}

The Polish translation table:

{{< code-toggle file=i18n/pl >}}
privacy = 'prywatność'
security = 'bezpieczeństwo'
{{< /code-toggle >}}

> [!NOTE]
> The examples below use the `T` alias for brevity.

When viewing the English language site:

```go-html-template
{{ T "privacy" }} → privacy
{{ T "security" }} → security
````

When viewing the Polish language site:

```go-html-template
{{ T "privacy" }} → prywatność
{{ T "security" }} → bezpieczeństwo
```

