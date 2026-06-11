{ pkgs, config, ... }:

{
  home.packages = with pkgs; [ rbw pinentry-curses ];

  # rbw is configured interactively — run once after install:
  #   rbw register   (asks for email + server URL, stores in ~/.config/rbw/)
  #   rbw login

  # Script to pull SSH key from Vaultwarden and install it
  home.file.".local/bin/ssh-from-vault" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      set -e

      SSH_DIR="$HOME/.ssh"
      KEY_FILE="$SSH_DIR/id_ed25519"

      if [[ -f "$KEY_FILE" ]]; then
        echo "SSH key already present at $KEY_FILE, skipping."
        exit 0
      fi

      echo "Fetching SSH key from Vaultwarden..."
      mkdir -p "$SSH_DIR"
      chmod 700 "$SSH_DIR"

      rbw get "SSH_private" > "$KEY_FILE"
      chmod 600 "$KEY_FILE"
      ssh-keygen -y -f "$KEY_FILE" > "$SSH_DIR/id_ed25519.pub"
      chmod 644 "$SSH_DIR/id_ed25519.pub"

      echo "SSH key installed successfully."
    '';
  };

  # Ensure ~/.local/bin is in PATH
  home.sessionPath = [ "$HOME/.local/bin" ];

  # SSH client config
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    matchBlocks = {
      "*" = {
        identityFile = "~/.ssh/id_ed25519";
        serverAliveInterval = 60;
      };
    };
  };
}
