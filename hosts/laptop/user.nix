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
      cloudflared.enable = true;
      tailscale.enable = true;
      rustdesk.enable = true;
      python.enable = true;
      zsh.enable = true;
      zoxide.enable = true;
      mullvad.enable = true;
      copilot.enable = true;
      dotnet.enable = true;
      stremio.enable = true;
    };
  };
}
