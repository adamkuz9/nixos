{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.dotnet;
in {
  options = {
    modules.dotnet.enable = mkEnableOption "dotnet";
  };

  config = mkIf (cfg.enable) {
    environment.systemPackages = with pkgs; [
        dotnet-sdk_9
        dotnet-runtime_9
        dotnet-aspnetcore_9
        dotnet-sdk_10
        dotnet-runtime_10
        dotnet-aspnetcore_10
    ];

    environment.sessionVariables = {
      DOTNET_ROOT = "/run/current-system/sw/share/dotnet";
    };
  };
}
