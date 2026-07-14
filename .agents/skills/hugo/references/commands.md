
---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/commands/hugo.md
---

## hugo

Build your project

### Synopsis

hugo is the main command, used to build your Hugo project.

Hugo is a Fast and Flexible Static Site Generator
built with love by spf13 and friends in Go.

Complete documentation is available at https://gohugo.io/.

```
hugo [flags]
```

### Options

```
  -b, --baseURL string             hostname (and path) to the root, e.g. https://spf13.com/
  -D, --buildDrafts                include content marked as draft
  -E, --buildExpired               include expired content
  -F, --buildFuture                include content with publishdate in the future
      --cacheDir string            filesystem path to cache directory
      --cleanDestinationDir        remove files from destination not found in static directories
      --clock string               set the clock used by Hugo, e.g. --clock 2021-11-06T22:30:00.00+09:00
      --config string              config file (default is hugo.yaml|json|toml)
      --configDir string           config dir (default "config")
  -c, --contentDir string          filesystem path to content directory
  -d, --destination string         filesystem path to write files to
      --disableKinds strings       disable different kind of pages (home, RSS etc.)
      --enableGitInfo              add Git revision, date, author, and CODEOWNERS info to the pages
  -e, --environment string         build environment
      --forceSyncStatic            copy all files when static is changed.
      --gc                         enable to run some cleanup tasks (remove unused cache files) after the build
  -h, --help                       help for hugo
      --ignoreCache                ignore the configured file caches
      --ignoreVendorPaths string   ignores any _vendor for module paths matching the given Glob pattern
  -l, --layoutDir string           filesystem path to layout directory
      --logLevel string            log level (debug|info|warn|error)
      --minify                     minify any supported output format (HTML, XML etc.)
      --noBuildLock                don't create .hugo_build.lock file
      --noChmod                    don't sync permission mode of files
      --noTimes                    don't sync modification time of files
      --panicOnWarning             panic on first WARNING log
      --poll string                set this to a poll interval, e.g --poll 700ms, to use a poll based approach to watch for file system changes
      --printI18nWarnings          print missing translations
      --printMemoryUsage           print memory usage to screen at intervals
      --printPathWarnings          print warnings on duplicate target paths etc.
      --printUnusedTemplates       print warnings on unused templates.
      --quiet                      build in quiet mode
      --renderSegments strings     named segments to render (configured in the segments config)
  -M, --renderToMemory             render to memory (mostly useful when running the server)
  -s, --source string              filesystem path to read files relative from
      --templateMetrics            display metrics about template executions
      --templateMetricsHints       calculate some improvement hints when combined with --templateMetrics
  -t, --theme strings              themes to use (located in /themes/THEMENAME/)
      --themesDir string           filesystem path to themes directory
      --trace file                 write trace to file (not useful in general)
  -w, --watch                      watch filesystem for changes and recreate as needed
```

### SEE ALSO

* [hugo build](/commands/hugo_build/)	 - Build your project
* [hugo completion](/commands/hugo_completion/)	 - Generate the autocompletion script for the specified shell
* [hugo config](/commands/hugo_config/)	 - Display project configuration
* [hugo convert](/commands/hugo_convert/)	 - Convert front matter to another format
* [hugo deploy](/commands/hugo_deploy/)	 - Deploy your project to a cloud provider
* [hugo env](/commands/hugo_env/)	 - Display version and environment info
* [hugo gen](/commands/hugo_gen/)	 - Generate documentation and syntax highlighting styles
* [hugo import](/commands/hugo_import/)	 - Import a project from another system
* [hugo list](/commands/hugo_list/)	 - List content
* [hugo mod](/commands/hugo_mod/)	 - Manage modules
* [hugo new](/commands/hugo_new/)	 - Create new content
* [hugo server](/commands/hugo_server/)	 - Start the embedded web server
* [hugo version](/commands/hugo_version/)	 - Display version


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/commands/hugo_build.md
---

## hugo build

Build your project

### Synopsis

build is the main command, used to build your Hugo project.

Hugo is a Fast and Flexible Static Site Generator
built with love by spf13 and friends in Go.

Complete documentation is available at https://gohugo.io/.

```
hugo build [flags]
```

### Options

```
  -b, --baseURL string             hostname (and path) to the root, e.g. https://spf13.com/
  -D, --buildDrafts                include content marked as draft
  -E, --buildExpired               include expired content
  -F, --buildFuture                include content with publishdate in the future
      --cacheDir string            filesystem path to cache directory
      --cleanDestinationDir        remove files from destination not found in static directories
      --clock string               set the clock used by Hugo, e.g. --clock 2021-11-06T22:30:00.00+09:00
      --config string              config file (default is hugo.yaml|json|toml)
      --configDir string           config dir (default "config")
  -c, --contentDir string          filesystem path to content directory
  -d, --destination string         filesystem path to write files to
      --disableKinds strings       disable different kind of pages (home, RSS etc.)
      --enableGitInfo              add Git revision, date, author, and CODEOWNERS info to the pages
  -e, --environment string         build environment
      --forceSyncStatic            copy all files when static is changed.
      --gc                         enable to run some cleanup tasks (remove unused cache files) after the build
  -h, --help                       help for build
      --ignoreCache                ignore the configured file caches
      --ignoreVendorPaths string   ignores any _vendor for module paths matching the given Glob pattern
  -l, --layoutDir string           filesystem path to layout directory
      --logLevel string            log level (debug|info|warn|error)
      --minify                     minify any supported output format (HTML, XML etc.)
      --noBuildLock                don't create .hugo_build.lock file
      --noChmod                    don't sync permission mode of files
      --noTimes                    don't sync modification time of files
      --panicOnWarning             panic on first WARNING log
      --poll string                set this to a poll interval, e.g --poll 700ms, to use a poll based approach to watch for file system changes
      --printI18nWarnings          print missing translations
      --printMemoryUsage           print memory usage to screen at intervals
      --printPathWarnings          print warnings on duplicate target paths etc.
      --printUnusedTemplates       print warnings on unused templates.
      --quiet                      build in quiet mode
      --renderSegments strings     named segments to render (configured in the segments config)
  -M, --renderToMemory             render to memory (mostly useful when running the server)
  -s, --source string              filesystem path to read files relative from
      --templateMetrics            display metrics about template executions
      --templateMetricsHints       calculate some improvement hints when combined with --templateMetrics
  -t, --theme strings              themes to use (located in /themes/THEMENAME/)
      --themesDir string           filesystem path to themes directory
      --trace file                 write trace to file (not useful in general)
  -w, --watch                      watch filesystem for changes and recreate as needed
```

### SEE ALSO

* [hugo](/commands/hugo/)	 - Build your project


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/commands/hugo_completion.md
---

## hugo completion

Generate the autocompletion script for the specified shell

### Synopsis

Generate the autocompletion script for hugo for the specified shell.
See each sub-command's help for details on how to use the generated script.


### Options

```
  -h, --help   help for completion
```

### Options inherited from parent commands

```
      --clock string               set the clock used by Hugo, e.g. --clock 2021-11-06T22:30:00.00+09:00
      --config string              config file (default is hugo.yaml|json|toml)
      --configDir string           config dir (default "config")
  -d, --destination string         filesystem path to write files to
  -e, --environment string         build environment
      --ignoreVendorPaths string   ignores any _vendor for module paths matching the given Glob pattern
      --logLevel string            log level (debug|info|warn|error)
      --noBuildLock                don't create .hugo_build.lock file
      --quiet                      build in quiet mode
  -M, --renderToMemory             render to memory (mostly useful when running the server)
  -s, --source string              filesystem path to read files relative from
      --themesDir string           filesystem path to themes directory
```

### SEE ALSO

* [hugo](/commands/hugo/)	 - Build your project
* [hugo completion bash](/commands/hugo_completion_bash/)	 - Generate the autocompletion script for bash
* [hugo completion fish](/commands/hugo_completion_fish/)	 - Generate the autocompletion script for fish
* [hugo completion powershell](/commands/hugo_completion_powershell/)	 - Generate the autocompletion script for powershell
* [hugo completion zsh](/commands/hugo_completion_zsh/)	 - Generate the autocompletion script for zsh


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/commands/hugo_completion_bash.md
---

## hugo completion bash

Generate the autocompletion script for bash

### Synopsis

Generate the autocompletion script for the bash shell.

This script depends on the 'bash-completion' package.
If it is not installed already, you can install it via your OS's package manager.

To load completions in your current shell session:

	source <(hugo completion bash)

