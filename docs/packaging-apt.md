# Publishing `portwho` via apt

This document provides a practical path to publish `portwho` for Debian/Ubuntu users.

## 1. Build a `.deb`

Create Debian packaging metadata (`debian/control`, `debian/rules`, `debian/changelog`, etc.) and build with:

```bash
dpkg-buildpackage -us -uc
```

For this project, package `bin/portwho` into `/usr/bin/portwho`.

## 2. Host an apt repository

Choose one:

- Launchpad PPA (Ubuntu-focused)
- Aptly/Reprepro on your own server
- A managed package repository service

## 3. Sign packages and repo metadata

- Generate a GPG key for package signing.
- Sign release metadata so `apt` trusts your repository.

## 4. User install flow

After repository setup, users can install with:

```bash
sudo apt update
sudo apt install portwho
```

## Notes

- Keep package versions aligned with git tags.
- Add CI to build and lint the package before publishing.
- Consider adding a man page (`portwho.1`) for distro quality.
