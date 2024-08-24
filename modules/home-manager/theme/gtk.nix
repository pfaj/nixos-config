{pkgs, ...}: {
  home.packages = with pkgs; [
    adwaita-icon-theme
  ];

  dconf = {
    enable = true;
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };

  gtk = {
    enable = true;

    font = {
      name = "Roboto";
      package = pkgs.roboto;
      size = 11;
    };

    iconTheme = {
      name = "MoreWaita";
      package = pkgs.morewaita-icon-theme;
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };
}
