{
  inputs,
  pkgs,
  ...
}: let
  pythonWithDeps = pkgs.python3.withPackages (ps:
    with pkgs; [
      # (pywayfire ps)
      # ps.pip
    ]);
in {
  home.packages = with pkgs; [
    inputs.quickshell.packages.${pkgs.system}.default
    pythonWithDeps
    wl-clipboard
    swww # wallpaper
    cliphist
    libnotify
    inotify-tools
    socat
    brightnessctl
    hyprshade
    desktop-file-utils
    kdePackages.qtdeclarative
  ];
}
