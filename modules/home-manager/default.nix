{
    programs = import ./programs;
    services = import ./services;
    desktops = import ./desktops;
    theme = import ./theme;

    home = import ./home.nix;
    xdg = import ./xdg.nix;
}
