{ config, pkgs, lib, inputs, ... }:

{
  # Keyboard layout (X11/Wayland apps that read it)
  services.xserver.xkb = {
    layout = "fr";
    variant = "azerty";
  };

  # Display manager: Ly (TUI)
  services.displayManager.ly = {
    enable = true;
    settings = {
      animation = "colormix";
      bigclock = "en";
      bigclock_seconds = true;
      clock = "%H:%M  %d/%m/%Y";
    };
  };

  # Niri compositor (via niri-flake)
  programs.niri.enable = true;

  # XDG portals for Wayland apps (screenshots, file pickers, ...)
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
    ];
  };

  # Sound (PipeWire)
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Fonts
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-color-emoji
    noto-fonts-cjk-sans
    dejavu_fonts
    liberation_ttf
    jetbrains-mono
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
  ];

  # Dark theme system-wide (GTK)
  environment.sessionVariables = {
    GTK_THEME = "Adwaita-dark";
    QT_QPA_PLATFORMTHEME = "gtk2";
  };

  services.gvfs.enable = true;

  # System packages required by the desktop session
  environment.systemPackages = with pkgs; [
    wofi
    swaylock-effects
    swayidle
    wlopm
    grim
    slurp
    wl-clipboard
    brightnessctl
    pamixer
    playerctl
    networkmanagerapplet
    adwaita-icon-theme
    gnome-themes-extra
  ];
}
