{
  imports = [
    # ./system
    ./flatpak
    ./gnome
    ./niri
    ./discord
    ./git
    ./vscode
  ];
  # imports = builtins.map (name: ./${name}) (builtins.attrNames (builtins.filter (name: type: type == "directory") (builtins.readDir ./)));
}
