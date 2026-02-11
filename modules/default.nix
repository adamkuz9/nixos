{
  imports = [
    # ./system
    ./flatpak
    ./gnome
    ./discord
    ./git
    ./vscode
  ];
  # imports = builtins.map (name: ./${name}) (builtins.attrNames (builtins.filter (name: type: type == "directory") (builtins.readDir ./)));
}
