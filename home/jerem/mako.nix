{ pkgs, ... }:

{
  home.packages = [ pkgs.mako ];

  xdg.configFile."mako/config".text = ''
    background-color=#1e1e2e
    text-color=#cdd6f4
    border-color=#89b4fa
    border-radius=8
    border-size=1
    padding=10,14
    margin=10
    width=360
    height=120
    font=JetBrainsMono Nerd Font 11
    icons=1
    max-icon-size=48
    default-timeout=5000
    layer=overlay

    [urgency=low]
    border-color=#45475a
    default-timeout=3000

    [urgency=critical]
    border-color=#f38ba8
    background-color=#1e1e2e
    text-color=#f38ba8
    default-timeout=0
  '';
}
