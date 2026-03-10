{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.zsh;
in {
  options = {
    modules.zsh.enable = mkEnableOption "zsh";
  };

  config = mkIf cfg.enable {
    programs.zsh.enable = true;

    users.users.adam.shell = pkgs.zsh;

    home-manager.users.adam = {
      programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;

        oh-my-zsh = {
          enable = true;
          theme = "robbyrussell";
          plugins = [
            "git"
            "sudo"
            "history"
            "dirhistory"
          ];
        };
      };
    };
  };
}
