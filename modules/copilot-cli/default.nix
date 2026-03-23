{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  copilot = config.modules.copilot;
in {
  options = {
    modules.copilot.enable = mkEnableOption "copilot";
  };

  config = mkIf (copilot.enable) {
    environment.systemPackages = with pkgs; [
        copilot-cli
    ];
  };
}
