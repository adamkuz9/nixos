{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  nodejs = config.modules.nodejs;
in {
  options = {
    modules.nodejs.enable = mkEnableOption "nodejs";
  };

  config = mkIf nodejs.enable {
    environment.systemPackages = with pkgs; [
      nodejs_latest
    ];
  };
}