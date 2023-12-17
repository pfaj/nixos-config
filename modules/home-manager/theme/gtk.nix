{
  inputs,
  pkgs,
  ...
}: let
  moreWaita = pkgs.stdenv.mkDerivation {
    name = "MoreWaita";
    src = inputs.more-waita;
    installPhase = ''
      mkdir -p $out/share/icons
      mv * $out/share/icons
    '';
  };
in {
  gtk = {
    enable = true;

    font = {
      name = "Roboto";
      package = pkgs.roboto;
      size = 11;
    };

    #iconTheme = {
    #  "name" = "Adwaita-dark";
    #  package = pkgs.gnome.adwaita-icon-theme;
    #};

    #iconTheme = {
    #  name = "MoreWaita";
    #  package = moreWaita;
    #};

    #theme = {
    #  name = "Marwaita X Dark";
    #  package = pkgs.marwaita-x;
    #};

    #iconTheme = {
    #  name = "Kora";
    #  package = pkgs.kora-icon-theme;
    #};

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };

    #gtk4.extraConfig = {
    #  gtk-application-prefer-dark-theme = 1;
    #};
  };
}
