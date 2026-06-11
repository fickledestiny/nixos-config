{ pkgs, ... }:

{
  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      theme = "base16_default_dark";
      editor = {
        line-number = "relative";
        cursorline = true;
        true-color = true;
        bufferline = "multiple";
        indent-guides.render = true;
      };
    };
  };
}
