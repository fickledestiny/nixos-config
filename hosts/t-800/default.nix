{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./disko.nix
    ../../modules/base.nix
    ../../modules/desktop.nix
    ../../modules/users.nix
  ];

  networking.hostName = "t-800";

  # Legacy (BIOS / MBR) boot — device managed by disko
  boot.loader.grub = {
    enable = true;
    useOSProber = true;
  };
  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.loader.efi.canTouchEfiVariables = lib.mkForce false;

  # Dell XPS hardware niceties
  services.fwupd.enable = true;
  services.thermald.enable = true;
  services.tlp.enable = true;
  hardware.cpu.intel.updateMicrocode = true;

  system.stateVersion = "24.11";
}
