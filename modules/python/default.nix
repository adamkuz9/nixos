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
  };
}
