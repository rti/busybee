## Create a project

### Commands

> [!NOTE]
> **If you are a Windows user:**
>
> - Do not use the Command Prompt
> - Do not use Windows PowerShell
> - Run these commands from [PowerShell][] or a Linux terminal such as WSL or Git > Bash
>
> PowerShell and Windows PowerShell [are different applications][].

Verify that you have installed Hugo {{% param "minVersion" %}} or later.

```sh
hugo version
```

Run these commands to create a Hugo project with the [Ananke][] theme. The next section provides an explanation of each command.

```sh
hugo new project quickstart
cd quickstart
git init
git submodule add https://github.com/gohugo-ananke/ananke themes/ananke
echo "theme = 'ananke'" >> hugo.toml
hugo server
```

View your project at the URL displayed in your terminal. Press `Ctrl + C` to stop Hugo's development server.

### Explanation of commands

Create the [project skeleton][] for your project in the `quickstart` directory.

```sh
hugo new project quickstart
```

Change the current directory to the root of your project.

```sh
cd quickstart
```

Initialize an empty Git repository in the current directory.

```sh
git init
```

Clone the [Ananke][] theme into the `themes` directory, adding it to your project as a [Git submodule][].

```sh
git submodule add https://github.com/gohugo-ananke/ananke themes/ananke
```

Append a line to your project configuration file, indicating the current theme.

```sh
echo "theme = 'ananke'" >> hugo.toml
```

Start Hugo's development server.

```sh
hugo server
```

Press `Ctrl + C` to stop Hugo's development server.

