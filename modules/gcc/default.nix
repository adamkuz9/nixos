{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  gcc = config.modules.gcc;
in {
  options = {
    modules.gcc.enable = mkEnableOption "gcc";
  };

  config = mkIf (gcc.enable) {
    environment.systemPackages = with pkgs; [
        gcc15
        cmake
    ];
  };
}
