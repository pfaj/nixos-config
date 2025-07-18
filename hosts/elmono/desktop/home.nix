{
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = with inputs.self.homeManagerModules; [
    common
    services.easy-effects
  ];

  home = {
    sessionVariables = {
      LIBVA_DRIVER_NAME = "nvidia";
      NVD_BACKEND = "direct";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    };

    packages = with pkgs; [
      firefox
      obsidian
      # gimp-with-plugins
      libreoffice

      intellijpatch

      #Cyber Sec
      nmap
      burpsuite
      wireshark
      john
      hashcat
      ffuf
      protonvpn-cli
    ];
  };

  wayland.windowManager.hyprland.settings = {
    exec-once = [
      #"wlr-randr --output HDMI-A-1 --off && sleep 1 && wlr-randr --output HDMI-A-1 --on --pos 1921,0"
      "xrandr --output DP-2 --primary"

      "hyprctl dispatch exec 'zen'"
      "hyprctl dispatch exec 'obsidian'"
      "hyprctl dispatch exec 'easy-effects'"
    ];

    # https://wiki.hyprland.org/Configuring/Monitors/
    monitor = [
      "DP-2, preferred, auto, 1"
      "DP-1, 1920x1080@144, 0x0, 1"
    ];

    workspace = [
      "1, monitor:DP-2, default:true"
      "2, monitor:DP-2"
      "3, monitor:DP-2"
      "4, monitor:DP-2"
      "5, monitor:DP-2"
      "6, monitor:DP-2"
      "7, monitor:DP-2"
      "11, monitor:DP-1, default:true"
      "12, monitor:DP-1"
      "13, monitor:DP-1"
      "14, monitor:DP-1"
      "15, monitor:DP-1"
      "16, monitor:DP-1"
      "17, monitor:DP-1"
    ];
    misc = {
      vrr = 1;
    };

    input = {
      sensitivity = lib.mkForce 0.5;
      accel_profile = "adaptive";
    };
  };
}
