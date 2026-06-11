{ pkgs, config, lib, ... }:

{
  programs.waybar = {
    enable = true;
    systemd.enable = false;

    settings = [{
      layer = "top";
      position = "top";
      height = 32;
      spacing = 4;
      margin-top = 4;
      margin-left = 8;
      margin-right = 8;

      modules-left = [
        "niri/workspaces"
        "niri/window"
      ];
      modules-center = [
        "clock"
      ];
      modules-right = [
        "cpu"
        "memory"
        "disk"
        "pulseaudio"
        "battery"
        "tray"
        "custom/power"
      ];

      "niri/workspaces" = {
        format = "{name}";
      };

      "niri/window" = {
        max-length = 60;
      };

      "clock" = {
        format = " {:%H:%M  %d/%m/%Y}";
        tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      };

      "cpu" = {
        format = "󰻠 {usage}%";
        interval = 2;
        tooltip = true;
        tooltip-format = "CPU: {usage}%\nLoad: {load}";
        on-click = "kitty -e btop";
      };

      "memory" = {
        format = "󰍛 {percentage}%";
        tooltip-format = "RAM: {used:0.1f}G / {total:0.1f}G";
        interval = 2;
        on-click = "kitty -e btop";
      };

      "disk" = {
        format = "󰋊 {percentage_used}%";
        tooltip-format = "Disk: {used} / {total} ({percentage_used}%)";
        path = "/";
        interval = 30;
      };

      "pulseaudio" = {
        format = "{icon} {volume}%";
        format-muted = "󰝟 muted";
        format-icons = {
          default = [ "󰕿" "󰖀" "󰕾" ];
        };
        on-click = "pamixer -t";
        on-scroll-up = "pamixer -i 5";
        on-scroll-down = "pamixer -d 5";
      };

      "network" = {
        format-wifi = "󰤨 {essid}";
        format-ethernet = "󰈀 {ipaddr}";
        format-disconnected = "󰤭 disconnected";
        tooltip-format = "{ifname}: {ipaddr}\nSignal: {signalStrength}%";
        on-click = "nm-connection-editor";
      };

      "battery" = {
        format = "{icon} {capacity}%";
        format-charging = "󰂄 {capacity}%";
        format-icons = [ "󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
        states = {
          warning = 30;
          critical = 15;
        };
      };

      "tray" = {
        spacing = 8;
      };

      "custom/power" = {
        format = "⏻";
        tooltip-format = "Power menu";
        on-click = "~/.config/waybar/power-menu.sh";
      };
    }];

    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font", monospace;
        font-size: 13px;
        font-feature-settings: "tnum";
        border: none;
        border-radius: 0;
        min-height: 0;
      }

      window#waybar {
        background: transparent;
        color: #cdd6f4;
      }

      button {
        box-shadow: none;
        border: none;
        border-radius: 0;
        transition-property: none;
      }

      button:hover {
        background: none;
        box-shadow: none;
        border: none;
        -gtk-icon-effect: none;
      }

      /* Workspaces */
      #workspaces {
        margin: 4px 4px;
        background-color: rgba(30, 30, 46, 0.7);
        border-radius: 99px;
        padding: 0 4px;
      }

      #workspaces button {
        padding: 0 8px;
        color: #6c7086;
        background: transparent;
        border-radius: 99px;
      }

      #workspaces button.active {
        color: #cdd6f4;
        background-color: rgba(69, 71, 90, 0.8);
      }

      #workspaces button:hover {
        background-color: rgba(49, 50, 68, 0.8);
        color: #cdd6f4;
      }

      /* Window title */
      #window {
        margin: 4px 4px;
        padding: 0 12px;
        color: #a6adc8;
        background-color: rgba(30, 30, 46, 0.7);
        border-radius: 99px;
      }

      /* All right-side pill modules share base style */
      #clock,
      #battery,
      #pulseaudio,
      #cpu,
      #memory,
      #disk,
      #tray,
      #custom-power {
        margin: 4px 2px;
        padding: 0 12px;
        background-color: rgba(30, 30, 46, 0.7);
        color: #cdd6f4;
        border-radius: 99px;
      }

      /* CPU+Memory pill — joined together */
      #cpu {
        color: #89b4fa;
        border-radius: 99px 0 0 99px;
        margin-right: 0;
        padding-right: 8px;
      }

      #memory {
        color: #cba6f7;
        border-radius: 0 99px 99px 0;
        margin-left: 0;
        padding-left: 8px;
      }

      #disk { color: #94e2d5; }

      #clock { font-weight: bold; }

      #battery.warning { color: #fab387; }
      #battery.critical { color: #f38ba8; }
      #battery.charging { color: #a6e3a1; }

      #pulseaudio.muted { color: #6c7086; }

      #tray > .passive { -gtk-icon-effect: dim; }
      #tray > .needs-attention {
        -gtk-icon-effect: highlight;
        background-color: rgba(243, 139, 168, 0.3);
      }

      #custom-power {
        color: #f38ba8;
        font-size: 15px;
        margin-right: 4px;
      }

      #custom-power:hover {
        background-color: rgba(243, 139, 168, 0.2);
      }
    '';
  };

  # nm-connection-editor for WiFi management (opened from waybar network click)
  home.packages = with pkgs; [
    networkmanagerapplet  # provides nm-connection-editor
  ];

  # Power menu script invoked by the waybar power button
  home.file.".config/waybar/power-menu.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      choice=$(printf "󰐥  Poweroff\n󰜉  Reboot\n󰍃  Logout" \
        | wofi --dmenu \
               --prompt "Power" \
               --width 200 \
               --height 148 \
               --lines 3 \
               --hide-scroll \
               --no-actions)
      case "$choice" in
        *Poweroff) systemctl poweroff ;;
        *Reboot)   systemctl reboot ;;
        *Logout)   niri msg action quit ;;
      esac
    '';
  };

  # Mask the auto-generated waybar systemd service so only niri's
  # spawn-at-startup launches it (prevents double instance).
  systemd.user.services.waybar = lib.mkForce {
    Unit.Description = "waybar (managed by niri spawn-at-startup)";
    Service.ExecStart = "${pkgs.coreutils}/bin/true";
    Install = {};
  };
}
