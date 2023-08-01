{ pkgs, ... }:
{
    home.packages = with pkgs; [
        libnotify
    ];

    services.mako = {
        enable = true;
        anchor = "bottom-right";
        borderRadius = 8;
        borderSize = 2;
        defaultTimeout = 5000;
        padding = "4,4,4,4";
        margin = "4,4,4,4";
        backgroundColor = "#00000080"; # 75% opacity
        borderColor = "#00000040"; # 25% opacity
    };
}
