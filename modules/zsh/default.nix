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

        plugins = [
          {
            name = "powerlevel10k";
            src = pkgs.zsh-powerlevel10k;
            file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
          }
        ];

        oh-my-zsh = {
          enable = true;
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
