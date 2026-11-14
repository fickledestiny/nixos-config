{ pkgs, ... }:

{
  # Claude Code CLI, logged in with the Claude Pro subscription.
  home.packages = [ pkgs.claude-code ];
}
