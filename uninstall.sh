#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage:
  ./uninstall.sh            Remove from $HOME/.local/bin
  ./uninstall.sh --system   Remove from /usr/local/bin (requires sudo/root)

Optional env:
  PREFIX=/custom/prefix ./uninstall.sh
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

TARGET="$PREFIX/bin/portwho"

if [[ -f "$TARGET" ]]; then
  rm -f "$TARGET"
  echo "Removed: $TARGET"
else
  echo "Not found: $TARGET"
fi
