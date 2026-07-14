## Multilingual projects

For multilingual projects, create a `params` key under each language:

{{< code-toggle file=hugo >}}
baseURL = 'https://example.org/'
defaultContentLanguage = 'en'

[languages.de]
direction = 'ltr'
label = 'Deutsch'
locale = 'de-DE'
title = 'Projekt Dokumentation'
weight = 1

[languages.de.params]
subtitle = 'Referenz, Tutorials und Erklärungen'

[languages.de.params.contact]
email = 'info@de.example.org'
phone = '+49 30 1234567'

[languages.en]
direction = 'ltr'
label = 'English'
locale = 'en-US'
title = 'Project Documentation'
weight = 2

[languages.en.params]
subtitle = 'Reference, Tutorials, and Explanations'

[languages.en.params.contact]
email = 'info@example.org'
phone = '+1 206-555-1212'
{{< /code-toggle >}}

