{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  stremio = config.modules.stremio;
  flatpak = config.modules.flatpak;
in {
  options = {
    modules.stremio.enable = mkEnableOption "stremio";
  };

  config = mkIf (stremio.enable && flatpak.enable) {
    services.flatpak.packages = [
      "com.stremio.Stremio"
    ];
  };
}
