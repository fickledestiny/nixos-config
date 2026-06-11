# Disko disk layout for t-800 (Dell XPS P54G)
# Reflects the actual setup: single /dev/sda, single ext4 root, legacy GRUB (MBR)
# To reformat from scratch: nix run github:nix-community/disko -- --mode disko /etc/nixos/hosts/t-800/disko.nix
#
# NOTE: disko.enableConfig = false — disko is used only for the install script.
# The running system mounts are defined in hardware-configuration.nix.
{ ... }:

{
  disko.enableConfig = false;

  disko.devices = {
    disk = {
      sda = {
        type = "disk";
        device = "/dev/sda";
        content = {
          type = "gpt";
          partitions = {
            # MBR compatibility partition required for legacy GRUB on GPT disks
            boot = {
              size = "1M";
              type = "EF02"; # BIOS boot partition
            };
            root = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
                mountOptions = [ "defaults" "relatime" ];
                extraArgs = [ "-L nixos" ];
              };
            };
          };
        };
      };
    };
  };
}
