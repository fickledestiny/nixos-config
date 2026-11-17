{ pkgs, ... }:

# Blink the keyboard backlight when the battery is low and discharging.
let
  led = "/sys/class/leds/dell::kbd_backlight";
  bat = "/sys/class/power_supply/BAT0";
  threshold = 5; # percent

  script = pkgs.writeShellScript "battery-blink" ''
    set -u
    saved=""
    while true; do
      cap=$(cat ${bat}/capacity)
      status=$(cat ${bat}/status)
      if [ "$status" = "Discharging" ] && [ "$cap" -le ${toString threshold} ]; then
        [ -z "$saved" ] && saved=$(cat ${led}/brightness)
        max=$(cat ${led}/max_brightness)
        # Alarm: fast hard on/off flashing, re-check battery every ~5 s
        for _ in $(seq 1 5); do
          echo "$max" > ${led}/brightness; sleep 0.5
          echo 0 > ${led}/brightness;      sleep 0.5
        done
      else
        if [ -n "$saved" ]; then
          echo "$saved" > ${led}/brightness
          saved=""
        fi
        sleep 30
      fi
    done
  '';
in
{
  systemd.services.battery-blink = {
    description = "Blink keyboard backlight on low battery";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = script;
      Restart = "always";
    };
  };
}
