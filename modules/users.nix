{ config, pkgs, lib, ... }:

{
  users.users.jerem = {
    isNormalUser = true;
    description = "jerem";
    extraGroups = [ "wheel" "networkmanager" "video" "audio" "input" ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCxKCP0cvFdvd9hnUzrYyAoe35Sfqt+gjY8dUcAc03od8c0bMNDIfRISCxyYN9lCUjSp5u+FkCEah42k1fJpy8AobaN1fQRy2pqZBbfKEM2Z6KInh2fDjYahUisZdMT+CSOEpzoB0tCU1sXNiBScRCDHYaSrL6xe4ij+CgiCKcLQFcm2Rjaz3ckkewZbsZwgwbRIP0A9GUJr9Xt4Tq0KgSt9TDKA7mUCS4dq6fOf079Wi+u4q1tcmMINAGDvWet1ZFHG6znut5IAMaBAdY+iPG9vjQRKHz9uq2gqdxFUveHwi1vCNhof7mPmN5oY/prQ3gl1OuKVc9gt5phPb7S+I/R"
    ];
  };

  programs.zsh.enable = true; # needed for zsh to be a valid login shell

  # Passwordless sudo for the wheel group
  security.sudo.wheelNeedsPassword = false;
}
