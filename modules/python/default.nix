{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.python;
in {
  options = {
    modules.python.enable = mkEnableOption "python";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      python3
    ];

    environment.sessionVariables = {
      LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib";
    };
  };
}
