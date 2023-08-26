{ pkgs, ... }:
{
    home.packages = with pkgs; [
        gnomeExtensions.appindicator
        gnomeExtensions.blur-my-shell
    ];
}
