{
  inputs,
  pkgs,
  ...
}: {
  imports = with inputs.self.homeManagerModules;
    [
      theme.fonts
      theme.gtk
      theme.qt
      xdg

      programs.ags # shell
      programs.anyrun # runner
    ]
    ++ [
      ./settings.nix
      #inputs.hyprland.homeManagerModules.default
    ];

  xdg.desktopEntries."org.gnome.Settings" = {
    name = "Settings";
    comment = "Gnome Control Center";
    icon = "org.gnome.Settings";
    exec = "XDG_CURRENT_DESKTOP=gnome ${pkgs.gnome.gnome-control-center}/bin/gnome-control-center";
    categories = ["X-Preferences"];
    terminal = false;
  };

  home = {
    sessionVariables = {
      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE = "wayland";
      XDG_SESSION_DESKTOP = "Hyprland";

      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      QT_QPA_PLATFORM = "wayland;xcb";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";

      SDL_VIDEODRIVER = "wayland";
      _JAVA_AWT_WM_NONREPARENTING = "1";
      CLUTTER_BACKEND = "wayland";
      GDK_BACKEND = "wayland,x11";
    };
  };

  dconf.settings = {
    "org.gnome.desktop.wm.preferences" = {
      button-layout = "";
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.default;
    #extraConfig = builtins.readFile ./config/hyprland.conf;
    plugins = [
      inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars
      inputs.hyprshell.packages.${pkgs.system}.hyprshell
      #inputs.hyprshell.packages.${pkgs.system}.hyprshell
      #inputs.split-monitor-workspaces.packages.${pkgs.system}.split-monitor-workspaces ### doesn't work as expected
    ];
  };
}
