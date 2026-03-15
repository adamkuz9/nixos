{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.kitty;
in {
  options = {
    modules.kitty.enable = mkEnableOption "kitty";
  };

  config = mkIf cfg.enable {
    home-manager.users.adam = {
      programs.kitty = {
        enable = true;
        font = {
          name = "JetBrainsMono Nerd Font";
          size = 16;
        };
        settings = {
          background = "#000000";
          foreground = "#FFFFFF";
          background_opacity = "0.7";
          cursor_trail = 120;
        };
      };
    };
  };
}