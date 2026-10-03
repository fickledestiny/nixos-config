{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user.name = "fickledestiny";
      user.email = "6524655+fickledestiny@users.noreply.github.com";
      init.defaultBranch = "main";
      pull.rebase = false;
    };
  };
}
