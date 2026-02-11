{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  discord = config.modules.discord;
  flatpak = config.modules.flatpak;
in {
  options = {
    modules.discord.enable = mkEnableOption "discord";
  };

  config = mkIf (discord.enable && flatpak.enable) {
    services.flatpak.packages = [
      "com.discordapp.Discord"
    ];
  };
}
