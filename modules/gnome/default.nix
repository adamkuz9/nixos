{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.gnome;
in {
  options = {
    modules.gnome.enable = mkEnableOption "gnome";
  };

  config = mkIf cfg.enable {
    services = {
      xserver.enable = true;
      desktopManager.gnome.enable = true;
      displayManager.gdm.enable = true;
    };
    services.desktopManager.gnome.extraGSettingsOverrides = ''
      [org.gnome.mutter]
      experimental-features=['scale-monitor-framebuffer', 'xwayland-native-scaling']
    '';

    environment.systemPackages = with pkgs; [
      gnome-tweaks
      gnome-extension-manager
      gnomeExtensions.blur-my-shell
      gnomeExtensions.appindicator
      gnomeExtensions.clipboard-indicator
    ];

    environment.gnome.excludePackages = with pkgs; [
      baobab # disk usage analyzer
      cheese # photo booth
      eog # image viewer
      epiphany # web browser
      gedit # text editor
      simple-scan # document scanner
      totem # video player
      yelp # help viewer
      evince # document viewer
      file-roller # archive manager
      geary # email client
      seahorse # password manager

      # these should be self explanatory
      # gnome-calculator
      gnome-calendar
      gnome-characters
      gnome-clocks
      gnome-contacts
      gnome-font-viewer
      gnome-logs
      gnome-maps
      gnome-music
      gnome-photos
      gnome-screenshot
      # gnome-system-monitor
      gnome-weather
      gnome-disk-utility
      pkgs.gnome-connections
    ];

    home-manager.users.adam = {
      dconf.settings = {
        "org/gnome/desktop/wm/keybindings" = {
          switch-to-workspace-1 = ["<Super>1"];
          switch-to-workspace-2 = ["<Super>2"];
          switch-to-workspace-3 = ["<Super>3"];
          switch-to-workspace-4 = ["<Super>4"];
          switch-to-workspace-5 = ["<Super>5"];
          close = ["<Super>q"];
          dconf.settings."org/gnome/desktop/interface".scaling-factor = 1.75;
        };
      };
    };
  };
}
