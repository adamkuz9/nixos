{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.typst;
in {
  options = {
    modules.typst.enable = mkEnableOption "typst";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      typst
    ];
  };
}
