{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  tailscale = config.modules.tailscale;
in {
  options = {
    modules.tailscale.enable = mkEnableOption "tailscale";
  };

  config = mkIf (tailscale.enable) {
    services.tailscale.enable = true;
    services.tailscale.openFirewall = true;
    services.tailscale.package = pkgs.tailscale;
  };
}