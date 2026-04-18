{
  imports = [
    # ./system
    ./flatpak
    ./gnome
    ./niri
    ./discord
    ./git
    ./vscode
    ./gcc
    ./python
    ./cloudflared
    ./tailscale
    ./rustdesk
    ./zsh
    ./zoxide
    ./mullvad
    ./copilot-cli
    ./dotnet
    ./stremio
  ];
  # imports = builtins.map (name: ./${name}) (builtins.attrNames (builtins.filter (name: type: type == "directory") (builtins.readDir ./)));
}
