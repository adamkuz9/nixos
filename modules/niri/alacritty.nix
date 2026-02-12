{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.alacritty;
in {
  options = {
    modules.alacritty.enable = mkEnableOption "alacritty";
  };

  config = mkIf cfg.enable {
    home-manager.users.adam = {
      programs.alacritty = {
        enable = true;
        settings = {
          font = {
            size = 16.0;
            normal = {
              family = "JetBrainsMono Nerd Font";
              style = "Regular";
            };
          };

          window = {
            opacity = 0.7;
          };

          colors = {
            primary = {
              background = "#000000";
              foreground = "#FFFFFF";
            };
          };
        };
      };
    };
  };
}