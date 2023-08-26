{
    applications = import ./applications;
    services = import ./services;
    desktops = import ./desktops;
    theme = import ./theme;

    dev = import ./dev.nix;
    home = import ./home.nix;
    xdg = import ./xdg.nix;
}
