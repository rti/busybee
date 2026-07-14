## Build your project

To build your project, `cd` into your project directory and run:

```sh
hugo build
```

The [`hugo build`][] command builds your project, publishing the files to the `public` directory. To publish your project to a different directory, use the [`--destination`][] flag or set [`publishDir`][] in your project configuration.

> [!NOTE]
> Hugo does not clear the `public` directory before building your project. Existing files are overwritten, but not deleted. This behavior is intentional to prevent the inadvertent removal of files that you may have added to the `public` directory after the build.
>
> Depending on your needs, you may wish to manually clear the contents of the `public` directory before every build.

