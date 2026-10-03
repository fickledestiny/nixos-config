
# NOTE: disko.enableConfig = false — disko is used only for the install script.
# The running system mounts are defined in hardware-configuration.nix.
{ ... }:

{
  disko.enableConfig = false;

  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/nvme0n1";
        content = {
          type = "gpt";
          partitions = {
            # EFI System Partition for systemd-boot (UEFI)
            ESP = {
              label = "ESP";
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
                extraArgs = [ "-n" "ESP" ];
              };
            };
            # LUKS-encrypted container holding an LVM volume group
            luks = {
              label = "luks";
              size = "100%";
              content = {
                type = "luks";
                name = "cryptroot";
                settings.allowDiscards = true;
                content = {
                  type = "lvm_pv";
                  vg = "pool";
                };
              };
            };
          };
        };
      };
    };
    lvm_vg = {
      pool = {
        type = "lvm_vg";
        lvs = {
          swap = {
            size = "64G";
            content = {
              type = "swap";
              resumeDevice = true;
            };
          };
          root = {
            size = "100%FREE";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/";
              mountOptions = [ "defaults" "relatime" ];
              extraArgs = [ "-L" "nixos" ];
            };
          };
        };
      };
    };
  };
}
