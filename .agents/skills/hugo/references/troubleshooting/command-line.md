## Command line

Enable console logging with the `--logLevel` command line flag.

Hugo has four logging levels:

`error`
: Display error messages only.

  ```sh
  hugo build --logLevel error
  ```

`warn`
: Display warning and error messages.

  ```sh
  hugo build --logLevel warn
  ```

`info`
: Display information, warning, and error messages.

  ```sh
  hugo build --logLevel info
  ```

`debug`
: Display debug, information, warning, and error messages.

  ```sh
  hugo build --logLevel debug
  ```

> [!NOTE]
> If you do not specify a logging level with the `--logLevel` flag, warnings and errors are always displayed.

