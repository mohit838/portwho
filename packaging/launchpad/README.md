# Launchpad PPA Publishing

This project includes `.github/workflows/launchpad-ppa.yml` for publishing source packages to Launchpad PPAs.

## Required GitHub secrets

- `LAUNCHPAD_GPG_PRIVATE_KEY`: ASCII-armored private key used to sign source uploads.
- `LAUNCHPAD_GPG_PASSPHRASE`: passphrase for the signing key (empty if key has no passphrase).

## One-time Launchpad setup

1. Create a Launchpad account and PPA (for example: `mohit838/portwho`).
2. Upload your public GPG key to Launchpad.
3. Confirm the key fingerprint in your Launchpad account.

## Trigger upload

1. Open GitHub Actions.
2. Run `Publish To Launchpad PPA`.
3. Set:
   - `ppa_owner` (user/team)
   - `ppa_name`
   - `ubuntu_series` (`jammy`, `noble`, etc.)

The workflow builds a signed source package and runs:

```bash
dput ppa:<owner>/<ppa> ../portwho_*_source.changes
```

## Local manual upload (optional)

```bash
dpkg-buildpackage -S -sa

dput ppa:<owner>/<ppa> ../portwho_*_source.changes
```
