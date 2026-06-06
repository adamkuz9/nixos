{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  obsidian = config.modules.obsidian;
in {
  options = {
    modules.obsidian.enable = mkEnableOption "obsidian";
  };

  config = mkIf (obsidian.enable) {
    environment.systemPackages = [
      pkgs.obsidian
    ];
  };
}