To load completions for every new session, execute once:

#### Linux:

	hugo completion bash > /etc/bash_completion.d/hugo

#### macOS:

	hugo completion bash > $(brew --prefix)/etc/bash_completion.d/hugo

You will need to start a new shell for this setup to take effect.


```
hugo completion bash
```

### Options

```
  -h, --help              help for bash
      --no-descriptions   disable completion descriptions
```

### Options inherited from parent commands

```
      --clock string               set the clock used by Hugo, e.g. --clock 2021-11-06T22:30:00.00+09:00
      --config string              config file (default is hugo.yaml|json|toml)
      --configDir string           config dir (default "config")
  -d, --destination string         filesystem path to write files to
  -e, --environment string         build environment
      --ignoreVendorPaths string   ignores any _vendor for module paths matching the given Glob pattern
      --logLevel string            log level (debug|info|warn|error)
      --noBuildLock                don't create .hugo_build.lock file
      --quiet                      build in quiet mode
  -M, --renderToMemory             render to memory (mostly useful when running the server)
  -s, --source string              filesystem path to read files relative from
      --themesDir string           filesystem path to themes directory
```

### SEE ALSO

* [hugo completion](/commands/hugo_completion/)	 - Generate the autocompletion script for the specified shell


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/commands/hugo_completion_fish.md
---

## hugo completion fish

Generate the autocompletion script for fish

### Synopsis

Generate the autocompletion script for the fish shell.

To load completions in your current shell session:

	hugo completion fish | source

To load completions for every new session, execute once:

	hugo completion fish > ~/.config/fish/completions/hugo.fish

You will need to start a new shell for this setup to take effect.


```
hugo completion fish [flags]
```

### Options

```
  -h, --help              help for fish
      --no-descriptions   disable completion descriptions
```

### Options inherited from parent commands

```
      --clock string               set the clock used by Hugo, e.g. --clock 2021-11-06T22:30:00.00+09:00
      --config string              config file (default is hugo.yaml|json|toml)
      --configDir string           config dir (default "config")
  -d, --destination string         filesystem path to write files to
  -e, --environment string         build environment
      --ignoreVendorPaths string   ignores any _vendor for module paths matching the given Glob pattern
      --logLevel string            log level (debug|info|warn|error)
      --noBuildLock                don't create .hugo_build.lock file
      --quiet                      build in quiet mode
  -M, --renderToMemory             render to memory (mostly useful when running the server)
  -s, --source string              filesystem path to read files relative from
      --themesDir string           filesystem path to themes directory
```

### SEE ALSO

* [hugo completion](/commands/hugo_completion/)	 - Generate the autocompletion script for the specified shell


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/commands/hugo_completion_powershell.md
---

## hugo completion powershell

Generate the autocompletion script for powershell

### Synopsis

Generate the autocompletion script for powershell.

To load completions in your current shell session:

	hugo completion powershell | Out-String | Invoke-Expression

To load completions for every new session, add the output of the above command
to your powershell profile.


```
hugo completion powershell [flags]
```

### Options

```
  -h, --help              help for powershell
      --no-descriptions   disable completion descriptions
```

### Options inherited from parent commands

```
      --clock string               set the clock used by Hugo, e.g. --clock 2021-11-06T22:30:00.00+09:00
      --config string              config file (default is hugo.yaml|json|toml)
      --configDir string           config dir (default "config")
  -d, --destination string         filesystem path to write files to
  -e, --environment string         build environment
      --ignoreVendorPaths string   ignores any _vendor for module paths matching the given Glob pattern
      --logLevel string            log level (debug|info|warn|error)
      --noBuildLock                don't create .hugo_build.lock file
      --quiet                      build in quiet mode
  -M, --renderToMemory             render to memory (mostly useful when running the server)
  -s, --source string              filesystem path to read files relative from
      --themesDir string           filesystem path to themes directory
```

### SEE ALSO

* [hugo completion](/commands/hugo_completion/)	 - Generate the autocompletion script for the specified shell


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/commands/hugo_completion_zsh.md
---

## hugo completion zsh

Generate the autocompletion script for zsh

### Synopsis

Generate the autocompletion script for the zsh shell.

If shell completion is not already enabled in your environment you will need
to enable it.  You can execute the following once:

	echo "autoload -U compinit; compinit" >> ~/.zshrc

To load completions in your current shell session:

	source <(hugo completion zsh)

To load completions for every new session, execute once:

#### Linux:

	hugo completion zsh > "${fpath[1]}/_hugo"

#### macOS:

	hugo completion zsh > $(brew --prefix)/share/zsh/site-functions/_hugo

You will need to start a new shell for this setup to take effect.


```
hugo completion zsh [flags]
```

### Options

```
  -h, --help              help for zsh
      --no-descriptions   disable completion descriptions
```

### Options inherited from parent commands

```
      --clock string               set the clock used by Hugo, e.g. --clock 2021-11-06T22:30:00.00+09:00
      --config string              config file (default is hugo.yaml|json|toml)
      --configDir string           config dir (default "config")
  -d, --destination string         filesystem path to write files to
  -e, --environment string         build environment
      --ignoreVendorPaths string   ignores any _vendor for module paths matching the given Glob pattern
      --logLevel string            log level (debug|info|warn|error)
      --noBuildLock                don't create .hugo_build.lock file
      --quiet                      build in quiet mode
  -M, --renderToMemory             render to memory (mostly useful when running the server)
  -s, --source string              filesystem path to read files relative from
      --themesDir string           filesystem path to themes directory
```

### SEE ALSO

* [hugo completion](/commands/hugo_completion/)	 - Generate the autocompletion script for the specified shell


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/commands/hugo_config.md
---

## hugo config

Display project configuration

### Synopsis

Display project configuration, both default and custom settings.

```
hugo config [command] [flags]
```

### Options

```
  -b, --baseURL string           hostname (and path) to the root, e.g. https://spf13.com/
      --cacheDir string          filesystem path to cache directory
  -c, --contentDir string        filesystem path to content directory
      --format string            preferred file format (toml, yaml or json) (default "toml")
  -h, --help                     help for config
      --lang string              the language to display config for. Defaults to the first language defined.
      --printZero                include config options with zero values (e.g. false, 0, "") in the output
      --renderSegments strings   named segments to render (configured in the segments config)
  -t, --theme strings            themes to use (located in /themes/THEMENAME/)
```

### Options inherited from parent commands

```
      --clock string               set the clock used by Hugo, e.g. --clock 2021-11-06T22:30:00.00+09:00
      --config string              config file (default is hugo.yaml|json|toml)
      --configDir string           config dir (default "config")
  -d, --destination string         filesystem path to write files to
  -e, --environment string         build environment
      --ignoreVendorPaths string   ignores any _vendor for module paths matching the given Glob pattern
      --logLevel string            log level (debug|info|warn|error)
      --noBuildLock                don't create .hugo_build.lock file
      --quiet                      build in quiet mode
  -M, --renderToMemory             render to memory (mostly useful when running the server)
  -s, --source string              filesystem path to read files relative from
      --themesDir string           filesystem path to themes directory
```

### SEE ALSO

* [hugo](/commands/hugo/)	 - Build your project
* [hugo config mounts](/commands/hugo_config_mounts/)	 - Print the configured file mounts


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/commands/hugo_config_mounts.md
---

## hugo config mounts

Print the configured file mounts

```
hugo config mounts [flags] [args]
```

### Options

```
  -b, --baseURL string           hostname (and path) to the root, e.g. https://spf13.com/
      --cacheDir string          filesystem path to cache directory
  -c, --contentDir string        filesystem path to content directory
  -h, --help                     help for mounts
      --renderSegments strings   named segments to render (configured in the segments config)
  -t, --theme strings            themes to use (located in /themes/THEMENAME/)
```

### Options inherited from parent commands

```
      --clock string               set the clock used by Hugo, e.g. --clock 2021-11-06T22:30:00.00+09:00
      --config string              config file (default is hugo.yaml|json|toml)
      --configDir string           config dir (default "config")
  -d, --destination string         filesystem path to write files to
  -e, --environment string         build environment
      --ignoreVendorPaths string   ignores any _vendor for module paths matching the given Glob pattern
      --logLevel string            log level (debug|info|warn|error)
      --noBuildLock                don't create .hugo_build.lock file
      --quiet                      build in quiet mode
  -M, --renderToMemory             render to memory (mostly useful when running the server)
  -s, --source string              filesystem path to read files relative from
      --themesDir string           filesystem path to themes directory
```

### SEE ALSO

