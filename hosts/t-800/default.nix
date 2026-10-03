{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./disko.nix
    ../../modules/base.nix
    ../../modules/desktop.nix
    ../../modules/ai.nix
    ../../modules/users.nix
  ];

  networking.hostName = "t-800";

  boot.loader.systemd-boot.enable = lib.mkForce true;
  boot.loader.efi.canTouchEfiVariables = lib.mkForce true;
  boot.loader.grub.enable = false;
  boot.initrd.systemd.enable = true;

  # Dell XPS hardware niceties
  services.fwupd.enable = true;
  services.thermald.enable = true;
  # power-profiles-daemon manages performance/balanced/power-saver profiles
  # (replaces tlp — they conflict)
  services.power-profiles-daemon.enable = true;
  hardware.cpu.intel.updateMicrocode = true;

  system.stateVersion = "24.11";
}
