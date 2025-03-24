{pkgs, ...}: let
  #nerdfonts = pkgs.nerdfonts.override {
  #  fonts = [
  #    "Ubuntu"
  #    "UbuntuMono"
  #    "CascadiaCode"
  #    "FantasqueSansMono"
  #    "JetBrainsMono"
  #    "FiraCode"
  #    "Mononoki"
  #  ];
  #};
in {
  home.packages = with pkgs; [
    #nerdfonts
    #font-awesome
    roboto
    nerd-fonts.ubuntu
  ];

  #home = {
  #  packages = with pkgs; [
  #  ];

  #  file = {
  #    ".local/share/fonts" = {
  #      recursive = true;
  #      source = "${nerdfonts}/share/fonts/truetype/NerdFonts";
  #    };

  #    ".fonts" = {
  #      recursive = true;
  #      source = "${nerdfonts}/share/fonts/truetype/NerdFonts";
  #    };
  #  };
  #};

  fonts.fontconfig.enable = true;
}