* [hugo config](/commands/hugo_config/)	 - Display project configuration


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/commands/hugo_convert.md
---

## hugo convert

Convert front matter to another format

### Synopsis

Convert front matter to another format.

See convert's subcommands toJSON, toTOML and toYAML for more information.

### Options

```
  -h, --help            help for convert
  -o, --output string   filesystem path to write files to
      --unsafe          enable less safe operations, please backup first
```

### Options inherited from parent commands

```
      --clock string               set the clock used by Hugo, e.g. --clock 2021-11-06T22:30:00.00+09:00
      --config string              config file (default is hugo.yaml|json|toml)
      --configDir string           config dir (default "config")
  -d, --destination string         filesystem path to write files to
  -e, --environment string         build environment
      --ignoreVendorPaths string   ignores any _vendor for module paths matching the given Glob pattern
      --logLevel string            log level (debug|info|warn|error)
      --noBuildLock                don't create .hugo_build.lock file
      --quiet                      build in quiet mode
  -M, --renderToMemory             render to memory (mostly useful when running the server)
  -s, --source string              filesystem path to read files relative from
      --themesDir string           filesystem path to themes directory
```

### SEE ALSO

* [hugo](/commands/hugo/)	 - Build your project
* [hugo convert toJSON](/commands/hugo_convert_tojson/)	 - Convert front matter to JSON
* [hugo convert toTOML](/commands/hugo_convert_totoml/)	 - Convert front matter to TOML
* [hugo convert toYAML](/commands/hugo_convert_toyaml/)	 - Convert front matter to YAML


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/commands/hugo_convert_toJSON.md
---

## hugo convert toJSON

Convert front matter to JSON

### Synopsis

toJSON converts all front matter in the content directory
to use JSON for the front matter.

```
hugo convert toJSON [flags] [args]
```

### Options

```
  -h, --help   help for toJSON
```

### Options inherited from parent commands

```
      --clock string               set the clock used by Hugo, e.g. --clock 2021-11-06T22:30:00.00+09:00
      --config string              config file (default is hugo.yaml|json|toml)
      --configDir string           config dir (default "config")
  -d, --destination string         filesystem path to write files to
  -e, --environment string         build environment
      --ignoreVendorPaths string   ignores any _vendor for module paths matching the given Glob pattern
      --logLevel string            log level (debug|info|warn|error)
      --noBuildLock                don't create .hugo_build.lock file
  -o, --output string              filesystem path to write files to
      --quiet                      build in quiet mode
  -M, --renderToMemory             render to memory (mostly useful when running the server)
  -s, --source string              filesystem path to read files relative from
      --themesDir string           filesystem path to themes directory
      --unsafe                     enable less safe operations, please backup first
```

### SEE ALSO

* [hugo convert](/commands/hugo_convert/)	 - Convert front matter to another format


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/commands/hugo_convert_toTOML.md
---

## hugo convert toTOML

Convert front matter to TOML

### Synopsis

toTOML converts all front matter in the content directory
to use TOML for the front matter.

```
hugo convert toTOML [flags] [args]
```

### Options

```
  -h, --help   help for toTOML
```

### Options inherited from parent commands

```
      --clock string               set the clock used by Hugo, e.g. --clock 2021-11-06T22:30:00.00+09:00
      --config string              config file (default is hugo.yaml|json|toml)
      --configDir string           config dir (default "config")
  -d, --destination string         filesystem path to write files to
  -e, --environment string         build environment
      --ignoreVendorPaths string   ignores any _vendor for module paths matching the given Glob pattern
      --logLevel string            log level (debug|info|warn|error)
      --noBuildLock                don't create .hugo_build.lock file
  -o, --output string              filesystem path to write files to
      --quiet                      build in quiet mode
  -M, --renderToMemory             render to memory (mostly useful when running the server)
  -s, --source string              filesystem path to read files relative from
      --themesDir string           filesystem path to themes directory
      --unsafe                     enable less safe operations, please backup first
```

### SEE ALSO

* [hugo convert](/commands/hugo_convert/)	 - Convert front matter to another format


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/commands/hugo_convert_toYAML.md
---

## hugo convert toYAML

Convert front matter to YAML

### Synopsis

toYAML converts all front matter in the content directory
to use YAML for the front matter.

```
hugo convert toYAML [flags] [args]
```

### Options

```
  -h, --help   help for toYAML
```

### Options inherited from parent commands

```
      --clock string               set the clock used by Hugo, e.g. --clock 2021-11-06T22:30:00.00+09:00
      --config string              config file (default is hugo.yaml|json|toml)
      --configDir string           config dir (default "config")
  -d, --destination string         filesystem path to write files to
  -e, --environment string         build environment
      --ignoreVendorPaths string   ignores any _vendor for module paths matching the given Glob pattern
      --logLevel string            log level (debug|info|warn|error)
      --noBuildLock                don't create .hugo_build.lock file
  -o, --output string              filesystem path to write files to
      --quiet                      build in quiet mode
  -M, --renderToMemory             render to memory (mostly useful when running the server)
  -s, --source string              filesystem path to read files relative from
      --themesDir string           filesystem path to themes directory
      --unsafe                     enable less safe operations, please backup first
```

### SEE ALSO

* [hugo convert](/commands/hugo_convert/)	 - Convert front matter to another format


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/commands/hugo_deploy.md
---

## hugo deploy

Deploy your project to a cloud provider

### Synopsis

Deploy your project to a cloud provider

See https://gohugo.io/hosting-and-deployment/hugo-deploy/ for detailed
documentation.


```
hugo deploy [flags] [args]
```

### Options

```
      --confirm          ask for confirmation before making changes to the target
      --dryRun           dry run
      --force            force upload of all files
  -h, --help             help for deploy
      --invalidateCDN    invalidate the CDN cache listed in the deployment target (default true)
      --maxDeletes int   maximum # of files to delete, or -1 to disable (default 256)
      --target string    target deployment from deployments section in config file; defaults to the first one
      --workers int      number of workers to transfer files. defaults to 10 (default 10)
```

### Options inherited from parent commands

```
      --clock string               set the clock used by Hugo, e.g. --clock 2021-11-06T22:30:00.00+09:00
      --config string              config file (default is hugo.yaml|json|toml)
      --configDir string           config dir (default "config")
  -d, --destination string         filesystem path to write files to
  -e, --environment string         build environment
      --ignoreVendorPaths string   ignores any _vendor for module paths matching the given Glob pattern
      --logLevel string            log level (debug|info|warn|error)
      --noBuildLock                don't create .hugo_build.lock file
      --quiet                      build in quiet mode
  -M, --renderToMemory             render to memory (mostly useful when running the server)
  -s, --source string              filesystem path to read files relative from
      --themesDir string           filesystem path to themes directory
```

### SEE ALSO

* [hugo](/commands/hugo/)	 - Build your project


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/commands/hugo_env.md
---

## hugo env

Display version and environment info

### Synopsis

Display version and environment info. This is useful in Hugo bug reports

```
hugo env [flags] [args]
```

### Options

```
  -h, --help   help for env
```

### Options inherited from parent commands

```
      --clock string               set the clock used by Hugo, e.g. --clock 2021-11-06T22:30:00.00+09:00
      --config string              config file (default is hugo.yaml|json|toml)
      --configDir string           config dir (default "config")
  -d, --destination string         filesystem path to write files to
  -e, --environment string         build environment
      --ignoreVendorPaths string   ignores any _vendor for module paths matching the given Glob pattern
      --logLevel string            log level (debug|info|warn|error)
      --noBuildLock                don't create .hugo_build.lock file
      --quiet                      build in quiet mode
  -M, --renderToMemory             render to memory (mostly useful when running the server)
  -s, --source string              filesystem path to read files relative from
      --themesDir string           filesystem path to themes directory
```

### SEE ALSO

* [hugo](/commands/hugo/)	 - Build your project


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/commands/hugo_gen.md
---

## hugo gen

Generate documentation and syntax highlighting styles

### Synopsis

Generate documentation for your project using Hugo's documentation engine, including syntax highlighting for various programming languages.

### Options

```
  -h, --help   help for gen
```

### Options inherited from parent commands

```
      --clock string               set the clock used by Hugo, e.g. --clock 2021-11-06T22:30:00.00+09:00
      --config string              config file (default is hugo.yaml|json|toml)
      --configDir string           config dir (default "config")
  -d, --destination string         filesystem path to write files to
  -e, --environment string         build environment
      --ignoreVendorPaths string   ignores any _vendor for module paths matching the given Glob pattern
      --logLevel string            log level (debug|info|warn|error)
      --noBuildLock                don't create .hugo_build.lock file
      --quiet                      build in quiet mode
  -M, --renderToMemory             render to memory (mostly useful when running the server)
  -s, --source string              filesystem path to read files relative from
      --themesDir string           filesystem path to themes directory
```

