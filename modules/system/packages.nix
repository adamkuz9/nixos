{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    vim
    firefox
    fastfetch
    alejandra
    pavucontrol
  ];
}
