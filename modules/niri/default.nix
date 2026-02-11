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
  ];

  options = {
    modules.niri.enable = mkEnableOption "niri";
  };

  config = mkIf cfg.enable {
    programs.niri.enable = true;

    home-manager.users.adam = {
    };
  };
}
