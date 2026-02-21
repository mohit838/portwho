# portwho

`portwho` is a lightweight Linux CLI to identify which process is listening on a TCP/UDP port, with an optional safe kill flow.

## Features

- Find listeners by port (`ss` first, `lsof` fallback)
- Validate ports (`1..65535`)
- Optional `--kill` mode with interactive confirmation
- User install (`~/.local/bin`) or system install (`/usr/local/bin`)

## Requirements

- Linux
- `bash`
- One of:
  - `ss` (from `iproute2`)
  - `lsof`

## Install

### User install (recommended)

```bash
git clone https://github.com/<your-org>/portwho.git
cd portwho
./install.sh
```

By default it installs to `~/.local/bin/portwho`.

### System install

```bash
sudo ./install.sh --system
```

This installs to `/usr/local/bin/portwho`.

## Uninstall

```bash
./uninstall.sh
```

System uninstall:

```bash
sudo ./uninstall.sh --system
```

## Usage

```bash
portwho 3000
portwho --kill 3000
portwho --help
```

## Development

Run tests:

```bash
bash tests/test_portwho.sh
```

## Project Layout

- `bin/portwho`: main executable
- `bin/portwho.sh`: backward-compatible wrapper
- `install.sh`: installer
- `uninstall.sh`: uninstaller
- `tests/test_portwho.sh`: script tests
- `docs/packaging-apt.md`: how to publish as an apt package

## License

MIT. See `LICENSE`.

## Contributing

See `docs/CONTRIBUTING.md`.
