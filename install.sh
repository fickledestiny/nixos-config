#!/usr/bin/env bash
set -euo pipefail

HOST="${1:-t-800}"
DISK="${2:-/dev/sda}"
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> Installing NixOS host: $HOST on disk: $DISK"
echo "    Press Ctrl+C within 5 seconds to abort..."
sleep 5

echo "==> Partitioning $DISK with disko..."
nix --extra-experimental-features "nix-command flakes" \
  run github:nix-community/disko -- \
  --mode disko "$REPO_DIR/hosts/$HOST/disko.nix"

echo "==> Copying config to /mnt/etc/nixos..."
mkdir -p /mnt/etc/nixos
cp -r "$REPO_DIR/." /mnt/etc/nixos/

echo "==> Generating hardware configuration..."
nixos-generate-config --root /mnt
cp /mnt/etc/nixos/hardware-configuration.nix \
   /mnt/etc/nixos/hosts/$HOST/hardware-configuration.nix

echo "==> Running nixos-install..."
nixos-install --flake "/mnt/etc/nixos#$HOST" --no-root-passwd

echo ""
echo "==> Done! You can now reboot."
