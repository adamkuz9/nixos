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
    home-manager.users.toft = {
      programs.alacritty = {
        enable = true;
        settings = {
          font = {
            size = 16.0;
            normal = {
              family = "Fira Nerd Code";
              style = "Regular";
            };
            bold = {
              family = "Fira Nerd Code";
              style = "Bold";
            };
            italic = {
              family = "Fira Nerd Code";
              style = "Italic";
            };
            bold_italic = {
              family = "Fira Nerd Code";
              style = "Bold Italic";
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