#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage:
  sudo ./uninstall-apt.sh

This script:
  1. Removes portwho package
  2. Removes local apt source entry
  3. Refreshes apt package indexes

Note:
  Local repo files in /opt/portwho-apt-repo are kept.
USAGE
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
  usage
  exit 0
fi

if [[ "${EUID}" -ne 0 ]]; then
  echo "Run as root: sudo ./uninstall-apt.sh" >&2
  exit 1
fi

LIST_FILE="/etc/apt/sources.list.d/portwho-local.list"

export DEBIAN_FRONTEND=noninteractive

apt-get remove -y portwho || true

if [[ -f "$LIST_FILE" ]]; then
  rm -f "$LIST_FILE"
fi

apt-get update

echo "Removed apt-installed portwho and local apt source entry."
