{
  inputs,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    (inputs.quickshell.packages.${pkgs.system}.default.override {withQMLLib = true;})
    wl-clipboard
    swww # wallpaper
    cliphist
    inotify-tools
    libnotify
    socat
    brightnessctl
  ];
}