### SEE ALSO

* [hugo](/commands/hugo/)	 - Build your project
* [hugo gen chromastyles](/commands/hugo_gen_chromastyles/)	 - Generate CSS stylesheet for the Chroma code highlighter
* [hugo gen doc](/commands/hugo_gen_doc/)	 - Generate Markdown documentation for the Hugo CLI
* [hugo gen man](/commands/hugo_gen_man/)	 - Generate man pages for the Hugo CLI


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/commands/hugo_gen_chromastyles.md
---

## hugo gen chromastyles

Generate CSS stylesheet for the Chroma code highlighter

### Synopsis

Generate CSS stylesheet for the Chroma code highlighter for a given style. This stylesheet is needed if markup.highlight.noClasses is disabled in config.

See https://gohugo.io/quick-reference/syntax-highlighting-styles/ for a preview of the available styles.

```
hugo gen chromastyles [flags] [args]
```

### Options

```
  -h, --help                            help for chromastyles
      --highlightStyle string           foreground and background colors for highlighted lines, e.g. --highlightStyle "#fff000 bg:#000fff"
      --lineNumbersInlineStyle string   foreground and background colors for inline line numbers, e.g. --lineNumbersInlineStyle "#fff000 bg:#000fff"
      --lineNumbersTableStyle string    foreground and background colors for table line numbers, e.g. --lineNumbersTableStyle "#fff000 bg:#000fff"
      --omitClassComments               omit CSS class comment prefixes in the generated CSS
      --omitEmpty                       omit empty CSS rules (deprecated, no longer needed)
      --style string                    highlighter style (default "friendly")
```

### Options inherited from parent commands

```
      --clock string               set the clock used by Hugo, e.g. --clock 2021-11-06T22:30:00.00+09:00
      --config string              config file (default is hugo.yaml|json|toml)
      --configDir string           config dir (default "config")
  -d, --destination string         filesystem path to write files to
  -e, --environment string         build environment
      --ignoreVendorPaths string   ignores any _vendor for module paths matching the given Glob pattern
      --logLevel string            log level (debug|info|warn|error)
      --noBuildLock                don't create .hugo_build.lock file
      --quiet                      build in quiet mode
  -M, --renderToMemory             render to memory (mostly useful when running the server)
  -s, --source string              filesystem path to read files relative from
      --themesDir string           filesystem path to themes directory
```

### SEE ALSO

* [hugo gen](/commands/hugo_gen/)	 - Generate documentation and syntax highlighting styles


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/commands/hugo_gen_doc.md
---

## hugo gen doc

Generate Markdown documentation for the Hugo CLI

### Synopsis

Generate Markdown documentation for the Hugo CLI.
			This command is, mostly, used to create up-to-date documentation
	of Hugo's command-line interface for https://gohugo.io/.

	It creates one Markdown file per command with front matter suitable
	for rendering in Hugo.

```
hugo gen doc [flags] [args]
```

### Options

```
      --dir string   the directory to write the doc. (default "/tmp/hugodoc/")
  -h, --help         help for doc
```

### Options inherited from parent commands

```
      --clock string               set the clock used by Hugo, e.g. --clock 2021-11-06T22:30:00.00+09:00
      --config string              config file (default is hugo.yaml|json|toml)
      --configDir string           config dir (default "config")
  -d, --destination string         filesystem path to write files to
  -e, --environment string         build environment
      --ignoreVendorPaths string   ignores any _vendor for module paths matching the given Glob pattern
      --logLevel string            log level (debug|info|warn|error)
      --noBuildLock                don't create .hugo_build.lock file
      --quiet                      build in quiet mode
  -M, --renderToMemory             render to memory (mostly useful when running the server)
  -s, --source string              filesystem path to read files relative from
      --themesDir string           filesystem path to themes directory
```

### SEE ALSO

* [hugo gen](/commands/hugo_gen/)	 - Generate documentation and syntax highlighting styles


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/commands/hugo_gen_man.md
---

## hugo gen man

Generate man pages for the Hugo CLI

### Synopsis

This command automatically generates up-to-date man pages of Hugo's
	command-line interface.  By default, it creates the man page files
	in the "man" directory under the current directory.

```
hugo gen man [flags] [args]
```

### Options

```
      --dir string   the directory to write the man pages. (default "man/")
  -h, --help         help for man
```

### Options inherited from parent commands

```
      --clock string               set the clock used by Hugo, e.g. --clock 2021-11-06T22:30:00.00+09:00
      --config string              config file (default is hugo.yaml|json|toml)
      --configDir string           config dir (default "config")
  -d, --destination string         filesystem path to write files to
  -e, --environment string         build environment
      --ignoreVendorPaths string   ignores any _vendor for module paths matching the given Glob pattern
      --logLevel string            log level (debug|info|warn|error)
      --noBuildLock                don't create .hugo_build.lock file
      --quiet                      build in quiet mode
  -M, --renderToMemory             render to memory (mostly useful when running the server)
  -s, --source string              filesystem path to read files relative from
      --themesDir string           filesystem path to themes directory
```

### SEE ALSO

* [hugo gen](/commands/hugo_gen/)	 - Generate documentation and syntax highlighting styles


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/commands/hugo_import.md
---

## hugo import

Import a project from another system

### Synopsis

Import a project from another system.

Import requires a subcommand, e.g. `hugo import jekyll jekyll_root_path target_path`.

### Options

```
  -h, --help   help for import
```

### Options inherited from parent commands

```
      --clock string               set the clock used by Hugo, e.g. --clock 2021-11-06T22:30:00.00+09:00
      --config string              config file (default is hugo.yaml|json|toml)
      --configDir string           config dir (default "config")
  -d, --destination string         filesystem path to write files to
  -e, --environment string         build environment
      --ignoreVendorPaths string   ignores any _vendor for module paths matching the given Glob pattern
      --logLevel string            log level (debug|info|warn|error)
      --noBuildLock                don't create .hugo_build.lock file
      --quiet                      build in quiet mode
  -M, --renderToMemory             render to memory (mostly useful when running the server)
  -s, --source string              filesystem path to read files relative from
      --themesDir string           filesystem path to themes directory
```

### SEE ALSO

* [hugo](/commands/hugo/)	 - Build your project
* [hugo import jekyll](/commands/hugo_import_jekyll/)	 - hugo import from Jekyll


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/commands/hugo_import_jekyll.md
---

## hugo import jekyll

hugo import from Jekyll

### Synopsis

hugo import from Jekyll.

Import from Jekyll requires two paths, e.g. `hugo import jekyll jekyll_root_path target_path`.

```
hugo import jekyll [flags] [args]
```

### Options

```
      --force   allow import into non-empty target directory
  -h, --help    help for jekyll
```

### Options inherited from parent commands

```
      --clock string               set the clock used by Hugo, e.g. --clock 2021-11-06T22:30:00.00+09:00
      --config string              config file (default is hugo.yaml|json|toml)
      --configDir string           config dir (default "config")
  -d, --destination string         filesystem path to write files to
  -e, --environment string         build environment
      --ignoreVendorPaths string   ignores any _vendor for module paths matching the given Glob pattern
      --logLevel string            log level (debug|info|warn|error)
      --noBuildLock                don't create .hugo_build.lock file
      --quiet                      build in quiet mode
  -M, --renderToMemory             render to memory (mostly useful when running the server)
  -s, --source string              filesystem path to read files relative from
      --themesDir string           filesystem path to themes directory
```

### SEE ALSO

* [hugo import](/commands/hugo_import/)	 - Import a project from another system


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/commands/hugo_list.md
---

## hugo list

List content

### Synopsis

List content.

List requires a subcommand, e.g. hugo list drafts

### Options

```
  -h, --help   help for list
```

### Options inherited from parent commands

```
      --clock string               set the clock used by Hugo, e.g. --clock 2021-11-06T22:30:00.00+09:00
      --config string              config file (default is hugo.yaml|json|toml)
      --configDir string           config dir (default "config")
  -d, --destination string         filesystem path to write files to
  -e, --environment string         build environment
      --ignoreVendorPaths string   ignores any _vendor for module paths matching the given Glob pattern
      --logLevel string            log level (debug|info|warn|error)
      --noBuildLock                don't create .hugo_build.lock file
      --quiet                      build in quiet mode
  -M, --renderToMemory             render to memory (mostly useful when running the server)
  -s, --source string              filesystem path to read files relative from
      --themesDir string           filesystem path to themes directory
```

