## Configure the project

With your editor, open the [project configuration][] file in the root of your project directory:

```toml {file="hugo.toml"}
baseURL = 'https://example.org/'
locale = 'en-us'
title = 'My New Hugo Project'
theme = 'ananke'
```

Make the following changes:

1. Set the `baseURL` for your project. This value must begin with the protocol and end with a slash, as shown above.
1. Set the `locale` to your locale.
1. Set the `title` for your project.

Start Hugo's development server to see your changes, remembering to include draft content.

```sh
hugo server -D
```

> [!NOTE]
> Now that you have the Ananke theme installed, check out their [documentation][] and [demonstration site][] to learn how to configure and customize it.

