
---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/host-and-deploy/deploy-with-hugo-deploy.md
---


Use the `hugo deploy` command to deploy your site Amazon S3, Azure Blob Storage, or Google Cloud Storage.

> [!NOTE]
> This feature requires the deploy or extended/deploy edition. See the [installation][] section for details.

## Assumptions

1. You have completed the [Quick Start][] or have a Hugo website you are ready to deploy and share with the world.
1. You have an account with the service provider ([AWS][], [Azure][], or [Google Cloud][]) that you want to deploy to.
1. You have authenticated.
    - AWS: [Install the CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html) and run [`aws configure`][].
    - Azure: [Install the CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) and run [`az login`][].
    - Google Cloud: [Install the CLI](https://cloud.google.com/sdk) and run [`gcloud auth login`][].

    Each service supports various authentication methods, including environment variables. See [details][].

1. You have created a bucket to deploy to. If you want your site to be
  public, be sure to configure the bucket to be publicly readable as a static website.
    - AWS: [create a bucket](https://docs.aws.amazon.com/AmazonS3/latest/gsg/CreatingABucket.html) and [host a static website](https://docs.aws.amazon.com/AmazonS3/latest/userguide/WebsiteHosting.html)
    - Azure: [create a storage container][] and [host a static website](https://learn.microsoft.com/en-us/azure/storage/blobs/storage-blob-static-website)
    - Google Cloud: [create a bucket](https://cloud.google.com/storage/docs/creating-buckets) and [host a static website](https://cloud.google.com/storage/docs/hosting-static-website)

## Configuration

Create a deployment target in your [project configuration][]. The only required parameters are [`name`][] and [`url`][]:

{{< code-toggle file=hugo >}}
[deployment]
  [[deployment.targets]]
    name = 'production'
    url = 's3://my_bucket?region=us-west-1'
{{< /code-toggle >}}

## Deploy

To deploy to a target:

```sh
hugo deploy [--target=<target name>]
```

This command syncs the contents of your local `public` directory (the default publish directory) with the destination bucket. If no target is specified, Hugo deploys to the first configured target.

For more command-line options, see `hugo help deploy` or the [CLI documentation][].

### File list creation

`hugo deploy` creates local and remote file lists by traversing the local publish directory and the remote bucket. Inclusion and exclusion are determined by the deployment target's [configuration][]:

- `include`: All files are skipped by default except those that match the pattern.
- `exclude`: Files matching the pattern are skipped.

> [!NOTE]
> During local file list creation, Hugo skips `.DS_Store` files and hidden directories (those starting with a period, like `.git`), except for the [`.well-known`][] directory, which is traversed if present.

### File list comparison

Hugo compares the local and remote file lists to identify necessary changes. It first compares file names. If both exist, it compares sizes and MD5 checksums. Any difference triggers a re-upload, and remote files not present locally are deleted.

> [!NOTE]
> Excluded remote files (due to `include`/`exclude` configuration) won't be deleted.

The `--force` flag forces all files to be re-uploaded, even if Hugo detects no local/remote differences.

The `--confirm` or `--dryRun` flags cause Hugo to display the detected differences and then pause or stop.

### Synchronization

Hugo applies the changes to the remote bucket: uploading missing or changed files and deleting remote files not present locally. Uploaded file headers are configured remotely based on the matchers configuration.

> [!NOTE]
> To prevent accidental data loss, Hugo will not delete more than 256 remote files by default. Use the `--maxDeletes` flag to override this limit.

## Advanced configuration

See [configure deployment][].

[AWS]: https://aws.amazon.com
[Azure]: https://azure.microsoft.com
[CLI documentation]: /commands/hugo_deploy/
[Google Cloud]: https://cloud.google.com/
[Quick Start]: /getting-started/quick-start/
[`.well-known`]: https://en.wikipedia.org/wiki/Well-known_URI
[`aws configure`]: https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html
[`az login`]: https://docs.microsoft.com/en-us/cli/azure/authenticate-azure-cli
[`gcloud auth login`]: https://cloud.google.com/sdk/gcloud/reference/auth/login
[`name`]: /configuration/deployment/#name
[`url`]: /configuration/deployment/#url
[configuration]: /configuration/deployment/#targets-1
[configure deployment]: /configuration/deployment/
[create a storage container]: https://docs.microsoft.com/en-us/azure/storage/blobs/storage-quickstart-blobs-portal
[details]: https://gocloud.dev/howto/blob/#services
[installation]: /installation/
[project configuration]: /configuration/deployment/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/host-and-deploy/deploy-with-rclone.md
---


## Assumptions

- A web host running a web server. This could be a shared hosting environment or a VPS
- Access to your web host with any of the [protocols supported by rclone][], such as SFTP
- A functional static website built with Hugo
- Deploying from an [Rclone][] compatible operating system
- You have [installed Rclone][]

**NB**: You can remove `--interactive` in the commands below once you are comfortable with rclone, if you wish. Also, `--gc` and `--minify` are optional in the commands below.

## Getting started

The spoiler is that you can even deploy your entire website from any compatible OS with no configuration. Using SFTP for example:

```txt
hugo build --gc --minify
rclone sync --interactive --sftp-host sftp.example.com --sftp-user www-data --sftp-ask-password public/ :sftp:www/
```

## Configure Rclone for even easier usage

The easiest way is simply to run `rclone config`.

The [Rclone docs][] provide [an example of configuring Rclone to use SFTP][].

For the next commands, we will assume you configured a remote you named `hugo-www`.

The above 'spoiler' commands could become:

```txt
hugo build --gc --minify
rclone sync --interactive public/ hugo-www:www/
```

After you issue the above commands (and respond to any prompts), check your website and you will see that it is deployed.

[Rclone docs]: https://rclone.org/docs/
[Rclone]: https://rclone.org
[an example of configuring Rclone to use SFTP]: https://rclone.org/sftp/
[installed Rclone]: https://rclone.org/install/
[protocols supported by rclone]: https://rclone.org/#providers


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/host-and-deploy/deploy-with-rsync.md
---


## Assumptions

- A web host running a web server. This could be a shared hosting environment or a VPS
- Access to your web host with SSH
- A functional static website built with Hugo

The spoiler is that you can deploy your entire website with a command that looks like the following:

```txt
hugo && rsync -avz --delete public/ www-data@ftp.topologix.fr:~/www/
```

As you will see, we'll put this command in a shell script file, which makes building and deployment as easy as executing `./deploy`.

## Copy Your SSH Key to your host

To make logging in to your server more secure and less interactive, you can upload your SSH key. If you have already installed your SSH key to your server, you can move on to the next section.

First, install the ssh client. On Debian distributions, use the following command:

```sh {file="install-openssh.sh"}
sudo apt-get install openssh-client
```

Then generate your ssh key. First, create the `.ssh` directory in your home directory if it doesn't exist:

```txt
~$ cd && mkdir .ssh & cd .ssh
```

Next, execute this command to generate a new keypair called `rsa_id`:

```txt
~/.ssh/$ ssh-keygen -t rsa -q -C "For SSH" -f rsa_id
```

You'll be prompted for a passphrase, which is an extra layer of protection. Enter the passphrase you'd like to use, and then enter it again when prompted, or leave it blank if you don't want to have a passphrase. Not using a passphrase will let you transfer files non-interactively, as you won't be prompted for a password when you log in, but it is slightly less secure.

To make logging in easier, add a definition for your web host to the file  `~/.ssh/config` with the following command, replacing `HOST` with the IP address or hostname of your web host, and `USER` with the username you use to log in to your web host when transferring files:

```txt
~/.ssh/$ cat >> config <<EOF
Host HOST
     Hostname HOST
     Port 22
     User USER
     IdentityFile ~/.ssh/rsa_id
EOF
```

Then copy your ssh public key to the remote server with the `ssh-copy-id` command:

```txt
~/.ssh/$ ssh-copy-id -i rsa_id.pub USER@HOST.com
```

Now you can easily connect to the remote server:

```txt
~$ ssh user@host
Enter passphrase for key '/home/mylogin/.ssh/rsa_id':
```

Now that you can log in with your SSH key, let's create a script to automate deployment of your Hugo site.

## Shell script

Create a new script called `deploy` at the root of your Hugo tree:

```txt
~/websites/topologix.fr$ editor deploy
```

Add the following content. Replace the `USER`, `HOST`, and `DIR` values with your own values:

```sh
#!/bin/sh
USER=my-user
HOST=my-server.com
DIR=my/directory/to/topologix.fr/   # the directory where your website files should go

hugo build && rsync -avz --delete public/ ${USER}@${HOST}:~/${DIR} # this will delete everything on the server that's not in the local public directory

exit 0
```

Note that `DIR` is the relative path from the remote user's home. If you have to specify a full path (for instance `/var/www/mysite/`) you must change `~/${DIR}` to `${DIR}` inside the command-line. For most cases you should not have to.

Save and close, and make the `deploy` file executable:

```txt
~/websites/topologix.fr$ chmod +x deploy
```

Now you only have to enter the following command to deploy and update your website:

```txt
~/websites/topologix.fr$ ./deploy
```

Your site builds and deploys:

```txt
Started building sites ...
Built site for language en:
0 draft content
0 future content
0 expired content
5 pages created
0 non-page files copied
0 paginator pages created
0 tags created
0 categories created
total in 56 ms
sending incremental file list
404.html
index.html
index.xml
sitemap.xml
posts/
posts/index.html

sent 9,550 bytes  received 1,708 bytes  7,505.33 bytes/sec
total size is 966,557  speedup is 85.86
```

You can incorporate other processing tasks into this deployment script as well.


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/host-and-deploy/host-on-azure-static-web-apps.md
---


You can create and deploy a Hugo web application to Azure Static Web Apps. The final result is a new Azure Static Web App with associated GitHub Actions that give you control over how the app is built and published. You'll learn how to create a Hugo app, set up an Azure Static Web App and deploy the Hugo app to Azure.

Here's the tutorial on how to [Publish a Hugo site to Azure Static Web Apps][].

[Publish a Hugo site to Azure Static Web Apps]: https://docs.microsoft.com/en-us/azure/static-web-apps/publish-hugo


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/host-and-deploy/host-on-firebase.md
---


## Assumptions

1. You have an account with [Firebase][signup].
1. You have completed the [Quick Start][] or have a completed Hugo website ready for deployment.

## Initial setup

Go to the [Firebase console][console] and create a new project (unless you already have a project). You will need to globally install `firebase-tools` (node.js):

```sh
npm install -g firebase-tools
```

Log in to Firebase (setup on your local machine) using `firebase login`, which opens a browser where you can select your account. Use `firebase logout` in case you are already logged in but to the wrong account.

```sh
firebase login
```

In the root of your Hugo project, initialize the Firebase project with the `firebase init` command:

```sh
firebase init
```

From here:

1. Choose Hosting in the feature question
1. Choose the project you just set up
1. Accept the default for your database rules file
1. Accept the default for the publish directory, which is `public`
1. Choose "No" in the question if you are deploying a single-page app

## Using Firebase & GitHub CI/CD

In new versions of Firebase, some other questions apply:

1. Set up automatic builds and deploys with GitHub?

    Here you will be redirected to login in your GitHub account to get permissions. Confirm.

1. For which GitHub repository would you like to set up a GitHub workflow? (format: user/repository)

    Include the repository you will use in the format above (Account/Repo)
    Firebase script with retrieve credentials, create a service account you can later manage in your GitHub settings.

1. Set up the workflow to run a build script before every deploy?

    Here is your opportunity to include some commands before you run the deploy.

1. Set up automatic deployment to your site's live channel when a PR is merged?

    You can let in the default option (main)

After that Firebase has been set in your project with [CI/CD](g). After that run:

```sh
hugo build && firebase deploy
```

With this you will have the app initialized manually. After that you can manage and fix your GitHub workflow from <https://github.com/your-account/your-repo/actions>.

Don't forget to update your static pages before push!

## Manual deploy

To deploy your Hugo site, execute the `firebase deploy` command, and your site will be up in no time:

```sh
hugo && firebase deploy
```

## CI setup (other tools)

You can generate a deploy token using

```sh
firebase login:ci
```

You can also set up your CI and add the token to a private variable like `$FIREBASE_DEPLOY_TOKEN`.

> [!NOTE]
> This is a private secret and it should not appear in a public repository. Make sure you understand your chosen CI and that it's not visible to others.

You can then add a step in your build to do the deployment using the token:

```sh
firebase deploy --token $FIREBASE_DEPLOY_TOKEN
```

## Reference links

- [Firebase CLI Reference][]

[Firebase CLI Reference]: https://firebase.google.com/docs/cli/#administrative_commands
[Quick Start]: /getting-started/quick-start/
[console]: https://console.firebase.google.com/
[signup]: https://console.firebase.google.com/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/host-and-deploy/host-on-gitlab-pages.md
---


Use these instructions to enable continuous deployment from a GitLab repository to GitLab Pages.

{{% include "/_common/gitignore-public.md" %}}

## Prerequisites

Please complete the following tasks before continuing:

1. [Create](https://gitlab.com/users/sign_up) a GitLab account.
1. [Log in](https://gitlab.com/users/sign_in) to your GitLab account.
1. [Create](https://gitlab.com/projects/new) a GitLab repository for your project.
1. [Create](https://git-scm.com/docs/git-init) a local Git repository for your project with a [remote][] reference to your GitLab repository.
1. Create a Hugo project within your local Git repository and test it with the `hugo server` command.
1. Commit the changes to your local Git repository and push to your GitLab repository.

## BaseURL

The [`baseURL`][] in your project configuration must reflect the full URL of your GitLab Pages repository if you are using the default GitLab Pages URL (e.g., `https://<YourUsername>.gitlab.io/<your-hugo-site>/`) and not a custom domain.

## Procedure

Step 1
: Create a `.gitlab-ci.yml` file in the root of your project, adjusting the tool versions and time zone as needed.

  ```yaml {file=".gitlab-ci.yml" copy=true}
  variables:
    # Define tool versions
    DART_SASS_VERSION: 1.101.0
    GO_VERSION: 1.26.4
    HUGO_VERSION: 0.163.3
    NODE_VERSION: 24.16.0

    # Set the build timezone
    TZ: Europe/Oslo

    # Set the build cache directory
    HUGO_CACHEDIR: ${CI_PROJECT_DIR}/.cache/hugo

    # Set the repository clone and fetch strategy
    GIT_DEPTH: 0
    GIT_STRATEGY: clone
    GIT_SUBMODULE_STRATEGY: recursive
  cache:
    key: ${CI_COMMIT_REF_SLUG}
    fallback_keys:
      - ${CI_DEFAULT_BRANCH}
    paths:
      - .cache/hugo
  image:
    name: buildpack-deps:bookworm
  pages:
    stage: deploy
    script:
      - chmod a+x build.sh && ./build.sh
    artifacts:
      paths:
        - public
    rules:
      - if: $CI_COMMIT_BRANCH == $CI_DEFAULT_BRANCH
  ```

Step 2
: Create a `build.sh` file in the root of your project.

  ```sh {file="build.sh" copy=true}
  #!/usr/bin/env bash

  #------------------------------------------------------------------------------
  # @file
  # Builds a Hugo project hosted on GitLab Pages.
  #------------------------------------------------------------------------------

  # Exit on error, undefined variables, or pipe failures
  set -euo pipefail

  # Perform cleanup
  cleanup() {
    if [[ -n "${build_temp_dir:-}" && -d "${build_temp_dir}" ]]; then
      rm -rf "${build_temp_dir}"
    fi
  }

  # Register the cleanup trap
  trap cleanup EXIT SIGINT SIGTERM

  main() {
    # Create a temporary directory for downloads
    build_temp_dir=$(mktemp -d)

    # Create a local tools directory
    mkdir -p "${HOME}/.local"

    # Install utilities
    echo "Installing utilities..."
    apt-get update > /dev/null
    apt-get install -y brotli > /dev/null

    # Install Dart Sass
    echo "Installing Dart Sass ${DART_SASS_VERSION}..."
    curl -sfLO --output-dir "${build_temp_dir}" "https://github.com/sass/dart-sass/releases/download/${DART_SASS_VERSION}/dart-sass-${DART_SASS_VERSION}-linux-x64.tar.gz"
    tar -C "${HOME}/.local" -xf "${build_temp_dir}/dart-sass-${DART_SASS_VERSION}-linux-x64.tar.gz"
    export PATH="${HOME}/.local/dart-sass:${PATH}"

    # Install Go
    if [[ -f "${CI_PROJECT_DIR}/go.mod" ]]; then
      echo "Installing Go ${GO_VERSION}..."
      curl -sfLO --output-dir "${build_temp_dir}" "https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz"
      tar -C "${HOME}/.local" -xf "${build_temp_dir}/go${GO_VERSION}.linux-amd64.tar.gz"
      export PATH="${HOME}/.local/go/bin:${PATH}"
    fi

    # Install Hugo
    echo "Installing Hugo ${HUGO_VERSION}..."
    curl -sfLO --output-dir "${build_temp_dir}" "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_linux-amd64.tar.gz"
    mkdir -p "${HOME}/.local/hugo"
    tar -C "${HOME}/.local/hugo" -xf "${build_temp_dir}/hugo_${HUGO_VERSION}_linux-amd64.tar.gz"
    export PATH="${HOME}/.local/hugo:${PATH}"

    # Install Node.js
    if [[ -f "${CI_PROJECT_DIR}/package-lock.json" ]]; then
      echo "Installing Node.js ${NODE_VERSION}..."
      curl -sfLO --output-dir "${build_temp_dir}" "https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.gz"
      tar -C "${HOME}/.local" -xf "${build_temp_dir}/node-v${NODE_VERSION}-linux-x64.tar.gz"
      export PATH="${HOME}/.local/node-v${NODE_VERSION}-linux-x64/bin:${PATH}"
    fi

    # Log tool versions
    echo "Logging tool versions..."
    command -v sass &> /dev/null && echo "Dart Sass: $(sass --version)" || echo "Dart Sass: not installed"
    command -v go &> /dev/null && echo "Go: $(go version)" || echo "Go: not installed"
    command -v hugo &> /dev/null && echo "Hugo: $(hugo version)" || echo "Hugo: not installed"
    command -v node &> /dev/null && echo "Node.js: $(node --version)" || echo "Node.js: not installed"

    # Configure Git
    echo "Configuring Git..."
    git config --global core.quotepath false

    # Fetch full Git history
    if [[ $(git rev-parse --is-shallow-repository) == true ]]; then
      echo "Fetching full Git history..."
      git fetch --unshallow
    fi

    # Initialize Git submodules
    if [[ -f .gitmodules ]]; then
      echo "Initializing Git submodules..."
      git submodule update --init --recursive
    fi

    # Install Node.js dependencies
    if [[ -f package-lock.json ]]; then
      echo "Installing Node.js dependencies..."
      npm ci
    fi

    # Build the project
    echo "Building the project..."
    hugo build --gc --minify

    # Compress published files
    echo "Compressing published files..."
    find public/ -type f -regextype posix-extended -regex '.+\.(cjs|css|html|js|json|mjs|svg|txt|xml)$' -print0 > "${build_temp_dir}/files.txt"
    xargs --null --max-procs=0 --max-args=1 brotli --quality=10 --force --keep < "${build_temp_dir}/files.txt"
    xargs --null --max-procs=0 --max-args=1 gzip -9 --force --keep < "${build_temp_dir}/files.txt"
  }

  main "$@"
  ```

Step 3
: In your project configuration, change the location of the image cache to the [`cacheDir`][] as shown below:

  {{< code-toggle file=hugo copy=true >}}
  [caches.images]
  dir = ':cacheDir/images'
  {{< /code-toggle >}}

  See [configure file caches][] for more information.

Step 4
: Commit the changes to your local Git repository and push to your GitLab repository.

Step 5
: From your GitLab repository, navigate to **Build**&nbsp;>&nbsp;**Pipelines** to follow the CI pipeline building your page.

Step 6
: When the pipeline has passed, your new website is available at `https://<YourUsername>.gitlab.io/<your-hugo-site>/`.

In the future, whenever you push a change from your local Git repository, GitLab Pages will rebuild and deploy your site.

[`baseURL`]: /configuration/all/#baseurl
[`cacheDir`]: /configuration/all/#cachedir
[configure file caches]: /configuration/caches/
[remote]: https://git-scm.com/docs/git-remote


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/host-and-deploy/host-on-sourcehut-pages.md
---


Use these instructions to host your site on SourceHut Pages using either manual deployment or the SourceHut build system.

{{% include "/_common/gitignore-public.md" %}}

## Prerequisites

- Working familiarity with [Git][] or [Mercurial][] for version control
- Completion of the Hugo [Quick Start][]
- A [SourceHut account][]
- A Hugo website on your local machine that you are ready to publish

Any and all mentions of `<YourUsername>` refer to your actual SourceHut username and must be substituted accordingly.

## BaseURL

The [`baseURL`][] in your project configuration must reflect the full URL provided by SourceHut Pages if you are using the default address (e.g. `https://<YourUsername>.srht.site/`). If you want to use another domain, check the [custom domain section][] of the official documentation.

## Manual deployment

This method does not require a paid account. To proceed you will need to create a [SourceHut personal access token][] and install and configure the [hut][] CLI tool:

```sh
hugo build
tar -C public -cvz . > site.tar.gz
hut init
hut pages publish -d <YourUsername>.srht.site site.tar.gz
```

A TLS certificate will be automatically obtained for you, and your new website will be available at `https://<YourUsername>.srht.site/` (or the provided custom domain).

## Automated deployment

This method requires a paid account and relies on the SourceHut build system.

First, define your [build manifest][] by creating a `.build.yml` file in the root of your project. The following is a bare-bones template:

```yaml {file=".build.yml" copy=true}
image: alpine/edge
packages:
  - hugo
  - hut
oauth: pages.sr.ht/PAGES:RW
environment:
  site: <YourUsername>.srht.site
tasks:
- package: |
    cd $site
    hugo build
    tar -C public -cvz . > ../site.tar.gz
- upload: |
    hut pages publish -d $site site.tar.gz
```

If your site requires [Dart Sass][] to transpile Sass to CSS, set the DART_SASS_VERSION to the [latest version number][] and include the Dart Sass installation lines before running the Hugo build step. Note that for Alpine, the `linux-x64-musl` version is used.

```yaml {file=".build.yml" copy=true}
image: alpine/edge
packages:
  - hugo
  - hut
  - curl # For Dart Sass installation
oauth: pages.sr.ht/PAGES:RW
environment:
  site: <YourUsername>.srht.site
tasks:
- package: |
    DART_SASS_VERSION=1.101.0
    mkdir -p $HOME/.local
    curl -L https://github.com/sass/dart-sass/releases/download/${DART_SASS_VERSION}/dart-sass-${DART_SASS_VERSION}-linux-x64-musl.tar.gz -o dart-sass.tar.gz
    tar -xzf dart-sass.tar.gz -C $HOME/.local
    rm dart-sass.tar.gz
    chmod -R +x $HOME/.local/dart-sass/src
    export PATH="$HOME/.local/dart-sass:$PATH"
    sass --version # Verify installation
    cd $site
    hugo build
    tar -C public -cvz . > ../site.tar.gz
- upload: |
    hut pages publish -d $site site.tar.gz
```

Create a repository titled `<YourUsername>.srht.site` (or your custom domain, if applicable) and push your local project to the repository.

You can now follow the build progress of your page at `https://builds.sr.ht/`.

After the build has passed, a TLS certificate will be automatically obtained for you and your new website will be available at `https://<YourUsername>.srht.site/` (or the provided custom domain).

## Other resources

- [SourceHut Pages][]
- [SourceHut Builds user manual][]

[Dart Sass]: https://gohugo.io/functions/css/sass/#dart-sass
[Git]: https://git-scm.com/
[Mercurial]: https://www.mercurial-scm.org/
[Quick Start]: /getting-started/quick-start/
[SourceHut Builds user manual]: https://man.sr.ht/builds.sr.ht/
[SourceHut Pages]: https://srht.site/
[SourceHut account]: https://meta.sr.ht/login
[SourceHut personal access token]: https://meta.sr.ht/oauth2/personal-token
[`baseURL`]: /configuration/all/#baseurl
[build manifest]: https://man.sr.ht/builds.sr.ht/#build-manifests
[custom domain section]: https://srht.site/custom-domains
[hut]: https://sr.ht/~xenrox/hut/
[latest version number]: https://github.com/sass/dart-sass/releases