### SEE ALSO

* [hugo](/commands/hugo/)	 - Build your project
* [hugo list all](/commands/hugo_list_all/)	 - List all content
* [hugo list drafts](/commands/hugo_list_drafts/)	 - List draft content
* [hugo list expired](/commands/hugo_list_expired/)	 - List expired content
* [hugo list future](/commands/hugo_list_future/)	 - List future content
* [hugo list published](/commands/hugo_list_published/)	 - List published content


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/commands/hugo_list_all.md
---

## hugo list all

List all content

### Synopsis

List all content including draft, future, and expired.

```
hugo list all [flags] [args]
```

### Options

```
  -h, --help   help for all
```

### Options inherited from parent commands

```
      --clock string               set the clock used by Hugo, e.g. --clock 2021-11-06T22:30:00.00+09:00
      --config string              config file (default is hugo.yaml|json|toml)
      --configDir string           config dir (default "config")
  -d, --destination string         filesystem path to write files to
  -e, --environment string         build environment
      --ignoreVendorPaths string   ignores any _vendor for module paths matching the given Glob pattern
      --logLevel string            log level (debug|info|warn|error)
      --noBuildLock                don't create .hugo_build.lock file
      --quiet                      build in quiet mode
  -M, --renderToMemory             render to memory (mostly useful when running the server)
  -s, --source string              filesystem path to read files relative from
      --themesDir string           filesystem path to themes directory
```

### SEE ALSO

* [hugo list](/commands/hugo_list/)	 - List content


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/commands/hugo_list_drafts.md
---

## hugo list drafts

List draft content

### Synopsis

List draft content.

```
hugo list drafts [flags] [args]
```

### Options

```
  -h, --help   help for drafts
```

### Options inherited from parent commands

```
      --clock string               set the clock used by Hugo, e.g. --clock 2021-11-06T22:30:00.00+09:00
      --config string              config file (default is hugo.yaml|json|toml)
      --configDir string           config dir (default "config")
  -d, --destination string         filesystem path to write files to
  -e, --environment string         build environment
      --ignoreVendorPaths string   ignores any _vendor for module paths matching the given Glob pattern
      --logLevel string            log level (debug|info|warn|error)
      --noBuildLock                don't create .hugo_build.lock file
      --quiet                      build in quiet mode
  -M, --renderToMemory             render to memory (mostly useful when running the server)
  -s, --source string              filesystem path to read files relative from
      --themesDir string           filesystem path to themes directory
```

### SEE ALSO

* [hugo list](/commands/hugo_list/)	 - List content


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/commands/hugo_list_expired.md
---

## hugo list expired

List expired content

### Synopsis

List content with a past expiration date.

```
hugo list expired [flags] [args]
```

### Options

```
  -h, --help   help for expired
```

### Options inherited from parent commands

```
      --clock string               set the clock used by Hugo, e.g. --clock 2021-11-06T22:30:00.00+09:00
      --config string              config file (default is hugo.yaml|json|toml)
      --configDir string           config dir (default "config")
  -d, --destination string         filesystem path to write files to
  -e, --environment string         build environment
      --ignoreVendorPaths string   ignores any _vendor for module paths matching the given Glob pattern
      --logLevel string            log level (debug|info|warn|error)
      --noBuildLock                don't create .hugo_build.lock file
      --quiet                      build in quiet mode
  -M, --renderToMemory             render to memory (mostly useful when running the server)
  -s, --source string              filesystem path to read files relative from
      --themesDir string           filesystem path to themes directory
```

### SEE ALSO

* [hugo list](/commands/hugo_list/)	 - List content


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/commands/hugo_list_future.md
---

## hugo list future

List future content

### Synopsis

List content with a future publication date.

```
hugo list future [flags] [args]
```

### Options

```
  -h, --help   help for future
```

### Options inherited from parent commands

```
      --clock string               set the clock used by Hugo, e.g. --clock 2021-11-06T22:30:00.00+09:00
      --config string              config file (default is hugo.yaml|json|toml)
      --configDir string           config dir (default "config")
  -d, --destination string         filesystem path to write files to
  -e, --environment string         build environment
      --ignoreVendorPaths string   ignores any _vendor for module paths matching the given Glob pattern
      --logLevel string            log level (debug|info|warn|error)
      --noBuildLock                don't create .hugo_build.lock file
      --quiet                      build in quiet mode
  -M, --renderToMemory             render to memory (mostly useful when running the server)
  -s, --source string              filesystem path to read files relative from
      --themesDir string           filesystem path to themes directory
```

### SEE ALSO

* [hugo list](/commands/hugo_list/)	 - List content


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/commands/hugo_list_published.md
---

## hugo list published

List published content

### Synopsis

List content that is not draft, future, or expired.

```
hugo list published [flags] [args]
```

### Options

```
  -h, --help   help for published
```

### Options inherited from parent commands

```
      --clock string               set the clock used by Hugo, e.g. --clock 2021-11-06T22:30:00.00+09:00
      --config string              config file (default is hugo.yaml|json|toml)
      --configDir string           config dir (default "config")
  -d, --destination string         filesystem path to write files to
  -e, --environment string         build environment
      --ignoreVendorPaths string   ignores any _vendor for module paths matching the given Glob pattern
      --logLevel string            log level (debug|info|warn|error)
      --noBuildLock                don't create .hugo_build.lock file
      --quiet                      build in quiet mode
  -M, --renderToMemory             render to memory (mostly useful when running the server)
  -s, --source string              filesystem path to read files relative from
      --themesDir string           filesystem path to themes directory
```

### SEE ALSO

* [hugo list](/commands/hugo_list/)	 - List content


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/commands/hugo_mod.md
---

## hugo mod

Manage modules

### Synopsis

Various helpers to help manage the modules in your project's dependency graph.
Most operations here requires a Go version installed on your system (>= Go 1.12) and the relevant VCS client (typically Git).
This is not needed if you only operate on modules inside /themes or if you have vendored them via "hugo mod vendor".


Note that Hugo will always start out by resolving the components defined in the project
configuration, provided by a _vendor directory (if no --ignoreVendorPaths flag provided),
Go Modules, or a folder inside the themes directory, in that order.

See https://gohugo.io/hugo-modules/ for more information.



### Options

```
  -h, --help   help for mod
```

### Options inherited from parent commands

```
      --clock string               set the clock used by Hugo, e.g. --clock 2021-11-06T22:30:00.00+09:00
      --config string              config file (default is hugo.yaml|json|toml)
      --configDir string           config dir (default "config")
  -d, --destination string         filesystem path to write files to
  -e, --environment string         build environment
      --ignoreVendorPaths string   ignores any _vendor for module paths matching the given Glob pattern
      --logLevel string            log level (debug|info|warn|error)
      --noBuildLock                don't create .hugo_build.lock file
      --quiet                      build in quiet mode
  -M, --renderToMemory             render to memory (mostly useful when running the server)
  -s, --source string              filesystem path to read files relative from
      --themesDir string           filesystem path to themes directory
```

### SEE ALSO

* [hugo](/commands/hugo/)	 - Build your project
* [hugo mod clean](/commands/hugo_mod_clean/)	 - Delete the Hugo Module cache for the current project
* [hugo mod get](/commands/hugo_mod_get/)	 - Resolves dependencies in your current Hugo project
* [hugo mod graph](/commands/hugo_mod_graph/)	 - Print a module dependency graph
* [hugo mod init](/commands/hugo_mod_init/)	 - Initialize this project as a Hugo Module
* [hugo mod npm](/commands/hugo_mod_npm/)	 - Various npm helpers
* [hugo mod tidy](/commands/hugo_mod_tidy/)	 - Remove unused entries in go.mod and go.sum
* [hugo mod vendor](/commands/hugo_mod_vendor/)	 - Vendor all module dependencies into the _vendor directory
* [hugo mod verify](/commands/hugo_mod_verify/)	 - Verify dependencies


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/commands/hugo_mod_clean.md
---

## hugo mod clean

Delete the Hugo Module cache for the current project

### Synopsis

Delete the Hugo Module cache for the current project.

```
hugo mod clean [flags] [args]
```

### Options

