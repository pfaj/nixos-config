{
  inputs,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    inputs.quickshell.packages.${pkgs.system}.default
    wl-clipboard
    swww # wallpaper
    cliphist
    libnotify
    inotify-tools
    socat
    brightnessctl
    hyprshade
    desktop-file-utils
    hyprpicker
  ];
}
