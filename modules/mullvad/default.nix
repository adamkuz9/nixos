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
    environment.systemPackages = with pkgs; [
        mullvad-vpn
    ];
  };
}