```
      --all                      clean entire module cache
  -b, --baseURL string           hostname (and path) to the root, e.g. https://spf13.com/
      --cacheDir string          filesystem path to cache directory
  -c, --contentDir string        filesystem path to content directory
  -h, --help                     help for clean
      --pattern string           pattern matching module paths to clean (all if not set), e.g. "**hugo*"
      --renderSegments strings   named segments to render (configured in the segments config)
  -t, --theme strings            themes to use (located in /themes/THEMENAME/)
```

### Options inherited from parent commands

```
      --clock string               set the clock used by Hugo, e.g. --clock 2021-11-06T22:30:00.00+09:00
      --config string              config file (default is hugo.yaml|json|toml)
      --configDir string           config dir (default "config")
  -d, --destination string         filesystem path to write files to
  -e, --environment string         build environment
      --ignoreVendorPaths string   ignores any _vendor for module paths matching the given Glob pattern
      --logLevel string            log level (debug|info|warn|error)
      --noBuildLock                don't create .hugo_build.lock file
      --quiet                      build in quiet mode
  -M, --renderToMemory             render to memory (mostly useful when running the server)
  -s, --source string              filesystem path to read files relative from
      --themesDir string           filesystem path to themes directory
```

### SEE ALSO

* [hugo mod](/commands/hugo_mod/)	 - Manage modules


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/commands/hugo_mod_get.md
---

## hugo mod get

Resolves dependencies in your current Hugo project

### Synopsis


Resolves dependencies in your current Hugo project.

Some examples:

Install the latest version possible for a given module:

    hugo mod get github.com/gohugoio/testshortcodes

Install a specific version:

    hugo mod get github.com/gohugoio/testshortcodes@v0.3.0

Install the latest versions of all direct module dependencies:

    hugo mod get
    hugo mod get ./... (recursive)

Install the latest versions of all module dependencies (direct and indirect):

    hugo mod get -u
    hugo mod get -u ./... (recursive)

Run "go help get" for more information. All flags available for "go get" is also relevant here.

Note that Hugo will always start out by resolving the components defined in the project
configuration, provided by a _vendor directory (if no --ignoreVendorPaths flag provided),
Go Modules, or a folder inside the themes directory, in that order.

See https://gohugo.io/hugo-modules/ for more information.



```
hugo mod get [flags] [args]
```

### Options

```
  -h, --help   help for get
```

### Options inherited from parent commands

```
      --clock string               set the clock used by Hugo, e.g. --clock 2021-11-06T22:30:00.00+09:00
      --config string              config file (default is hugo.yaml|json|toml)
      --configDir string           config dir (default "config")
  -d, --destination string         filesystem path to write files to
  -e, --environment string         build environment
      --ignoreVendorPaths string   ignores any _vendor for module paths matching the given Glob pattern
      --logLevel string            log level (debug|info|warn|error)
      --noBuildLock                don't create .hugo_build.lock file
      --quiet                      build in quiet mode
  -M, --renderToMemory             render to memory (mostly useful when running the server)
  -s, --source string              filesystem path to read files relative from
      --themesDir string           filesystem path to themes directory
```

### SEE ALSO

* [hugo mod](/commands/hugo_mod/)	 - Manage modules


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/commands/hugo_mod_graph.md
---

## hugo mod graph

Print a module dependency graph

### Synopsis

Print a module dependency graph with information about module status (disabled, vendored).
Note that for vendored modules, that is the version listed and not the one from go.mod.


```
hugo mod graph [flags] [args]
```

### Options

```
  -b, --baseURL string           hostname (and path) to the root, e.g. https://spf13.com/
      --cacheDir string          filesystem path to cache directory
      --clean                    delete module cache for dependencies that fail verification
  -c, --contentDir string        filesystem path to content directory
  -h, --help                     help for graph
      --renderSegments strings   named segments to render (configured in the segments config)
  -t, --theme strings            themes to use (located in /themes/THEMENAME/)
```

### Options inherited from parent commands

```
      --clock string               set the clock used by Hugo, e.g. --clock 2021-11-06T22:30:00.00+09:00
      --config string              config file (default is hugo.yaml|json|toml)
      --configDir string           config dir (default "config")
  -d, --destination string         filesystem path to write files to
  -e, --environment string         build environment
      --ignoreVendorPaths string   ignores any _vendor for module paths matching the given Glob pattern
      --logLevel string            log level (debug|info|warn|error)
      --noBuildLock                don't create .hugo_build.lock file
      --quiet                      build in quiet mode
  -M, --renderToMemory             render to memory (mostly useful when running the server)
  -s, --source string              filesystem path to read files relative from
      --themesDir string           filesystem path to themes directory
```

### SEE ALSO

* [hugo mod](/commands/hugo_mod/)	 - Manage modules


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/commands/hugo_mod_init.md
---

## hugo mod init

Initialize this project as a Hugo Module

### Synopsis

Initialize this project as a Hugo Module.
	It will try to guess the module path, but you may help by passing it as an argument, e.g:

		hugo mod init github.com/gohugoio/testshortcodes

	Note that Hugo Modules supports multi-module projects, so you can initialize a Hugo Module
	inside a subfolder on GitHub, as one example.
	

```
hugo mod init [flags] [args]
```

### Options

```
  -b, --baseURL string           hostname (and path) to the root, e.g. https://spf13.com/
      --cacheDir string          filesystem path to cache directory
  -c, --contentDir string        filesystem path to content directory
  -h, --help                     help for init
      --renderSegments strings   named segments to render (configured in the segments config)
  -t, --theme strings            themes to use (located in /themes/THEMENAME/)
```

### Options inherited from parent commands

```
      --clock string               set the clock used by Hugo, e.g. --clock 2021-11-06T22:30:00.00+09:00
      --config string              config file (default is hugo.yaml|json|toml)
      --configDir string           config dir (default "config")
  -d, --destination string         filesystem path to write files to
  -e, --environment string         build environment
      --ignoreVendorPaths string   ignores any _vendor for module paths matching the given Glob pattern
      --logLevel string            log level (debug|info|warn|error)
      --noBuildLock                don't create .hugo_build.lock file
      --quiet                      build in quiet mode
  -M, --renderToMemory             render to memory (mostly useful when running the server)
  -s, --source string              filesystem path to read files relative from
      --themesDir string           filesystem path to themes directory
```

### SEE ALSO

* [hugo mod](/commands/hugo_mod/)	 - Manage modules


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/commands/hugo_mod_npm.md
---

## hugo mod npm

Various npm helpers

### Synopsis

Various npm (Node package manager) helpers.

```
hugo mod npm [command] [flags]
```

### Options

```
  -h, --help   help for npm
```

### Options inherited from parent commands

```
      --clock string               set the clock used by Hugo, e.g. --clock 2021-11-06T22:30:00.00+09:00
      --config string              config file (default is hugo.yaml|json|toml)
      --configDir string           config dir (default "config")
  -d, --destination string         filesystem path to write files to
  -e, --environment string         build environment
      --ignoreVendorPaths string   ignores any _vendor for module paths matching the given Glob pattern
      --logLevel string            log level (debug|info|warn|error)
      --noBuildLock                don't create .hugo_build.lock file
      --quiet                      build in quiet mode
  -M, --renderToMemory             render to memory (mostly useful when running the server)
  -s, --source string              filesystem path to read files relative from
      --themesDir string           filesystem path to themes directory
```

### SEE ALSO

* [hugo mod](/commands/hugo_mod/)	 - Manage modules
* [hugo mod npm pack](/commands/hugo_mod_npm_pack/)	 - Merges module Node.js dependencies into an npm workspace


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/commands/hugo_mod_npm_pack.md
---

## hugo mod npm pack

Merges module Node.js dependencies into an npm workspace

### Synopsis

Merges Node.js dependencies from all Hugo modules into a "packages/hugoautogen" npm workspace.

The merged dependencies are written to packages/hugoautogen/package.json, and the root package.json
is updated with a "workspaces" entry pointing to "packages/hugoautogen".

The source entries are read from either package.hugo.json or package.json in the module root, with package.hugo.json taking precedence if both exist.

See [Node.js dependencies](/hugo-modules/nodejs-dependencies/) for more information.


```
hugo mod npm pack [flags] [args]
```

### Options

```
  -b, --baseURL string           hostname (and path) to the root, e.g. https://spf13.com/
      --cacheDir string          filesystem path to cache directory
  -c, --contentDir string        filesystem path to content directory
  -h, --help                     help for pack
      --renderSegments strings   named segments to render (configured in the segments config)
  -t, --theme strings            themes to use (located in /themes/THEMENAME/)
```

