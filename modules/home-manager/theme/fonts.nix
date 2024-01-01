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
    roboto
  ];

  fonts.fontconfig.enable = true;
}
