{ pkgs, ... }:
{
    home.pointerCursor = {
        name = "McMojave-cursors";
        package = pkgs.mcmojave-cursors;
        size = 24;
        gtk.enable = true;
        x11.enable = true;
    };
}
