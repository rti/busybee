## Language keys

Language keys must conform to the syntax described in [RFC 5646][]. For example:

{{< code-toggle file=hugo >}}
defaultContentLanguage = 'de'
[languages.de]
weight = 1
[languages.en-US]
weight = 2
[languages.pt-BR]
weight = 3
{{< /code-toggle >}}

Artificial languages with private use subtags as defined in [RFC 5646 § 2.2.7][] are also supported. Omit the `art-x-` prefix from the language key. For example:

{{< code-toggle file=hugo >}}
defaultContentLanguage = 'en'
[languages.en]
weight = 1
[languages.hugolang]
weight = 2
{{< /code-toggle >}}

> [!NOTE]
> Private use subtags must not exceed 8 alphanumeric characters.

