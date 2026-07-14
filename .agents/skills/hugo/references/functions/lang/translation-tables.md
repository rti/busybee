## Translation tables

{{% glossary-term "translation table" %}}

For example:

```text
i18n/en.toml
i18n/pt-BR.toml
```

Hugo searches for a matching translation table using the following base names, in order:

1. The [`locale`][] of the current language
1. The [key][] of the current language
1. The locale of the [`defaultContentLanguage`][]
1. The key of the [`defaultContentLanguage`][]

Artificial languages with private use subtags as defined in [RFC 5646 § 2.2.7][] are also supported. You may omit the `art-x-` prefix for brevity. For example:

```text
i18n/art-x-hugolang.toml
i18n/hugolang.toml
```

> [!NOTE]
> Private use subtags must not exceed 8 alphanumeric characters.

