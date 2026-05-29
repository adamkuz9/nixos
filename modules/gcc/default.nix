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
    environment = {
      pathsToLink = [
        "/include"
        "/libexec"
        "/metatypes"
        "/mkspecs"
      ];

      sessionVariables = {
        CMAKE_PREFIX_PATH = ["/run/current-system/sw"];
      };

      systemPackages = with pkgs; [
        gcc15
        cmake
        ninja
        gdb
        pkg-config
        libglvnd
        libglvnd.dev
        vulkan-headers
        vulkan-loader
        qt6.qtbase
        qt6.qtdeclarative
        qt6.qtgraphs
        qt6.qtquick3d
        qt6.qtshadertools
        qt6.qttools
        qt6.qtwayland
        pkgs.jetbrains.clion
      ];
    };
  };
}
