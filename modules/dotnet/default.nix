{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  dotnet = config.modules.dotnet;
in {
  options = {
    modules.dotnet.enable = mkEnableOption "dotnet";
  };

  config = mkIf (dotnet.enable) {
    environment.systemPackages = with pkgs; [
        dotnet-sdk
        dotnet-runtime
        dotnet-aspnetcore
    ];
  };
}
