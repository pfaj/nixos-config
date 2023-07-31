{ pkgs, ... }:
let
    callPackage = pkgs.lib.callPackageWith (pkgs);
in
{
    gtk = {
        enable = true;

        font = {
            name = "Roboto Regular";
            size = 11;
        };

        theme = {
            name = "Marwaita X Dark";
            package = callPackage ./marwaita-x.nix { };
        };

        iconTheme = {
            name = "Kora";
            package = pkgs.kora-icon-theme;
        };

        cursorTheme = {
            name = "McMojave-cursors";
            package = callPackage ./mcmojave-cursors.nix { };
            size = 24;
        };
    };
}
