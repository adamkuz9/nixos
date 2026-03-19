{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  mullvad = config.modules.mullvad;
in {
  options = {
    modules.mullvad.enable = mkEnableOption "mullvad";
  };

  config = mkIf (mullvad.enable) {
    services.mullvad-vpn.enable = true;
    services.mullvad-vpn.package = pkgs.mullvad-vpn;
  };
}