### Options inherited from parent commands

```
      --clock string               set the clock used by Hugo, e.g. --clock 2021-11-06T22:30:00.00+09:00
      --config string              config file (default is hugo.yaml|json|toml)
      --configDir string           config dir (default "config")
  -d, --destination string         filesystem path to write files to
  -e, --environment string         build environment
      --ignoreVendorPaths string   ignores any _vendor for module paths matching the given Glob pattern
      --logLevel string            log level (debug|info|warn|error)
      --noBuildLock                don't create .hugo_build.lock file
      --quiet                      build in quiet mode
  -M, --renderToMemory             render to memory (mostly useful when running the server)
  -s, --source string              filesystem path to read files relative from
      --themesDir string           filesystem path to themes directory
```

### SEE ALSO

* [hugo mod npm](/commands/hugo_mod_npm/)	 - Various npm helpers


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/commands/hugo_mod_tidy.md
---

## hugo mod tidy

Remove unused entries in go.mod and go.sum

```
hugo mod tidy [flags] [args]
```

### Options

```
  -b, --baseURL string           hostname (and path) to the root, e.g. https://spf13.com/
      --cacheDir string          filesystem path to cache directory
  -c, --contentDir string        filesystem path to content directory
  -h, --help                     help for tidy
      --renderSegments strings   named segments to render (configured in the segments config)
  -t, --theme strings            themes to use (located in /themes/THEMENAME/)
```

### Options inherited from parent commands

```
      --clock string               set the clock used by Hugo, e.g. --clock 2021-11-06T22:30:00.00+09:00
      --config string              config file (default is hugo.yaml|json|toml)
      --configDir string           config dir (default "config")
  -d, --destination string         filesystem path to write files to
  -e, --environment string         build environment
      --ignoreVendorPaths string   ignores any _vendor for module paths matching the given Glob pattern
      --logLevel string            log level (debug|info|warn|error)
      --noBuildLock                don't create .hugo_build.lock file
      --quiet                      build in quiet mode
  -M, --renderToMemory             render to memory (mostly useful when running the server)
  -s, --source string              filesystem path to read files relative from
      --themesDir string           filesystem path to themes directory
```

### SEE ALSO

* [hugo mod](/commands/hugo_mod/)	 - Manage modules


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/commands/hugo_mod_vendor.md
---

## hugo mod vendor

Vendor all module dependencies into the _vendor directory

### Synopsis

Vendor all module dependencies into the _vendor directory.
	If a module is vendored, that is where Hugo will look for it's dependencies.
	

```
hugo mod vendor [flags] [args]
```

### Options

```
  -b, --baseURL string           hostname (and path) to the root, e.g. https://spf13.com/
      --cacheDir string          filesystem path to cache directory
  -c, --contentDir string        filesystem path to content directory
  -h, --help                     help for vendor
      --renderSegments strings   named segments to render (configured in the segments config)
  -t, --theme strings            themes to use (located in /themes/THEMENAME/)
```

### Options inherited from parent commands

```
      --clock string               set the clock used by Hugo, e.g. --clock 2021-11-06T22:30:00.00+09:00
      --config string              config file (default is hugo.yaml|json|toml)
      --configDir string           config dir (default "config")
  -d, --destination string         filesystem path to write files to
  -e, --environment string         build environment
      --ignoreVendorPaths string   ignores any _vendor for module paths matching the given Glob pattern
      --logLevel string            log level (debug|info|warn|error)
      --noBuildLock                don't create .hugo_build.lock file
      --quiet                      build in quiet mode
  -M, --renderToMemory             render to memory (mostly useful when running the server)
  -s, --source string              filesystem path to read files relative from
      --themesDir string           filesystem path to themes directory
```

### SEE ALSO

* [hugo mod](/commands/hugo_mod/)	 - Manage modules


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/commands/hugo_mod_verify.md
---

## hugo mod verify

Verify dependencies

### Synopsis

Verify checks that the dependencies of the current module, which are stored in a local downloaded source cache, have not been modified since being downloaded.

```
hugo mod verify [flags] [args]
```

### Options

```
  -b, --baseURL string           hostname (and path) to the root, e.g. https://spf13.com/
      --cacheDir string          filesystem path to cache directory
      --clean                    delete module cache for dependencies that fail verification
  -c, --contentDir string        filesystem path to content directory
  -h, --help                     help for verify
      --renderSegments strings   named segments to render (configured in the segments config)
  -t, --theme strings            themes to use (located in /themes/THEMENAME/)
```

### Options inherited from parent commands

```
      --clock string               set the clock used by Hugo, e.g. --clock 2021-11-06T22:30:00.00+09:00
      --config string              config file (default is hugo.yaml|json|toml)
      --configDir string           config dir (default "config")
  -d, --destination string         filesystem path to write files to
  -e, --environment string         build environment
      --ignoreVendorPaths string   ignores any _vendor for module paths matching the given Glob pattern
      --logLevel string            log level (debug|info|warn|error)
      --noBuildLock                don't create .hugo_build.lock file
      --quiet                      build in quiet mode
  -M, --renderToMemory             render to memory (mostly useful when running the server)
  -s, --source string              filesystem path to read files relative from
      --themesDir string           filesystem path to themes directory
```

### SEE ALSO

* [hugo mod](/commands/hugo_mod/)	 - Manage modules


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/commands/hugo_new.md
---

## hugo new

Create new content

### Synopsis

Create a new content file and automatically set the date and title.
It will guess which kind of file to create based on the path provided.

You can also specify the kind with `-k KIND`.

If archetypes are provided in your theme or project, they will be used.

Ensure you run this within the root directory of your project.

### Options

```
  -h, --help   help for new
```

### Options inherited from parent commands

```
      --clock string               set the clock used by Hugo, e.g. --clock 2021-11-06T22:30:00.00+09:00
      --config string              config file (default is hugo.yaml|json|toml)
      --configDir string           config dir (default "config")
  -d, --destination string         filesystem path to write files to
  -e, --environment string         build environment
      --ignoreVendorPaths string   ignores any _vendor for module paths matching the given Glob pattern
      --logLevel string            log level (debug|info|warn|error)
      --noBuildLock                don't create .hugo_build.lock file
      --quiet                      build in quiet mode
  -M, --renderToMemory             render to memory (mostly useful when running the server)
  -s, --source string              filesystem path to read files relative from
      --themesDir string           filesystem path to themes directory
```

### SEE ALSO

* [hugo](/commands/hugo/)	 - Build your project
* [hugo new content](/commands/hugo_new_content/)	 - Create new content
* [hugo new project](/commands/hugo_new_project/)	 - Create a new project
* [hugo new theme](/commands/hugo_new_theme/)	 - Create a new theme


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/commands/hugo_new_content.md
---

## hugo new content

Create new content

### Synopsis

Create a new content file and automatically set the date and title.
It will guess which kind of file to create based on the path provided.

You can also specify the kind with `-k KIND`.

If archetypes are provided in your theme or project, they will be used.

Ensure you run this within the root directory of your project.

```
hugo new content [path] [flags]
```

### Options

```
  -b, --baseURL string           hostname (and path) to the root, e.g. https://spf13.com/
      --cacheDir string          filesystem path to cache directory
  -c, --contentDir string        filesystem path to content directory
      --editor string            edit new content with this editor, if provided
  -f, --force                    overwrite file if it already exists
  -h, --help                     help for content
  -k, --kind string              content type to create
      --renderSegments strings   named segments to render (configured in the segments config)
  -t, --theme strings            themes to use (located in /themes/THEMENAME/)
```

### Options inherited from parent commands

```
      --clock string               set the clock used by Hugo, e.g. --clock 2021-11-06T22:30:00.00+09:00
      --config string              config file (default is hugo.yaml|json|toml)
      --configDir string           config dir (default "config")
  -d, --destination string         filesystem path to write files to
  -e, --environment string         build environment
      --ignoreVendorPaths string   ignores any _vendor for module paths matching the given Glob pattern
      --logLevel string            log level (debug|info|warn|error)
      --noBuildLock                don't create .hugo_build.lock file
      --quiet                      build in quiet mode
  -M, --renderToMemory             render to memory (mostly useful when running the server)
  -s, --source string              filesystem path to read files relative from
      --themesDir string           filesystem path to themes directory
```

### SEE ALSO

* [hugo new](/commands/hugo_new/)	 - Create new content


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/commands/hugo_new_project.md
---

## hugo new project

Create a new project

### Synopsis

Create a new project at the specified path.

```
hugo new project [path] [flags]
```

