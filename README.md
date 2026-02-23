# portwho

`portwho` is a lightweight Linux CLI to show which process is listening on a TCP/UDP port, with an optional safe kill flow.

Repository: https://github.com/mohit838/portwho
Maintainer: Mohitul Islam <connect@mohitul-islam.com>

## Features

- Find listeners by port (`ss` first, `lsof` fallback)
- Port validation (`1..65535`)
- Optional `--kill` mode with confirmation
- User and system installers
- Debian packaging metadata included (`debian/`)

## Quick Start

```bash
git clone https://github.com/mohit838/portwho.git
cd portwho
./install.sh
portwho --help
```

## Install

From Launchpad PPA (recommended for Ubuntu/Debian):

```bash
sudo add-apt-repository ppa:mohit838/portwho
sudo apt update
sudo apt install -y portwho
```

From source (user install, default `~/.local/bin`):

```bash
./install.sh
```

From source (system install, `/usr/local/bin`):

```bash
sudo ./install.sh --system
```

## Uninstall

```bash
./uninstall.sh
sudo ./uninstall.sh --system
```

## Usage

```bash
portwho 3000
portwho --kill 3000
```

## Tests

```bash
bash tests/test_portwho.sh
```

## Build Debian Package

```bash
dpkg-buildpackage -us -uc -b
```

## Release Automation

- Tag push (`v*`) triggers `.github/workflows/deb-release.yml` to:
  - run tests
  - build `.deb`
  - run `lintian` quality checks
  - install package and run `portwho --help` smoke test
  - upload workflow artifacts
  - attach artifacts to the GitHub release
- Manual workflow `.github/workflows/launchpad-ppa.yml` publishes signed source packages to Launchpad PPA.

Launchpad setup details are in `packaging/launchpad/README.md`.

## Documentation Site (VitePress)

```bash
cd docs
npm install
npm run dev
```

## Contributing

See `CONTRIBUTING.md` and the docs site content under `docs/`.

## License

MIT (`LICENSE`).
