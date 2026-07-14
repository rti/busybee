## Redirects

By default, Hugo handles aliases by creating individual HTML files for each alias path. These files contain a `meta http-equiv="refresh"` tag to redirect the visitor via the browser.

While functional, generating a single `_redirects` file allows your hosting provider to handle redirects at the server level. This is more efficient than client-side redirection and improves performance by eliminating the need to load a middle-man HTML page.

> [!TIP]
> You can use the same general approach to generate an `.htaccess` file.

