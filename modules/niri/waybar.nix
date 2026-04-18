{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.waybar;
  tailscaleStatusScript = pkgs.writeShellScript "waybar-tailscale-status" ''
    if ${pkgs.tailscale}/bin/tailscale status --json 2>/dev/null | ${pkgs.gnugrep}/bin/grep -q '"BackendState":[[:space:]]*"Running"'; then
      printf '%s\n' '{"text":"󰖂","class":"connected","tooltip":"Tailscale connected"}'
    else
      printf '%s\n' '{"text":"󰖂","class":"disconnected","tooltip":"Tailscale disconnected"}'
    fi
  '';
in {
  options = {
    modules.waybar.enable = mkEnableOption "waybar";
  };

  config = mkIf cfg.enable {
    home-manager.users.adam = {
      programs.waybar = {
        enable = true;
        style = ./style.css;
        settings.main = {
          layer = "top";
          margin-top = 0;
          margin-bottom = 0;
          margin-left = 0;
          margin-right = 0;
          spacing = 0;

          modules-left = [
            "niri/workspaces"
          ];
          modules-center = [
            # "niri/window"
            "clock"
          ];
          modules-right = [
            "custom/tailscale"
            "custom/mullvad"
            "backlight"
            "pulseaudio"
            "battery"
            "network"
            "cpu"
            "memory"
            "power-profiles-daemon"
          ];

          "niri/workspaces" = {
            disable-click = true;
            format = "{icon}";
            format-icons = {
              active = "󰮯 ";
              default = "󰊠 ";
            };
          };

          "niri/window" = {
            icon = true;
            icon-size = 18;
            max-length = 70;
          };
          
          backlight = {
            format = "{icon}";
            format-icons = ["" "" "" "" "" "" "" "" ""];
          };

          pulseaudio = {
            format = "{icon}{volume}%";
            format-bluetooth = "{icon} {volume}%";
            tooltip-format = "{desc} - {volume} %";
            format-muted = "󰝟 ";
            on-click = "pavucontrol --tab=2 || pavucontrol";
            format-icons = {
              headphone = "󰋋 ";
              default = ["󰕿 " "󰖀 "];
            };
            reverse-scrolling = true;
          };

          battery = {
            states = {
              good = 100;
              warning = 30;
              critical = 15;
            };
            interval = 10;
            format = "{icon} {capacity}%";
            format-charging = "󰂄 {capacity}%";
            format-plugged = "󰂄 {capacity}%";
            format-icons = ["󰁻" "󰁽" "󰁿" "󰂁" "󰁹"];
          };

          network = {
            format = "{ifname}";
            format-wifi = "󰤨  {essid}";
            format-ethernet = "󰈀  {ifname}";
            format-disconnected = "Disconnected";
            tooltip-format-wifi = "󰤨  {ifname} @ {essid}\nIP: {ipaddr}\nStrength: {signalStrength}%\nFreq: {frequency}MHz\nUp: {bandwidthUpBits} Down: {bandwidthDownBits}";
            tooltip-format-ethernet = "󰈀  {ifname}\nIP: {ipaddr}\n up: {bandwidthUpBits} down: {bandwidthDownBits}";
            tooltip-format-disconnected = "Disconnected";
            max-length = 50;
            on-click = "kitty sh -c 'nmtui connect'";
          };

          cpu = {
            format = "󰻠  {usage}%";
            interval = 10;
          };

          memory = {
            format = "󰍛  {}%";
            interval = 10;
          };

          "power-profiles-daemon" = {
            format = "{icon}";
            tooltip-format = "{profile}";
            tooltip = true;
            format-icons = {
              performance = "󰓅";
              balanced = "󰾅";
              power-saver = "󰾆";
            };
          };

          "custom/mullvad" = {
            format = "󰒃";
            tooltip = "Mullvad VPN";
            on-click = "mullvad-vpn";
          };

          "custom/tailscale" = {
            exec = tailscaleStatusScript;
            format = "{}";
            return-type = "json";
            interval = 10;
          };

          clock = {
            format = "{:%b %d %H:%M}";
            tooltip-format = "<tt>{calendar}</tt>";
          };
        };
      };
    };
  };
}
