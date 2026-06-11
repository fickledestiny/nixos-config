{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user.name = "jerem";
      user.email = "jerem@t-800.local";
      init.defaultBranch = "main";
      pull.rebase = false;
    };
  };
}
