## Lookup order

Hugo selects _shortcode_ templates based on the shortcode name, the current output format, and the current language. The examples below are sorted by specificity in descending order. The least specific path is at the bottom of the list.

Shortcode name|Output format|Language|Template path
:--|:--|:--|:--
foo|html|en|`layouts/_shortcodes/foo.en.html`
foo|html|en|`layouts/_shortcodes/foo.html.html`
foo|html|en|`layouts/_shortcodes/foo.html`
foo|html|en|`layouts/_shortcodes/foo.html.en.html`

Shortcode name|Output format|Language|Template path
:--|:--|:--|:--
foo|rss|en|`layouts/_shortcodes/foo.en.rss.xml`
foo|rss|en|`layouts/_shortcodes/foo.rss.xml`
foo|rss|en|`layouts/_shortcodes/foo.en.xml`
foo|rss|en|`layouts/_shortcodes/foo.xml`

