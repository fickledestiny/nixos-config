{ pkgs, ... }:

{
  programs.zellij = {
    enable = true;
    enableZshIntegration = false; # don't auto-start in every terminal
    settings = {
      theme = "catppuccin-mocha";
      default_layout = "compact";
      pane_frames = false;
      mouse_mode = true;
      copy_on_select = false;
      scrollback_editor = "hx";
    };
  };
}
