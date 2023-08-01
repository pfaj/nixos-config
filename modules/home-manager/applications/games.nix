{ pkgs, ... }:
{
    home.packages = with pkgs; [
        lutris
        lunar-client
        prismlauncher
    ];
}
