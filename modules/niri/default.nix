{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.niri;
in {
  imports = [
    ./alacritty.nix
    ./waybar.nix
  ];

  options = {
    modules.niri.enable = mkEnableOption "niri";
  };

  config = mkIf cfg.enable {
    programs.niri.enable = true;

    modules = {
      alacritty.enable = true;
      waybar.enable = true;
    };

    environment.systemPackages = with pkgs; [
      fuzzel # app launcher
      waybar # status bar
      swaylock-effects # screen locker
      mako # notification daemon
      wl-clipboard # clipboard utils
      brightnessctl # brightness control
      playerctl # media control
      grim # screenshot
      slurp # region selection for screenshots
      xdg-desktop-portal-gnome # portal for screencasting etc
    ];

    security.pam.services.swaylock = {};

    home-manager.users.adam = {
      xdg.configFile = {
        "niri/config.kdl".text = ''
          include "input.kdl"
          include "layout.kdl"
          include "autostart.kdl"
          include "misc.kdl"
          include "window-rules.kdl"
          include "binds.kdl"
        '';
        "niri/input.kdl".text = builtins.readFile ./conf/input.kdl;
        "niri/layout.kdl".text = builtins.readFile ./conf/layout.kdl;
        "niri/autostart.kdl".text = builtins.readFile ./conf/autostart.kdl;
        "niri/misc.kdl".text = builtins.readFile ./conf/misc.kdl;
        "niri/window-rules.kdl".text = builtins.readFile ./conf/window-rules.kdl;
        "niri/binds.kdl".text = builtins.readFile ./conf/binds.kdl;
      };
    };
  };
}
