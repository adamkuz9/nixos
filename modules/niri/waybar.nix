{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.waybar;
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
            "custom/media"
          ];
          modules-center = [
            "niri/window"
          ];
          modules-right = [
            "pulseaudio"
            "battery"
            "network"
            "cpu"
            "memory"
            "power-profiles-daemon"
            "clock"
          ];

          "niri/workspaces" = {
            disable-click = true;
            format = "{icon}";
            format-icons = {
              active = "󰮯 ";
              default = "󰊠 ";
            };
          };

          "custom/media" = {
            format = "{}";
            tooltip = true;
            tooltip-format = "{}";
            escape = true;
            return-type = "json";
            max-length = 50;
            on-click = "playerctl play-pause";
            on-click-right = "playerctl stop";
            on-scroll-up = "playerctl previous";
            on-scroll-down = "playerctl next";
          };

          "niri/window" = {
            icon = true;
            icon-size = 18;
            max-length = 70;
          };

          pulseaudio = {
            format = "{icon}";
            format-bluetooth = "{icon}";
            tooltip-format = "{desc} - {volume} %";
            format-muted = "󰝟 ";
            on-click = "pwvucontrol";
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
            on-click = "alacritty -e nmtui connect";
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

          clock = {
            format = "{:%b %d %H:%M}";
            tooltip-format = "<tt>{calendar}</tt>";
          };
        };
      };
    };
  };
}
