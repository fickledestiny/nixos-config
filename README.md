# NixOS configuration

My NixOS configuration.

## Configuration

| Category | Choice |
|---|---|
| **Compositor** | [Niri](https://github.com/YaLTeR/niri) (Wayland, scrolling) |
| **Display manager** | Ly |
| **Status bar** | Waybar |
| **Launcher** | Wofi |
| **Screen locker** | Swaylock-effects |
| **Idle daemon** | Swayidle (lock at 5 min, screen off at 10 min) |
| **Notifications** | Mako |
| **Terminal** | Kitty |
| **Shell** | Zsh + Oh-My-Zsh + Starship |
| **Editor** | Helix |
| **Browser** | Firefox + uBlock Origin + Bitwarden |
| **File manager** | Thunar |
| **Image viewer** | Loupe |
| **Multiplexer** | Zellij |
| **Theme** | Catppuccin Mocha (dark) |
| **Font** | JetBrainsMono Nerd Font |
| **Keyboard** | French AZERTY |

### CLI tools

| Tool | Purpose |
|---|---|
| `bat` | Better `cat` |
| `eza` | Better `ls` |
| `fd` | Better `find` |
| `ripgrep` | Better `grep` |
| `fzf` | Fuzzy finder |
| `zoxide` | Smart `cd` |
| `delta` | Better `git diff` |
| `btop` / `htop` / `atop` | System monitors |
| `procs` | Better `ps` |
| `fastfetch` | System info on terminal start |

## Installing on a fresh NixOS minimal image

1. **Boot** the NixOS minimal ISO.

2. **Get a shell with git and network access:**
   ```sh
   sudo -i
   nix-env -iA nixos.git
   ```

3. **Clone this repo:**
   ```sh
   git clone https://github.com/fickledestiny/nixos-config
   ```

4. **Install:**
```sh
bash /path/to/nixos-config/install.sh
```

## Adding another host

1. `mkdir hosts/<name>` and add `default.nix` + `hardware-configuration.nix`.
2. Register it under `nixosConfigurations` in `flake.nix`.
