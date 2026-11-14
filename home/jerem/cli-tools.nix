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
    uv
    python3
  ];

  # uv's downloaded Pythons are generic-linux binaries that can't run on NixOS;
  # force it to use the Nix-provided interpreter instead.
  home.sessionVariables = {
    UV_PYTHON_DOWNLOADS = "never";
    UV_PYTHON = "${pkgs.python3}/bin/python3";
  };

  home.sessionPath = [ "${config.home.homeDirectory}/.local/bin" ];

  home.file.".tfswitch.toml".text = ''
    bin = "${config.home.homeDirectory}/.local/bin/terraform"
  '';
}