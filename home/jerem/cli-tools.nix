{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    bat
    eza
    btop
    atop
    htop
    procs
    fd
    ripgrep
    fzf
    zoxide
    delta
    fastfetch
    libnotify
    kubectl
    kubernetes-helm
    k9s
    tfswitch
    rsync
    rclone
    jq
    yq-go
  ];

  home.sessionPath = [ "${config.home.homeDirectory}/.local/bin" ];

  home.file.".tfswitch.toml".text = ''
    bin = "${config.home.homeDirectory}/.local/bin/terraform"
  '';
}