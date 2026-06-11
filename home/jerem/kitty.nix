{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 12;
    };
    themeFile = "Catppuccin-Mocha";
    settings = {
      background_opacity = "0.95";
      enable_audio_bell = false;
      window_padding_width = 6;
    };
  };
}
