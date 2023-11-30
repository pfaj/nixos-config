{ inputs, pkgs, config, lib, self, ... }:
{
  imports = with inputs.self.homeManagerModules; [
    theme.fonts
    theme.gtk
    theme.qt
    xdg

    programs.anyrun # runner
    programs.ags # shell
  ] ++ [
    inputs.hyprland.homeManagerModules.default
  ];

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

    packages = with pkgs; [
      # programs
      networkmanagerapplet
      dolphin
      ark
      gnome.gnome-system-monitor

      # external packages
      inputs.hyprland-contrib.packages.${pkgs.system}.grimblast

      #eww-wayland
      #hyprland-workspaces
    ];
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    plugins = [
      #inputs.split-monitor-workspaces.packages.${pkgs.system}.split-monitor-workspaces ### doesn't work as expected
      #inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars
    ];
    extraConfig = builtins.readFile ./config/hyprland.conf;
  };
}
