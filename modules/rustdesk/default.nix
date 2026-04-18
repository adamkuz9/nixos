{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  rustdesk = config.modules.rustdesk;
in {
  options = {
    modules.rustdesk.enable = mkEnableOption "rustdesk";
  };

  config = mkIf (rustdesk.enable) {
    environment.systemPackages = [
      pkgs.rustdesk
    ];
  };
}