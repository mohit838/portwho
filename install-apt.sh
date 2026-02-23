#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage:
  sudo ./install-apt.sh

This script:
  1. Installs build dependencies
  2. Builds a local .deb from this repository
  3. Creates a local apt repository at /opt/portwho-apt-repo
  4. Installs portwho via apt
USAGE
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
  usage
  exit 0
fi

if [[ "${EUID}" -ne 0 ]]; then
  echo "Run as root: sudo ./install-apt.sh" >&2
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="/opt/portwho-apt-repo"
LIST_FILE="/etc/apt/sources.list.d/portwho-local.list"

cd "$SCRIPT_DIR"

export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get install -y \
  build-essential \
  dpkg-dev \
  debhelper \
  devscripts \
  fakeroot

dpkg-buildpackage -us -uc -b

DEB_FILE="$(ls -1 ../portwho_*_all.deb | sort | tail -n 1)"

mkdir -p "$REPO_DIR"
cp -f "$DEB_FILE" "$REPO_DIR/"

(
  cd "$REPO_DIR"
  dpkg-scanpackages . /dev/null | gzip -9c > Packages.gz
)

printf 'deb [trusted=yes] file:%s ./\n' "$REPO_DIR" > "$LIST_FILE"

apt-get update
apt-get install -y portwho

echo "Installed via apt: $(command -v portwho)"
portwho --help >/dev/null
echo "Smoke test passed: portwho --help"
