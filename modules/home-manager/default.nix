{
    home = import ./home.nix;
    dev = import ./dev.nix;
    xdg = import ./xdg.nix;

    desktops = {
        hyprland = import ./desktops/hyprland/hyprland.nix;
    };

    theme = {
        gtk = import ./theme/gtk.nix;
        qt = import ./theme/qt.nix;
    };
}
