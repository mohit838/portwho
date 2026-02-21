# Packaging Notes

Debian package metadata is kept in the repository root at `debian/`.

Launchpad-specific operational docs are in `packaging/launchpad/README.md`.

Build with:

```bash
dpkg-buildpackage -us -uc -b
```
