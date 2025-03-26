{
  inputs,
  pkgs,
  ...
}: {
  imports = with inputs.self.homeManagerModules; [
    theme
    xdg

    programs.quickshell
  ];

  home = {
    sessionVariables = {
      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE = "wayland";
      XDG_SESSION_DESKTOP = "Hyprland";

      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      QT_QPA_PLATFORM = "wayland;xcb";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";

      _JAVA_AWT_WM_NONREPARENTING = "1";
      CLUTTER_BACKEND = "wayland";
      GDK_BACKEND = "wayland,x11";

      NIXOS_OZONE_WL = "1"; # force wayland on electron apps
    };

    packages = with pkgs; [
      inputs.hyprland-contrib.packages.${pkgs.system}.grimblast

      snapshot # camera app
      baobab # storage visualizer
      file-roller # archive manager
      #gnome-calendar
      gnome-system-monitor
      #gnome-control-center
      #gnome-weather
      gnome-calculator
      fuzzel
      #gnome-clocks
      #gnome-software
    ];
  };
}
