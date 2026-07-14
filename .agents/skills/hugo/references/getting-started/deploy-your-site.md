## Deploy your site

> [!NOTE]
> As noted above, Hugo does not clear the `public` directory before building your project. Manually clear the contents of the `public` directory before each build to remove draft, expired, and future content.

When you are ready to deploy your site, run:

```sh
hugo
```

This builds your site, publishing the files to the `public` directory. The directory structure will look something like this:

```tree
public/
├── categories/
│   ├── index.html
│   └── index.xml  <-- RSS feed for this section
├── posts/
│   ├── my-first-post/
│   │   └── index.html
│   ├── index.html
│   └── index.xml  <-- RSS feed for this section
├── tags/
│   ├── index.html
│   └── index.xml  <-- RSS feed for this section
├── index.html
├── index.xml      <-- RSS feed for the site
└── sitemap.xml
```

In a simple hosting environment, where you typically `ftp`, `rsync`, or `scp` your files to the root of a virtual host, the contents of the `public` directory are all that you need.

Most of our users deploy their sites to a [CI/CD](g) platform, where a push[^1] to their remote Git repository triggers a build and deployment. Learn more in the [host and deploy][] section.

[^1]: The Git repository contains the entire project directory, typically excluding the `public` directory because the site is built _after_ the push.

[LiveReload]: https://github.com/livereload/livereload-js
[`--destination`]: /commands/hugo/#options
[`cascade`]: /content-management/front-matter/#cascade
[`hugo build`]: /commands/hugo/
[`hugo server`]: /commands/hugo_server/
[`publishDir`]: /configuration/all/#publishdir
[build options]: /content-management/build-options/
[front matter]: /content-management/front-matter/
[host and deploy]: /host-and-deploy/
[installing]: /installation/

