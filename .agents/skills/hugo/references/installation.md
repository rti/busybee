
---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/installation/bsd.md
---


{{% include "/_common/installation/01-editions.md" %}}

{{% include "/_common/installation/02-prerequisites.md" %}}

{{% include "/_common/installation/03-prebuilt-binaries.md" %}}

## Repository packages

Most BSD derivatives maintain a repository for commonly installed applications. Please note that these repositories may not contain the [latest release][].

### DragonFly BSD

[DragonFly BSD][] includes Hugo in its package repository. To install the extended edition of Hugo:

```sh
sudo pkg install gohugo
```

### FreeBSD

[FreeBSD][] includes Hugo in its package repository. To install the extended edition of Hugo:

```sh
sudo pkg install gohugo
```

### NetBSD

[NetBSD][] includes Hugo in its package repository. To install the extended edition of Hugo:

```sh
sudo pkgin install go-hugo
```

### OpenBSD

[OpenBSD][] includes Hugo in its package repository. This will prompt you to select which edition of Hugo to install:

```sh
doas pkg_add hugo
```

{{% include "/_common/installation/04-build-from-source.md" %}}

## Comparison

&nbsp;|Prebuilt binaries|Repository packages|Build from source
:--|:--:|:--:|:--:
Easy to install?|:heavy_check_mark:|:heavy_check_mark:|:heavy_check_mark:
Easy to upgrade?|:heavy_check_mark:|varies|:heavy_check_mark:
Easy to downgrade?|:heavy_check_mark:|varies|:heavy_check_mark:
Automatic updates?|:x:|varies|:x:
Latest version available?|:heavy_check_mark:|varies|:heavy_check_mark:

[DragonFly BSD]: https://www.dragonflybsd.org/
[FreeBSD]: https://www.freebsd.org/
[NetBSD]: https://www.netbsd.org/
[OpenBSD]: https://www.openbsd.org/
[latest release]: https://github.com/gohugoio/hugo/releases/latest


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/installation/linux.md
---


{{% include "/_common/installation/01-editions.md" %}}

{{% include "/_common/installation/02-prerequisites.md" %}}

{{% include "/_common/installation/03-prebuilt-binaries.md" %}}

## Package managers

### Snap

[Snap][] is a free and open-source package manager for Linux. Available for [most distributions][], snap packages are simple to install and are automatically updated.

The Hugo snap package is [strictly confined][]. Strictly confined snaps run in complete isolation, up to a minimal access level that's deemed always safe. The sites you create and build must be located within your home directory, or on removable media.

To install the extended edition of Hugo:

```sh
sudo snap install hugo
```

To control automatic updates:

```sh
# disable automatic updates
sudo snap refresh --hold hugo

# enable automatic updates
sudo snap refresh --unhold hugo
```

To control access to removable media:

```sh
# allow access
sudo snap connect hugo:removable-media

# revoke access
sudo snap disconnect hugo:removable-media
```

To control access to SSH keys:

```sh
# allow access
sudo snap connect hugo:ssh-keys

# revoke access
sudo snap disconnect hugo:ssh-keys
```

{{% include "/_common/installation/homebrew.md" %}}

## Repository packages

Most Linux distributions maintain a repository for commonly installed applications.

> [!NOTE]
> The Hugo version available in package repositories varies based on Linux distribution and release, and in some cases will not be the [latest version][].
>
> Use one of the other installation methods if your package repository does not provide the desired version.

### Alpine Linux

To install the extended edition of Hugo on [Alpine Linux][]:

```sh
doas apk add --no-cache --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community hugo
```

### Arch Linux

Derivatives of the [Arch Linux][] distribution of Linux include [EndeavourOS][], [Garuda Linux][], [Manjaro][], and others. To install the extended edition of Hugo:

```sh
sudo pacman -S hugo
```

### Debian

Derivatives of the [Debian][] distribution of Linux include [elementary OS][], [KDE neon][], [Linux Lite][], [Linux Mint][], [MX Linux][], [Pop!_OS][], [Ubuntu][], [Zorin OS][], and others. To install the extended edition of Hugo:

```sh
sudo apt install hugo
```

You can also download Debian packages from the [latest release][] page.

### Exherbo

To install the extended edition of Hugo on [Exherbo][]:

1. Add this line to /etc/paludis/options.conf:

    ```text
    www-apps/hugo extended
    ```

1. Install using the Paludis package manager:

    ```sh
    cave resolve -x repository/heirecka
    cave resolve -x hugo
    ```

### Fedora

