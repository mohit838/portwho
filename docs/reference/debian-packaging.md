# Debian Packaging

This repository includes a real Debian package layout under `debian/`.

## Build package

```bash
dpkg-buildpackage -us -uc -b
```

Generated `.deb` files are placed in the parent directory.

## Local apt-style install

```bash
sudo ./install-apt.sh
```

This script builds the package, indexes a local apt repository, and installs `portwho` with apt.

## Package contents

- `usr/bin/portwho`
- `man/portwho.1`

## Metadata

- Maintainer: Mohitul Islam <connect@mohitul-islam.com>
- Homepage: https://github.com/mohit838/portwho

## CI/CD Workflows

- `.github/workflows/deb-release.yml`: builds Debian binary packages when tags like `v1.2.3` are pushed.
- `.github/workflows/launchpad-ppa.yml`: manual Launchpad PPA upload workflow using signed source packages.

For PPA secrets and one-time setup, see `packaging/launchpad/README.md`.
