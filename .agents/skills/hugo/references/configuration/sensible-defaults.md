## Sensible defaults

Hugo offers many configuration settings, but its defaults are often sufficient. A new project requires only these settings:

{{< code-toggle file=hugo >}}
baseURL = 'https://example.org/'
locale = 'en-us'
title = 'My New Hugo Site'
{{< /code-toggle >}}

Only define settings that deviate from the defaults. A smaller configuration file is easier to read, understand, and debug. Keep your configuration concise.

> [!NOTE]
> The best configuration file is a short configuration file.

