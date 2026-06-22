{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.latex;
  latex = pkgs.texlive.combine {
    inherit
      (pkgs.texlive)
      scheme-small
      latexmk
      titlesec
      fira
      arvo
      fontaxes
      ;
  };
in {
  options = {
    modules.latex.enable = mkEnableOption "LaTeX";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      latex
    ];
  };
}