Derivatives of the [Fedora][] distribution of Linux include [CentOS][], [Red Hat Enterprise Linux][], and others. To install the extended edition of Hugo:

```sh
sudo dnf install hugo
```

### Gentoo

Derivatives of the [Gentoo][] distribution of Linux include [Calculate Linux][], [Funtoo][], and others. To install the extended edition of Hugo:

1. Specify the `extended` [USE][] flag in /etc/portage/package.use/hugo:

    ```text
    www-apps/hugo extended
    ```

1. Build using the Portage package manager:

    ```sh
    sudo emerge www-apps/hugo
    ```

### NixOS

The NixOS distribution of Linux includes Hugo in its package repository. To install the extended edition of Hugo:

```sh
nix-env -iA nixos.hugo
```

### openSUSE

Derivatives of the [openSUSE][] distribution of Linux include [GeckoLinux][], [Linux Karmada][], and others. To install the extended edition of Hugo:

```sh
sudo zypper install hugo
```

### Solus

The [Solus][] distribution of Linux includes Hugo in its package repository. To install the extended edition of Hugo:

```sh
sudo eopkg install hugo
```

### Void Linux

To install the extended edition of Hugo on [Void Linux][]:

```sh
sudo xbps-install -S hugo
```

{{% include "/_common/installation/04-build-from-source.md" %}}

## Comparison

&nbsp;|Prebuilt binaries|Package managers|Repository packages|Build from source
:--|:--:|:--:|:--:|:--:
Easy to install?|:heavy_check_mark:|:heavy_check_mark:|:heavy_check_mark:|:heavy_check_mark:
Easy to upgrade?|:heavy_check_mark:|:heavy_check_mark:|varies|:heavy_check_mark:
Easy to downgrade?|:heavy_check_mark:|:heavy_check_mark: [^1]|varies|:heavy_check_mark:
Automatic updates?|:x:|varies [^2]|:x:|:x:
Latest version available?|:heavy_check_mark:|:heavy_check_mark:|varies|:heavy_check_mark:

[^1]: Easy if a previous version is still installed.
[^2]: Snap packages are automatically updated. Homebrew requires advanced configuration.

[Alpine Linux]: https://alpinelinux.org/
[Arch Linux]: https://archlinux.org/
[Calculate Linux]: https://www.calculate-linux.org/
[CentOS]: https://www.centos.org/
[Debian]: https://www.debian.org/
[EndeavourOS]: https://endeavouros.com/
[Exherbo]: https://www.exherbolinux.org/
[Fedora]: https://getfedora.org/
[Funtoo]: https://www.funtoo.org/
[Garuda Linux]: https://garudalinux.org/
[GeckoLinux]: https://geckolinux.github.io/
[Gentoo]: https://www.gentoo.org/
[KDE neon]: https://neon.kde.org/
[Linux Karmada]: https://linuxkamarada.com/
[Linux Lite]: https://www.linuxliteos.com/
[Linux Mint]: https://linuxmint.com/
[MX Linux]: https://mxlinux.org/
[Manjaro]: https://manjaro.org/
[Pop!_OS]: https://pop.system76.com/
[Red Hat Enterprise Linux]: https://www.redhat.com/
[Snap]: https://snapcraft.io/
[Solus]: https://getsol.us/
[USE]: https://packages.gentoo.org/packages/www-apps/hugo
[Ubuntu]: https://ubuntu.com/
[Void Linux]: https://voidlinux.org/
[Zorin OS]: https://zorin.com/os/
[elementary OS]: https://elementary.io/
[latest release]: https://github.com/gohugoio/hugo/releases/latest
[latest version]: https://github.com/gohugoio/hugo/releases/latest
[most distributions]: https://snapcraft.io/docs/installing-snapd
[openSUSE]: https://www.opensuse.org/
[strictly confined]: https://snapcraft.io/docs/snap-confinement


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/installation/macos.md
---


{{% include "/_common/installation/01-editions.md" %}}

{{% include "/_common/installation/02-prerequisites.md" %}}

{{% include "/_common/installation/03-prebuilt-binaries.md" %}}

## Package managers

{{% include "/_common/installation/homebrew.md" %}}

### MacPorts

[MacPorts][] is a free and open-source package manager for macOS. To install the extended edition of Hugo:

```sh
sudo port install hugo
```

{{% include "/_common/installation/04-build-from-source.md" %}}

## Comparison

