{ pkgs, ... }:
let
    nerdfonts = (pkgs.nerdfonts.override { fonts = [
        "Ubuntu"
        "UbuntuMono"
        "CascadiaCode"
        "FantasqueSansMono"
        "FiraCode"
        "Mononoki"
    ]; });
in
{
    home.packages = [
        nerdfonts
    ];

    fonts.fontconfig.enable = true;
}
