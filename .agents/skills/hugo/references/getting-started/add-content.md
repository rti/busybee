## Add content

Add a new page to your project.

```sh
hugo new content content/posts/my-first-post.md
```

Hugo created the file in the `content/posts` directory. Open the file with your editor.

```md
+++
title = 'My First Post'
date = 2024-01-14T07:07:07+01:00
draft = true
+++
```

Notice the `draft` value in the [front matter][] is `true`. By default, Hugo does not publish draft content when you build the project. Learn more about [draft, future, and expired content][].

Add some [Markdown][] to the body of the post, but do not change the `draft` value.

```md
+++
title = 'My First Post'
date = 2024-01-14T07:07:07+01:00
draft = true
+++
