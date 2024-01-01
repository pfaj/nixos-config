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
  #home.file = {
  #  ".local/share/icons/MoreWaita" = {
  #    source = "${moreWaita}/share/icons";
  #  };
  #};

  gtk = {
    enable = true;

    font = {
      name = "Roboto";
      package = pkgs.roboto;
      size = 11;
    };

    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };

    iconTheme = {
      inherit (moreWaita) name;
      package = moreWaita;
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };

    #gtk4.extraConfig = {
    #  gtk-application-prefer-dark-theme = 1;
    #};
  };
}
