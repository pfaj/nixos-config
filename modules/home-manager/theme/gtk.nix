{ pkgs, ... }:
{
    gtk = {
        enable = true;

        font = {
            name = "Roboto";
            package = pkgs.roboto;
            size = 11;
        };

        theme = {
            name = "Marwaita X Dark";
            package = pkgs.marwaita-x;
        };

        iconTheme = {
            name = "Kora";
            package = pkgs.kora-icon-theme;
        };

        gtk3.extraConfig = {
            gtk-application-prefer-dark-theme = 1;
        };

        gtk4.extraConfig = {
            gtk-application-prefer-dark-theme = 1;
        };
    };
}
