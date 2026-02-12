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
  ];
  # imports = builtins.map (name: ./${name}) (builtins.attrNames (builtins.filter (name: type: type == "directory") (builtins.readDir ./)));
}
