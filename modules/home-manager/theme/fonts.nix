{pkgs, ...}: let
  nerdfonts = pkgs.nerdfonts.override {
    fonts = [
      "Ubuntu"
      "UbuntuMono"
      "CascadiaCode"
      "FantasqueSansMono"
      "FiraCode"
      "Mononoki"
    ];
  };
in {
  home.packages = with pkgs; [
    nerdfonts
    font-awesome
    papirus-icon-theme
    qogir-icon-theme
    whitesur-icon-theme
    colloid-icon-theme
    adw-gtk3
    roboto
  ];

  fonts.fontconfig.enable = true;
}
