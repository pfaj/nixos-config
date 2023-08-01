{
    applications = import ./applications;
    desktops = import ./desktops;
    theme = import ./theme;

    dev = import ./dev.nix;
    home = import ./home.nix;
    xdg = import ./xdg.nix;
}