### Options

```
  -f, --force           init inside non-empty directory
      --format string   preferred file format (toml, yaml or json) (default "toml")
  -h, --help            help for project
```

### Options inherited from parent commands

```
      --clock string               set the clock used by Hugo, e.g. --clock 2021-11-06T22:30:00.00+09:00
      --config string              config file (default is hugo.yaml|json|toml)
      --configDir string           config dir (default "config")
  -d, --destination string         filesystem path to write files to
  -e, --environment string         build environment
      --ignoreVendorPaths string   ignores any _vendor for module paths matching the given Glob pattern
      --logLevel string            log level (debug|info|warn|error)
      --noBuildLock                don't create .hugo_build.lock file
      --quiet                      build in quiet mode
  -M, --renderToMemory             render to memory (mostly useful when running the server)
  -s, --source string              filesystem path to read files relative from
      --themesDir string           filesystem path to themes directory
```

### SEE ALSO

* [hugo new](/commands/hugo_new/)	 - Create new content


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/commands/hugo_new_theme.md
---

## hugo new theme

Create a new theme

### Synopsis

Create a new theme with the specified name in the ./themes directory.
This generates a functional theme including template examples and sample content.

```
hugo new theme [name] [flags]
```

### Options

```
      --format string   preferred file format (toml, yaml or json) (default "toml")
  -h, --help            help for theme
```

### Options inherited from parent commands

```
      --clock string               set the clock used by Hugo, e.g. --clock 2021-11-06T22:30:00.00+09:00
      --config string              config file (default is hugo.yaml|json|toml)
      --configDir string           config dir (default "config")
  -d, --destination string         filesystem path to write files to
  -e, --environment string         build environment
      --ignoreVendorPaths string   ignores any _vendor for module paths matching the given Glob pattern
      --logLevel string            log level (debug|info|warn|error)
      --noBuildLock                don't create .hugo_build.lock file
      --quiet                      build in quiet mode
  -M, --renderToMemory             render to memory (mostly useful when running the server)
  -s, --source string              filesystem path to read files relative from
      --themesDir string           filesystem path to themes directory
```

### SEE ALSO

* [hugo new](/commands/hugo_new/)	 - Create new content


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/commands/hugo_server.md
---

## hugo server

Start the embedded web server

### Synopsis

Hugo provides its own webserver which builds and serves the project.
While hugo server is high performance, it is a webserver with limited options.

The `hugo server` command will by default write and serve files from disk, but
you can render to memory by using the `--renderToMemory` flag. This can be
faster in some cases, but it will consume more memory.

By default hugo will also watch your files for any changes you make and
automatically rebuild the project. It will then live reload any open browser pages
and push the latest content to them. As most Hugo projects are built in a fraction
of a second, you will be able to save and see your changes nearly instantly.

```
hugo server [command] [flags]
```

### Options

```
      --appendPort               append port to baseURL (default true)
  -b, --baseURL string           hostname (and path) to the root, e.g. https://spf13.com/
      --bind string              interface to which the server will bind (default "127.0.0.1")
  -D, --buildDrafts              include content marked as draft
  -E, --buildExpired             include expired content
  -F, --buildFuture              include content with publishdate in the future
      --cacheDir string          filesystem path to cache directory
      --cleanDestinationDir      remove files from destination not found in static directories
  -c, --contentDir string        filesystem path to content directory
      --disableBrowserError      do not show build errors in the browser
      --disableFastRender        enables full re-renders on changes
      --disableKinds strings     disable different kind of pages (home, RSS etc.)
      --disableLiveReload        watch without enabling live browser reload on rebuild
      --enableGitInfo            add Git revision, date, author, and CODEOWNERS info to the pages
      --forceSyncStatic          copy all files when static is changed.
      --gc                       enable to run some cleanup tasks (remove unused cache files) after the build
  -h, --help                     help for server
      --ignoreCache              ignore the configured file caches
  -l, --layoutDir string         filesystem path to layout directory
      --liveReloadPort int       port for live reloading (i.e. 443 in HTTPS proxy situations) (default -1)
      --minify                   minify any supported output format (HTML, XML etc.)
  -N, --navigateToChanged        navigate to changed content file on live browser reload
      --noChmod                  don't sync permission mode of files
      --noHTTPCache              disable browser caching of pages served by the embedded web server
      --noTimes                  don't sync modification time of files
  -O, --openBrowser              open the project in a browser after server startup
      --panicOnWarning           panic on first WARNING log
      --poll string              set this to a poll interval, e.g --poll 700ms, to use a poll based approach to watch for file system changes
  -p, --port int                 port on which the server will listen (default 1313)
      --pprof                    enable the pprof server (port 8080)
      --printI18nWarnings        print missing translations
      --printMemoryUsage         print memory usage to screen at intervals
      --printPathWarnings        print warnings on duplicate target paths etc.
      --printUnusedTemplates     print warnings on unused templates.
      --renderSegments strings   named segments to render (configured in the segments config)
      --renderStaticToDisk       serve static files from disk and dynamic files from memory
      --templateMetrics          display metrics about template executions
      --templateMetricsHints     calculate some improvement hints when combined with --templateMetrics
  -t, --theme strings            themes to use (located in /themes/THEMENAME/)
      --tlsAuto                  generate and use locally-trusted certificates.
      --tlsCertFile string       path to TLS certificate file
      --tlsKeyFile string        path to TLS key file
      --trace file               write trace to file (not useful in general)
  -w, --watch                    watch filesystem for changes and recreate as needed (default true)
```

### Options inherited from parent commands

```
      --clock string               set the clock used by Hugo, e.g. --clock 2021-11-06T22:30:00.00+09:00
      --config string              config file (default is hugo.yaml|json|toml)
      --configDir string           config dir (default "config")
  -d, --destination string         filesystem path to write files to
  -e, --environment string         build environment
      --ignoreVendorPaths string   ignores any _vendor for module paths matching the given Glob pattern
      --logLevel string            log level (debug|info|warn|error)
      --noBuildLock                don't create .hugo_build.lock file
      --quiet                      build in quiet mode
  -M, --renderToMemory             render to memory (mostly useful when running the server)
  -s, --source string              filesystem path to read files relative from
      --themesDir string           filesystem path to themes directory
```

### SEE ALSO

* [hugo](/commands/hugo/)	 - Build your project
* [hugo server trust](/commands/hugo_server_trust/)	 - Install the local CA in the system trust store


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/commands/hugo_server_trust.md
---

## hugo server trust

Install the local CA in the system trust store

```
hugo server trust [flags] [args]
```

### Options

```
  -h, --help        help for trust
      --uninstall   Uninstall the local CA (but do not delete it).
```

### Options inherited from parent commands

```
      --clock string               set the clock used by Hugo, e.g. --clock 2021-11-06T22:30:00.00+09:00
      --config string              config file (default is hugo.yaml|json|toml)
      --configDir string           config dir (default "config")
  -d, --destination string         filesystem path to write files to
  -e, --environment string         build environment
      --ignoreVendorPaths string   ignores any _vendor for module paths matching the given Glob pattern
      --logLevel string            log level (debug|info|warn|error)
      --noBuildLock                don't create .hugo_build.lock file
      --quiet                      build in quiet mode
  -M, --renderToMemory             render to memory (mostly useful when running the server)
  -s, --source string              filesystem path to read files relative from
      --themesDir string           filesystem path to themes directory
```

### SEE ALSO

* [hugo server](/commands/hugo_server/)	 - Start the embedded web server


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/commands/hugo_version.md
---

## hugo version

Display version

### Synopsis

Display version and environment info. This is useful in Hugo bug reports.

```
hugo version [flags] [args]
```

### Options

```
  -h, --help   help for version
```

### Options inherited from parent commands

```
      --clock string               set the clock used by Hugo, e.g. --clock 2021-11-06T22:30:00.00+09:00
      --config string              config file (default is hugo.yaml|json|toml)
      --configDir string           config dir (default "config")
  -d, --destination string         filesystem path to write files to
  -e, --environment string         build environment
      --ignoreVendorPaths string   ignores any _vendor for module paths matching the given Glob pattern
      --logLevel string            log level (debug|info|warn|error)
      --noBuildLock                don't create .hugo_build.lock file
      --quiet                      build in quiet mode
  -M, --renderToMemory             render to memory (mostly useful when running the server)
  -s, --source string              filesystem path to read files relative from
      --themesDir string           filesystem path to themes directory
```

### SEE ALSO

* [hugo](/commands/hugo/)	 - Build your project

