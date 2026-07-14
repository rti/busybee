## Localized settings

Some configuration settings can be defined separately for each language. For example:

{{< code-toggle file=hugo >}}
[languages.en]
label = 'English'
locale = 'en-US'
timeZone = 'America/New_York'
title = 'Project Documentation'
weight = 1
[languages.en.pagination]
path = 'page'
[languages.en.params]
subtitle = 'Reference, Tutorials, and Explanations'
{{< /code-toggle >}}

The following configuration keys can be defined separately for each language:

{{< per-lang-config-keys >}}

Any key not defined in a `languages` object will fall back to the global value in the root of your project configuration.

