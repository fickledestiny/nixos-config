{ pkgs, config, lib, ... }:

{
  # Niri config. The niri-flake home-manager module is not imported here;
  # we manage the config file directly for clarity and portability.
  xdg.configFile."niri/config.kdl".text = ''
    // Niri configuration for jerem
    // https://github.com/YaLTeR/niri/wiki/Configuration:-Overview

    input {
        keyboard {
            xkb {
                layout "fr"
                variant "azerty"
            }
        }
        touchpad {
            tap
            natural-scroll
            dwt
        }
        focus-follows-mouse
    }

    output "eDP-1" {
        scale 1.0
    }

    layout {
        gaps 8
        center-focused-column "never"
        preset-column-widths {
            proportion 0.33333
            proportion 0.5
            proportion 0.66667
        }
        default-column-width { proportion 0.5; }

        focus-ring {
            width 1
            active-color "#89b4fa"
            inactive-color "#45475a"
        }
        border {
            off
        }
    }

    spawn-at-startup "swaybg" "-i" "${config.home.homeDirectory}/.config/wallpaper.jpg" "-m" "fill"
    spawn-at-startup "waybar"
    spawn-at-startup "mako"
    spawn-at-startup "nm-applet" "--indicator"
    spawn-at-startup "swayidle" "-w" "timeout" "300" "swaylock --screenshots --clock --indicator --indicator-radius 100 --indicator-thickness 7 --effect-blur 7x5 --effect-vignette 0.5:0.5 --color 1e1e2ebb --font 'JetBrainsMono Nerd Font' --inside-color 1e1e2e88 --ring-color 89b4faff --key-hl-color a6e3a1ff --text-color cdd6f4ff --line-color 00000000 --separator-color 00000000 --fade-in 0.2" "timeout" "600" "NIRI_SOCKET=$(ls /run/user/$(id -u)/niri.*.sock 2>/dev/null | head -1) niri msg action power-off-monitors" "resume" "NIRI_SOCKET=$(ls /run/user/$(id -u)/niri.*.sock 2>/dev/null | head -1) niri msg action power-on-monitors"

    prefer-no-csd

    hotkey-overlay {
        skip-at-startup
    }

    screenshot-path "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png"

    environment {
        DISPLAY ":0"
        QT_QPA_PLATFORM "wayland"
        GTK_THEME "Adwaita-dark"
    }

    cursor {
        xcursor-theme "Adwaita"
        xcursor-size 24
    }

    binds {
        Mod+T            { spawn "kitty"; }
        Mod+E            { spawn "thunar"; }
        Mod+D            { spawn "wofi" "--show" "drun"; }
        Mod+B            { spawn "firefox"; }
        Mod+L            { spawn "swaylock" "--screenshots" "--clock" "--indicator" "--indicator-radius" "100" "--indicator-thickness" "7" "--effect-blur" "7x5" "--effect-vignette" "0.5:0.5" "--color" "1e1e2ebb" "--font" "JetBrainsMono Nerd Font" "--inside-color" "1e1e2e88" "--ring-color" "89b4faff" "--key-hl-color" "a6e3a1ff" "--text-color" "cdd6f4ff" "--line-color" "00000000" "--separator-color" "00000000" "--fade-in" "0.2"; }
        Mod+Shift+Q      { close-window; }
        Mod+Shift+E      { quit; }

        XF86AudioRaiseVolume allow-when-locked=true { spawn "pamixer" "-i" "5"; }
        XF86AudioLowerVolume allow-when-locked=true { spawn "pamixer" "-d" "5"; }
        XF86AudioMute        allow-when-locked=true { spawn "pamixer" "-t"; }
        XF86MonBrightnessUp   { spawn "brightnessctl" "set" "+5%"; }
        XF86MonBrightnessDown { spawn "brightnessctl" "set" "5%-"; }

        Mod+Left   { focus-column-left; }
        Mod+Right  { focus-column-right; }
        Mod+Up     { focus-window-up; }
        Mod+Down   { focus-window-down; }
        Mod+H      { focus-column-left; }
        Mod+J      { focus-window-down; }
        Mod+K      { focus-window-up; }

        Mod+Shift+Left  { move-column-left; }
        Mod+Shift+Right { move-column-right; }
        Mod+Shift+Up    { move-window-up; }
        Mod+Shift+Down  { move-window-down; }

        Mod+F1 { focus-workspace 1; }
        Mod+F2 { focus-workspace 2; }
        Mod+F3 { focus-workspace 3; }
        Mod+F4 { focus-workspace 4; }
        Mod+F5 { focus-workspace 5; }
        Mod+Shift+F1 { move-column-to-workspace 1; }
        Mod+Shift+F2 { move-column-to-workspace 2; }
        Mod+Shift+F3 { move-column-to-workspace 3; }
        Mod+Shift+F4 { move-column-to-workspace 4; }
        Mod+Shift+F5 { move-column-to-workspace 5; }

        Mod+F       { maximize-column; }
        Mod+Shift+F { fullscreen-window; }
        Mod+R       { switch-preset-column-width; }

        Print { screenshot; }
        Mod+Print { screenshot-window; }
        Shift+Print { screenshot-screen; }
    }

    window-rule {
        geometry-corner-radius 10
        clip-to-geometry true
    }
  '';
}
