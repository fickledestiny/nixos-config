{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    ./niri.nix
    ./wofi.nix
    ./kitty.nix
    ./helix.nix
    ./firefox.nix
    ./git.nix
    ./waybar.nix
    ./zsh.nix
    ./mako.nix
    ./thunar.nix
    ./zellij.nix
    ./ssh.nix
  ];

  home.username = "jerem";
  home.homeDirectory = "/home/jerem";
  home.stateVersion = "24.11";

  programs.home-manager.enable = true;

  xdg.configFile."fastfetch/config.jsonc".text = ''
    {
      "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
      "logo": { "type": "none" },
      "display": {
        "separator": "  ",
        "color": { "keys": "blue", "title": "cyan" }
      },
      "modules": [
        { "type": "title",   "format": "{user-name}@{host-name}" },
        "break",
        { "type": "host",    "key": "󰌢 Computer" },
        { "type": "os",      "key": "󰣇 OS" },
        "break",
        { "type": "localip", "key": "󰈀 Network", "showIpv4": true, "showIpv6": false },
        { "type": "wifi",    "key": "󰤨 WiFi" },
        "break",
        { "type": "disk",    "key": "󰋊 Disk",    "folders": "/" },
        { "type": "battery", "key": "󰁹 Battery" },
        "break"
      ]
    }
  '';

  # Wallpaper file made available in the user profile
  home.file.".config/wallpaper.jpg".source = ../../assets/wallpaper.jpg;

  # GTK dark theme
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
    gtk4.theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style.name = "adwaita-dark";
  };

  home.sessionVariables = {
    EDITOR = "hx";
    TERMINAL = "kitty";
    BROWSER = "firefox";
    XDG_DATA_DIRS = "$HOME/.nix-profile/share:$HOME/.local/share:/run/current-system/sw/share:/etc/profiles/per-user/$USER/share";
  };

  home.packages = with pkgs; [
    swaybg
  ];

  # Wallpaper service via swaybg (started by niri spawn-at-startup as well)
  systemd.user.services.swaybg = {
    Unit = {
      Description = "Wallpaper";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.swaybg}/bin/swaybg -i %h/.config/wallpaper.jpg -m fill";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };
}
