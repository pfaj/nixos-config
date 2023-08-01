{ pkgs, ... }:
{
    qt = {
        enable = false;
        platformTheme = "gtk";
        style = {
            name = "adwaita-dark";
            package = pkgs.adwaita-qt;
        };
    };
}
