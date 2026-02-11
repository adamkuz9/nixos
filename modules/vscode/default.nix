{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.vscode;
in {
  options = {
    modules.vscode.enable = mkEnableOption "vscode";
  };

  config = mkIf cfg.enable {
    nixpkgs.config.allowUnfree = true;
    home-manager.users.adam = {
      nixpkgs.config.allowUnfree = true;
      programs.vscode = {
        enable = true;
      };
    };
  };
}
