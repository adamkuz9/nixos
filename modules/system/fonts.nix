{pkgs, ...}: {
  fonts.packages = with pkgs; [
    fira-code
    nerd-fonts.fira-code
    nerd-fonts.symbols-only
    noto-fonts
    nerd-fonts.jetbrains-mono
    nerd-fonts.ubuntu-mono
  ];
}
