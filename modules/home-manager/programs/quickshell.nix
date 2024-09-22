{
  inputs,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    swww # wallpaper
    (inputs.quickshell.packages.${pkgs.system}.default.override {withQMLLib = true;})
    wl-clipboard
    #jc
  ];
}
