{
  pkgs,
  config,
  ...
}: {
  imports = [
    ../../modules
  ];

  config = {
    environment.systemPackages = with pkgs; [
      brightnessctl
    ];
    modules = {
      gnome.enable = true;
      git.enable = true;
      vscode.enable = true;
      flatpak.enable = true;
      discord.enable = true;
      niri.enable = true;
      gcc.enable = true;
    };
  };
}
