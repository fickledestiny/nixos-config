#!/usr/bin/env bash
set -euo pipefail

HOST="${1:-t-800}"
DISK="${2:-/dev/sda}"
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> Installing NixOS host: $HOST on disk: $DISK"
echo "    Press Ctrl+C within 5 seconds to abort..."
sleep 5

# Configure binary caches on the ISO to avoid compiling niri from source
echo "==> Configuring binary caches..."
export NIX_CONFIG="extra-substituters = https://niri.cachix.org
extra-trusted-public-keys = niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="

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
