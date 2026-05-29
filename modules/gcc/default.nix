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
      ninja
      gdb
      pkg-config
      qt6.qtbase
      qt6.qtdeclarative
      qt6.qtgraphs
      qt6.qttools
      qt6.qtwayland
      pkgs.jetbrains.clion
    ];
  };
}
