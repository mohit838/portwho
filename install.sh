#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage:
  ./install.sh            Install to $HOME/.local/bin
  ./install.sh --system   Install to /usr/local/bin (requires sudo/root)

Optional env:
  PREFIX=/custom/prefix ./install.sh
USAGE
}

PREFIX="${PREFIX:-$HOME/.local}"

case "${1:-}" in
  --system)
    PREFIX="/usr/local"
    ;;
  -h|--help)
    usage
    exit 0
    ;;
  "")
    ;;
  *)
    echo "Unknown option: $1" >&2
    usage
    exit 2
    ;;
esac

BIN_DIR="$PREFIX/bin"
mkdir -p "$BIN_DIR"
install -m 0755 bin/portwho "$BIN_DIR/portwho"

echo "Installed: $BIN_DIR/portwho"
echo "Make sure $BIN_DIR is in PATH."
echo "Try: portwho --help"
