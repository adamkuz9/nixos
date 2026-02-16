{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.cloudflared;
in {
  options = {
    modules.cloudflared.enable = mkEnableOption "cloudflared";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.cloudflared
    ];
  };
}