&nbsp;|Prebuilt binaries|Package managers|Build from source
:--|:--:|:--:|:--:
Easy to install?|:heavy_check_mark:|:heavy_check_mark:|:heavy_check_mark:
Easy to upgrade?|:heavy_check_mark:|:heavy_check_mark:|:heavy_check_mark:
Easy to downgrade?|:heavy_check_mark:|:heavy_check_mark: [^1]|:heavy_check_mark:
Automatic updates?|:x:|:x: [^2]|:x:
Latest version available?|:heavy_check_mark:|:heavy_check_mark:|:heavy_check_mark:

[^1]: Easy if a previous version is still installed.
[^2]: Possible but requires advanced configuration.

[MacPorts]: https://www.macports.org/


---
source: https://github.com/gohugoio/hugo/blob/master/docs/content/en/installation/windows.md
---


> [!NOTE]
> Hugo requires Windows 10, Windows Server 2016, or later.

{{% include "/_common/installation/01-editions.md" %}}

{{% include "/_common/installation/02-prerequisites.md" %}}

{{% include "/_common/installation/03-prebuilt-binaries.md" %}}

## Package managers

### Chocolatey

[Chocolatey][] is a free and open-source package manager for Windows. To install the extended edition of Hugo:

```sh
choco install hugo-extended
```

### Scoop

[Scoop][] is a free and open-source package manager for Windows. To install the extended edition of Hugo:

```sh
scoop install hugo-extended
```

### Winget

[Winget][] is Microsoft's official free and open-source package manager for Windows. To install the extended edition of Hugo:

```sh
winget install Hugo.Hugo.Extended
```

To uninstall the extended edition of Hugo:

```sh
winget uninstall --name "Hugo (Extended)"
```

## Build from source

To build Hugo from source you must install:

1. [Git][]
1. [Go][] version {{% current-go-version %}} or later

> [!NOTE]
> The Bash-style `KEY=VALUE cmd` syntax used in the macOS and Linux build-from-source instructions does not work in PowerShell or Command Prompt. Use the code block matching your shell.

### Standard edition

To build and install the standard edition:

PowerShell:

```powershell
$env:CGO_ENABLED=0; go install github.com/gohugoio/hugo@latest
```

Command Prompt:

```bat
set CGO_ENABLED=0
go install github.com/gohugoio/hugo@latest
```

### Deploy edition

{{< new-in v0.159.2 />}}

To build and install the deploy edition:

PowerShell:

```powershell
$env:CGO_ENABLED=0; go install -tags withdeploy github.com/gohugoio/hugo@latest
```

Command Prompt:

```bat
set CGO_ENABLED=0
go install -tags withdeploy github.com/gohugoio/hugo@latest
```

### Extended edition

To build and install the extended edition, first install a C compiler such as [GCC][] or [Clang][] and then run the following command:

PowerShell:

```powershell
$env:CGO_ENABLED=1; go install -tags extended github.com/gohugoio/hugo@latest
```

Command Prompt:

```bat
set CGO_ENABLED=1
go install -tags extended github.com/gohugoio/hugo@latest
```

### Extended/deploy edition

To build and install the extended/deploy edition, first install a C compiler such as [GCC][] or [Clang][] and then run the following command:

PowerShell:

```powershell
$env:CGO_ENABLED=1; go install -tags extended,withdeploy github.com/gohugoio/hugo@latest
```

Command Prompt:

```bat
set CGO_ENABLED=1
go install -tags extended,withdeploy github.com/gohugoio/hugo@latest
```

> [!NOTE]
> See these [detailed instructions][] to install GCC on Windows.

## Comparison

&nbsp;|Prebuilt binaries|Package managers|Build from source
:--|:--:|:--:|:--:
Easy to install?|:heavy_check_mark:|:heavy_check_mark:|:heavy_check_mark:
Easy to upgrade?|:heavy_check_mark:|:heavy_check_mark:|:heavy_check_mark:
Easy to downgrade?|:heavy_check_mark:|:heavy_check_mark: [^2]|:heavy_check_mark:
Automatic updates?|:x:|:x: [^1]|:x:
Latest version available?|:heavy_check_mark:|:heavy_check_mark:|:heavy_check_mark:

[^1]: Possible but requires advanced configuration.
[^2]: Easy if a previous version is still installed.

[Chocolatey]: https://chocolatey.org/
[Clang]: https://clang.llvm.org/
[GCC]: https://gcc.gnu.org/
[Git]: https://git-scm.com/book/en/v2/Getting-Started-Installing-Git
[Go]: https://go.dev/doc/install
[Scoop]: https://scoop.sh/
[Winget]: https://learn.microsoft.com/en-us/windows/package-manager/
[detailed instructions]: https://discourse.gohugo.io/t/41370

