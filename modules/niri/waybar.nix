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

          include = [
            "./waybar/modules.jsonc"
          ];

          modules-left = [
            "niri/workspaces"
            "custom/media"
          ];
          modules-center = [
            "niri/window"
          ];
          modules-right = [
            "custom/updates"
            "backlight"
            "pulseaudio"
            "battery"
            "network"
            "cpu"
            "memory"
            "power-profiles-daemon"
            "clock"
          ];
        };
      };

      xdg.configFile."niri/waybar/modules.jsonc".source = ./waybar/modules.jsonc;
    };
  };
}
