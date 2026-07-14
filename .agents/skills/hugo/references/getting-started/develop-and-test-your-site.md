## Develop and test your site

To view your site while developing layouts or creating content, `cd` into your project directory and run:

```sh
hugo server
```

The [`hugo server`][] command builds your site and serves your pages using a minimal HTTP server. When you run `hugo server` it will display the URL of your local site:

```text
Web Server is available at http://localhost:1313/
```

While the server is running, it watches your project directory for changes to assets, configuration, content, data, layouts, translations, and static files. When it detects a change, the server rebuilds your site and refreshes your browser using [LiveReload][].

Most Hugo builds are so fast that you may not notice the change unless you are looking directly at your browser.

### LiveReload

While the server is running, Hugo injects JavaScript into the generated HTML pages. The LiveReload script creates a connection from the browser to the server via web sockets. You do not need to install any software or browser plugins, nor is any configuration required.

### Automatic redirection

When editing content, if you want your browser to automatically redirect to the page you last modified, run:

```sh
hugo server --navigateToChanged
```

