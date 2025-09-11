{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = with inputs.self.homeManagerModules; [
    common
  ];

  home = {
    sessionVariables = {
    };

    packages = with pkgs; [
      obsidian
      # fprintd
      libreoffice
      tailscale

      intellijpatch

    ];
  };

  wayland.windowManager.hyprland.settings = {
    exec-once = [
      #"wlr-randr --output HDMI-A-1 --off && sleep 1 && wlr-randr --output HDMI-A-1 --on --pos 1921,0"
      "xrandr --output DP-2 --primary"

      "hyprctl dispatch exec 'zen'"
      "hyprctl dispatch exec 'obsidian'"
    ];

    # https://wiki.hyprland.org/Configuring/Monitors/
    monitor = [
      "eDP-1, 2560x1600@165.00,0x0,1.333"
      ", preferred, auto, 1.333"
    ];

    misc = {
      vrr = 1;
    };

    input = {
      sensitivity = lib.mkForce 0.65;
      accel_profile = "adaptive";
    };
  };
}
